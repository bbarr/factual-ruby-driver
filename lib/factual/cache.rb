class Factual
  class Cache
    class << self

      attr_reader :instance

      def set &block

        cache = Class.new
        cache.class_eval(&block) if block_given?

        has_get = cache.method_defined?(:get)
        has_set = cache.method_defined?(:set)
        unless has_get and has_set
          raise NoMethodError, "#{has_get ? 'get' : 'set'} method is not defined for cache."
        end

        @instance = cache.new
      end
    end
  end
end
