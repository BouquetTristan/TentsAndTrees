require 'gtk3'
require './IGrille.rb'
require './gHelp.rb'
#require './Page.rb'

# Fichier: fPlay.rb
# Auteur: Marchand Killian
# Description: 
# => Fenertre du jeu
# => C'est ici qu'est regroupé les composants de la fenetre de jeu
# => Elle est composé de la grille de jeu, ainsi que la grille d'aide


class FPlay

	def FPlay.construire(fenetre, taille)
		new(fenetre, taille)
	end

	def initialize(fenetre, taille)
		
		@gPlay=Gtk::Table.new(1,3, false)
		fenetre.add(@gPlay)
		
		@grille=Gtk::Table.new(taille+1,taille+1, false)
		@gHelp=Gtk::Table.new(3,1, false)

		@gPlay.attach(@grille, 0,1,0,1)
		@gPlay.attach(@gHelp, 2,3,0,1)
		
		@grille = IGrille.new(taille, @grille)
		@gHelp = GHelp.new(@gHelp)

		fenetre.show_all()
	end	
end
