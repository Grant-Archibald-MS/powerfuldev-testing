using System.Globalization;
using System.Runtime.InteropServices.JavaScript;
using System.Runtime.Versioning;
using System.Text;
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
            if (powerFxResult is StringValue stringValue) {
                return stringValue.Value;
            }
            if (powerFxResult is NumberValue numberValue) {
                return numberValue.Value.ToString();
            } 
            if (powerFxResult is BooleanValue booleanValue) {
            return booleanValue.Value.ToString();
            }

            string? value = powerFxResult.ToString();
            return !string.IsNullOrEmpty(value) ? value : String.Empty;  
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
            if (callNode.Head.Name == "Set") {
                var first = callNode.Args.ChildNodes[0];
                var second = callNode.Args.ChildNodes[1];
                if (first is FirstNameNode identifier) {
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
}