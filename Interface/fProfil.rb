require 'gtk3'
#require '../Interface/fDiff.rb'
#require '../Interface/fMenu.rb'
#require '../Interface/fPlay.rb'
require './TexteAfficher.rb'
require './Page.rb'
require './fModifierCompte.rb'



class FProfil < Page

	def initialize(monApp, header, anciennePage, unJoueur)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)
		@frame.set_opacity(0.9)

		@gProfil = Gtk::ButtonBox.new(:vertical)

		@gP = Gtk::Table.new(1,2,false)
		@gP.row_spacing = 50


		@gP1 = Gtk::ButtonBox.new(:vertical)
		@gP2 = Gtk::ButtonBox.new(:vertical)


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
	

		@gP1.add(@pseudo.gTexteAfficher, :expand => true, :fill => false)
		@gP1.add(@scoreGlobal.gTexteAfficher, :expand => true, :fill => false)
		@gP2.add(@scoreFacile.gTexteAfficher, :expand => true, :fill => false)
		@gP2.add(@scoreMoyen.gTexteAfficher, :expand => true, :fill => false)
		@gP2.add(@scoreDifficile.gTexteAfficher, :expand => true, :fill => false)
		@gP1.add(@nbParties.gTexteAfficher, :expand => true, :fill => false)

		@gP.attach(@gP1,0,1,0,1)
		@gP.attach(@gP2,0,1,1,2)	

		@gProfil.add(@gP)	
		@gProfil.add(@gProfil2)
		@gProfil2.add(@modif, :expand => true, :fill => false)
		@gProfil2.add(@desinscription, :expand => true, :fill => false)
        @gProfil2.add(@deco, :expand => true, :fill => false)

        @header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(@window, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
	    }

		@modif.signal_connect('clicked') {
			self.supprimeMoi
            suivant = FModifC.new(@window, header, self, unJoueur)
            suivant.ajouteMoi
            @window.show_all
		}

		@desinscription.signal_connect('clicked') {
			unJoueur.desinscrire()
			unJoueur = nil
			self.supprimeMoi
			suivant = FConnexion.new(@window, header, self, nil)
            suivant.ajouteMoi
            @window.show_all
		}


		@deco.signal_connect('clicked') {
			unJoueur = nil
			self.supprimeMoi
            suivant = FConnexion.new(@window, header, self, nil)
            suivant.ajouteMoi
            @window.show_all
        }

		@frame.attach(@gProfil,0,1,0,1)

		@bg=(Gtk::Image.new(:file =>"../Assets/ImgGame2.png"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)

	end
end
