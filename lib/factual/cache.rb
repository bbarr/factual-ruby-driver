class Factual
  class Cache
    class << self

      attr_reader :instance

      def config &block
        raise Error, "Cache already configured" unless @instance.nil?

        cache = self.new
        cache.instance_eval(&block) if block_given?

        has_get = cache.instance_variable_defined?(:@getter)
        has_set = cache.instance_variable_defined?(:@setter)
        unless has_get and has_set
          raise Error, "#{has_get ? 'get' : 'set'} is not defined for cache."
        end

        @instance = cache
      end
    end

    attr_accessor :getter, :setter

    def get *args, &block
      @getter = block and return if block_given?   
      @getter.call(*args)
    end

    def set *args, &block
      @setter = block and return if block_given?   
      @setter.call(*args)
    end

    def max_age response
      response['cache-control'].split('=')[1].to_i
    end
  end
end
