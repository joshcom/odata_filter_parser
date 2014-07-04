module OdataFilterParser
  require 'strscan'
  require_relative 'token'
  class Lexer < StringScanner
    def initialize(str)
      str.freeze
      super(str, false)
    end

    def shift
      token = nil
      value = nil

      OdataFilterParser::Token.all do |token_def|
        if value = scan(token_def[:matcher])
          puts token_def.inspect
          token = OdataFilterParser::Token.build(token_def[:token], value)
          break
        end
      end

      token.freeze
    end
  end
end
