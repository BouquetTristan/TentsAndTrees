require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
require './Page.rb'
require './fMenu.rb'


class FCreationCompte < Page

     def initialize(monApp, header, anciennePage)

          super("Création du compte", monApp, :vertical, header,  anciennePage)
          self.hautPage.spacing = 220

		@gCC = Gtk::ButtonBox.new(:vertical)
          @gCC.spacing = 30

          @pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
          @mdp = TexteEntree.creer('Mot de passe : ', true).gTexteEntree
          @question =  Gtk::Label.new('Quel est votre lieux de vacance préféré?')
          @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
		
          @gCC.add(@pseudo, :expand => true, :fill => false)
          @gCC.add(@mdp, :expand => true, :fill => false)
          @gCC.add(@question, :expand => true, :fill => false)
          @gCC.add(@reponse, :expand => true, :fill => false)
          @gCC.add(@connexion, :expand => true, :fill => false)
          

          @connexion.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all          
          }
         
        self.add(@gCC)

     end

end
