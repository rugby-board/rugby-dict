require "helper"

class TestDict < Minitest::Test
  context "test dict" do
    should "init with yaml" do
      dict = RugbyDict::Dict.from_yaml
      assert_equal("Rugby World Cup", dict.dict[0]["w"])
      assert_equal("橄榄球世界杯", dict.dict[0]["t"])
      assert_equal("橄榄球世界杯", dict.dict_hash["Rugby World Cup"])
    end

    should "do word segment" do
      sentence = "The Hurricanes moved a point behind the Crusaders at the top of the table after they beat the Waratahs 38-28 at Westpac Stadium on Friday."
      names = RugbyDict::Dict.segment(sentence)
      assert_equal(["The", "Hurricanes"], names[0])
      assert_equal(["Crusaders"], names[1])
      assert_equal(["Waratahs"], names[2])
      assert_equal(["Westpac", "Stadium"], names[3])
      assert_equal(["Friday"], names[4])
    end

    should "find full word" do
      dict = RugbyDict::Dict.from_yaml
      result = dict.query_dict(["Rugby", "World", "Cup"])
      assert_equal("橄榄球世界杯", result)
    end
  end
end
