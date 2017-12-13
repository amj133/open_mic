require 'pry'
require './lib/user'

class Joke
  attr_reader :id, :question, :answer

  def initialize(joke_info)
    @id = joke_info[:id]
    @question = joke_info[:question]
    @answer = joke_info[:answer]
  end
  
end
