
##
# BOUQUET Tristan
#
# Ce fichier contient toutes les méthodes pour lire, écrire, supprimer ou remplacer des informations contenues dans les
# bases de données
##

require 'sqlite3'
require 'digest'


#########################################################
### Méthodes pour modifier la base de données du profil###

##################
## Méthodes d'ouverture des bases de données

def ouvrirBDDP()
	return SQLite3::Database.new './BaseDeDonnees/profil.db'
end

def ouvrirBDDA()
	return SQLite3::Database.new './BaseDeDonnees/aventure.db'
end

def ouvrirBDDN()
	return SQLite3::Database.new './BaseDeDonnees/niveau.db'
end

def ouvrirBDDG()
	return SQLite3::Database.new './BaseDeDonnees/grille.db'
end

def ouvrirBDDS()
	return SQLite3::Database.new './BaseDeDonnees/succes.db'
end

def ouvrirBDDCS()
	return SQLite3::Database.new './BaseDeDonnees/conditionSucces.db'
end

###################


def chercherIDUnique(bdd)
# Cette méthode cherche le nombre de joueur enregistré et renvoie la valeur supérieure
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
		creerSucces(id)
		return id
	else
		return 0
	end
end

def supprimerUtilisateur(unID)
#Supprimer des informations dans la base de données
	bddP = ouvrirBDDP()
	bddA = ouvrirBDDA()
	bddN = ouvrirBDDN()
	bddG = ouvrirBDDG()
	bddS = ouvrirBDDS()

	borneInf = unID*100
	borneSup = (unID+1)*100

	if (utilisateurExistant(unID)) then
		bddG.execute("DELETE FROM grille WHERE idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}'")
		bddN.execute("DELETE FROM niveau WHERE idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}'")
		bddA.execute("DELETE FROM aventure WHERE idAventure = '#{unID}'")
		bddS.execute("DELETE FROM succes WHERE idJoueur = '#{unID}'")
		bddP.execute("DELETE FROM profil WHERE idJoueur = '#{unID}'")
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
	if bdd.execute("SELECT idJoueur FROM profil WHERE idJoueur = '#{unID}'").shift != nil
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

	ligneAventure = IO.readlines("./Ressources/aventure.txt")[uneLigne]
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

	ligneGrille = IO.readlines("./Ressources/aventure.txt")[uneLigne]
	#puts "#{ligneGrille}\n"
	informationGrille = ligneGrille.split(';')

	idCourant = informationGrille.shift.to_i + unIDNiveau%100
	difficulteCourante = informationGrille.shift
	ligneCourante = informationGrille.shift
	tempsCourant = informationGrille.shift.to_i

	#puts "#{difficulteCourante}\n"
	#puts "#{ligneCourante}\n"

	bddG.execute("INSERT INTO grille (idGrille, niveauDifficulte, numeroLigne, idNiveau, temps, pointGagnable, statut) VALUES (#{idCourant}, '#{difficulteCourante}', #{ligneCourante}, #{unIDNiveau}, #{tempsCourant}, 10, 'A faire')")

end


############

## Méthodes pour créer les succès de chaque joueur
def creerSucces(unID)
# Méthode qui crée la base de données des succès du joueur à partir du fichier Succes.txt
	bddS = ouvrirBDDS()

	idDuSucces = 0

	# Lecture de l'ensemble du fichier
	ligneFichier = IO.readlines("./Ressources/Succes.txt")
	ligneFichier.each { |ligne| 
		leSucces = ligne.split('><')

		nomDuSucces = leSucces[0]
		descriptionDuSucces = leSucces[1]

		bddS.execute("INSERT INTO succes (idSucces, idJoueur, nom, description, statut) VALUES (#{idDuSucces}, #{unID}, '#{nomDuSucces}', '#{descriptionDuSucces}', 'A faire')")

		creerConditionSucces(idDuSucces, leSucces[2])
		idDuSucces += 1
	}
end

def creerConditionSucces(unID, lesConditions)
# Méthode qui crée la base de données des conditions des succès du joueur à partir de l'id du succes et des conditions reçu en paramètres
	bddCS = ouvrirBDDCS()


	laCondition = lesConditions.split(';')
	donnee = laCondition[0]
	table = laCondition[1]
	valeur = laCondition[2].to_i

	bddCS.execute("INSERT INTO conditionSucces (idSucces, donnee, tableCondition, valeurCondition) VALUES (#{unID}, '#{donnee}', '#{table}', #{valeur})")
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
	if bdd.execute("SELECT pseudo FROM profil WHERE idJoueur = '#{unID}'").shift != leNouveauPseudo && !(pseudoDejaPris(leNouveauPseudo)) then
		bdd.execute("UPDATE profil SET pseudo = '#{leNouveauPseudo}' WHERE idJoueur = '#{unID}'")
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

def augmenterNbAides(unID, uneValeur)
#Augmenter le nombre d'aide disponible par partie d'un joueur
	bdd = ouvrirBDDP()
	valeur = bdd.execute("SELECT nbAides FROM profil WHERE idJoueur = '#{unID}'").shift.shift + uneValeur
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

def changerStatutGrille(unID, unIDGrille)
#Méthode pour changer le statut d'une grille d'un joueur de 'A faire' à 'Fait'
	bddG = ouvrirBDDG()

	borneInf = unID*100
	borneSup = (unID+1)*100

	bddG.execute("UPDATE grille SET statut = 'Fait' WHERE (idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}') AND idGrille = #{unIDGrille}")

end

def recupererArgentGrille(unID, unIDGrille)
#Méthode pour donner l'argent d'une grille à un joueur
	bddP = ouvrirBDDP()
	bddG = ouvrirBDDG()

	borneInf = unID*100
	borneSup = (unID+1)*100

	nbPoint = bddG.execute("SELECT pointGagnable FROM grille WHERE (idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}') AND idGrille = #{unIDGrille}").shift.shift
	argentDuJoueur = nbPoint + bddP.execute("SELECT argent FROM profil WHERE idJoueur = #{unID}").shift.shift
	bddP.execute("UPDATE profil SET argent = #{argentDuJoueur} WHERE idJoueur = #{unID}")
end

def grillePasFaite(unID, unIDGrille)
#Méthode pour vérifier si une grille a été faite ou non
	bddG = ouvrirBDDG()

	borneInf = unID*100
	borneSup = (unID+1)*100

	statut = bddG.execute("SELECT statut FROM grille WHERE (idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}') AND idGrille = #{unIDGrille}").shift

	if statut == "A faire" then
		return true
	else
		return false
	end
end

def niveauComplet(unID, unIDGrille)
#Méthode pour vérifier si le niveau où se trouve la grille est complet
	bddG = ouvrirBDDG()

	borneInf = unID*100
	borneSup = (unID+1)*100

	niveauCourant = bddG.execute("SELECT idNiveau FROM grille WHERE idGrille = #{unIDGrille} AND (idNiveau BETWEEN '#{borneInf}' AND '#{borneSup}')")

	if bddG.execute("SELECT COUNT(idGrille) FROM grille WHERE idNiveau = #{niveauCourant} AND statut = 'Fait'") == bddG.execute("SELECT COUNT(idGrille) FROM grille WHERE idNiveau = #{idNiveauCourant}") then
		return true
	end
end



################

## Méthode pour récupérer les informations du succès
def inspecterSucces(unIDS, unID)
	bddCS = ouvrirBDDCS()

	uneDonnee = bddCS.execute("SELECT donnee FROM conditionSucces WHERE idSucces = #{unIDS}").shift.shift
	uneTable = bddCS.execute("SELECT tableCondition FROM conditionSucces WHERE idSucces = #{unIDS}").shift.shift
	uneValeur = bddCS.execute("SELECT valeurCondition FROM conditionSucces WHERE idSucces = #{unIDS}").shift.shift
	
	verifierSucces(unIDS, unID, uneDonnee, uneTable, uneValeur)
end

## Méthode pour vérifier si ce succès peut être validé ou non et renvoie le résultat en booléan
def verifierSucces(unIDS, unID, uneDonnee, uneTable, uneValeur)
	bddP = ouvrirBDDP()
	bddA = ouvrirBDDA()
	bddN = ouvrirBDDN()
	bddG = ouvrirBDDG()
	bddS = ouvrirBDDS()

	if bddS.execute("SELECT statut FROM succes WHERE idSucces = #{unIDS} AND idJoueur = #{unID}") == 'A faire' then
		case uneTable
			when 'profil' # si la table est la table profil
				if bddP.execute("SELECT #{uneDonnee} FROM #{uneTable} WHERE idJoueur = #{unID}") >= uneValeur then
					return true
				end
			when 'aventure' # si la table est la table aventure
				if bddA.execute("SELECT #{uneDonnee} FROM #{uneTable} WHERE idJoueur = #{unID}") >= uneValeur then
					return true
				end
		else
			return false
		end
	else
		return false
	end
end

def validerSucces(unIDS, unID)
	bddS = ouvrirBDDS()

	bddS.execute("UPDATE succes SET statut = 'Fait' WHERE idSucces = #{unIDS} AND idJoueur = #{unID}")
end

################

## Méthode pour voir les différentes informations d'un compte en utilisant l'id


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

#################

##Méthode pour renvoyer les identifiants de la grille, le niveau de difficulté et le numéro de la ligne
def donnerInformationsGrille(unID, leNiveau, laGrille)

	bddG = ouvrirBDDG()

	informationsGrille = Array.new()

	
	idNiveauBDD = unID*100 + leNiveau

	nbGrilleParNiveau = bddG.execute("SELECT COUNT(idGrille) FROM grille WHERE idNiveau = #{idNiveauBDD}").shift.shift

	idGrilleBDD = (nbGrilleParNiveau + 1)*(leNiveau-1) + laGrille
	difficulte = bddG.execute("SELECT niveauDifficulte FROM grille WHERE idGrille = #{idGrilleBDD} AND idNiveau = #{idNiveauBDD}").shift.shift
	numLigne = bddG.execute("SELECT numeroLigne FROM grille WHERE idGrille = #{idGrilleBDD} AND idNiveau = #{idNiveauBDD}").shift.shift
	tempsGrille = bddG.execute("SELECT temps FROM grille WHERE idGrille = #{idGrilleBDD} AND idNiveau = #{idNiveauBDD}").shift.shift

	informationsGrille = [idGrilleBDD, difficulte, numLigne, tempsGrille]

	return informationsGrille
end