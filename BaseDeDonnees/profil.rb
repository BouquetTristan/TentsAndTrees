
##
# BOUQUET Tristan
#
# Méthodes pour créer et modifier une base de données

require 'sqlite3'
require 'digest'

# Ouverture de la base de donnée SQLite 3
bddP = SQLite3::Database.new '../BaseDeDonnees/profil.db'
bddN = SQLite3::Database.new '../BaseDeDonnees/niveau.db'
bddA = SQLite3::Database.new '../BaseDeDonnees/aventure.db'
bddG = SQLite3::Database.new '../BaseDeDonnees/grille.db'



# Créer la table du profil si elle n'existe pas
resultat = bddP.execute <<-SQL
	CREATE TABLE IF NOT EXISTS profil
	(
		idJoueur INT PRIMARY KEY,
		pseudo VARCHAR(50) UNIQUE,
		password VARCHAR(50),
		repSecret VARCHAR(50),

		scoreGlobal INT DEFAULT 0,
		scoreFacile INT DEFAULT 0,
		scoreMoyen INT DEFAULT 0,
		scoreDifficile INT DEFAULT 0,

		nbPartiesJouees INT DEFAULT 0,
		nbPartiesFinitSansAides INT DEFAULT 0,
		nbAides INT DEFAULT 10,
		argent INT DEFAULT 0
	);
SQL

# Créer la table des niveaux si elle n'existe pas
resutlatNiveau = bddN.execute <<-SQL
	CREATE TABLE IF NOT EXISTS niveau
	(
		idNiveau INT PRIMARY KEY,
		nomNiveau VARCHAR(15),
		statut VARCHAR(12) CHECK(statut IN ('Verouillé', 'Déverouillé')),
		cout INT
	);
SQL

# Créer la table du mode aventure si elle n'existe pas
resultatAventure = bddA.execute <<-SQL
	CREATE TABLE IF NOT EXISTS aventure
	(
		idAventure INT PRIMARY KEY,
		idPrintemps INT,
		idEte INT,
		idAutomne INT,
		idHiver INT,

		FOREIGN KEY(idAventure) REFERENCES profil(idJoueur),
		FOREIGN KEY(idPrintemps) REFERENCES niveau(idNiveau),
		FOREIGN KEY(idEte) REFERENCES niveau(idNiveau),
		FOREIGN KEY(idAutomne) REFERENCES niveau(idNiveau),
		FOREIGN KEY(idHiver) REFERENCES niveau(idNiveau)
	
	);
SQL


# Créer la table d'une grille si elle n'existe pas
resultatGrille = bddG.execute <<-SQL
	CREATE TABLE IF NOT EXISTS grille
	(
		idGrille INT,
		niveauDifficulte VARCHAR,
		numeroLigne INT,
		idNiveau INT,

		pointGagnable INT,
		statut VARCHAR(8) CHECK(statut IN ('Fait', 'A faire')),

		FOREIGN KEY(idNiveau) REFERENCES niveau(idNiveau),
		PRIMARY KEY(numeroLigne, niveauDifficulte, idNiveau)
	);
SQL

#########################################################
###Méthodes pour modifier la base de données du profil###



def ouvrirBDDP()
	return SQLite3::Database.new '../BaseDeDonnees/profil.db'
end

def ouvrirBDDA()
	return SQLite3::Database.new '../BaseDeDonnees/aventure.db'
end

def ouvrirBDDN()
	return SQLite3::Database.new '../BaseDeDonnees/niveau.db'
end

def ouvrirBDDG()
	return SQLite3::Database.new '../BaseDeDonnees/grille.db'
end


def chercherIDUnique(bdd)
# Cette méthode cherche le nombre de joueur enregistré et renvoie la valeur suppérieure
	id = bdd.execute("SELECT MAX( idJoueur) FROM profil")
	tmp = id.shift.shift.to_i
	#puts tmp.class
	return (tmp+1)

end


# Ajouter et supprimer un utilisateur

def ajouterUtilisateur(unPseudo, unMDP, uneReponse)
#Insérer des informations dans la base de données
	bddP = ouvrirBDDP()
	if !(pseudoDejaPris(unPseudo)) then
		id = chercherIDUnique(bddP)
		bddP.execute("INSERT INTO profil (idJoueur, pseudo, password, repSecret, scoreGlobal, scoreFacile, scoreMoyen, scoreDifficile, nbPartiesJouees, nbPartiesFinitSansAides, argent, nbAides) VALUES ( #{id}, '#{unPseudo}', '#{Digest::SHA256.hexdigest(unMDP)[0..20]}', '#{Digest::SHA256.hexdigest(uneReponse)[0..20]}', 0, 0, 0, 0, 0, 0, 0, 10 )")
		creerModeAventure(id)
		return id
	else
		return 0
	end
end

def supprimerUtilisateur(unID)
#Supprimer des informations dans la base de données
	bdd = ouvrirBDDP()
	if (utilisateurExistant(unID)) then
		bdd.execute("DELETE FROM profil WHERE idJoueur = '#{unID}'")
		return true
	else
		return false
	end
end

def voirLesUtilisateurs()
#Trouver des informations
	bdd = ouvrirBDDP()
	bdd.execute 'SELECT * FROM profil' do |ligne|
		p ligne
	end
end

def utilisateurExistant(unID)
	bdd = ouvrirBDDP()
	if bdd.execute("SELECT idJoueur FROM profil WHERE idJoueur = '#{unID}'").shift.shift != nil
		return true
	else
		return false
	end
end

def pseudoDejaPris(unPseudo)
#Vérifier si un pseudo est déjà présent dans la base de données
	bdd = ouvrirBDDP()
	nbPseudo = bdd.execute("SELECT COUNT(idJoueur) FROM profil WHERE EXISTS (SELECT pseudo FROM profil WHERE pseudo = '#{unPseudo}')").shift.shift
	if nbPseudo == 0
		return false
	else
		return true
	end
end
############
#Création du mode aventure

def creerModeAventure(unID)
	bddA = ouvrirBDDA()
	bddG = ouvrirBDDG()

	baseNiveau = unID*100
	nbGrilleParNiveau = 6

	#Création de tous les niveaux avec l'id du joueur

	ligne = 0

	#printemps
		niveau1 = creerNiveauAventure(baseNiveau, ligne, nbGrilleParNiveau)
		ligne += nbGrilleParNiveau+1
	#été
		niveau2 = creerNiveauAventure(baseNiveau, ligne, nbGrilleParNiveau)
		ligne += nbGrilleParNiveau+1
	#automne
		niveau3 = creerNiveauAventure(baseNiveau, ligne, nbGrilleParNiveau)
		ligne += nbGrilleParNiveau+1
	#hiver
		niveau4 = creerNiveauAventure(baseNiveau, ligne, nbGrilleParNiveau)
		ligne += nbGrilleParNiveau+1
	#Ajout du mode aventure au compte du joueur
	bddA.execute("INSERT INTO aventure (idAventure, idPrintemps, idEte, idAutomne, idHiver) VALUES (#{unID}, #{niveau1}, #{niveau2}, #{niveau3}, #{niveau4})")
	
end

def creerNiveauAventure(baseNiveau, uneLigne, nbGrilleParNiveau)
	bddN = ouvrirBDDN()

	ligneAventure = IO.readlines("../Ressources/aventure.txt")[uneLigne]
	informationAventure = ligneAventure.split(';')


	niveauCourant = baseNiveau + informationAventure.shift.to_i
	nomCourant = informationAventure.shift
	coutCourant = informationAventure.shift.to_i

	bddN.execute("INSERT INTO niveau (idNiveau, nomNiveau, statut, cout) VALUES (#{niveauCourant}, '#{nomCourant}', 'Verouillé', #{coutCourant})")

	for i in 1..nbGrilleParNiveau
		creerGrilleAventure(niveauCourant, uneLigne + i)
	end
	#puts "--------"

	return niveauCourant

end

def creerGrilleAventure(unIDNiveau, uneLigne)
	bddG = ouvrirBDDG()

	ligneGrille = IO.readlines("../Ressources/aventure.txt")[uneLigne]
	#puts "#{ligneGrille}\n"
	informationGrille = ligneGrille.split(';')

	idCourant = informationGrille.shift
	difficulteCourante = informationGrille.shift
	ligneCourante = informationGrille.shift

	bddG.execute("INSERT INTO grille (idGrille, niveauDifficulte, numeroLigne, idNiveau, pointGagnable, statut) VALUES (#{idCourant}, '#{difficulteCourante}', #{ligneCourante}, #{unIDNiveau}, 10, 'A faire')")

end



############

## Méthode de recherche du mot de passe par le pseudo
def connexion(unPseudo, unMDP)
# Recherche si les deux éléments passés en paramètre appartiennent à un même compte
	bdd = ouvrirBDDP()
	if bdd.execute("SELECT password FROM profil WHERE pseudo = '#{unPseudo}'").shift != nil then
		motDePasse = bdd.execute("SELECT password FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
		if Digest::SHA256.hexdigest(unMDP)[0..20] == motDePasse then
			return bdd.execute("SELECT idJoueur FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
		end

		return nil
	end
	return nil
end

############

## Méthodes de changement des informations 

def motDePasseOublie(unPseudo, uneReponse, unMDP)
# Change le mot de passe d'un profil si la réponse secrète est exacte
	bdd = ouvrirBDDP()
	if bdd.execute("SELECT repSecret FROM profil WHERE pseudo = '#{unPseudo}'").shift != nil then
		reponseSecrete = bdd.execute("SELECT repSecret FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
		if Digest::SHA256.hexdigest(uneReponse)[0..20] == reponseSecrete then
			bdd.execute("UPDATE profil SET password = '#{Digest::SHA256.hexdigest(unMDP)[0..20] }' WHERE pseudo = '#{unPseudo}'")
			return true
		end
	else
		return false
	end
end

def changerMotDePasse(unID, leNouveauMDP)
# change le mot de passe d'un profil avec celui obtenu en paramètre
	bdd = ouvrirBDDP()
	if bdd.execute("SELECT password FROM profil WHERE idJoueur = '#{unID}'").shift != Digest::SHA256.hexdigest(leNouveauMDP)[0..20]  then
		bdd.execute("UPDATE profil SET password = '#{Digest::SHA256.hexdigest(leNouveauMDP)[0..20] }' WHERE idJoueur = '#{unID}'")
		return true
	else
		return false
	end
end

def changerPseudo(unID, leNouveauPseudo)
# change le pseudo d'un profil avec celui obtenu en paramètre
	bdd = ouvrirBDDP()
	if bdd.execute("SELECT pseudo FROM profil WHERE idJoueur = '#{unID}'").shift != leNouveauPseudo then
		bdd.execute("UPDATE profil SET pseudo = leNouveauPseudo WHERE idJoueur = '#{unID}'")
		return true
	else
		return false
	end
end

###########

## Méthodes pour modifier les scores, le nombre de partie jouée et terminée et la progression du mode aventure

def augmenterScoreGlobal(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDDP()
	ancienneValeur = bdd.execute("SELECT scoreGlobal FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreGlobal = #{valeur} ")
end

def augmenterScoreFacile(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDDP()
	ancienneValeur = bdd.execute("SELECT scoreFacile FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreFacile = #{valeur} WHERE idJoueur = '#{unID}'")
end

def augmenterScoreMoyen(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDDP()
	ancienneValeur = bdd.execute("SELECT scoreMoyen FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreMoyen = #{valeur} WHERE idJoueur = '#{unID}'")
end

def augmenterScoreDifficile(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDDP()
	ancienneValeur = bdd.execute("SELECT scoreDifficile FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreDifficile = #{valeur} WHERE idJoueur = '#{unID}'")
end

def augmenterNbPartiesJouees(unID)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDDP()
	valeur = bdd.execute("SELECT nbPartiesJouees FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbPartiesJouees = #{valeur} WHERE idJoueur = '#{unID}'")
end

def augmenterNbPartiesTermineesSansAides(unID)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDDP()
	valeur = bdd.execute("SELECT nbPartiesFinitSansAides FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbPartiesFinitSansAides = #{valeur} WHERE idJoueur = '#{unID}'")
end

def augmenterNbAides(unID)
#Augmenter le nombre d'aide disponible par partie d'un joueur
	bdd = ouvrirBDDP()
	valeur = bdd.execute("SELECT nbAides FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbAides = #{valeur} WHERE idJoueur = '#{unID}'")
end

def modifierArgent(unID, uneValeur)
#Permet d'ajouter de l'argent à un joueur en renseignant son id et la valeur à ajouter (Pour enlver, donner une valeur négative)
	bdd = ouvrirBDDP()
	nouvelleValeur = bdd.execute("SELECT argent FROM profil WHERE idJoueur = '#{unID}'").shift.shift + uneValeur
	bdd.execute("UPDATE profil SET argent = #{nouvelleValeur} WHERE idJoueur = '#{unID}'")
end

############

## Méthodes pour interagir avec le mode aventure

def deverouillerNiveau(unIDNiveau)
#Méthode pour déverouiller un niveau
	bdd = ouvrirBDDN()
	bdd.execute("UPDATE niveau SET statut = 'Déverouillé' WHERE idNiveau = '#{unIDNiveau}'")
end

def payerNiveau(unID, unIDNiveau)
#Méthode pour payer un niveau
	bddP = ouvrirBDDP()
	bddN = ouvrirBDDN()

	difference = bddP.execute("SELECT argent FROM profil WHERE idJoueur = '#{unID}'").shift.shift - bddN.execute("SELECT cout FROM niveau WHERE idNiveau = '#{unIDNiveau}'").shift.shift

	if difference >= 0 then
		bddP.execute("UPDATE profil SET argent = #{difference} WHERE idJoueur = '#{unID}'")
		return true
	else 
		return false
	end
end




################

## Méthodes pour voir les différentes informations d'un compte en utilisant l'id
def recupererInformation(unID, iterateur)
# Envoie les informations d'un compte en utilisant l'id. L'itérateur permet de choisir l'information
	bddP = ouvrirBDDP()
	bddA = ouvrirBDDA()
	bddN = ouvrirBDDN()
	bddG = ouvrirBDDG()
	case iterateur
	when 1 # Renvoie le pseudo
		return bddP.execute("SELECT repSecret FROM profil WHERE idJoueur = #{unID}").to_s
	when 2 # Renvoie le score global
		return bddP.execute("SELECT scoreGlobal FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 3 # Renvoie le score facile
		return bddP.execute("SELECT scoreFacile FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 4 # Renvoie le score moyen
		return bddP.execute("SELECT scoreMoyen FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 5 # Renvoie le score difficile
		return bddP.execute("SELECT scoreDifficile FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 6 # Renvoie le nombre de partie jouée
		return bddP.execute("SELECT nbPartiesJouees FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 7 # Renvoie le nombre de partie terminée sans aide
		return bddP.execute("SELECT nbPartiesFinitSansAides FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 8 # Renvoie le nombre d'aide disponible par partie
		return bddP.execute("SELECT nbAides FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 9 # Renvoie l'argent du joueur
		return bddP.execute("SELECT argent FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 10 # Renvoie un array d'un array de 2 paramètres (String nom et String état)
		
		borneInf = unID*100
		borneSup = (unID+1)*100
		taille = bddN.execute("SELECT COUNT(nomNiveau) FROM niveau WHERE idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}'").shift.shift

		informations = Array.new()

		for i in 1..taille
			idDuNiveau = unID*100 + i
			nomCourantNiveau = bddN.execute("SELECT nomNiveau FROM niveau WHERE idNiveau = #{idDuNiveau}").shift.shift
			statutCourantNiveau = bddN.execute("SELECT statut FROM niveau WHERE idNiveau = #{idDuNiveau}").shift.shift

			if statutCourantNiveau == "Déverouillé" then
				nbGrilleParNiveau = bddG.execute("SELECT COUNT(idGrille) FROM grille WHERE idNiveau = #{idDuNiveau}").shift.shift
				nbGrilleAccomplie = bddG.execute("SELECT COUNT(idGrille) FROM grille WHERE idNiveau = #{idDuNiveau} AND statut = 'Fait'").shift.shift
				statutCourantNiveau = "#{nbGrilleAccomplie}/#{nbGrilleParNiveau}"
			end
	
			#puts " #{nomCourantNiveau}\n"
			#puts " #{statutCourantNiveau}\n"
			informationsCourantes = [idDuNiveau, nomCourantNiveau, statutCourantNiveau]
			informations.push(informationsCourantes)
		end

		return informations

	else
		return false
	end
end