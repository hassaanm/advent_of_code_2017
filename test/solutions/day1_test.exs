defmodule AOC.Solutions.Day1Test do
  use ExUnit.Case
  doctest AOC.Solutions.Day1

  # sum_captcha tests
  describe ".sum_captcha" do
    test "sum_captcha is the sum of matching digits next to each other" do
      assert AOC.Solutions.Day1.sum_captcha("1122") == 3
      assert AOC.Solutions.Day1.sum_captcha("445555") == 19
    end

    test "sum_captcha is the sum of matching digits next to each other (including wrap around)" do
      assert AOC.Solutions.Day1.sum_captcha("1001") == 1
      assert AOC.Solutions.Day1.sum_captcha("9889") == 17
    end

    test "sum_captcha of any one digit is that same digit" do
      assert AOC.Solutions.Day1.sum_captcha("3") == 3
      assert AOC.Solutions.Day1.sum_captcha("9") == 9
    end

    test "sum_captcha of all same digits is the digit times the length of the string" do
      assert AOC.Solutions.Day1.sum_captcha("333") == 9
      assert AOC.Solutions.Day1.sum_captcha("5555") == 20
    end

    test "sum_captcha of all unique digits is 0" do
      assert AOC.Solutions.Day1.sum_captcha("1234") == 0
      assert AOC.Solutions.Day1.sum_captcha("3940") == 0
    end

    test "sum_captcha of no matching digits next to each other is 0" do
      assert AOC.Solutions.Day1.sum_captcha("1212") == 0
      assert AOC.Solutions.Day1.sum_captcha("0131") == 0
    end
  end

  describe ".sum_captcha_half" do
    test "sum_captcha_half is the sum of matching digits with shift of half length" do
      assert AOC.Solutions.Day1.sum_captcha_half("1212") == 6
      assert AOC.Solutions.Day1.sum_captcha_half("445555") == 10
    end

    test "sum_captcha_half of all same digits is the digit times the length of the string" do
      assert AOC.Solutions.Day1.sum_captcha_half("3333") == 12
      assert AOC.Solutions.Day1.sum_captcha_half("5555") == 20
    end

    test "sum_captcha_half of all unique digits is 0" do
      assert AOC.Solutions.Day1.sum_captcha_half("1234") == 0
      assert AOC.Solutions.Day1.sum_captcha_half("3940") == 0
    end

    test "sum_captcha_half of no matching digits with shift of half length is 0" do
      assert AOC.Solutions.Day1.sum_captcha_half("1122") == 0
      assert AOC.Solutions.Day1.sum_captcha_half("0110") == 0
    end
  end
end
