require 'gtk3'
require './boutonAide.rb'

class BoutonAideTente < BoutonAide

	@@prix = 3
	#a voir si c légal ou pas

	def initialize(uneValeur, cliquable)
		super(uneValeur, cliquable)
	end

	def aide(uneGrille, unLabel, unJoueur)
		if(@cliquable == true)
			aide1 = Aide.arbreTentePlacer(uneGrille)
			if(aide1 != nil)
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Il ne reste qu'une possibilité pour la tente de l'arbre en #{aide1.i} #{aide1.j}</span>")
			else
				unLabel.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Aucune tente ne peut être placée</span>")
				return nil
			end
		end
	end

	attr_accessor :bouton, :cliquable
end