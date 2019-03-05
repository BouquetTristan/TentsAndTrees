require 'gtk2'
require '../Interface/fDiff.rb'
require '../Interface/fMenu.rb'
require '../Interface/fPlay.rb'


class FGM < Gtk::Builder

	def initialize

		@fGM = Gtk::Window.new
		@fGM.set_default_size(600,400)
		@fGM.border_width=5
	
		@gGM = Gtk::Table.new(5,1, false)
		@fGM.add(@gGM)

		titre =  Gtk::Label.new('Choix du mode de JEU')
		@classic = Gtk::Button.new("Classique")
		@adven = Gtk::Button.new("Aventure")
		@comp = Gtk::Button.new("Compétition")
		@back = Gtk::Button.new("Retour")

		@gGM.attach(titre, 0,1,0,1)
		@gGM.attach(@classic, 0,1,1,2)
		@gGM.attach(@adven, 0,1,2,3)
		@gGM.attach(@comp, 0,1,3,4)
		@gGM.attach(@back, 0,1,4,5)
		@fGM.show_all()

		@classic.signal_connect('clicked') {
			
			FDiff.new
			#@fGM.destroy

			
		}
		@adven.signal_connect('clicked') {
			puts('mode avaneture')
			
		}
		@comp.signal_connect('clicked') {
			puts('mode competition')
			#FPlay.construire(12)
			
		}

		@back.signal_connect('clicked') {
	
			FMenu.new
			@fGM.destroy
			
		}

		
		#destruction fenetre quand "quitter"
		#@fDiff.signal_connect('destroy') {onDestroy}
	end	
end


#builder = FGM.new
#Gtk.main