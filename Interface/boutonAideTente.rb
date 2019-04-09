require 'gtk3'
require './boutonAide.rb'

class BoutonAideTente < BoutonAide

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton
	# @@prix		: prix de l'aide en feuille

	attr_accessor :cliquable
	attr_accessor :bouton

	@@prix = 3

	#Initialize le bouton
	# @param uneValeur    //Le nom du label
	# @param cliquable    //Booléen 
	# @return void  	//ne renvoie rien
	def initialize(uneValeur, cliquable)
		super(uneValeur, cliquable)
	end

	#Définie la marche à suivre en cas d'appel d'aide sur le bouton tente
	# @param uneGrille    //la grille de jeu
	# @param unLabel     //La position d'affichage 
	# @param unJoueur    //Pour sauvegarder le joueur et ne pas le perdre en cas de changement de page 
	# @return nil  	//si aucune aide ne trouve de solution
	def aide(uneGrille, unLabel, unJoueur, interfaceGrille)
		if(@cliquable == true)
			aide1 = Aide.arbreTentePlacer(uneGrille)
			aide2 = Aide.lignePlacerTentes(uneGrille)
			aide3 = Aide.colonnePlacerTentes(uneGrille)
			if(aide1 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Il ne reste qu'une possibilité pour la tente de l'arbre en #{aide1.i} #{aide1.j}</span>")
				interfaceGrille[aide1.i][aide1.j].indiquerAide(uneGrille.grilleJ[aide1.i][aide1.j].etat)
				return aide1
			elsif(aide2 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">On peut placer toutes les tentes sur la ligne #{aide2}</span>")
				for i in (0..uneGrille.taille-1)
					interfaceGrille[i][aide2].indiquerAide(uneGrille.grilleJ[i][aide2].etat)
				end
				return aide2
			elsif(aide3 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">On peut placer toutes les tentes sur la colonne #{aide3}</span>")
				for i in (0..uneGrille.taille-1)
					interfaceGrille[aide3][i].indiquerAide(uneGrille.grilleJ[aide3][i].etat)
				end
				return aide3
			else
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Aucune tente ne peut être placée</span>")
				return nil
			end
		end
	end

end
