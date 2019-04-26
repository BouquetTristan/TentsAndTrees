require 'gtk3'
require './Interface/fGameMode.rb'
require './Interface/fPlay.rb'
require './Classes/Page.rb'
require './Interface/fInter.rb'


# Fichier: fDiff.rb
# Auteur: Marchand Killian
# Description:
# C'est ici qu'est regroupé les composants du menu des difficultés
# Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction de la page

#====== Menu des difficultés

class FDiff < Page



	#Initialise la page 
	# @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
	# @param comp 			//booléen pour savoir si on est en mod compétition ou non
	# @return void			//ne renvoie rien
	def initialize(monApp, header, anciennePage, unJoueur, comp)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)

		# @boutons = Gtk::ButtonBox.new(:vertical)

		@boutons = Gtk::ButtonBox.new(:horizontal)
    	@boutons.layout = :spread

		@easy = Gtk::Button.new(:label => 'Facile', :use_underline => nil, :stock_id => nil)
		@easy.set_relief(:none)
		@medium = Gtk::Button.new(:label => 'Moyen', :use_underline => nil, :stock_id => nil)
		@medium.set_relief(:none)
		@hard = Gtk::Button.new(:label => 'Difficile', :use_underline => nil, :stock_id => nil)
		@hard.set_relief(:none)
		@charger = Gtk::Button.new(:label => 'Charger la dernière partie', :use_underline => nil, :stock_id => nil)
		@charger.set_relief(:none)


		@boutons.add(@easy, :expand => true, :fill => false)
		@boutons.add(@medium, :expand => true, :fill => false)
		@boutons.add(@hard, :expand => true, :fill => false)
		@boutons.spacing = 100

		# @boutons.add(@boutons, :expand => true, :fill => false)

		if (comp == false)
			@boutons.add(@charger, :expand => true, :fill => false)
		end

		@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(monApp, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
    	}

		@easy.signal_connect('clicked') {
			self.supprimeMoi
			diff = "Facile"
			if comp == false
				grilleDeJeu = Grille.creerD(diff)
				suivant=FPlay.new(monApp, header, self, unJoueur, diff, grilleDeJeu ,comp)
			else
				suivant=FInter.new(monApp, header, self, unJoueur, diff,comp)
			end
			suivant.ajouteMoi
			@window.show_all
		}
		@medium.signal_connect('clicked') {
			self.supprimeMoi
			diff = "Moyenne"
			if comp == false
				grilleDeJeu = Grille.creerD(diff)
				suivant=FPlay.new(monApp, header, self, unJoueur, diff, grilleDeJeu ,comp)
			else
				suivant=FInter.new(monApp, header, self, unJoueur, diff,comp)
			end
			suivant.ajouteMoi
			@window.show_all
		}
		@hard.signal_connect('clicked') {
			self.supprimeMoi
			diff = "Difficile"
			if comp == false
				grilleDeJeu = Grille.creerD(diff)
				suivant=FPlay.new(monApp, header, self, unJoueur, diff, grilleDeJeu ,comp)
			else
				suivant=FInter.new(monApp, header, self, unJoueur, diff,comp)
			end
			suivant.ajouteMoi
			@window.show_all
		}
		@charger.signal_connect('clicked') {
			grilleDeJeu = Grille.charger(unJoueur.pseudo)
			
			if (grilleDeJeu != nil)

				diff = grilleDeJeu.difficulte
				self.supprimeMoi
				suivant=FPlay.new(monApp, header, self, unJoueur, diff, grilleDeJeu ,comp)
				suivant.ajouteMoi
				@window.show_all
			end
		}
		@frame.attach(@boutons,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Menu/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
