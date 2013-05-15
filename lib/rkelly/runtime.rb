require 'rkelly/js'
require 'rkelly/runtime/scope_chain'

module RKelly
  class Runtime
    UNDEFINED = RKelly::JS::Property.new(:undefined, :undefined)

    def initialize
      @parser = Parser.new
      @scope  = ScopeChain.new
    end

    def [](name)
      var = @scope[name]
      var.is_a?(RKelly::JS::Property) ? var.value : nil
    end

    def []=(name, value)
      @scope[name].value = value
    end

    # Execute +js+
    def execute(js)
      eval(js)
      @scope
    end

    def eval(js)
      function_visitor  = Visitors::FunctionVisitor.new(@scope)
      eval_visitor      = Visitors::EvaluationVisitor.new(@scope)
      tree = @parser.parse(js)
      function_visitor.accept(tree)
      eval_visitor.accept(tree)
    end

    def call_function(function_name, *args)
      function = @scope[function_name].value
      @scope.new_scope { |chain|
        function.js_call(chain, *(args.map { |x|
          RKelly::JS::Property.new(:param, x)
        }))
      }.value
    end

    def define_function(function, &block)
      @scope[function.to_s].function = block
    end
  end
end
