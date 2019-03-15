require 'gtk3'
#require '../Interface/fDiff.rb'
#require '../Interface/fMenu.rb'
#require '../Interface/fPlay.rb'
require './TexteAfficher.rb'


class FProfil < Gtk::Builder

	def initialize

		fenetre = Gtk::Window.new
          fenetre.set_default_size(600,400)
          fenetre.border_width=5

		@gProfil = Gtk::Table.new(3,4, false)
		fenetre.add(@gProfil)

		titre =  Gtk::Label.new('Profil')
		@pseudo = TexteAfficher.creer('Pseudo : ').gTexteAfficher
		@score = TexteAfficher.creer('Score').gTexteAfficher
		@modif = Gtk::Button.new("Modifier mes inforamtions")
		@back = Gtk::Button.new("Retour")
          @deco = Gtk::Button.new("Deconnexion")

		@gProfil.attach(titre, 1,2,0,1)
		@gProfil.attach(@pseudo, 1,2,1,2)
          @gProfil.attach(@score, 1,2,2,3)
		@gProfil.attach(@modif, 0,1,3,4)
          @gProfil.attach(@back, 1,2,3,4)
          @gProfil.attach(@deco, 2,3,3,4)


		@modif.signal_connect('clicked') {

			#FDiff.new
			@FProfil.destroy


		}

		@back.signal_connect('clicked') {

			#FMenu.new
			@FProfil.destroy

		}
          @deco.signal_connect('clicked') {

			#FMenu.new
			@FProfil.destroy

		}
		fenetre.show_all()


		#destruction fenetre quand "quitter"
		#@fDiff.signal_connect('destroy') {onDestroy}
	end
end


builder = FProfil.new
Gtk.main
