# rubayes
A naive Bayes document classifier in Ruby that uses Redis for persistence.

## rubayes + redis
[Redis](http://redis.io/ "Redis") is an open-source distributed key-value store
that integrates quite nicely with Ruby. Redis works natively with advanced collections
such as lists, arrays, hashes, sets, and sorted sets. Using Ruby, this means
that when a hash is fetched from Redis, its class is a native Ruby Hash.

## inspired by:
http://blog.saush.com/2009/02/11/naive-bayesian-classifiers-and-ruby/

## what?
A naive Bayes classifier is a tool used to classify documents as a certain
category based on the words in the document. The classifier "trains" itself
by ingesting existing documents that are already classified into certain categories.
The more data it ingests, the better the classifier gets at classifying unknown documents.

## why?
I made this to learn about Bayes classification and how to use NoSQL databases like
Redis, MongoDB, and Cassandra.

## prereqs
Install Redis on your local machine. If you're on a Mac and have [Homebrew](http://mxcl.github.com/homebrew/ "Homebrew") installed, it's as simple as:

    $ brew install redis

Once it's installed, run Redis locally using the default host and port, (`127.0.0.1` and `6379`, respectively.)

## To clone:

    $ git clone git://github.com:acurry/rubayes.git    

## To run the specs:

    $ bundle install
    $ rspec

## To run the example

    $ ruby rubayes/rubayes_driver.rb
    
## future plans
* Make rubayes work with [MongoDB](http://www.mongodb.org/ "MongoDB"), [Cassandra](http://cassandra.apache.org/ "Cassandra"), and [Hyperdex](http://hyperdex.org/ "Hyperdex").


