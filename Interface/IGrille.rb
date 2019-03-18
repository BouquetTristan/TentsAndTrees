require 'gtk3'

require './grille/grille.rb'
require './boutonGrille.rb'

# Fichier: fPlay.rb
# Auteur: Marchand Killian
# Description: 
# => Fenertre du jeu
# => C'est ici qu'est regroupé les composants de la fenetre de jeu
# => Elle est composé de la grille de jeu, ainsi que la grille d'aide

class IGrille

	def initialize(taille)

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
	end	
end