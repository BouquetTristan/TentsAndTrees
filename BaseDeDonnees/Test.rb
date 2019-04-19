

require './BaseDeDonnees/Joueur.rb'


j1 = Joueur.creer("Killian", "Kikidu72", "Killian est genial")
j1.inscrire()



#j2.afficherStatistiques()
j1.connecter()
j1.acheterNiveau(0)
j1.modifierInformationsFinDePartie(250, "Facile", 0)
j1.commencerAventure(2, 2)
j1.recupererSucces()
j1.recupererScoreJoueurs()
j1.afficherStatistiques()
