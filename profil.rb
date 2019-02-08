
require 'sqlite3'

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

		scoreGlobal INT,
		scoreFacile INT,
		scoreMoyen INT,
		scoreDifficile INT,

		nbPartiesJouees INT,
		nbPartiesFinitSansAides INT,

		niveau INT,
		tableau INT
	);
SQL

def ouvrirBDD()
	return SQLite3::Database.new 'profil.db'
end

def chercherIDUnique(bdd)
# Cette méthode cherche le nombre de joueur enregistré et renvoie la valeur suppérieure
	id = bdd.execute("SELECT COUNT( idJoueur) FROM profil") 
	tmp = id.shift.shift
	#p tmp.respond_to?(:to_i)
	return (tmp+1)

end


def ajouterUtilisateur(pseudo, mdp, rep)
#Insérer des informations dans la base de données
	bdd = ouvrirBDD()
	if (!pseudoDejaPris(pseudo))
		id = chercherIDUnique(bdd)
		bdd.execute("INSERT INTO profil (idJoueur, pseudo, password, repSecret, scoreGlobal, scoreFacile, scoreMoyen, scoreDifficile, nbPartiesJouees, nbPartiesFinitSansAides, niveau, tableau) VALUES ( #{id}, '#{pseudo}', '#{mdp}', '#{rep}', 0, 0, 0, 0, 0, 0, 0, 0 )")
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

def pseudoDejaPris(unPseudo)
#Vérifier si un pseudo est déjà présent dans la base de données
	bdd = ouvrirBDD()
	nbPseudo = bdd.execute("SELECT COUNT(pseudo) FROM profil WHERE EXISTS (SELECT pseudo FROM profil WHERE pseudo = '#{unPseudo}')").shift.shift
	return nbPseudo
end


## Méthodes pour modifier les scores, le nombre de partie jouée et terminée et la progression du mode aventure

def augmenterScoreGlobal(unPseudo, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreGlobal FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreGlobal = #{valeur} ")
end

def augmenterScoreFacile(unPseudo, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreFacile FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreFacile = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

def augmenterScoreMoyen(unPseudo, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreMoyen FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreMoyen = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

def augmenterScoreDifficile(unPseudo, uneValeur)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	ancienneValeur = bdd.execute("SELECT scoreDifficile FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift
	valeur = ancienneValeur + uneValeur
	bdd.execute("UPDATE profil SET scoreDifficile = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

def augmenterNbPartiesJouees(unPseudo)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT nbPartiesJouees FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbPartiesJouees = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

def augmenterNbPartiesTermineesSansAides(unPseudo)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT nbPartiesFinitSansAides FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift + 1
	bdd.execute("UPDATE profil SET nbPartiesFinitSansAides = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

############


## Méthodes pour intérargir avec le mode aventure

def augmenterNiveau(unPseudo)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT niveau FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift + 1
	bdd.execute("UPDATE profil SET niveau = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

def augmenterTableau(unPseudo)
#Augmenter le score global d'un joueur
	bdd = ouvrirBDD()
	valeur = bdd.execute("SELECT tableau FROM profil WHERE pseudo = '#{unPseudo}'").shift.shift + 1
	bdd.execute("UPDATE profil SET tableau = #{valeur} WHERE pseudo = '#{unPseudo}' ")
end

def razTableau(unPseudo)
#Remise à zéro du compteur de tableau
	bdd = ouvrirBDD()
	bdd.execute("UPDATE profil SET tableau = 1 WHERE pseudo = '#{unPseudo}' ")
end

############

## Méthode de recherche du mot de passe par le pseudo
def connexion(unPseudo, unMotDePasse)
# Recherche si les deux éléments passés en paramètre appartiennent à un même compte
	bdd = ouvrirBDD()
	motDePassePseudo = bdd.execute("SELECT password FROM profil WHERE pseudo = '#{unPseudo}'").to_s
	if unMotDePasse = motDePassePseudo then
		return true
	else
		return false
	end
end

############

## Méthode de changement de mot de passe
def nouveauMotDePasse(unPseudo, uneReponse, unMotDePasse)
# Change le mot de passe d'un pseudo si la réponse secrète est exacte
	bdd = ouvrirBDD()
	reponseSecrete = bdd.execute("SELECT repSecret FROM profil WHERE pseudo = '#{unPseudo}'").to_s
	if uneReponse = reponseSecrete then
		bdd.execute("UPDATE profil SET password = '#{unMotDePasse}' WHERE pseudo = '#{unPseudo}'")
		return true
	else
		return false
	end
end