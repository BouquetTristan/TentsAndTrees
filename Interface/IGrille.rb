require 'gtk3'

require './grille/grille.rb'
require './boutonGrille.rb'

class IGrille

	def IGrille.constuire(taille, grille)
		new(taille, grille)
	end

	def initialize(taille, grille)

		grilleJ = Grille.creer(taille, "./grille/GrilleJ.txt")
		grilleF = Grille.creer(taille, "./grille/GrilleF.txt")
		
		@boutonGrille = [[]]

		for i in (0..taille-1)
			temp=[]
			for j in (0..taille-1)
					vEtat = grilleJ.grille[i][j].etat
					temp[j] = BoutonGrille.new
					temp[j].mCoord(i,j)
					temp[j].chgEtat(vEtat)
					grille.attach(temp[j].bouton, i, i+1, j,j+1)
			end
			@boutonGrille[i] = temp
		end 
		@boutonGrille.each{|k| 
			k.each{|l|
				l.bouton.signal_connect("button_press_event"){
		        	grilleJ.grille[l.coordI][l.coordJ].jouerCase()
					@boutonGrille[l.coordI][l.coordJ].chgEtat(grilleJ.grille[l.coordI][l.coordJ].etat)
					grilleJ.grilleTofich()	
				}
			}
		}
	end	
end