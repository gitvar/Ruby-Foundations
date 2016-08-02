require 'minitest/autorun'

class EqualityTest < Minitest::Test

  def test_value_equality
    str1 = "hello there"
    str2 = "hello there"

    assert_equal(str1, str2)
    assert_same(str1, str2)
  end
end
