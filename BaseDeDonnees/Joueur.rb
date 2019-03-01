
# Ce programme a pour but d'interagir avec la base de données des profils des utilisateurs
# Ce programme possède des méthodes pour lire, écrire et trouver des informations qui seront envoyés par le biais de 'profil.rb'

load '../../BaseDeDonnees/profil.rb'


class Joueur

	def Joueur.creer(unPseudo, unMDP, uneRepSec)
		new(unPseudo, unMDP, uneRepSec)
	end

	def initialize(unPseudo, unMDP, uneRepSec)
		@id = nil

		@pseudo = unPseudo
		@mdp = unMDP
		@rep = uneRepSec

		@scoreGlobal = nil
		@scoreFacile = nil
		@scoreMoyen = nil
		@scoreDifficile = nil

		@nbPartiesJouees = nil
		@nbPartiesFinitSansAides = nil

		@niveau = nil
		@tableau = nil

	end

	def inscrire()
		
		puts "Ajout de l'utilisateur #{@pseudo}\n"
		@id = ajouterUtilisateur( @pseudo, @mdp, @rep)
		if  @id != 0 then
			puts "\n\n\nL'utilisateur #{@pseudo} est bien enregistré\n\n\n"
		else
			puts "\n\n\nLe pseudo #{@pseudo} est déjà enregistré\n\n\n"
		end
		return @id
	end

	def desinscrire()
		puts "Suppression de l'utilisateur #{@pseudo}\n"
		if supprimerUtilisateur(@id) == true then
			puts "L'utilisateur #{@pseudo} a bien été supprimé\n"
		else
			puts "L'utilisateur #{@pseudo} n'existe pas et n'a pas pu être supprimé\n"
		end
	end

	def connecter()
		puts "Connexion en cours....\n"
		id = connexion(@pseudo, @mdp)
		if id != nil then
			puts "   Authentification en cours....\n"
			puts "   Récupération des informations....\n"
				@id = id
				@rep = recupererInformation(@id, 1)
				@scoreGlobal = recupererInformation(@id, 2)
				@scoreFacile = recupererInformation(@id, 3)
				@scoreMoyen = recupererInformation(@id, 4)
				@scoreDifficile = recupererInformation(@id, 5)

				@nbPartiesJouees = recupererInformation(@id, 6)
				@nbPartiesFinitSansAides = recupererInformation(@id, 7)

				@niveau = recupererInformation(@id, 8)
				@tableau = recupererInformation(@id, 9)
			puts "Connexion réussie\n"
		else
			puts "Connexion échouée\n"
		end

		return id
	end

	def motDePasseOublier(nouveauMDP)
		if nouveauMotDePasse(@pseudo, @rep, nouveauMDP) == true then
			puts "   Le mot de passe a bien été modifié\n"
			return true
		else
			puts "   La réponse secrète est incorrecte\n"
			return false
		end
	end

	def afficherStatistiques()
		if @scoreGlobal != nil then
			puts "Joueur : #{@pseudo}##{@id}\n"
			puts " Score \n"
			puts "  Score global : #{@scoreGlobal}\n"
			puts "  Score facile : #{@scoreFacile}\n"
			puts "  Score moyen : #{@scoreMoyen}\n"
			puts "  Score difficile : #{@scoreDifficile}\n"
			puts " Info parties \n"
			puts "  Parties jouées : #{@nbPartiesJouees}\n"
			puts "  Parties finit sans aides : #{@nbPartiesFinitSansAides}\n"
			puts " Histoire \n"
			puts "  Niveau : #{@niveau}\n"
			puts "  Tableau : #{@tableau}\n"
		else
			puts "Erreur, aucune information présente. Veuillez vous identifiez avant\n"
		end
	end
end
