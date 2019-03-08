require 'gtk3'
require '../Interface/fDiff.rb'
#require '../Interface/fMenu.rb'
require '../Interface/fPlay.rb'

# Fichier: fGameMode.rb
# Auteur: Marchand Killian
# Description: 
# => Menu des modes de jeu
# => C'est ici qu'est regroupé les composants du menu des modes de jeu
# => Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction la page.

class FGM

	def initialize

		fenetre = Gtk::Window.new
		fenetre.set_default_size(700,400)
		fenetre.border_width=5
		fenetre.set_resizable(true)

		@gGM = Gtk::Table.new(5,1, false)
		fenetre.add(@gGM)

		titre =  Gtk::Label.new('Choix du mode de JEU')
		@classic = Gtk::Button.new(:label => 'Classique', :use_underline => nil, :stock_id => nil)
		@adven = Gtk::Button.new(:label => 'Aventure', :use_underline => nil, :stock_id => nil)
		@comp = Gtk::Button.new(:label => 'Compétition', :use_underline => nil, :stock_id => nil)
		@back = Gtk::Button.new(:label => 'Retour', :use_underline => nil, :stock_id => nil)

		@gGM.attach(titre, 0,1,0,1)
		@gGM.attach(@classic, 0,1,1,2)
		@gGM.attach(@adven, 0,1,2,3)
		@gGM.attach(@comp, 0,1,3,4)
		@gGM.attach(@back, 0,1,4,5)
		
		@classic.signal_connect('clicked') {
			FDiff.construire(fenetre)
			@gGM.destroy
		}

		@adven.signal_connect('clicked') {
			puts('mode avaneture')
			
		}
		@comp.signal_connect('clicked') {
			puts('mode competition')			
		}

		@back.signal_connect('clicked') {
	
			FMenu.new
			@fGM.destroy
			
		}

		fenetre.show_all()
	end	
end


builder = FGM.new
Gtk.main