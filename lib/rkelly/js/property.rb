module RKelly
  module JS
    class Property
      attr_accessor :name, :value, :attributes, :function, :binder
      def initialize(name, value, binder = nil, function = nil, attributes = [])
        @name = name
        @value = value
        @binder = binder
        @function = function
        @attributes = attributes
      end

      [:read_only, :dont_enum, :dont_delete, :internal].each do |property|
        define_method(:"#{property}?") do
          self.attributes.include?(property)
        end
      end

      def to_s
        if function
          "#{name}: #{function}"
        elsif value.is_a?(Proc)
          "#{name}: function() { ... }"
        else
          "#{name}: #{value}"
        end
      end
    end
  end
end
