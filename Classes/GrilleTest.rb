require_relative 'Grille.rb'

numGrille = 40

#Test de la création et de l'affichage d'une grille
grille = Grille.creerD("Facile")
print "\nGrille du joueur : "
grille.afficherGrille(grille.grilleJ)
print "\nGrille finale : "
grille.afficherGrille(grille.grilleF)

#Test du parcours horizontal de la grille
grille.parcourirH  {|c| c.jouerCase()}
print "\nGrille du joueur après avoir joué chaque case 1 fois : "
grille.afficherGrille(grille.grilleJ)

#Test de la sauvegarde et du chargement d'une grille
print "\nSauvegarde de la grille\n"
grille.enregistrerFichier
print "\nChargement de la grille\n"
grille = Grille.charger("Facile", numGrille)

print "\nGrille chargée : "
grille.afficherGrille(grille.grilleJ)

