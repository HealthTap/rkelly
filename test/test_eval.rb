require File.dirname(__FILE__) + "/helper"

class EvalTest < Test::Unit::TestCase
  def setup
    @runtime = RKelly::Runtime.new
  end

  def test_integer_equal_integer_is_true
    assert @runtime.eval('1 == 1')
  end

  def test_integer_equal_integer_is_false
    assert !@runtime.eval('1 == 2')
  end

  def test_integer_not_equal_integer_is_true
    assert @runtime.eval('1 != 2')
  end

  def test_integer_not_equal_integer_is_false
    assert !@runtime.eval('1 != 1')
  end

  def test_integer_equal_string_is_false
    assert !@runtime.eval('1 == "2"')
  end

  def test_integer_equal_string_is_true
    assert @runtime.eval('1 == "1"')
  end

  def test_integer_not_equal_string_is_false
    assert !@runtime.eval('1 != "1"')
  end

  def test_integer_not_equal_string_is_true
    assert @runtime.eval('1 != "2"')
  end

  def test_string_equal_integer_is_false
    assert !@runtime.eval('"2" == 1')
  end

  def test_string_equal_integer_is_true
    assert @runtime.eval('"1" == 1')
  end

  def test_string_not_equal_integer_is_false
    assert !@runtime.eval('"1" != 1')
  end

  def test_string_not_equal_integer_is_true
    assert @runtime.eval('"2" != 1')
  end

  def test_float_equal_string_is_true
    assert @runtime.eval('1.5 == "1.5"')
  end

  def test_float_equal_string_is_false
    assert !@runtime.eval('1.5 == "1.52"')
  end

  def test_string_less_integer_is_true
    assert @runtime.eval('"1" < 2')
  end

  def test_string_less_or_equal_integer_is_true
    assert @runtime.eval('"1" <= 1')
  end

  def test_integer_greater_string_is_true
    assert @runtime.eval('2 > "1"')
  end

  def test_integer_greater_or_equal_string_is_true
    assert @runtime.eval('2 >= "2"')
  end

  def test_node_accessor
    assert_equal 1, @runtime.eval('a = {}; a.foo = 1; a.foo')
  end

  def test_bracket_accessor
    assert_equal 1, @runtime.eval('a = {}; a["foo"] = 1; a["foo"]')
  end

  def test_bracket_accessor_2
    assert_equal 1, @runtime.eval('a = {}; b = "foo"; a[b] = 1; a[b]')
  end

  def test_null_integer_comparison
    assert @runtime.eval("null < 1")
  end

  def test_null_integer_comparison_2
    assert @runtime.eval("null > -1")
  end

  def test_null_integer_comparison_3
    assert !@runtime.eval("null > 0")
  end

  def test_null_integer_comparison_3
    assert @runtime.eval("null >= 0")
  end

  def test_null_integer_comparison_4
    assert !@runtime.eval("null == 0")
  end

  def test_integer_null_comparison
    assert @runtime.eval("1 > null")
  end

  def test_integer_null_comparison_2
    assert @runtime.eval("-1 < null")
  end

  def test_integer_null_comparison_3
    assert !@runtime.eval("0 < null")
  end

  def test_integer_null_comparison_3
    assert @runtime.eval("0 <= null")
  end

  def test_integer_null_comparison_4
    assert !@runtime.eval("0 == null")
  end
end
