require 'hash_mangler/version'

module HashMangler
  class SimpleStruct
    def initialize(snake_case_method_names = true)
      @snake_case_method_names = snake_case_method_names
      @hash = {}
    end

    def []=(key, val)
      key = format_key(key)
      @hash[key] = val
      define_singleton_method(key) { @hash[key] }
    end

    def [](key)
      @hash[format_key(key)]
    end

    private

    def format_key(key)
      return key unless @snake_case_method_names
      key_to_snake_case(key)
    end

    def key_to_snake_case(key)
      key
        .to_s
        .gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr('-', '_')
        .downcase
        .to_sym
    end
  end

  class Mangler
    def initialize(options = {})
      @snake_case_method_names = options.fetch(:snake_case_method_names, true)
      @value_mangler = options.fetch(:value_mangler, proc { |o| o })
    end

    def mangle(a)
      return @value_mangler.(a) unless a.is_a?(Hash) || a.is_a?(Array)
      return a.map { |v| mangle(v) } if a.is_a?(Array)
      r = HashMangler::SimpleStruct.new(@snake_case_method_names)
      a.each { |k, v| r[k] = mangle(v) }
      r
    end
  end
end
