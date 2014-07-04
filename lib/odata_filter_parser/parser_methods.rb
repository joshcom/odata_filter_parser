module OdataFilterParser
  require_relative 'lexer'
  module ParserMethods
    attr_accessor :expresions

    def parse(str)
      @expressions = []
      @method_stack = []
      @lexer = OdataFilterParser::Lexer.new(str)
      do_parse

      @expressions
    end

    def next_token
      @lexer.shift
    end

    def prepare_next_method(name)
      @method_stack.unshift({
        :method_name       => name,
        :method_parameters => [] 
      })
    end

    def tokenize_function(vals)
      @expressions << @method_stack.shift
    end

    def collect_function_parameter(value)
      @method_stack.first[:method_parameters] << {
        :value => value,
        :type  => @last_type
      }
    end

    def record_last_type(type_sym)
      @last_type = type_sym
    end
  end
end
