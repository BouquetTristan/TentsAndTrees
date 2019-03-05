require 'gtk2'
#require './fGameMode.rb'

class FMenu < Gtk::Builder

	def initialize

		@fMenu = Gtk::Window.new
		@fMenu.set_default_size(600,400)
		@fMenu.border_width=5
		
		@gMenu = Gtk::Table.new(5,1, false)
		@fMenu.add(@gMenu)

		@ghead = Gtk::Table.new(3,1, false)
			@titre =  Gtk::Label.new('Tent''s & trees')
			@option = Gtk::Button.new("")
			@profil = Gtk::Button.new("Profil")
			@ghead.attach(@option, 0,1,0,1)
			@ghead.attach(@titre, 1,2,0,1)
			@ghead.attach(@profil, 2,3,0,1)
		
		@play = Gtk::Button.new("Jouer")
		@didac = Gtk::Button.new("Didactitiel")
		@score = Gtk::Button.new("Classement")
		@back = Gtk::Button.new("Retour")

		@gMenu.attach(@ghead, 0,1,0,1)
		@gMenu.attach(@play, 0,1,1,2)
		@gMenu.attach(@didac, 0,1,2,3)
		@gMenu.attach(@score, 0,1,3,4)
		@gMenu.attach(@back, 0,1,4,5)


		@play.signal_connect('clicked') {
			puts('ok')
			#FGM.new()
			FDiff.new

			#@fMenu.destroy
			#FGameMode.new
			
		}
		@didac.signal_connect('clicked') {
			
			puts ('didac')
			
		}
		@score.signal_connect('clicked') {
			
			puts ('score')
			
		}
		@back.signal_connect('clicked') {
			
			puts('back')
			
		}

		@fMenu.show_all()
		#destruction fenetre quand "quitter"
		#@fDiff.signal_connect('destroy') {onDestroy}
	end	
end

#builder = FMenu.new()
#Gtk.main