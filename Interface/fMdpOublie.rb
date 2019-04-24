require 'gtk3'
#require './fGameMode.rb'
require './Classes/TexteEntree'
require './Classes/Page.rb'
require './Interface/fMenu.rb'

class FMdpOublie < Page

     def initialize(monApp, header, anciennePage, unJoueur)

        super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)

    	@gMdpOublie = Gtk::ButtonBox.new(:vertical)
        @gMdpOublie.spacing = 30

    	@pseudo = TexteEntree.creer('Pseudo : ', true)
        @newMdp = TexteEntree.creer('Nouveau mot de passe : ', true)
	@newMdp.entree.visibility = false
        @question =  Gtk::Label.new('')
        @question.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 15\">Quel est votre lieu de vacances favori ?</span>\n")
        @reponse = TexteEntree.creer('Reponse secrète : ', true)
	@reponse.entree.visibility = false
        @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)
        @connexion.set_relief(:none)
        @back = Gtk::Button.new(:label => 'Retour', :use_underline => nil, :stock_id => nil)
        @back.set_relief(:none)

    		@gMdpOublie.add(@pseudo.gTexteEntree, :expand => true, :fill => false)
          @gMdpOublie.add(@question, :expand => true, :fill => false)
    		@gMdpOublie.add(@reponse.gTexteEntree, :expand => true, :fill => false)
    		@gMdpOublie.add(@newMdp.gTexteEntree, :expand => true, :fill => false)

    		@gMdpOublie.add(@connexion, :expand => true, :fill => false)
        @gMdpOublie.add(@back, :expand => true, :fill => false)

    	@connexion.signal_connect('clicked') {

          joueur = Joueur.new(@pseudo.entree.text, @newMdp.entree.text, @reponse.entree.text)


          puts @newMdp.entree.text
          puts("OK nouveau mdp\n")
          if (@pseudo.entree.text == '')
               #@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
               @pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer votre pseudo</span>\n")


          elsif joueur.motDePasseOublier(@newMdp.entree.text) == false then
               puts("Réponse incorectve\n")
               @newMdp.entree.text = ''
               puts("mdp sans rien\n")
               @reponse.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Réponse à la question incorrecte</span>\n")
               @pseudo.erreur.set_markup("")

          elsif (@newMdp.entree.text == '')
               #@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
               @newMdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Le mot de passe n'est pas valide</span>\n")
               @pseudo.erreur.set_markup("")
               @reponse.erreur.set_markup("")

          else
              joueur.connecter()
               self.supprimeMoi
               suivant = FMenu.new(monApp, header, self, joueur)
               suivant.ajouteMoi
               @window.show_all
          end
    }

          @back.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FConnexion.new(monApp, header, self, nil)
              suivant.ajouteMoi
              @window.show_all
          }

        @frame.attach(@gMdpOublie,0,1,0,1)

        @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)

	end

end
