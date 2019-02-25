
# Ce programme a pour but d'interagir avec la base de données des profils des utilisateurs
# Ce programme possède des méthodes pour lire, écrire et trouver des informations qui seront envoyés par le biais de 'profil.rb'

load 'profil.rb'


class Joueur

	def Joueur.creer(unPseudo, unMDP, uneRepSec)
		new(unPseudo, unMDP, uneRepSec)
	end

	def initialize(unPseudo, unMDP, uneRepSec)
		@pseudo = unPseudo
		@mdp = unMDP
		@rep = uneRepSec
		@id = nil
	end

	def inscrire()
		
		puts "Ajout de l'utilisateur #{@pseudo}\n"
		@id = ajouterUtilisateur( @pseudo, @mdp, @rep)
		if  @id != 0 then
			puts "L'utilisateur #{@pseudo} est bien enregistré\n"
			return @id
		else
			puts "Le pseudo #{@pseudo} est déjà enregistré\n"
		end
	end

	def desinscrire()
		puts "Suppression de l'utilisateur #{@pseudo}\n"
		if supprimerUtilisateur(@id) == true then
			puts "L'utilisateur #{@pseudo} a bien été supprimé\n"
		else
			puts "L'utilisateur #{@pseudo} n'existe pas et n'a pas pu être supprimé\n"
		end
	end
end
