require 'gtk3'
require './fGameMode.rb'
require './fPlay.rb'
require './Page.rb'

# Fichier: fDiff.rb
# Auteur: Marchand Killian
# Description: 
# => Menu des difficultés
# => C'est ici qu'est regroupé les composants du menu des difficultés
# => Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction de la page


class FDiff < Page

	def initialize(monApp, header, anciennePage)

		super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220

		@butons = Gtk::ButtonBox.new(:horizontal)
    	@butons.layout = :spread

		@easy = Gtk::Button.new(:label => 'Facile', :use_underline => nil, :stock_id => nil)
		@medium = Gtk::Button.new(:label => 'Moyen', :use_underline => nil, :stock_id => nil)
		@hard = Gtk::Button.new(:label => 'Diffice', :use_underline => nil, :stock_id => nil)


		@butons.add(@easy, :expand => true, :fill => false)
		@butons.add(@medium, :expand => true, :fill => false)
		@butons.add(@hard, :expand => true, :fill => false)


		@easy.signal_connect('clicked') {
			self.supprimeMoi
			FPlay.construire(fenetre, 8)
			@window.show_all		
		}
		@medium.signal_connect('clicked') {
			self.supprimeMoi
			FPlay.construire(fenetre, 12)
			@window.show_all
		}
		@hard.signal_connect('clicked') {
			self.supprimeMoi
			FPlay.construire(fenetre, 16)
			@window.show_all
		}

		self.add(@butons)
	end	
end
