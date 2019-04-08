require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
require './Page.rb'
require './fMenu.rb'
require './fCreationCompte.rb'
require './fMdpOublie.rb'
require '../BaseDeDonnees/Joueur.rb'


class FConnexion < Page

     def initialize(monApp, header, anciennePage, unJoueur)

          super(monApp, :vertical, header,  anciennePage, unJoueur)

          @frame = Gtk::Table.new(1,1,false)
          #super(monApp, :vertical, header,  anciennePage, unJoueur)

		@gConnexion = Gtk::ButtonBox.new(:vertical)
          @gConnexion.layout = :spread
          @gConnexion.spacing = 30
          @gC2 = Gtk::ButtonBox.new(:horizontal)

          @pseudo = TexteEntree.creer('Pseudo : ',false)
          @mdp = TexteEntree.creer('Mot de passe : ',true)

          @creaC = Gtk::Button.new(:label => 'Creer un compte', :use_underline => nil, :stock_id => nil)
          @creaC.set_relief(:none)
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
          @connexion.set_relief(:none)
          @mdpO = Gtk::Button.new(:label => 'Mot de passe oublié', :use_underline => nil, :stock_id => nil)
          @mdpO.set_relief(:none)

          @gConnexion.add(@pseudo.gTexteEntree, :expand => true, :fill => false)
          @gConnexion.add(@mdp.gTexteEntree, :expand => true, :fill => false)
          @gConnexion.add(@connexion, :expand => true, :fill => false)

          @gConnexion.add(@gC2)
          @gC2.add(@creaC, :expand => true, :fill => false)
          @gC2.add(@mdpO, :expand => true, :fill => false)



          @connexion.signal_connect('clicked') {


			joueur = Joueur.new(@pseudo.entree.text, @mdp.entree.text, nil)
               puts @pseudo.entree.text
               puts @mdp.entree.text
               puts("OK nouveau joueur\n")
               if (@pseudo.entree.text == '' || @mdp.entree.text == '')
				#@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
                    @mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer un pseudo et un mot de passe</span>\n")


			elsif joueur.connecter() == nil then
                    puts("Joueur non trouvé\n")
				@mdp.entree.text = ''
                    puts("mdp sans rien\n")
                    @mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur pseudo ou mot de passe incorrect</span>\n")


               else
                    self.supprimeMoi
                    suivant = FMenu.new(@window, header, self, joueur)
                    suivant.ajouteMoi
                    @window.show_all
               end
         }

          @creaC.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FCreationCompte.new(@window, header, self, nil)
               suivant.ajouteMoi
               @window.show_all
          }

          @mdpO.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMdpOublie.new(@window, header, self, nil)
               suivant.ajouteMoi
               @window.show_all
          }

          @frame.attach(@gConnexion, 0,1,0,1)

          @bg = (Gtk::Image.new(:file=>"../Assets/ImgGame2.png"))

          @frame.attach(@bg, 0,1,0,1)

          self.add(@frame)


     end

end
