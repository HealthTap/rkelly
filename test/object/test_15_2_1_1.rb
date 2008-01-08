require File.dirname(__FILE__) + "/../helper"

class Object_15_2_1_1_Test < Test::Unit::TestCase
  def setup
    @runtime = RKelly::Runtime.new
    @runtime.define_function(:assert_equal) do |*args|
      assert_equal(*args)
    end
  end

  def test_null_value_of
    @runtime.execute("
                     var NULL_OBJECT = Object(null);
                     assert_equal(NULL_OBJECT, (NULL_OBJECT).valueOf());
                     ")
  end

  def test_null_type_of
    js_assert_equal("'object'", 'typeof (Object(null))')
  end

  def test_undefined_value_of
    @runtime.execute("
                     var UNDEF_OBJECT = Object(void 0);
                     assert_equal(UNDEF_OBJECT, (UNDEF_OBJECT).valueOf());
                     ")
  end

  def test_undefined_type_of
    js_assert_equal("'object'", 'typeof (Object(void 0))')
  end

  def js_assert_equal(expected, actual)
    @runtime.execute("assert_equal(#{expected}, #{actual});")
  end
end
