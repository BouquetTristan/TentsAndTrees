require 'gtk3'

require './Interface/fMenu.rb'
require './Classes/TexteAfficher.rb'
require './Classes/Page.rb'
require './Interface/fModifierCompte.rb'


#====== Fenetre de profil joueur du jeu
class FProfil < Page


	#Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @return void		//ne renvoie rien
	def initialize(monApp, header, anciennePage, unJoueur)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)
		@frame.set_opacity(0.9)

		@gProfil = Gtk::ButtonBox.new(:vertical)

		@gP = Gtk::Box.new(:vertical)
		@gP.spacing = 50


		@gProfil2 = Gtk::ButtonBox.new(:horizontal)

		@gProfil2.spacing = 100

		@pseudo = TexteAfficher.creer('Pseudo : ', unJoueur.pseudo)
		@scoreGlobal = TexteAfficher.creer('Score Global : ', unJoueur.scoreGlobal.to_s)
		@scoreFacile = TexteAfficher.creer('Score Facile : ', unJoueur.scoreFacile.to_s)
		@scoreMoyen = TexteAfficher.creer('Score Moyen : ', unJoueur.scoreMoyen.to_s)
		@scoreDifficile = TexteAfficher.creer('Score Difficile : ', unJoueur.scoreDifficile.to_s)
		@nbParties = TexteAfficher.creer('Nombre de parties jouées : ', unJoueur.nbPartiesJouees.to_s)
		@modif =Gtk::Button.new(:label => 'Modifier mes informations', :use_underline => nil, :stock_id => nil)
		@desinscription =Gtk::Button.new(:label => 'Supprimer mon profil', :use_underline => nil, :stock_id => nil)
		@deco = Gtk::Button.new(:label => 'Deconnexion', :use_underline => nil, :stock_id => nil)


		@gP.add(@pseudo.gTexteAfficher, :expand => true, :fill => false)
		@gP.add(@scoreGlobal.gTexteAfficher, :expand => true, :fill => false)
		@gP.add(@scoreFacile.gTexteAfficher, :expand => true, :fill => false)
		@gP.add(@scoreMoyen.gTexteAfficher, :expand => true, :fill => false)
		@gP.add(@scoreDifficile.gTexteAfficher, :expand => true, :fill => false)
		@gP.add(@nbParties.gTexteAfficher, :expand => true, :fill => false)

		@gProfil.add(@gP)
		@gProfil.add(@gProfil2)
		@gProfil2.add(@modif, :expand => true, :fill => false)
		@gProfil2.add(@desinscription, :expand => true, :fill => false)
        @gProfil2.add(@deco, :expand => true, :fill => false)

        @header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(monApp, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
	    }

		@modif.signal_connect('clicked') {
			self.supprimeMoi
            suivant = FModifC.new(monApp, header, self, unJoueur)
            suivant.ajouteMoi
            @window.show_all
		}

		@desinscription.signal_connect('clicked') {
			unJoueur.desinscrire()
			unJoueur = nil
			self.supprimeMoi
			suivant = FConnexion.new(monApp, header, self, nil)
            suivant.ajouteMoi
            @window.show_all
		}


		@deco.signal_connect('clicked') {
			unJoueur = nil
			self.supprimeMoi
            suivant = FConnexion.new(monApp, header, self, nil)
            suivant.ajouteMoi
            @window.show_all
        }

		@frame.attach(@gProfil,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)

	end
end
