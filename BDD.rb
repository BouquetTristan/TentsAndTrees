##
# BOUQUET Tristan
#
# Ce fichier contient les méthodes de créations des bases de données 
##


require 'sqlite3'
require 'digest'

dbProfil = './BaseDeDonnees/profil.db'
dbAventure = './BaseDeDonnees/aventure.db'
dbNiveau = './BaseDeDonnees/niveau.db'
dbGrille = './BaseDeDonnees/grille.db'
dbSucces = './BaseDeDonnees/succes.db'
dbConditionsS = './BaseDeDonnees/conditionSucces.db'

# Ouverture de la base de donnée SQLite 3
if (!File.exist?(dbProfil) || !File.exist?(dbAventure) || !File.exist?(dbNiveau) || !File.exist?(dbGrille) || !File.exist?(dbSucces) || !File.exist?(dbConditionsS))
	
	if File.exist?(dbProfil)
		File.delete(dbProfil)
	end

	if File.exist?(dbAventure)
		File.delete(dbAventure)
	end

	if File.exist?(dbNiveau)
		File.delete(dbNiveau)
	end

	if File.exist?(dbGrille)
		File.delete(dbGrille)
	end

	if File.exist?(dbSucces)
		File.delete(dbSucces)
	end

	if File.exist?(dbConditionsS)
		File.delete(dbConditionsS)
	end

	bddP = SQLite3::Database.new dbProfil
	bddA = SQLite3::Database.new dbAventure
	bddN = SQLite3::Database.new dbNiveau
	bddG = SQLite3::Database.new dbGrille
	bddS = SQLite3::Database.new dbSucces
	bddCS = SQLite3::Database.new dbConditionsS


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

			temps INT,

			pointGagnable INT,
			statut VARCHAR(8) CHECK(statut IN ('Fait', 'A faire')),

			FOREIGN KEY(idNiveau) REFERENCES niveau(idNiveau),
			PRIMARY KEY(numeroLigne, niveauDifficulte, idNiveau)
		);
	SQL


	# Créer la table des succes si elle n'existe pas
	resultatSucces = bddS.execute <<-SQL
		CREATE TABLE IF NOT EXISTS succes
		(
			idSucces INT, 
			idJoueur INT,

			nom VARCHAR(40),
			description VARCHAR(100),
			statut VARCHAR(8) CHECK(statut IN ('Fait', 'A faire')),

			FOREIGN KEY(idJoueur) REFERENCES profil(idJoueur),
			PRIMARY KEY(idJoueur, idSucces)
		);
	SQL


	# Créer la table des conditions de succes si elle n'existe pas
	resultatConditionSucces = bddCS.execute <<-SQL
		CREATE TABLE IF NOT EXISTS conditionSucces
		(
			idSucces INT, 
			donnee VARCHAR(20),
			tableCondition VARCHAR(10),
			valeurCOndition INT,

			FOREIGN KEY(idSucces) REFERENCES succes(idSucces)
		);
	SQL
end