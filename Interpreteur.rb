
# Ce programme a pour but d'interagir avec la base de données des profils des utilisateurs
# Ce programme possède des méthodes pour lire, écrire et trouver des informations qui seront envoyés par le biais de 'profil.rb'

load 'profil.rb'




def inscription(pseudo, mdp, rep)
	
	puts "Ajout de l'utilisateur #{pseudo}\n"
	resInscription = ajouterUtilisateur( pseudo, mdp, rep)
	if  resInscription != 0 then
		puts "L'utilisateur #{pseudo} est bien enregistré\n"
		return resInscription
	else
		puts "Le pseudo #{pseudo} est déjà enregistré\n"
	end
end

def desinscrire(pseudo)
	puts "Suppression de l'utilisateur #{pseudo}\n"
	if supprimerUtilisateur(pseudo) == true then
		puts "L'utilisateur #{pseudo} a bien été supprimé\n"
	else
		puts "L'utilisateur #{pseudo} n'existe pas et n'a pas pu être supprimé\n"
	end
end


j1 = inscription("Killian", "Kikidu72", "Killian est genial")

j2 = inscription("Mehdi", "MerguezEnChaleur", "Mehdi est un BG")

voirLesUtilisateurs()

desinscrire(j2)

desinscrire(457)

j3 = inscription("Yann", "YannouilleDu72", "Yayaya")

voirLesUtilisateurs()

