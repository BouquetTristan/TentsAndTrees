require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
require './Page.rb'
require './fMenu.rb'


class FCreationCompte < Page

     def initialize(monApp, header, anciennePage)

          super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
          self.hautPage.spacing = 220

		@gCC = Gtk::Table.new(7,1, false)

          @pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
          @mdp = TexteEntree.creer('Mot de passe : ', true).gTexteEntree
          @question =  Gtk::Label.new('Quel est votre lieux de vacance préféré?')
          @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
		#@quit = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)


          @gCC.attach(@pseudo, 0,1,1,2)
          @gCC.attach(@mdp, 0,1,2,3)
          @gCC.attach(@question, 0,1,3,4)
          @gCC.attach(@reponse, 0,1,4,5)
          @gCC.attach(@connexion, 0,1,5,6)
          #@gCC.attach(@quit, 0,1,6,7)



          @connexion.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all          
          }
         
        self.add(@gCC)

     end

end
