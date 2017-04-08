module RugbyDict
  class Dict
    attr_reader :dict
    attr_reader :dict_hash

    def initialize(dict)
      @dict = dict || []
      @dict_hash = {}
      @dict.each do |item|
        @dict_hash[item["w"]] = item["t"]
      end
    end

    class << self
      def from_yaml
        require "yaml"
        lib = File.expand_path('..', __FILE__)
        p lib
        dict = YAML.load_file("#{lib}/dict.yml")
        new(dict)
      end
    end

    def self.segment(input)
      names = []
      temp = []
      input.split(" ").each do |word|
        if word.capital?
          if word.end_with_punct?
            temp << word[0..-2]
          else
            temp << word
          end
        else
          unless temp.empty?
            names << temp
            temp = []
          end
        end
      end

      unless temp.empty?
        names << temp
      end

      names
    end

    def query_dict(input)
      full_word = input.join(" ")
      if @dict_hash.key?(full_word)
        @dict_hash[full_word]
      else
        input.permutate.each do |item|
          query_dict(item)
        end
      end
    end

    def permutate(input)
    end
  end
end

class String
  def capital?
    /[[:upper:]]/.match(self[0])
  end

  def end_with_punct?
    /[[:punct:]]/.match(self[-1])
  end
end
