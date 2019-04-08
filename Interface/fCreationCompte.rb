require 'gtk3'
#require './IGrille.rb'
#require './gHelp.rb'
require './TexteEntree'
require './Page.rb'
require './fMenu.rb'


class FCreationCompte < Page

     def initialize(monApp, header, anciennePage, unJoueur)

          super(monApp, :vertical, header,  anciennePage, unJoueur)

          @frame = Gtk::Table.new(1,1,false)

		@gCC = Gtk::ButtonBox.new(:vertical)
          @gCC.spacing = 30

          @pseudo = TexteEntree.creer('Pseudo : ', false)
          @mdp = TexteEntree.creer('Mot de passe : ', true)
          @question =  Gtk::Label.new('')
          @question.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 15\">Quel est votre lieu de vacance favorie ?</span>\n")
          @reponse = TexteEntree.creer('Reponse : ', true)
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
          @connexion.set_relief(:none)

          @gCC.add(@pseudo.gTexteEntree, :expand => true, :fill => false)
          @gCC.add(@mdp.gTexteEntree, :expand => true, :fill => false)
          @gCC.add(@question, :expand => true, :fill => false)
          @gCC.add(@reponse.gTexteEntree, :expand => true, :fill => false)
          @gCC.add(@connexion, :expand => true, :fill => false)


          @connexion.signal_connect('clicked') {


 			joueur = Joueur.new(@pseudo.entree.text, @mdp.entree.text, @reponse.entree.text)

                puts("OK nouveau joueur\n")
                if (@pseudo.entree.text == '' || @mdp.entree.text == '')
 				#@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
                     @mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer un pseudo et un mot de passe</span>\n")
                end
                if (@reponse.entree.text =='')
 				#@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
                     @reponse.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Répondez a la question</span>\n")

 			elsif joueur.inscrire() == 0 then
                     puts("Joueur\n")
 				@mdp.entree.text = ''
                     puts("mdp sans rien\n")
                     @mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur L'utilisateur est déjà enregistré</span>\n")


                else
                     self.supprimeMoi
                     suivant = FMenu.new(@window, header, self, joueur)
                     suivant.ajouteMoi
                     @window.show_all
                end
          }

          @frame.attach(@gCC,0,1,0,1)

          @bg=(Gtk::Image.new(:file =>"../Assets/ImgGame2.png"))
          @frame.attach(@bg,0,1,0,1)
          self.add(@frame)

     end

end
