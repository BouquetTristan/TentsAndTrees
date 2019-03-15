require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
#require './Page.rb'


class FConnexion# Page

     def initialize
          fenetre = Gtk::Window.new
		fenetre.set_default_size(600,400)
		fenetre.border_width=5

		@gConnexion = Gtk::Table.new(5,1, false)
		fenetre.add(@gConnexion)

          titre =  Gtk::Label.new('Connexion')
          @pseudo = TexteEntree.creer('Pseudo : ',true).gTexteEntree
          @mdp = TexteEntree.creer('Mot de passe : ',true).gTexteEntree
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
		@quit = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)

          puts(@pseudo.class)

          @gConnexion.attach(titre, 0,1,0,1)
          @gConnexion.attach(@pseudo, 0,1,1,2)
          @gConnexion.attach(@mdp, 0,1,2,3)
          @gConnexion.attach(@connexion, 0,1,3,4)
          @gConnexion.attach(@quit, 0,1,4,5)


          @connexion.signal_connect('clicked') {

			#ouvir menu
			@gConnexion.destroy


		}

          @quit.signal_connect('clicked') {

			#detruit tout
               fenetre.destroy

		}
          fenetre.show_all()

     end

end

builder = FConnexion.new

Gtk.main
