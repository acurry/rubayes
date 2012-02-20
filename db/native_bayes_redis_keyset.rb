module NativeBayesRedisKeyset
  DELIMITER = ":"
  ROOT_KEY = "native_bayes"
  WORDS_HASH_SUBKEY = "words"
  CATEGORIES_DOCUMENTS_HASH_SUBKEY = "categories_documents"
  CATEGORIES_WORDS_HASH_SUBKEY = "categories_words"
  TOTAL_DOCUMENTS_SUBKEY = "total_documents"
  TOTAL_WORDS_SUBKEY = "total_words"
  THRESHOLD_SUBKEY = "threshold"
  
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
  
  def words_hash_key
    "#{root_key_with_delimiter}#{WORDS_HASH_SUBKEY}"
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