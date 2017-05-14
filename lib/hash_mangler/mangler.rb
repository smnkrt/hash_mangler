require_relative 'mangler/key_mangler'
require_relative 'simple_struct'

module HashMangler
  class Mangler
    #
    # @param options [Hash]
    # @option options [Boolean] :snake_case_method_names specifies if generated method
    #  names should be formatted to snake case, defaults to: true
    # @option options [Proc] :value_mangler optional proc called for each leaf value
    #   defaults to: proc { |o| o }
    # @option options [Class] :struct_class optional class which will be used to convert
    #   hash data into object, defaults to: HashMangler::SimpleStruct
    #   any class with [](key) and []=(key, value) accessor methods
    #
    def initialize(options = {})
      @value_mangler           = options.fetch(:value_mangler, proc { |o| o })
      @struct_class            = options.fetch(:struct_class , HashMangler::SimpleStruct)
      @key_mangler             = KeyMangler.new(options)
    end

    #
    # @param obj (Object) for which mangling should be performed
    #  it should respond to []= and [] methods
    # @return [struct_class]
    #
    def mangle(obj)
      return @value_mangler.call(obj) unless obj.is_a?(Hash) || obj.is_a?(Array)
      return obj.map { |v| mangle(v) } if obj.is_a?(Array)
      r = @struct_class.new()
      obj.each { |k, v| r[@key_mangler.format(k)] = mangle(v) }
      r
    end
  end
end
