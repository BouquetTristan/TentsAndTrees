require_relative 'Grille.rb'
require_relative 'Aide.rb'



numGrille = 40	#Attention ! Le changement de grille lors du test peut le casser, les cases dont l'état a été changé peuvent se retrouver hors grille.

grille = Grille.creer("Facile", numGrille)
print "\nGrille du joueur : "
grille.afficherGrille(grille.grilleJ)
print "\nGrille finale : "
grille.afficherGrille(grille.grilleF)


aide = Aide.erreur(grille)
print aide != nil ? "Erreur sur la case #{aide.i} #{aide.j}": "Aucune erreur"

aide = Aide.ligneCompleterHerbes(grille)
print aide != nil ? "\nLa ligne #{aide} peut être complétée par des herbes": "\nAucune ligne ne peut être complétée par des herbes"

aide = Aide.colonneCompleterHerbes(grille)
print aide != nil ? "\nLa colonne #{aide} peut être complétée par des herbes": "\nAucune colonne ne peut être complétée par des herbes"

grille.grilleJ[1][0].jouerCase()

grille.grilleJ[1][0].jouerCase()


print "\n\nGrille du joueur après avoir placé une tente : "
grille.afficherGrille(grille.grilleJ)

aide = Aide.tenteContourCompleter(grille)
print aide != nil ? "\nLe contour de la tente en #{aide.i} #{aide.j} doit être complété": "\nAucun contour de tente ne peut être complété par des herbes"


grille.grilleJ[4][6].jouerCase()
grille.grilleJ[6][6].jouerCase()

print "\n\nGrille du joueur après avoir placé des herbes : "
grille.afficherGrille(grille.grilleJ)

aide = Aide.arbreTentePlacer(grille)
print aide != nil ? "\nL'arbre en #{aide.i} #{aide.j} possède une seule possiblité pour une tente": "\nIl n'y a pas d'arbre avec une seule case disponible"

aide = Aide.arbreAngleHerbe(grille)
print aide != nil ? "\nL'arbre en #{aide.i} #{aide.j} possède un coin qui est obligatoirement de l'herbe": "\nIl n'y a pas d'arbre avec un coin à compléter"
aide = Aide.caseEstDeLHerbe(grille)
print aide != nil ? "\nLa case en #{aide.i} #{aide.j} est obligatoirement de l'herbe": "\nIl n'y a aucune case vide à compléter par de l'herbe"

print "\n\nGrille pour le déplacement vertical"

#Bah super
grille.parcourirC() { |ligne|
	print "\n"
	ligne.each do |c|
		print c
	end
	print "\n"
}


