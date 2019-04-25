require 'gtk3'
require './Classes/boutonAide.rb'

#====== La classe BoutonAideTente hérite de la classe BoutonAide et représente une aide spécifique aux tentes

class BoutonAideTente < BoutonAide

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton
	# @cliquable		: booléen
	# @@prix		: prix de l'aide en feuille

	attr_accessor :prix
	attr_accessor :cliquable
	attr_accessor :bouton

	@@prix = 3

	#renvoie le prix associé au bouton
	# @param void		//ne prend aucun paramètre
	# @return prix		//renvie un prix integer
	def prix()
		return @@prix
	end

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
	def aide(monApp, uneGrille, unLabel, unJoueur, interfaceGrille)
		if(@cliquable == true)
			aide1 = Aide.arbreTentePlacer(uneGrille)
			aide2 = Aide.lignePlacerTentes(uneGrille)
			aide3 = Aide.colonnePlacerTentes(uneGrille)
			if(aide1 != nil)
				unLabel.set_markup("<span foreground=\"#E30E0B\" font-desc=\"Courier New bold 11\">Il ne reste qu'une \npossibilité pour la tente de\nl'arbre en surbrillance</span>")
				interfaceGrille[aide1.i][aide1.j].indiquerAide(monApp, uneGrille.grilleJ[aide1.i][aide1.j].etat)
				return aide1
			elsif(aide2 != nil)
				unLabel.set_markup("<span foreground=\"#E30E0B\" font-desc=\"Courier New bold 11\">On peut placer toutes \nles tentes sur la ligne\nen surbrillance</span>")
				for i in (0..uneGrille.taille-1)
					interfaceGrille[i][aide2].indiquerAide(monApp, uneGrille.grilleJ[i][aide2].etat)
				end
				return aide2
			elsif(aide3 != nil)
				unLabel.set_markup("<span foreground=\"#E30E0B\" font-desc=\"Courier New bold 11\">On peut placer toutes \nles tentes sur la colonne\n en surbrillance</span>")
				for i in (0..uneGrille.taille-1)
					interfaceGrille[aide3][i].indiquerAide(monApp, uneGrille.grilleJ[aide3][i].etat)
				end
				return aide3
			else
				unLabel.set_markup("<span foreground=\"#E30E0B\" font-desc=\"Courier New bold 11\">Aucune tente \nne peut être placée</span>")
				return nil
			end
		end
	end

end
