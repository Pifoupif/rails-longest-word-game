require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    word_array = params[:word].split(//)
    letters_array = params[:letters].split(" ")
    arr = []
    if is_english?(params[:word])
      word_array.each do |letter|
        if letters_array.include?(letter) && letters_array.count(letter) >= word_array.count(letter)
          i = word_array.index(letter)
          arr << word_array[i]
        end
      end
      arr.sort == word_array.sort ? @score = true : @score = false
    else
      @score = false
    end
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('a'..'z').to_a.sample }
  end

  def is_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_word = open(url).read
    word = JSON.parse(serialized_word)
    word["found"]
  end
end
