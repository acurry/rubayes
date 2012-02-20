#!/usr/bin/ruby
require "stats.rb"

spam_emails = 30
penis_emails = 51
total_emails = 74

spam = Event.new(spam_emails, total_emails, "spam emails")
penis = Event.new(penis_emails, total_emails, "penis emails")
penis_marked_as_spam = 20

puts spam
puts penis
puts p_penis_given_spam = Event.new(penis_marked_as_spam, spam_emails, "penis emails marked as spam")

# objective
p_spam_given_penis = (p_penis_given_spam.p) * (spam.p) / (penis.p).to_f

puts p_spam_given_penis