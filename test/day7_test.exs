defmodule Day7Test do
  use ExUnit.Case

  test "counts how many addresses are valid from a file" do
    count = Day7.count_supports_tls_from_file("test/data/day7.txt")
    assert count == 2
  end

  test "counts how many addresses are valid" do
    count = Day7.count_supports_tls([
      "abba[mnop]qrst",
      "ioxxoj[asdfgh]zxcvbn",
      "abcd[bddb]xyyx",
      "aaaa[qwer]tyui",
    ])
    assert count == 2
  end

  test "checks if addresses support TLS" do
    assert Day7.supports_tls?("abba[mnop]qrst")
    assert Day7.supports_tls?("ioxxoj[asdfgh]zxcvbn")
    assert Day7.supports_tls?("ioj[asdfgh]zxc[qosj]oxxovbn")
    assert !Day7.supports_tls?("abcd[bddb]xyyx")
    assert !Day7.supports_tls?("abcd[asdf]xyyx[abba]")
    assert !Day7.supports_tls?("aaaa[qwer]tyui")
  end

  test "checks if addresses support SSL" do
    assert Day7.supports_ssl?("aba[bab]xyz")
    assert Day7.supports_ssl?("zazbz[bzb]cdb")
    assert Day7.supports_ssl?("aaa[kek]eke")
    assert Day7.supports_ssl?("aaa[lep]qxe[huh]uhu")
    assert !Day7.supports_ssl?("xyx[xyx]xyx")
  end

  test "checks for ABBA patterns in a substring" do
    assert Day7.abba_valid?("LLLABBAM")
    assert Day7.abba_valid?("XYYX")
    assert !Day7.abba_valid?("XYLLLYY")
    assert !Day7.abba_valid?("XYXYLLA")
  end

  test "checks for ABBA patterns" do
    assert Day7.abba_valid?("ABBA")
    assert Day7.abba_valid?("XYYX")
    assert !Day7.abba_valid?("XYYY")
    assert !Day7.abba_valid?("XYYY")
    assert !Day7.abba_valid?("XXXX")
  end

  test "gets ABA matches" do
    matches = Day7.aba_matches([
      "aaaaaba",
      "zxzx",
      "jjjkjjjjejj",
    ])

    assert matches == [
      "aba",
      "zxz",
      "xzx",
      "jkj",
      "jej",
    ]
  end
end
