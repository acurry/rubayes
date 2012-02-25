require_relative "../rubayes/rubayes_utils"

class DummyUtils; include RubayesUtils; end

describe RubayesUtils do
  describe "word_count" do
    before :each do
      @dummy_utils = DummyUtils.new
    end
    
    it "should take in a string and make a hash of each word's root and count of each word" do
      dummy_tech_doc = "apple apple apple boss boss car dummy"
      @dummy_utils.word_count(dummy_tech_doc)
        .should eq({"appl"=>3, "boss"=>2, "car"=>1, "dummi"=>1})
    end
    
    it "should not count common words contained in COMMON_WORDS" do
      dummy_common_doc = "I am certainly against death."
      @dummy_utils.word_count(dummy_common_doc)
        .should eq({"death"=>1})
    end
    
    it "should remove all non-word and non-space chars" do
      dummy_garbage_doc = "Oh! Sweet. OK then, so long, and VALONQAR!"
      @dummy_utils.word_count(dummy_garbage_doc)
        .should eq({"sweet"=>1, "long"=>1, "valonqar"=>1})
    end
    
    it "should convert all words found in the doc to lower-case before putting it in the hash" do
      dummy_all_caps_doc = "HELL YES MY FRIEND!"
      @dummy_utils.word_count(dummy_all_caps_doc)
        .should eq({"hell"=>1, "friend"=>1})
    end
  end
end