require_relative "../db/rubayes_redis_keyset"

class DummyKeysetUser; include RubayesRedisKeyset; end

describe RubayesRedisKeyset do
  before :each do
    @dummy = DummyKeysetUser.new
  end
  
  describe "root_key" do
    it "should return the root key" do
      @dummy.root_key.should eq "rubayes"
    end
  end
  
  describe "root_key_with_delimiter" do
    it "should return the root key, appended by delimiter" do
      @dummy.root_key_with_delimiter.should eq "rubayes:"
    end
  end
  
  describe "set_of_categories_key" do
    it "should return the set_of_categories key" do
      @dummy.set_of_categories_key.should eq "rubayes:set_of_categories"
    end
  end
  
  describe "words_category_hash_key" do
    it "should return the words hash key" do
      @dummy.words_category_hash_key("tech").should eq "rubayes:words:tech"
    end
  end
  
  describe "categories_documents_key" do
    it "should return the categories_documents key" do
      @dummy.categories_documents_key.should eq "rubayes:categories_documents"
    end
  end
  
  describe "categories_words_key" do
    it "should return the categories_words key" do
      @dummy.categories_words_key.should eq "rubayes:categories_words"
    end
  end
  
  describe "total_documents_key" do
    it "should return the total_documents key" do
      @dummy.total_documents_key.should eq "rubayes:total_documents"
    end
  end
  
  describe "total_words_key" do
    it "should return the total_words key" do
      @dummy.total_words_key.should eq "rubayes:total_words"
    end
  end
  
  describe "threshold_key" do
    it "should return the threshold key" do
      @dummy.threshold_key.should eq "rubayes:threshold"
    end
  end
end
