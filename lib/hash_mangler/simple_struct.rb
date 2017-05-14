module HashMangler
  #
  # Simple object defining singleton methods for each (key, value) pair
  #  passed into []=(key, val) method.
  #
  class SimpleStruct
    def initialize
      @hash = {}
    end

    #
    # sets value for provided key and generates a singleton method
    # @param key [String/Symbol]
    #  a passed value (val) will be available
    # @param val [Object]
    #
    def []=(key, val)
      @hash[key] = val
      define_singleton_method(key) { @hash[key] }
    end

    #
    # retrieves value for provided key
    # @param key [String/Symbol]
    #
    def [](key)
      @hash[key]
    end
  end
end
