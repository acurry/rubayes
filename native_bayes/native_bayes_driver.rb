require 'rubygems'
require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'
require 'hpricot'
require_relative "native_bayes"
require 'pp'

categories = %w(tech sports business entertainment)
classifier = NativeBayes.new(categories)

content = ""
categories.each do |category|
  feed = "http://rss.news.yahoo.com/rss/#{category}"
  open(feed) {|s| content = s.read }
  rss = RSS::Parser.parse(content, false)
  rss.items.each do |item|
    text = Hpricot(item.description).inner_text
    classifier.train(category, text)
  end
end

# classify this
documents = [
"Google said on Monday it was releasing a beta version of Google Sync for the iPhone and Windows Mobile phones",
"Michigan come from behind to beat Ohio State",
"Going well beyond its current Windows Mobile software, Microsoft will try to extend its desktop dominance with a Windows phone.",
"Obama jobs bill should help businesses growth",
"A fight in Hancock Park after a pre-Grammy Awards party left the singer with bruises and a scratched face, police say."]

documents.each do |text|
  puts text
  puts "category => #{classifier.classify(text)}"
  puts
end

