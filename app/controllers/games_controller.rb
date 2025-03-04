require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    # servira à afficher une nouvelle grille aléatoire et un formulaire
    @letters = ('A'..'Z').to_a.sample(10)
    # Le formulaire sera envoyé (avec POST) à l’action score.
  end

  def score
    @letters = params[:userletters]
    @word = params[:word].upcase # on recup l'entrée utilisateur
    #  Le mot ne peux pas être fait avec d’autre lettres que celle afficher
    @included = @word.chars.all? do |letter|
                  @word.count(letter) <= @letters.count(letter)
                end
    @valid_word = valid_word?(@word)
    # Récupérer de la donné hiden filtag
    # Le mot est valide d’après la grille et est un mot anglais valide.
    # le mot doit être en anglais validé

  end
  def valid_word?(word)
    url = "https://dictionary.lewagon.com/#{word}"
      user_serialized = URI.parse(url).read
      user = JSON.parse(user_serialized)
      user['found']
  end
end
