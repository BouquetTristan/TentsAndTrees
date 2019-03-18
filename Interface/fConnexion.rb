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

          super("Connexion", monApp, :vertical, header,  anciennePage)
          self.hautPage.spacing = 220
          

		@gConnexion = Gtk::ButtonBox.new(:vertical)
          @gConnexion.layout = :spread
          @gConnexion.spacing = 30
          @gC2 = Gtk::ButtonBox.new(:horizontal)

          @pseudo = TexteEntree.creer('Pseudo : ',true).gTexteEntree
          @mdp = TexteEntree.creer('Mot de passe : ',true).gTexteEntree
          @creaC = Gtk::Button.new(:label => 'Creer un compte', :use_underline => nil, :stock_id => nil)
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
          @mdpO = Gtk::Button.new(:label => 'Mot de passe oublié', :use_underline => nil, :stock_id => nil)
		@quit = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)

          @gConnexion.add(@pseudo, :expand => true, :fill => false)
          @gConnexion.add(@mdp, :expand => true, :fill => false)
          @gConnexion.add(@connexion, :expand => true, :fill => false)
          @gConnexion.add(@quit, :expand => true, :fill => false)
          
          @gConnexion.add(@gC2)
          @gC2.add(@creaC, :expand => true, :fill => false)
          @gC2.add(@mdpO, :expand => true, :fill => false)


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

