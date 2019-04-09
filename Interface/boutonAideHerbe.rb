require 'gtk3'
require './boutonAide.rb'

class BoutonAideHerbe < BoutonAide

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton
	# @@prix		: prix de l'aide en feuille
	
	attr_accessor :cliquable
	attr_accessor :bouton


	@@prix = 4


	#Initialize le bouton
	# @param uneValeur    //Le nom du label
	# @param cliquable    //Booléen 
	# @return void  	//ne renvoie rien
	def initialize(uneValeur, cliquable)
		super(uneValeur, cliquable)
	end
	

	#Définie la marche à suivre en cas d'appel d'aide sur le bouton herbe
	# @param uneGrille    //la grille de jeu
	# @param unLabel    //La position d'affichage 
	# @param unJoueur    //POur sauvegarder le joueur et ne pas le perdre en cas de changement de page 
	# @return nil  	//si aucune aide ne trouve de solution
	def aide(uneGrille, unLabel, unJoueur)
		if(@cliquable == true)
			aide1 = Aide.ligneCompleterHerbes(uneGrille)
			aide2 = Aide.colonneCompleterHerbes(uneGrille)
			aide3 = Aide.tenteContourCompleter(uneGrille)
			aide4 = Aide.arbreAngleHerbe(uneGrille)
			if(aide1 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">La colonne #{aide1} peut être complétée par des herbes</span>")
			elsif(aide2 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">La ligne #{aide2} peut être complétée par des herbes</span>")
			elsif(aide3 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Le contour de la tente en #{aide3.i} #{aide3.j} doit être complété</span>")
			elsif(aide4 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">L'arbre en #{aide4.i} #{aide4.j} possède un coin qui est obligatoirement de l'herbe</span>")
			else
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Aucune herbe ne peut être placée</span>")
				return nil
			end
		end
	end
	
end
