require 'open-uri'
require 'json'
require "nokogiri"

class GamesController < ApplicationController
  # def initialize
  #   @letters = []
  # end

  def new
    @letters = []
    10.times{ @letters << ('A'..'Z').to_a.sample }
    # TODO: generate random grid of letters
  end

  def in_grid?(attempt, letters)
    grid = letters
    attempt.upcase!
    array = attempt.chars
    return false if !array.all? { |char| grid.include? char }

    array.each do |x|
      return false if array.count(x) > grid.count(x)
    end
    true
  end

def score
  grid = params[:letters]
    @result = params[:word]
    attempt = @result

  attempt.upcase!
  array = attempt.chars
  url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
  html_file = URI.open(url).read
  html_doc = JSON.parse(html_file)
  #time = end_time - start_time
  # check if in the grid
  if in_grid?(@result, grid)
    # now check if in dictionary
    if html_doc["found"] == true
      @message = "Congratulations! This is a valid English word, you win!"

      # score = array.size - time
    else
      @message = "Nope! This is not an english word"

      # score = 0
    end
  else
    @message = "Ooops! The given word is not in the grid"

    # score = 0
  end


  # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
end



end
