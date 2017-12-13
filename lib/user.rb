require 'pry'
require './lib/joke'
require 'csv'

class User
  attr_reader :name

  attr_accessor :jokes

  def initialize(name)
    @name = name
    @jokes = []
  end

  def learn(joke)
    @jokes.push(joke)
  end

  def tell(friend, joke)
    friend.learn(joke)
  end

  def perform_routine_for(friend)
      @jokes.each do |joke|
        friend.jokes << joke
      end
  end

  def learn_routine(filename)
    jokes = CSV.read(filename)
    jokes.each_with_index do |row, index|
      if index == 0
      else
        @jokes << Joke.new({id: row[0],
            question: row[1].lstrip, answer: row[2].lstrip})
      end
    end
  end

end
