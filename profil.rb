
require 'sqlite3'
require 'digest'

# Ouverture de la base de donnée SQLite 3
bdd = SQLite3::Database.new 'profil.db'


# Créer la table si elle n'existe pas
resultat = bdd.execute <<-SQL
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

		niveau INT DEFAULT 0,
		tableau INT DEFAULT 0
	);
SQL

def ouvrirBDD()
	return SQLite3::Database.new 'profil.db'
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
	bdd = ouvrirBDD()
	if !(pseudoDejaPris(unPseudo)) then
		id = chercherIDUnique(bdd)
		bdd.execute("INSERT INTO profil (idJoueur, pseudo, password, repSecret, scoreGlobal, scoreFacile, scoreMoyen, scoreDifficile, nbPartiesJouees, nbPartiesFinitSansAides, niveau, tableau) VALUES ( #{id}, '#{unPseudo}', '#{Digest::SHA256.hexdigest(unMDP)[0..20]}', '#{Digest::SHA256.hexdigest(uneReponse)[0..20]}', 0, 0, 0, 0, 0, 0, 0, 0 )")
		return id
	else
		return 0
	end
end

def supprimerUtilisateur(unID)
#Supprimer des informations dans la base de données
	bdd = ouvrirBDD()
	if (utilisateurExistant(unID)) then
		bdd.execute("DELETE FROM profil WHERE idJoueur = '#{unID}'")
		return true
	else
		return false
	end
end

def voirLesUtilisateurs()
#Trouver des informations
	bdd = ouvrirBDD()
	bdd.execute 'SELECT * FROM profil' do |ligne|
		p ligne
	end
end

def utilisateurExistant(unID)
	bdd = ouvrirBDD()
	if bdd.execute("SELECT idJoueur FROM profil WHERE idJoueur = '#{unID}'").shift.shift != nil
		return true
	else
		return false
	end
end

def pseudoDejaPris(unPseudo)
#Vérifier si un pseudo est déjà présent dans la base de données
	bdd = ouvrirBDD()
	nbPseudo = bdd.execute("SELECT COUNT(idJoueur) FROM profil WHERE EXISTS (SELECT pseudo FROM profil WHERE pseudo = '#{unPseudo}')").shift.shift
	if nbPseudo == 0
		return false
	else
		return true
	end
end

############

## Méthode de recherche du mot de passe par le pseudo
def connexion(unPseudo, unMDP)
# Recherche si les deux éléments passés en paramètre appartiennent à un même compte
	bdd = ouvrirBDD()
	if bdd.execute("SELECT password FROM profil WHERE pseudo = '#{unPseudo}'").shift != nil then
		motDePasse = bdd.execute("SELECT password FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
		if Digest::SHA256.hexdigest(unMDP)[0..20] == motDePasse then
			return bdd.execute("SELECT idJoueur FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
		end
	
		return nil
	end

end

############

## Méthode de changement de mot de passe
def nouveauMotDePasse(unID, uneReponse, unMDP)
# Change le mot de passe d'un id si la réponse secrète est exacte
	bdd = ouvrirBDD()
	reponseSecrete = bdd.execute("SELECT repSecret FROM profil WHERE idJoueur = '#{unID}'").to_s
	if Digest::SHA256.hexdigest(uneReponse)[0..20] == reponseSecrete then
		bdd.execute("UPDATE profil SET password = '#{Digest::SHA256.hexdigest(unMDP)[0..20] }' WHERE idJoueur = '#{unID}'")
		return true
	else
		return false
	end
end

###########


## Méthodes pour modifier les scores, le nombre de partie jouée et terminée et la progression du mode aventure

def augmenterScoreGlobal(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreGlobal FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreGlobal = #{valeur} ")
end

def augmenterScoreFacile(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreFacile FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreFacile = #{valeur} WHERE idJoueur = '#{unID}' ")
end

def augmenterScoreMoyen(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreMoyen FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreMoyen = #{valeur} WHERE idJoueur = '#{unID}' ")
end

def augmenterScoreDifficile(unID, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreDifficile FROM profil WHERE idJoueur = '#{unID}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreDifficile = #{valeur} WHERE idJoueur = '#{unID}' ")
end

def augmenterNbPartiesJouees(unID)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT nbPartiesJouees FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbPartiesJouees = #{valeur} WHERE idJoueur = '#{unID}' ")
end

def augmenterNbPartiesTermineesSansAides(unID)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT nbPartiesFinitSansAides FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbPartiesFinitSansAides = #{valeur} WHERE idJoueur = '#{unID}' ")
end

############


## Méthodes pour intérargir avec le mode aventure

def augmenterNiveau(unID)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT niveau FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET niveau = #{valeur} WHERE idJoueur = '#{unID}' ")
end

def augmenterTableau(unID)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT tableau FROM profil WHERE idJoueur = '#{unID}'").shift.shift + 1
	bdd.execute("UPDATE profil SET tableau = #{valeur} WHERE idJoueur = '#{unID}' ")
end

def razTableau(unID)
#Remise à zéro du compteur de tableau
	bdd = ouvrirBDD()
	bdd.execute("UPDATE profil SET tableau = 1 WHERE idJoueur = '#{unID}' ")
end

################

## Méthodes pour voir les différentes informations d'un compte en utilisant l'id
def recupererInformation(unID, iterateur)
# Envoie les informations d'un compte en utilisant l'id. L'itérateur permet de choisir l'information
	bdd = ouvrirBDD()
	case iterateur
	when 1 # Renvoie le pseudo
		return bdd.execute("SELECT pseudo FROM profil WHERE idJoueur = #{unID}").to_s
	when 2 # Renvoie le score global
		return bdd.execute("SELECT scoreGlobal FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 3 # Renvoie le score facile
		return bdd.execute("SELECT scoreFacile FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 4 # Renvoie le score moyen
		return bdd.execute("SELECT scoreMoyen FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 5 # Renvoie le score difficile
		return bdd.execute("SELECT scoreDifficile FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 6 # Renvoie le nombre de partie jouée
		return bdd.execute("SELECT nbPartiesJouees FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 7 # Renvoie le nombre de partie terminée sans aide
		return bdd.execute("SELECT nbPartiesFinitSansAides FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 8 # Renvoie le niveau de progression dans l'histoire
		return bdd.execute("SELECT niveau FROM profil WHERE idJoueur = #{unID}").shift.shift
	when 9 # Renvoie le tableau de progression dans l'histoire
		return bdd.execute("SELECT tableau FROM profil WHERE idJoueur = #{unID}").shift.shift

	else
		return false
	end
end
