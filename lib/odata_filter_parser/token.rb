module OdataFilterParser::Token
  METHOD_NAMES = %w(
    endswith
    indexof
    replace
    startswith
    tolower
    toupper
    trim
    substring
    substringof
    concat
    length
    gettotaloffsetminutes
    year
    month
    day
    hour
    minute
    second
    round
    floor
    ceiling
    geo\\.distance
    geo\\.length
    geo\\.intersects
  )

  TOKENS = [
      {
        :token => :LEFT_PARENTHESIS,
        :matcher => /\([\s]*/
      },
      {
        :token => :RIGHT_PARENTHESIS,
        :matcher => /[\s]*\)[\s]*/
      },
      {
        :token => :COMMA,
        :matcher => /[\s]*\,[\s]*/
      },
      {
        :token => :NULL_LITERAL,
        :matcher => /null/    # TODO: optional qualifiedTypeName
      },
      {
        :token => :BOOLEAN_LITERAL,
        :matcher => /(true|false)/
      },
      {
        :token => :STRING_LITERAL,
        :matcher => /\'.*\'/,
      },
      {
        :token => :DATETIME_LITERAL,
        :matcher => 
           /datetime\'[0-9]{4}\-[0-9]{2}\-[0-9]{2}T[0-9]{2}\:[0-9]{2}(:[0-9]{2}(\.[0-9]{1,7})?)?\'/,
      },
      {
        :token => :DECIMAL_LITERAL,
        :matcher => /[+-]?[0-9]{1,29}(\.[0-9]{1,29})?(M|m)/,
      },
      {
        :token => :INT_64_LITERAL,
        :matcher => /[+-]?[0-9]{1,19}(L|l)/,
      },
      {
        :token => :INT_32_LITERAL,
        :matcher => /[+-]?[0-9]{6,10}/,
      },
      {
        :token => :INT_16_LITERAL,
        :matcher => /[+-]?[0-9]{1,5}/,
      },
      {
        :token => :METHOD_CALL,
        :matcher => /(#{METHOD_NAMES.join("|")})[\s]*/
      },
      {
        :token => :WSP,
        :matcher  => /\s+/
      }
  ]



  def self.all
    TOKENS.each { |token| yield(token) }
  end

  def self.build(token_sym, value)
    [token_sym, value]
  end
end
