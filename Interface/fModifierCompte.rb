require 'gtk3'
#require './fGameMode.rb'
require './TexteEntree'

class FMdpOublie < Gtk::Builder

	def initialize

		fenetre = Gtk::Window.new
		fenetre.set_default_size(600,400)
		fenetre.border_width=5

		@gMdpOublie = Gtk::Table.new(7,1, false)
		fenetre.add(@gMdpOublie)


		titre =  Gtk::Label.new('Modification de compte')
		@pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
          @newMdp = TexteEntree.creer('Mot de passe : ', false).gTexteEntree
          @question =  Gtk::Label.new('Quel est votrelieux de vacance préféré?')
          @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
		@back = Gtk::Button.new(:label => 'Retour', :use_underline => nil, :stock_id => nil)

		puts(@pseudo.class)

		@gMdpOublie.attach(titre, 0,1,0,1)
		@gMdpOublie.attach(@pseudo, 0,1,1,2)


		@gMdpOublie.attach(@newMdp, 0,1,2,3)
          @gMdpOublie.attach(@question, 0,1,3,4)
		@gMdpOublie.attach(@reponse, 0,1,4,5)
		@gMdpOublie.attach(@connexion, 0,1,5,6)
		@gMdpOublie.attach(@back, 0,1,6,7)



		@connexion.signal_connect('clicked') {

			#ouvir menu
			#@gConnexion.destroy


		}

		@back.signal_connect('clicked') {

			#detruit tout
			fenetre.destroy

		}
		fenetre.show_all()

		end

	end



builder = FMdpOublie.new
Gtk.main
