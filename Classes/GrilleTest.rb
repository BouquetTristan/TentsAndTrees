require_relative 'Grille.rb'


grille = Grille.creer("Facile", 51)
print "\nGrille du joueur : "
grille.afficherGrille(grille.grilleJ)
print "\nGrille finale : "
grille.afficherGrille(grille.grilleF)
grille.enregistrerFichier
grille = Grille.charger("Facile", 51)
print "\nSauvegarde de la grille\n"
print "\nChargement de la grille\n"
print "\nGrille chargée : "
grille.afficherGrille(grille.grilleJ)
