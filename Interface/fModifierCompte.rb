require 'gtk3'
require './Classes/TexteEntree'
require './Classes/Page.rb'

#====== Fenetre de modification de compte du jeu
class FModifC < Page

	#Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @return void		//ne renvoie rien
	def initialize(monApp, header, anciennePage, unJoueur)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)

		@gModifC = Gtk::ButtonBox.new(:vertical)
          @gModifC.spacing = 30

          @pseudo = TexteEntree.creer('Pseudo : ', false)
          @mdp = TexteEntree.creer('Mot de passe : ', true)
	  @mdp.entree.visibility = false
          @valider = Gtk::Button.new(:label => 'Valider les modifications', :use_underline => nil, :stock_id => nil)
          @valider.set_relief(:none)

          @gModifC.add(@pseudo.gTexteEntree, :expand => true, :fill => false)
          @gModifC.add(@mdp.gTexteEntree, :expand => true, :fill => false)
          @gModifC.add(@valider, :expand => true, :fill => false)



		@valider.signal_connect('clicked') {



			puts("OK nouveau joueur\n")
			if (@pseudo.entree.text == '')
				if (@mdp.entree.text == '')
					@mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer un pseudo et un mot de passe</span>\n")
				elsif (unJoueur.nouveauMotDePasse(@mdp.entree.text) == false)
					@mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer un mot de passe différent</span>\n")
				end

			elsif (unJoueur.nouveauPseudo(@pseudo.entree.text))

				if (@mdp.entree.text != '' && unJoueur.nouveauMotDePasse(@mdp.entree.text) == false)
					@mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer un mot de passe différent</span>\n")
				end
			else
				@mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur ce pseudo est déjà utilisé ou est déjà votre pseudo actuel</span>\n")
			end

			self.supprimeMoi
	        menu = FProfil.new(monApp, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
		}


		@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(monApp, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
	    }

	    @frame.attach(@gModifC,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)

	end

end
