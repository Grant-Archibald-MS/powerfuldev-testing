using System.Dynamic;
using System.Globalization;
using System.Runtime.InteropServices.JavaScript;
using System.Runtime.Versioning;
using System.Text;
using System.Text.Json;
using Microsoft.PowerApps.TestEngine.PowerFx.Functions;
using Microsoft.PowerFx;
using Microsoft.PowerFx.Syntax;
using Microsoft.PowerFx.Types;

[SupportedOSPlatform("browser")]
public partial class PowerFx {
    [JSExport]
    internal static string Execute(String code) {
        try {
            var powerFxConfig = new PowerFxConfig(Features.PowerFxV1);
            var vals = new SymbolValues();
            var symbols = (SymbolTable)vals.SymbolTable;
            symbols.EnableMutationFunctions();
            powerFxConfig.SymbolTable = symbols;
            powerFxConfig.EnableSetFunction();
            powerFxConfig.AddFunction(new AssertFunction());
            var engine = new RecalcEngine(powerFxConfig);

            var options = new ParserOptions() { AllowsSideEffects = true, Culture = new CultureInfo("en-us"), NumberIsFloat = true };

            var parsed = engine.Parse(code, options);

            StringBuilder result = new StringBuilder();

            if (!parsed.IsSuccess) {
                foreach ( var error in parsed.Errors ) {
                    result.AppendLine(error.Message);
                }
                return result.ToString();
            }
            AddVariables(parsed.Root, engine);

            var checkResult = engine.Check(code, null, options);
            if ( !checkResult.IsSuccess ) {
                foreach ( var error in checkResult.Errors ) {
                    result.AppendLine(error.Message);
                }
                return result.ToString();
            }
            
            var powerFxResult = engine.Eval(code, null, options);

            return ConvertToJson(powerFxResult).Result;  
        } 
        catch ( Exception ex ) {
            return ex.Message;
        }
    } 

    internal static void AddVariables(TexlNode node, RecalcEngine engine) {
        if (node is VariadicOpNode opNode) {
            foreach ( var child in opNode.ChildNodes ) {
                AddVariables(child, engine);
            }
        }
        if (node is CallNode callNode) {
            if (callNode.Head.Name == "Collect") {
                var first = callNode.Args.ChildNodes[0];
                var second = callNode.Args.ChildNodes[1];
                if (first is FirstNameNode identifier) {
                    if (second is TableNode tableValue) {
                        engine.UpdateVariable(identifier.Ident.Name, GenerateTable(tableValue));
                    }
                    if(second is RecordNode recordValue) {
                        var record = GenerateRecord(recordValue);
                        // Query the fields of the RecordValue
                        var fields = record.Fields.Select(field => new NamedValue(field.Name, field.Value)).ToList();
                        // Create a new RecordType based on the queried fields
                        var newRecordType = RecordType.Empty();
                        foreach (var field in fields)
                        {
                            newRecordType = newRecordType.Add(field.Name, field.Value.Type);
                        }
                        engine.UpdateVariable(identifier.Ident.Name,TableValue.NewTable(newRecordType, record));
                    }
                }
            }
            if (callNode.Head.Name == "Set") {
                var first = callNode.Args.ChildNodes[0];
                var second = callNode.Args.ChildNodes[1];
                if (first is FirstNameNode identifier) {
                    if (second is TableNode tableValue) {
                        engine.UpdateVariable(identifier.Ident.Name, GenerateTable(tableValue));
                    }
                    if(second is RecordNode recordValue) {
                        engine.UpdateVariable(identifier.Ident.Name, GenerateRecord(recordValue));
                    }
                    if (second is NumLitNode) {
                        engine.UpdateVariable(identifier.Ident.Name, NumberValue.New(0));
                    }
                    if (second is StrLitNode) {
                        engine.UpdateVariable(identifier.Ident.Name, StringValue.New(""));
                    }
                }
            }
        }
    }

    internal static TableValue GenerateTable(TableNode node) {
        RecordType type = RecordType.Empty();
        var recordValues = new List<RecordValue>();
        var firstRow = true;

        foreach ( var row in node.ChildNodes ) {
            if ( row is StrLitNode stringNode ) {
                if (firstRow) {
                    type  = RecordType.Empty().Add("Value", FormulaType.String);
                }
                recordValues.Add(RecordValue.NewRecordFromFields(new NamedValue("Value", FormulaValue.New(stringNode.Value))));
            }
            if ( row is RecordNode recordNode) {
                if (firstRow) {
                }
                recordValues.Add(GenerateRecord(recordNode));
            }
        }

        return TableValue.NewTable(type, recordValues);
    }

    internal static RecordValue GenerateRecord(RecordNode node) {
        var index = 0;
        List<NamedValue> values = new List<NamedValue>();
        foreach ( Identifier child in node.Ids ) {
            var childValue = node.ChildNodes[index];
            if (childValue is StrLitNode) {
                values.Add(new NamedValue(child.Name, StringValue.New("")));
            }
            if (childValue is NumLitNode) {
                values.Add(new NamedValue(child.Name, NumberValue.NewBlank()));
            }
            index++;
        }

        RecordValue value =  RecordValue.NewRecordFromFields(values.ToArray());
    
        return value;
    }

    internal static async Task<string> ConvertToJson(FormulaValue thenResult)
    {
        if (thenResult is TableValue thenValue)
        {
            return await ConvertTableToJson(thenValue);
        }

        var stack = new Stack<(string, FormulaValue, Dictionary<string, object?>)>();
        var root = new Dictionary<string, object?>(new ExpandoObject());
        stack.Push(("root", thenResult, root));

        while (stack.Count > 0)
        {
            var (key, value, parent) = stack.Pop();

            if (value is RecordValue record)
            {
                var row = new Dictionary<string, object?>(new ExpandoObject());
                await foreach (var field in record.GetFieldsAsync(CancellationToken.None))
                {
                    if (field.Value.TryGetPrimitiveValue(out object val))
                    {
                        row.Add(field.Name, val);
                    }
                    else
                    {
                        stack.Push((field.Name, field.Value, row));
                    }
                }
                parent[key] = row;
            }
            else if (value is TableValue table)
            {
                var tableList = new List<Dictionary<string, object?>>();
                var rows = table.Rows;
                foreach (DValue<RecordValue> row in rows)
                {
                    var rowDict = new Dictionary<string, object?>(new ExpandoObject());

                    if (row.IsValue)
                    {
                        await foreach (var field in row.Value.GetFieldsAsync(CancellationToken.None))
                        {
                            if (field.Value.TryGetPrimitiveValue(out object val))
                            {
                                rowDict.Add(field.Name, val);
                            }
                            else
                            {
                                stack.Push((field.Name, field.Value, rowDict));
                            }
                        }
                        tableList.Add(rowDict);
                    }
                }
                parent[key] = tableList;
            }
            else if (value.TryGetPrimitiveValue(out object primitiveVal))
            {
                parent[key] = primitiveVal;
            }
        }

        if (root.Keys.Count == 1)
        {
            return JsonSerializer.Serialize(root["root"]);
        }

        if (root.ContainsKey("root"))
        {
            root.Remove("root");
        }

        return JsonSerializer.Serialize(root);
    }

    internal static async Task<string> ConvertTableToJson(TableValue value)
    {
        // Convert the TableValue to JSON
        var data = await ConvertToObject(value);
        var responseData = new Dictionary<string, object?>();
        responseData["value"] = data;

        return JsonSerializer.Serialize(responseData);
    }

    internal static async Task<List<object>> ConvertToObject(TableValue value)
    {
        var data = new List<object>();
        foreach (var item in value.Rows)
        {
            var row = new Dictionary<string, object?>(new ExpandoObject());

            await foreach (var field in item.Value.GetFieldsAsync(CancellationToken.None))
            {
                if (field.Value.TryGetPrimitiveValue(out object val))
                {
                    row.Add(field.Name, val);
                    continue;
                }

                // TODO: Handle complex non primative types
            }

            data.Add(row);
        }
        return data;
    }
}