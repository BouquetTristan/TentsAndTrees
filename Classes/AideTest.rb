require_relative 'Grille.rb'
require_relative 'Aide.rb'

numGrille = 40

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