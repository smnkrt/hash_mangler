module HashMangler
  class Mangler
    class KeyMangler
      #
      # @param options [Hash]
      # @option options [Boolean] :snake_case_method_names specifies if generated method
      #  names should be formatted to snake case, defaults to: true
      #
      def initialize(options)
        @snake_case_method_names = options.fetch(:snake_case_method_names, true)
      end

      #
      # formats key to snake case if @snake_case_method_names is true,
      #  otherwise returns key as a symbol
      # @param key [Symbol/String]
      # @return [Symbol]
      #
      def format(key)
        return key.to_sym unless @snake_case_method_names
        key_to_snake_case(key)
      end

      private

      #
      # @params key
      # @return [Symbol] key in snake case
      #
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

    private_constant :KeyMangler
  end
end
