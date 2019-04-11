require 'gtk3'
require './Classes/boutonAide.rb'

#====== La classe BoutonAideVerif hérite de la classe BoutonAide et va chercher une erreur sur le grille de jeu complété par le joueur

class BoutonAideVerif < BoutonAide

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton
	# @@prix		: prix de l'aide en feuille

	attr_accessor :cliquable
	attr_accessor :bouton


	@@prix = 5

	def prix()
		return @@prix
	end

	#Définie la marche à suivre en cas d'appel d'aide sur le bouton verif
	# @param uneGrille    //la grille de jeu
	# @param unLabel      //La position d'affichage
	# @param unJoueur     //Pour sauvegarder le joueur et ne pas le perdre en cas de changement de page
	# @param interfaceGrille //Permet d'accéder à l'affichage de la grille dans le jeu
	# @return aide 			//Case conscenrée par l'aide si elle existe
	# @return nil  	//si aucune aide ne trouve de solution
	def aide(uneGrille, unLabel, unJoueur, interfaceGrille)
		if(@cliquable == true)
			aide = Aide.erreur(uneGrille)
			if(aide != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Erreur sur la case \n#{aide.i} #{aide.j}</span>")
				interfaceGrille[aide.i][aide.j].indiquerAide(uneGrille.grilleJ[aide.i][aide.j].etat)
				return aide
			else
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Aucune erreur \nsur la grille actuelle</span>")
				return nil
			end
		end
	end


end
