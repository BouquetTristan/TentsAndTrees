require 'gtk3'

require './fDiff.rb'
#require '../Interface/fMenu.rb'
require './fPlay.rb'
require './Page.rb'


# Fichier: fGameMode.rb
# Auteur: Marchand Killian
# Description: 
# => Menu des modes de jeu
# => C'est ici qu'est regroupé les composants du menu des modes de jeu
# => Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction la page.

class FGM < Page

	def initialize(monApp, header, anciennePage)

		super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220

		@butons = Gtk::ButtonBox.new(:horizontal)
    	@butons.layout = :spread

		@classic = Gtk::Button.new(:label => 'Classique', :use_underline => nil)
		@adven = Gtk::Button.new(:label => 'Aventure', :use_underline => nil)
		@comp = Gtk::Button.new(:label => 'Compétition', :use_underline => nil)

		@butons.add(@classic, :expand => true, :fill => false)
		@butons.add(@adven, :expand => true, :fill => false)
		@butons.add(@comp, :expand => true, :fill => false)

		
		@classic.signal_connect('clicked') {
			self.supprimeMoi
			suivant = FDiff.new(@window, header, self)
			suivant.ajouteMoi
      		@window.show_all
		}

		@adven.signal_connect('clicked') {
			self.supprimeMoi
			suivant = FDiff.new(@window, header, self)
			suivant.ajouteMoi
      		@window.show_all
		}

		@comp.signal_connect('clicked') {
			self.supprimeMoi
			suivant = FDiff.new(@window, header, self)
			suivant.ajouteMoi
      		@window.show_all
		}

		self.add(@butons)
	end	
end

