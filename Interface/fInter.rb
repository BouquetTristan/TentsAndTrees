require 'gtk3'
require './Interface/fPlay.rb'
require './Classes/Page.rb'
require './Classes/boutonGrille.rb'

# Fichier: fDiff.rb
# Auteur: Marchand Killian
# Description:
# => Menu des difficultés
# => C'est ici qu'est regroupé les composants du menu des difficultés
# => Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction de la page


class FInter < Page

	def initialize(monApp, header, anciennePage, unJoueur, difficulte ,comp)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		grilleDeJeu = Grille.creerD(difficulte)

		taille = grilleDeJeu.taille()

        @grille = Gtk::Table.new(taille, taille, false)

		@frame = Gtk::Table.new(1,1,false)

		@frame2 = Gtk::Table.new(1,2,false)

		@box = Gtk::ButtonBox.new(:vertical)

		@boutonGrille = [[]]

		for i in (0..taille-1)
			temp=[]
			for j in (0..taille-1)
					vEtat = grilleDeJeu.grilleJ[i][j].etat
					temp[j] = BoutonGrille.new
					temp[j].mCoord(i,j)
					temp[j].chgEtat(vEtat)
					@grille.attach(temp[j].bouton, i+1, i+2, j+1,j+2)
			end
			@boutonGrille[i] = temp
		end

		@box.add(@grille)
		@frame2.attach(@box,0,1,0,1)

		@framebut=Gtk::Table.new(1,2,false)


		@next= Gtk::Button.new(:label => 'Suivante >>', :use_underline => nil, :stock_id => nil)
		@next.set_relief(:none)
		@play= Gtk::Button.new(:label => 'Jouer', :use_underline => nil, :stock_id => nil)
		@play.set_relief(:none)

		@framebut.attach(@next, 0,1,0,1)
		@framebut.attach(@play,0,1,1,2)


		@frame2.attach(@framebut, 1,2,0,1)

		@frame.attach(@frame2,0,1,0,1)

		@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(@window, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
    	}

		@next.signal_connect('clicked') {
			self.supprimeMoi
			suivant=FInter.new(@window, header, self, unJoueur, difficulte ,comp)
			suivant.ajouteMoi
			@window.show_all
		}

		@play.signal_connect('clicked') {
			self.supprimeMoi
			suivant=FPlay.new(@window, header, self, unJoueur, difficulte, grilleDeJeu ,comp)
			suivant.ajouteMoi
			@window.show_all
		}


		@bg=(Gtk::Image.new(:file =>"./Assets/ImgGame.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
