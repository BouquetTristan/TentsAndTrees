##
# BOUQUET Tristan
#
# La classe Joueur est là pour stocker les informations de l'utilisateur et servir d'intermédiaire entre le jeu et les bases de données
# L'objet Joueur dispose de plusieurs méthode qui permettent d'envoyer les nouvelles informations de l'utilisateur après avoir agit dans le jeu
# La classe opère à des traitements de l'information avant de les envoyer aux bases de données


require './BaseDeDonnees/FonctionsBDD.rb'

#====== Stock les information de l'utilisateur
class Joueur

	def Joueur.creer(unPseudo, unMDP, uneRepSec)
		new(unPseudo, unMDP, uneRepSec)
	end

	def initialize(unPseudo, unMDP, uneRepSec)
	# On crée toutes les variables d'instances

		@id = nil

		@pseudo = unPseudo
		@mdp = unMDP
		@rep = uneRepSec

		@creditAide = nil #nbFeuilles
		@argent = nil  #nbEtoiles

		@scoreGlobal = nil
		@scoreFacile = nil
		@scoreMoyen = nil
		@scoreDifficile = nil

		@nbPartiesJouees = nil
		@nbPartiesFinitSansAides = nil

		#Mode Aventure
		@niveaux = Array.new

	end

	attr_reader :pseudo
	attr_reader :scoreGlobal
	attr_reader :scoreFacile
	attr_reader :scoreMoyen
	attr_reader :scoreDifficile
	attr_reader :nbPartiesJouees
	attr_reader :creditAide
	attr_reader :argent
	attr_reader :niveaux

	def inscrire()
	# On envoie les informations du nouveau joueur dans le fichier FonctionBDD.rb pour que le joueur soit créé
		#puts "Ajout de l'utilisateur #{@pseudo}\n"
		@id = ajouterUtilisateur( @pseudo, @mdp, @rep)
		if  @id != 0 then
			connecter()
			#puts "\n\n\nL'utilisateur #{@pseudo} est bien enregistré\n\n\n"
		else
			#puts "\n\n\nLe pseudo #{@pseudo} est déjà enregistré\n\n\n"
		end
		return @id
	end

	def desinscrire()
	# On envoie les informations du nouveau joueur dans le fichier FonctionBDD.rb pour que le joueur soit supprimée
		#puts "Suppression de l'utilisateur #{@pseudo}\n"
		if supprimerUtilisateur(@id) == true then
			#puts "L'utilisateur #{@pseudo} a bien été supprimé\n"
		else
			#puts "L'utilisateur #{@pseudo} n'existe pas et n'a pas pu être supprimé\n"
		end
	end

	def connecter()
	# On va voir si le joueur est présent dans les bases de données et on va aller les récupérer avec actualiser()
		#puts "Connexion en cours....\n"
		id = connexion(@pseudo, @mdp)
		if id != nil then
			#puts "   Authentification en cours....\n"
			#puts "   Récupération des informations....\n"
				@id = id
				actualiser()

			#puts "Connexion réussie\n"
		else
			#puts "Connexion échouée\n"
		end

		return id
	end

	def motDePasseOublier(nouveauMDP)
	# On modifie le mot de passe si son pseudo et sa réponse secrète sont bien dans les bases de données et appartiennent au même profil
		if motDePasseOublie(@pseudo, @rep, nouveauMDP) == true then
			@mdp = nouveauMDP
			#puts "   Le mot de passe a bien été modifié\n"
			return true
		else
			#puts "   La réponse secrète est incorrecte\n"
			return false
		end
	end

	def nouveauMotDePasse(nouveauMotDePasse)
	# On modifie le mot de passe du joueur
		if changerMotDePasse(@id, nouveauMotDePasse) == true then
			@mdp = nouveauMotDePasse
			#puts "   Le mot de passe a bien été modifié\n"
			return true
		else
			#puts "   Le nouveau mot de passe ne peut pas être le même\n"
			return false
		end
	end

	def nouveauPseudo(nouveauPseudo)
	# On modifie le pseudo du joueur
		if changerPseudo(@id, nouveauPseudo) == true then
			@pseudo = nouveauPseudo
			#puts "   Le pseudo a bien été modifié\n"
			return true
		else
			#puts "   Le nouveau pseudo ne peut pas être le même\n"
			return false
		end
	end

	def afficherStatistiques()
	# Méthode de test servant à afficher toutes les informations d'un profil
		if @scoreGlobal != nil then
#			puts "Joueur : #{@pseudo}##{@id}\n"
#			puts " Score \n"
#			puts "  Score global : #{@scoreGlobal}\n"
#			puts "  Score facile : #{@scoreFacile}\n"
#			puts "  Score moyen : #{@scoreMoyen}\n"
#			puts "  Score difficile : #{@scoreDifficile}\n"
#			puts " Info parties \n"
#			puts "  Parties jouées : #{@nbPartiesJouees}\n"
#			puts "  Parties finit sans aides : #{@nbPartiesFinitSansAides}\n"
#			puts " Info profil \n"
#			puts "  Nb aides : #{@creditAide}\n"
#			puts "  argent : #{@argent}\n"
#			puts " Histoire \n"
			for i in 0..(@niveaux.length-1)
				nomNiveau = @niveaux.at(i).at(1)
				statutNiveau = @niveaux.at(i).at(2)
				puts "  #{nomNiveau} : #{statutNiveau}\n"
			end
#		else
#			puts "Erreur, aucune information présente. Veuillez vous identifiez avant\n"
		end
	end

	def commencerAventure(unNiveau, uneGrille)
	# Méthode qui permet d'envoyer les informations de la grille du mode aventure avec le numéro du niveau et de la grille passés en paramètres
		return donnerInformationsGrille(@id, unNiveau, uneGrille)
	end

	def acheterNiveau(unNumeroNiveau)
	# Méthode permettant de soustraire l'argent du joueur pour acheter le niveau dont l'indice est passé en paramètre
		if payerNiveau(@id, @niveaux.at(unNumeroNiveau).at(0)) then
			deverouillerNiveau(@niveaux.at(unNumeroNiveau).at(0))
			actualiser()
			return true
		else
			return false
		end
	end

	def niveauDeverouille(unNumeroNiveau)
	# Méthode permettant de changer le statut d'un niveau pour le dévérouiller dont l'indice est passé en paramètre
		return niveauDebloque(@id, unNumeroNiveau)
	end

	def finirLaPartie(unNiveau, uneGrille)
	# Méthode qui modifie les bases de données après la fin de chaque partie du mode aventure en ajoutant de l'argent, en
	# changeant le statut de la grille et en augmentant le nombre d'aide disponible si les conditions sont remplies
		if grillePasFaite(@id, unNiveau, uneGrille) then
			recupererArgentGrille(@id, unNiveau, uneGrille)
			changerStatutGrille(@id, unNiveau, uneGrille)

			if niveauComplet(@id, unNiveau, uneGrille) then
				augmentercreditAide(@id, 4)
			end

			actualiser()

			return true
		else
			return false
		end
	end


	def modifierInformationsFinDePartie(unScore, uneDifficulte, creditAideUtilises)
	# Méthode qui modifie les bases de données après la fin de chaque partie du mode compétition en sauvegardant le nouveau score
	# s'il est plus haut que celui sauvegardé. On incrémente les statistiques du joueur si les conditions sont remplies
		if uneDifficulte == "Facile" && unScore > @scoreFacile then
			@scoreFacile = unScore
			augmenterScoreFacile(@id, @scoreFacile)
		end
		if uneDifficulte == "Moyenne" && unScore > @scoreMoyen then
			@scoreMoyen = unScore
			augmenterScoreMoyen(@id, @scoreMoyen)
		end
		if uneDifficulte == "Difficile" && unScore > @scoreDifficile then
			@scoreDifficile = unScore
			augmenterScoreDifficile(@id, @scoreDifficile)
		end

		@scoreGlobal = (@scoreFacile + @scoreMoyen + @scoreDifficile)/3
		augmenterScoreGlobal(@id, @scoreGlobal)


		augmenterNbPartiesJouees(@id)

		if creditAideUtilises == 0 then
			augmenterNbPartiesTermineesSansAides(@id)
		end

		@nbPartiesJouees = recupererInformation(@id, 6)
		@nbPartiesFinitSansAides = recupererInformation(@id, 7)

		actualiser()

	end



	def verifierSucces()
	# Méthode permettant de voir si un succès peut être validé
		dernierSucces = dernierSucces()

		(0..dernierSucces).each do |i|
			if inspecterSucces(i, @id) then
				validerSucces(i, @id)
			end
		end
	end

	def recupererSucces()
	# Méthode permettant de voir tous les succès et ceux validé par le joueur
		return voirSucces(@id)
	end

	def recupererScoreJoueurs()
	# Méthode permettant de voir le score de tous les autres joueurs
		return scoreDeTousLesJoueurs()
	end


	def actualiser()
	# Méthode permettant de récupérer toutes les informations du joueur et les place dans les variables d'instances

		@rep = recupererInformation(@id, 1)

		@scoreGlobal = recupererInformation(@id, 2)
		@scoreFacile = recupererInformation(@id, 3)
		@scoreMoyen = recupererInformation(@id, 4)
		@scoreDifficile = recupererInformation(@id, 5)

		@nbPartiesJouees = recupererInformation(@id, 6)
		@nbPartiesFinitSansAides = recupererInformation(@id, 7)

		@creditAide = recupererInformation(@id, 8)
		@argent = recupererInformation(@id, 9)

		@niveaux = recupererInformation(@id, 10)
	end

end
