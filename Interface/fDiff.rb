require 'gtk3'
require './fGameMode.rb'
require './fPlay.rb'
require './Page.rb'
require './fInter.rb'

# Fichier: fDiff.rb
# Auteur: Marchand Killian
# Description:
# => Menu des difficultés
# => C'est ici qu'est regroupé les composants du menu des difficultés
# => Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction de la page


class FDiff < Page

	def initialize(monApp, header, anciennePage, unJoueur, comp)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)

		@butons = Gtk::ButtonBox.new(:horizontal)
    	@butons.layout = :spread

		@easy = Gtk::Button.new(:label => 'Facile', :use_underline => nil, :stock_id => nil)
		@easy.set_relief(:none)
		@medium = Gtk::Button.new(:label => 'Moyen', :use_underline => nil, :stock_id => nil)
		@medium.set_relief(:none)
		@hard = Gtk::Button.new(:label => 'Difficile', :use_underline => nil, :stock_id => nil)
		@hard.set_relief(:none)


		@butons.add(@easy, :expand => true, :fill => false)
		@butons.add(@medium, :expand => true, :fill => false)
		@butons.add(@hard, :expand => true, :fill => false)

		@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(@window, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
    	}

		@easy.signal_connect('clicked') {
			self.supprimeMoi
			diff = "Facile"
			if comp == false
				grilleDeJeu = Grille.creerD(diff)
				suivant=FPlay.new(@window, header, self, unJoueur, diff, grilleDeJeu ,comp)
			else
				suivant=FInter.new(@window, header, self, unJoueur, diff,comp)
			end	
			suivant.ajouteMoi
			@window.show_all
		}
		@medium.signal_connect('clicked') {
			self.supprimeMoi
			diff = "Moyenne"
			if comp == false
				grilleDeJeu = Grille.creerD(diff)
				suivant=FPlay.new(@window, header, self, unJoueur, diff, grilleDeJeu ,comp)
			else
				suivant=FInter.new(@window, header, self, unJoueur, diff,comp)
			end	
			suivant.ajouteMoi
			@window.show_all
		}
		@hard.signal_connect('clicked') {
			self.supprimeMoi
			diff = "Difficile"
			if comp == false
				grilleDeJeu = Grille.creerD(diff)
				suivant=FPlay.new(@window, header, self, unJoueur, diff, grilleDeJeu ,comp)
			else
				suivant=FInter.new(@window, header, self, unJoueur, diff,comp)
			end	
			suivant.ajouteMoi
			@window.show_all
		}
		@frame.attach(@butons,0,1,0,1)

		@bg=(Gtk::Image.new(:file =>"../Assets/ImgGame.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
