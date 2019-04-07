##
# BOUQUET Tristan
#
# Ce fichier contient les méthodes de créations des bases de données 
##


require 'sqlite3'
require 'digest'

# Ouverture de la base de donnée SQLite 3
bddP = SQLite3::Database.new '../BaseDeDonnees/profil.db'
bddA = SQLite3::Database.new '../BaseDeDonnees/aventure.db'
bddN = SQLite3::Database.new '../BaseDeDonnees/niveau.db'
bddG = SQLite3::Database.new '../BaseDeDonnees/grille.db'
bddS = SQLite3::Database.new '../BaseDeDonnees/succes.db'



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
		grilleFaite INT,
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
