require 'gtk3'
require './Page.rb'

require '../Classes/Grille.rb'
require '../Classes/Aide.rb'
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

		@boxAide = Gtk::ButtonBox.new(:vertical)

		@box1 = Gtk::ButtonBox.new(:horizontal)
		@b1 = Gtk::Button.new(:label => '1', :use_underline => nil, :stock_id => nil)
		@b2 = Gtk::Button.new(:label => '2', :use_underline => nil, :stock_id => nil)

		@box1.add(@b1)
		@box1.add(@b2)

		@box2 = Gtk::ButtonBox.new(:horizontal)
		@b3 = Gtk::Button.new(:label => '3', :use_underline => nil, :stock_id => nil)
		@b4 = Gtk::Button.new(:label => '4', :use_underline => nil, :stock_id => nil)

		@box2.add(@b3)
		@box2.add(@b4)

		@box3 = Gtk::ButtonBox.new(:horizontal)
		@b5 = Gtk::Button.new(:label => '5', :use_underline => nil, :stock_id => nil)
		@b6 = Gtk::Button.new(:label => '6', :use_underline => nil, :stock_id => nil)

		@box3.add(@b5)
		@box3.add(@b6)

		@boxAide.add(@box1)
		@boxAide.add(@box2)
		@boxAide.add(@box3)

		@b1.signal_connect('clicked') {
			
         	}

		@b2.signal_connect('clicked') {

         	}

		@b3.signal_connect('clicked') {

         	}

		@b4.signal_connect('clicked') {

         	}

		@b5.signal_connect('clicked') {

         	}

		@b6.signal_connect('clicked') {

         	}

		#@bAide = Gtk::Button.new()
#		@help=(Gtk::Image.new(:file =>"./image/Aide.png"))
#		@bAide.set_image(@help)
		@gHelp.add(@boxAide)

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
