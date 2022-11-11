require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (0..8).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @grid = params["grid"].split("")
    @word = params["word"].split("")

    @url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @word_serialized = URI.open(@url).read
    @word_dict = JSON.parse(@word_serialized)


    @grid_check = (@word - @grid) == []
    @dictionary_check = @word_dict["found"]
    @both_check = (@grid_check && @dictionary_check)

    case
    when @grid_check == false
      @results = "Your word '#{@word}' is not in the grid"
    when @grid_check && @dictionary_check
      @results = "Your word '#{@word}' is accepted!"
    else
      @results = "Your word '#{@word}' is not a real word"
    end
  end
end
