require 'gtk3'
#require './fGameMode.rb'
require './fPlay.rb'



class FDiff

	def initialize

		@fDiff = Gtk::Window.new
		@fDiff.set_default_size(600,400)
		@fDiff.border_width=5
		
		@gDiff = Gtk::Table.new(5,1, false)
		@fDiff.add(@gDiff)

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
			
			FPlay.construire(8)
			@fDiff.destroy

			
		}
		@medium.signal_connect('clicked') {
			
			FPlay.construire(12)
			@fDiff.destroy
			
		}
		@hard.signal_connect('clicked') {
			
			FPlay.construire(16)
			@fDiff.destroy
		}

		@back.signal_connect('clicked') {
			
			FGM.new
			@fDiff.destroy
		}

		@fDiff.show_all()
		#destruction fenetre quand "quitter"
		#@fDiff.signal_connect('destroy') {onDestroy}
	end	
end

builder = FDiff.new
Gtk.main