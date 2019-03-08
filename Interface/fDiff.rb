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


class FDiff

	def FDiff.construire(fenetre)
		new(fenetre)
	end

	def initialize

		@gDiff = Gtk::Table.new(5,1, false)
		fenetre.add(@gDiff)

		titre =  Gtk::Label.new('Choix de la difficulté')
		@easy = Gtk::Button.new(:label => 'Facile', :use_underline => nil, :stock_id => nil)
		@medium = Gtk::Button.new(:label => 'Moyen', :use_underline => nil, :stock_id => nil)
		@hard = Gtk::Button.new(:label => 'Diffice', :use_underline => nil, :stock_id => nil)
		@back = Gtk::Button.new(:label => 'Retour', :use_underline => nil, :stock_id => nil)

		@gDiff.attach(titre, 0,1,0,1)
		@gDiff.attach(@easy, 0,1,1,2)
		@gDiff.attach(@medium, 0,1,2,3)
		@gDiff.attach(@hard, 0,1,3,4)
		@gDiff.attach(@back, 0,1,4,5)

		@easy.signal_connect('clicked') {
			@gDiff.destroy
			FPlay.construire(fenetre, 8)
					
		}
		@medium.signal_connect('clicked') {
			@gDiff.destroy
			FPlay.construire(fenetre, 12)
			
		}
		@hard.signal_connect('clicked') {
			fenetre.remove(@gDiff)
			FPlay.construire(fenetre, 16)
		}

		@back.signal_connect('clicked') {
			fenetre.remove(@gDiff)
			FGM.new
			
		}

		fenetre.show_all()
	end	
end
