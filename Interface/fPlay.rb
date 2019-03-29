require 'gtk3'
require './Page.rb'

require '../Classes/Grille.rb'
require './boutonGrille.rb'

class FPlay < Page

	def initialize(monApp, header, anciennePage, unJoueur, difficulte)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:horizontal)

	   grilleDeJeu = Grille.creerD(difficulte)

	   taille = grilleDeJeu.taille()

        @grille = Gtk::Table.new(taille, taille, false)



		@boutonGrille = [[]]

	# Mise en place des indicateurs de la grille de jeu

		for i in (0..taille-1)
			for j in (0..taille-1)
				lId = Gtk::Label.new(grilleDeJeu.nbTentesLigne[j].to_s)
				@grille.attach(lId, j+1,j+2, 0,1)
			end
			lId2 = Gtk::Label.new(grilleDeJeu.nbTentesColonne[i].to_s)
			@grille.attach(lId2,0,1, i+1,i+2)
		end

	# Création de la grille de jeu.
	# Mise en place d'une matrice composant tous les boutons

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

	# Appel de l'evenement bouton "cliqué", et modification du bouton cliqué

		@boutonGrille.each{|k|
			k.each{|l|
				l.bouton.signal_connect("clicked"){
		        	grilleDeJeu.grilleJ[l.coordI][l.coordJ].jouerCase()
					@boutonGrille[l.coordI][l.coordJ].chgEtat(grilleDeJeu.grilleJ[l.coordI][l.coordJ].etat)
					grilleDeJeu.enregistrerFichier()
					if (grilleDeJeu.observateur())
						#puts("gagné")
						#timer stop + affichage "gagné"
						self.supprimeMoi
			  	        	menu = FMenu.new(@window, @header, self, unJoueur)
			  	        	menu.ajouteMoi
			  	        	@window.show_all
					end

				}
			}
		}

		@gHelp = Gtk::ButtonBox.new(:vertical)

		@Label = Gtk::Label.new('Timer / afficher les aides')
		@gHelp.add(@Label)

		@bAide = Gtk::Button.new()
		@help=(Gtk::Image.new(:file =>"./image/Aide.png"))
		@bAide.set_image(@help)
		@gHelp.add(@bAide)

		@bPause = Gtk::Button.new()
		@pause=(Gtk::Image.new(:file =>"./image/pause.png"))
		@bPause.set_image(@pause)
		@gHelp.add(@bPause)

		@gHelp.spacing=70

		@box.add(@grille)
		@box.add(@gHelp)

		@frame.attach(@box,0,1,0,1)

		@bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
