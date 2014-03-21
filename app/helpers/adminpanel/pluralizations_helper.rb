module Adminpanel
  module PluralizationsHelper

    def pluralize_es(string)
      pluralized_string = ""
      string.split.each do |word|
        case(word.last)
          when 'a', 'e', 'i', 'o', 'u', 'c'
            pluralized_string = "#{pluralized_string}#{word}s "
          when 'b', 'r'
            pluralized_string = "#{pluralized_string}#{word}es "
          when 'z'
            pluralized_string = "#{pluralized_string}#{word.chop}ces "
          else
            pluralized_string = "#{pluralized_string}#{word} "
        end
      end
      pluralized_string.chop
    end
  end
end