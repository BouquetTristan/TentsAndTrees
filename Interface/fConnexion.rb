require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
require './Page.rb'
require './fMenu.rb'
require './fCreationCompte.rb'
require './fMdpOublie.rb'


class FConnexion < Page

     def initialize(monApp, header, anciennePage)

          super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
          self.hautPage.spacing = 220
          

		@gConnexion = Gtk::Table.new(6,1, false)
          @pseudo = TexteEntree.creer('Pseudo : ',true).gTexteEntree
          @mdp = TexteEntree.creer('Mot de passe : ',true).gTexteEntree
          @creaC = Gtk::Button.new(:label => 'Creer un compte', :use_underline => nil, :stock_id => nil)
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
          @mdpO = Gtk::Button.new(:label => 'Mot de passe oublié', :use_underline => nil, :stock_id => nil)
		@quit = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)

          @gConnexion.attach(@pseudo, 0,1,0,1)
          @gConnexion.attach(@mdp, 0,1,1,2)
          @gConnexion.attach(@connexion, 0,1,2,3)
          @gConnexion.attach(@creaC, 0,1,3,4)
          @gConnexion.attach(@mdpO, 0,1,4,5)
          @gConnexion.attach(@quit, 0,1,5,6)


          @connexion.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all         
          }

          @creaC.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FCreationCompte.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all
          }

          @mdpO.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMdpOublie.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all
          }
          @quit.signal_connect('clicked') {
          }


          self.add(@gConnexion)

     end

end

