module Regexer
  class Pattern
    def initialize
      @result_pattern = ""
    end
  
    def regex(&block)
      instance_exec(&block)
      /#{@result_pattern}/
    end
  
    def has_letters(**kwargs)
      pattern = "[#{kwargs[:from]}-#{kwargs[:to]}]+"
      pattern.gsub!("+", "*") if kwargs[:optional]
      @result_pattern.concat(pattern)
    end
  
    def has_numbers(**kwargs)
      pattern = "[#{kwargs[:from]}-#{kwargs[:to]}]+"
      pattern.gsub!("+", "*") if kwargs[:optional]
      @result_pattern.concat(pattern)
    end
  
    def contains(value, **kwargs)
      pattern = "#{value}+"
      pattern = pattern[..-2] if kwargs[:one?]
      pattern = "#{pattern[..-2]}*" if kwargs[:optional]
      @result_pattern.concat(pattern)
    end
  end
end