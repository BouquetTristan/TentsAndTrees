require 'gtk3'
require './boutonAide.rb'

class BoutonAideHerbe < BoutonAide

	@@prix = 4
	#a voir si c légal ou pas

	def initialize(uneValeur, cliquable)
		super(uneValeur, cliquable)
	end

	def aide(uneGrille, unLabel, unJoueur)
		if(@cliquable == true)
			aide1 = Aide.ligneCompleterHerbes(uneGrille)
			aide2 = Aide.colonneCompleterHerbes(uneGrille)
			aide3 = Aide.tenteContourCompleter(uneGrille)
			aide4 = Aide.arbreTentePlacer(uneGrille)
			aide5 = Aide.arbreAngleHerbe(uneGrille)
			if(aide1 != nil)
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">La colonne #{aide1} peut être complétée par des herbes</span>")
			elsif(aide2 != nil)
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">La ligne #{aide2} peut être complétée par des herbes</span>")
			elsif(aide3 != nil)
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">Le contour de la tente en #{aide3.i} #{aide3.j} doit être complété</span>")
			elsif(aide4 != nil)
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">Il ne reste qu'une possibilité pour la tente de l'arbre en #{aide4.i} #{aide4.j}</span>")
			elsif(aide5 != nil)
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">L'arbre en #{aide4.i} #{aide4.j} possède un coin qui est obligatoirement de l'herbe</span>")
			else
				unLabel.set_markup("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 11\">Aucune herbe ne peut être placée</span>")
				return nil
			end
		end
	end
	attr_accessor :bouton, :cliquable
end
