
require 'gtk3'
require './Interface/fSaison.rb'

#====== La classe BoutonSaison représente les boutons de l'interface sur la section aventure

class BoutonSaison

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ		:Coordonée du bouton
	# @@prix 		: prix de l'aide en feuille

	def initialize(uneSaison, cliquable)
		@bouton = Gtk::Button.new()
        focus_hadjustment=(:start)
		@cliquable = cliquable
		@saison = uneSaison
		case @cliquable
			when true then
				@img=(Gtk::Image.new(:file =>"./Assets/Vignette#{@saison}.png"))
		        @bouton.set_image(@img)
			when false then
				@img=(Gtk::Image.new(:file =>"./Assets/Vignette#{@saison}V.png"))
		        @bouton.set_image(@img)
		end

		case @saison
			when "Printemps" then
				@numSaison = 0
			when "Ete" then
				@numSaison = 1
			when "Automne" then
				@numSaison = 2
			when "Hiver" then
				@numSaison = 3
   		end
   		puts @saison
	end

	def debloquer(unJoueur)
		if (@cliquable == false)
			@cliquable = unJoueur.acheterNiveau(@numSaison)
		end
		if (@cliquable)
			@img=(Gtk::Image.new(:file =>"./Assets/Vignette#{@saison}.png"))
        	@bouton.set_image(@img)
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
