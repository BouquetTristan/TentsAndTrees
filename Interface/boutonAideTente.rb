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
			aide = Aide.erreur(uneGrille)
			if(aide != nil)
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">Erreur sur la case #{aide.i} #{aide.j}</span>")
			else
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">Aucune erreur sur la grille actuelle</span>")
				return nil
			end
		end
	end

	attr_accessor :bouton, :cliquable
end