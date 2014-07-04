class OdataFilterParser::Parser
rule
  intersectsMethodCallExpr    : method_call
                                    LEFT_PARENTHESIS function_parameter RIGHT_PARENTHESIS 
                                    {tokenize_function(val)} |
                                method_call
                                    LEFT_PARENTHESIS function_parameter 
                                    COMMA function_parameter RIGHT_PARENTHESIS 
                                    {tokenize_function(val)} |
                                method_call
                                    LEFT_PARENTHESIS function_parameter 
                                    COMMA function_parameter
                                    COMMA function_parameter RIGHT_PARENTHESIS 
                                    {tokenize_function(val)} ;

  method_call                 : METHOD_CALL    { prepare_next_method(val[0]) }


  # primitiveLiteral is wrong, but a start.  Nested methods need to be supported
  function_parameter          : primitiveLiteral { collect_function_parameter(val[0]) } ; 

  primitiveLiteral            : NULL_LITERAL     { record_last_type(:null)   } |
                                BOOLEAN_LITERAL  { record_last_type(:boolean)} | 
                                STRING_LITERAL   { record_last_type(:string) } |
                                DATETIME_LITERAL { record_last_type(:datetime) }|
                                INT_16_LITERAL   { record_last_type(:int_16) } |
                                INT_32_LITERAL   { record_last_type(:int_32) } |
                                INT_64_LITERAL   { record_last_type(:int_64) } |
                                DECIMAL_LITERAL   { record_last_type(:int_64) } 
                              ; 
end

---- inner
require_relative 'parser_methods'
include OdataFilterParser::ParserMethods
