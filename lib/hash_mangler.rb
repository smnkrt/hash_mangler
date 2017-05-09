require "hash_mangler/version"

class String
  def snakecase
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end


module HashMangler
  class SimpleStruct
    def initialize
      @hash = {}
    end

    def []=(key, val)
      key = key.to_s.snakecase.to_sym
      @hash[key] = val
      define_singleton_method(key) { @hash[key] }
    end

    def [](key)
      @hash[key.to_s.snakecase.to_sym]
    end
  end

  class Mangler
    def mangle(a)
      return a unless a.is_a?(Hash) || a.is_a?(Array)
      return a.map { |v| mangle(v) } if a.is_a?(Array)
      r = SimpleStruct.new
      a.each { |k, v| r[k] = mangle(v) }
      r
    end
  end
end
