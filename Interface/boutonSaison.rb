
require 'gtk3'
require './fSaison.rb'

class BoutonSaison

	# @bouton
	# @coordI, @coordJ
	# @@prix : prix de l'aide en feuille

	def initialize(uneSaison, cliquable)
		@bouton = Gtk::Button.new()
		@img=(Gtk::Image.new(:file =>"../Assets/Vignette#{uneSaison}.png"))
        @bouton.set_image(@img)
        focus_hadjustment=(:start)
		@cliquable = cliquable

		case uneSaison
			when "Printemps" then
				@saison = 0
			when "Ete" then
				@saison = 1
			when "Automne" then
				@saison = 2
			when "Hiver" then
				@saison = 3
   		end
   		puts @saison
	end

	def debloquer(unJoueur)
		if (@cliquable == false)
			@cliquable == unJoueur.acheterNiveau(@saison)
		end
	end

	def lancer(uneApp, unHeader, unePrecedente, unJoueur)
		if (@cliquable == true)
			unePrecedente.supprimeMoi
			suivante = FSaison.new(uneApp, unHeader, unePrecedente, unJoueur, @saison)
			suivante.ajouteMoi
			uneApp.show_all
		end
   	end

	attr_accessor :bouton, :cliquable


end