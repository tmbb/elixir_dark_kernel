defmodule DarkKernel.DarkKeywordTest do
  use ExUnit.Case, async: true
  import DarkKernel
  alias DarkKernel.DarkKeywords.{
    InvalidKeywordError,
    InvalidKeywordMatchExpressionError
  }

  test "~k[] expressions capture user variables correctly" do
    {a, b, c} = {"A", "B", "C"}

    assert ~k[a, b, c] == [a: "A", b: "B", c: "C"]
  end

  test "~k[] expressions respect order of the keys" do
    {a, b, c} = {"A", "B", "C"}

    assert ~k[c, a, b] == [c: "C", a: "A", b: "B"]
  end

  test "~k[] expressions allow repeated keys" do
    {a, b, c} = {"A", "B", "C"}

    assert ~k[a, a, b, b, b, c] == [a: "A", a: "A", b: "B", b: "B", b: "B", c: "C"]
  end

  test "~k[] match expressions return only the matched keys and values" do
    opts = [a: 1, b: 2, c: 3]
    assert Keyword.keys(~k[a, b = opts]) == [:a, :b]
    assert Keyword.keys(~k[a, b = opts]) != [:a, :b, :c]
  end

  test "~k[] match expressions return the matched keys in the correct order" do
    opts = [a: 1, b: 2, c: 3]
    assert Keyword.keys(~k[b, a, c = opts]) == [:b, :a, :c]
    assert Keyword.keys(~k[b, a, c = opts]) != [:a, :b, :c]
  end

  test "~k[] match expressions assign variables to nil when appropriate" do
    opts = [a: "A", b: "B", c: "C"]

    ~k[a, b, c, d = opts]

    assert a == "A"
    assert b == "B"
    assert c == "C"
    assert d == nil
  end

  test "~k[] match expression: bang (!) gives the same result - 1" do
    opts = [a: "A", b: "B", c: "C"]
    assert ~k[a, b, c = opts] ==  ~k[!a, !b, !c = opts]
  end

  test "~k[] match expression: bang (!) gives the same result - 2" do
    opts = [a: "A", b: "B", c: "C"]

    ~k[!a, !b, !c = opts]

    assert a == "A"
    assert b == "B"
    assert c == "C"
  end

  test "~k[] match expression with default values: integer constant" do
    opts = [a: "A"]

    ~k[!a, b: 1 = opts]
    ~k[c: 2 = opts]

    assert a == "A"
    assert b == 1
    assert c == 2
  end

  test "~k[] match expression with default values: float constant" do
    opts = [a: "A"]

    ~k[!a, b: 2.78 = opts]
    ~k[c: 3.14 = opts]

    assert a == "A"
    assert b == 2.78
    assert c == 3.14
  end

  test "~k[] match expression with default values: string constant" do
    opts = [a: "A"]

    ~k[!a, b: "a string" = opts]
    ~k[c: "another string" = opts]

    assert a == "A"
    assert b == "a string"
    assert c == "another string"
  end

  test "~k[] match expression with default values: charlist constant" do
    opts = [a: "A"]

    ~k[!a, b: 'a charlist' = opts]
    ~k[c: 'another charlist' = opts]

    assert a == "A"
    assert b == 'a charlist'
    assert c == 'another charlist'
  end

  test "~k[] match expression with default values: date and time sigils" do
    opts = [a: "A"]

    ~k[!a, b: ~D{2022-10-12} = opts]
    ~k[c: ~T{10:00:00} = opts]

    assert a == "A"
    assert b == ~D[2022-10-12]
    assert c == ~T{10:00:00}
  end

  test "~k[] match expression with default values: functions" do
    opts = [a: "A"]

    ~k[!a, b: :rand.uniform() = opts]
    ~k[c: :rand.uniform() = opts]

    assert a == "A"
    assert is_float(b)
    assert is_float(c)
    assert b != c
  end

  test "~k[] match expression with default values: arithmetic expressions" do
    opts = [a: "A"]

    ~k[!a, b: 1 + 2 = opts]
    ~k[c: 5 + :rand.uniform() = opts]

    assert a == "A"
    assert b == 3
    assert is_float(c)
    assert b != c
  end

  test "~k[] match expression can't contain two equals signs" do
    code_that_does_not_compile =
      quote do
        opts = [a: "A"]
        ~k[!a, b: (_ = 1 + 2) = opts]
      end

    message_beginning = ~r/Invalid dark keyword match expression:/

    assert_raise InvalidKeywordMatchExpressionError, message_beginning, fn ->
      Code.eval_quoted(code_that_does_not_compile)
    end
  end

  test "~k[] bang keywords can't have defaults" do
    code_that_does_not_compile =
      quote do
        opts = [a: "A", b: "B"]
        ~k[a, b, !c: 1 = opts]
      end

    assert_raise InvalidKeywordError, ~r/Invalid keyword: !c/, fn ->
      Code.eval_quoted(code_that_does_not_compile)
    end
  end
end
