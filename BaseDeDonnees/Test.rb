

load '../BaseDeDonnees/Joueur.rb'


j1 = Joueur.creer("Killian", "Kikidu72", "Killian est genial")
j1.inscrire()


j2 = Joueur.creer("Mehdi", "MerguezEnChaleur", "Mehdi est un BG")
j2.inscrire()


j3 = Joueur.creer("Yann", "YannouilleDu72", "Yayaya")
j3.inscrire()


#j2.desinscrire()

j2.connecter()
#j2.afficherStatistiques()
j1.connecter()
j1.acheterNiveau(0)

j1.afficherStatistiques()
