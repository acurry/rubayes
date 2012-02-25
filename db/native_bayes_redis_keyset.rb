module RubayesRedisKeyset
  DELIMITER = ":"
  ROOT_KEY = "native_bayes"
  WORDS_HASH_SUBKEY = "words"
  CATEGORIES_DOCUMENTS_HASH_SUBKEY = "categories_documents"
  CATEGORIES_WORDS_HASH_SUBKEY = "categories_words"
  TOTAL_DOCUMENTS_SUBKEY = "total_documents"
  TOTAL_WORDS_SUBKEY = "total_words"
  THRESHOLD_SUBKEY = "threshold"
  SET_OF_CATEGORIES_SUBKEY = "set_of_categories"
  PLACEHOLDER_KEY = "qwertyuio"
  PLACEHOLDER_VALUE = "asdfghjkl"
  
  # @words
  # => native_bayes:words
  # @words[category] => hash
  # => native_bayes:words:category
  # @words[category][word] => integer
  # => native_bayes:words:category:word 
  
  def root_key
    "#{ROOT_KEY}"
  end
  
  def root_key_with_delimiter
    "#{root_key}#{DELIMITER}"
  end
  
  def set_of_categories_key
    "#{root_key_with_delimiter}#{SET_OF_CATEGORIES_SUBKEY}"
  end
  
  def words_category_hash_key(category)
    "#{root_key_with_delimiter}#{WORDS_HASH_SUBKEY}#{DELIMITER}#{category}"
  end
  
  def categories_documents_key
    "#{root_key_with_delimiter}#{CATEGORIES_DOCUMENTS_HASH_SUBKEY}"
  end
  
  def categories_words_key
    "#{root_key_with_delimiter}#{CATEGORIES_WORDS_HASH_SUBKEY}"
  end
  
  def total_documents_key
    "#{root_key_with_delimiter}#{TOTAL_DOCUMENTS_SUBKEY}"
  end
  
  def total_words_key
    "#{root_key_with_delimiter}#{TOTAL_WORDS_SUBKEY}"
  end
  
  def threshold_key
    "#{root_key_with_delimiter}#{THRESHOLD_SUBKEY}"
  end  
end