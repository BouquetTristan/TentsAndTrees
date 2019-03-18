require 'gtk3'
require './Page.rb'

require './grille/grille.rb'
require './boutonGrille.rb'

class FPlay < Page

	def initialize(monApp, header, anciennePage, taille)

		super("Tents & Trees", monApp, :vertical, header,  anciennePage)
        self.hautPage.spacing = 10

        @box = Gtk::ButtonBox.new(:horizontal)

        @grille = Gtk::Table.new(taille, taille, false)

        grilleJ = Grille.creer(taille, "./grille/GrilleJ.txt")
		grilleF = Grille.creer(taille, "./grille/GrilleF.txt")
		
		@boutonGrille = [[]]

	# Mise en place des indicateurs de la grille de jeu

		for i in (0..taille-1)
			for j in (0..taille-1)
				lId = Gtk::Label.new(grilleF.tentesL[j].to_s)
				@grille.attach(lId, j+1,j+2, 0,1)
			end
			lId2 = Gtk::Label.new(grilleF.tentesC[i].to_s)
			@grille.attach(lId2,0,1, i+1,i+2)			
		end 

	# Cration de la grille de jeu.
	# Mise en place d'une matrice composant tous les boutons

		for i in (0..taille-1)
			temp=[]
			for j in (0..taille-1)
					vEtat = grilleJ.grille[i][j].etat
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
		        	grilleJ.grille[l.coordI][l.coordJ].jouerCase()
					@boutonGrille[l.coordI][l.coordJ].chgEtat(grilleJ.grille[l.coordI][l.coordJ].etat)
					grilleJ.grilleTofich()	
				}
			}
		}

		@gHelp = Gtk::ButtonBox.new(:vertical)

		@Label = Gtk::Label.new('Timer / afficher les aides')
		@gHelp.add(@Label)

		@bAide = Gtk::Button.new()
		@help=(Gtk::Image.new(:file =>"./image/help.png"))
		@bAide.set_image(@help)
		@gHelp.add(@bAide)

		@bPause = Gtk::Button.new()
		@pause=(Gtk::Image.new(:file =>"./image/pause.png"))
		@bPause.set_image(@pause)
		@gHelp.add(@bPause)

		@box.add(@grille)
		@box.add(@gHelp)

        self.add(@box)
    end
end
