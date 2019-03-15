require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
#require './Page.rb'


class FCreationCompte# Page

     def initialize
          fenetre = Gtk::Window.new
          fenetre.set_default_size(600,400)
          fenetre.border_width=5

		@gCC = Gtk::Table.new(7,1, false)
		fenetre.add(@gCC)

          titre =  Gtk::Label.new('Création de compte')
          @pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
          @mdp = TexteEntree.creer('Mot de passe : ', true).gTexteEntree
          @question =  Gtk::Label.new('Quel est votre lieux de vacance préféré?')
          @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
		@quit = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)

          puts(@pseudo.class)

          @gCC.attach(titre, 0,1,0,1)
          @gCC.attach(@pseudo, 0,1,1,2)
          @gCC.attach(@mdp, 0,1,2,3)
          @gCC.attach(@question, 0,1,3,4)
          @gCC.attach(@reponse, 0,1,4,5)
          @gCC.attach(@connexion, 0,1,5,6)
          @gCC.attach(@quit, 0,1,6,7)



          @connexion.signal_connect('clicked') {

			#ouvir menu
			#@gConnexion.destroy


		}

          @quit.signal_connect('clicked') {

			#detruit tout
               fenetre.destroy

		}
          fenetre.show_all()

     end

end

builder = FCreationCompte.new

Gtk.main
