require_relative 'Grille.rb'

#La classe Aide contient des méthodes qui évaluent l'état de la grille du joueur
class Aide

	#Parcourt la grille du joueur et la grille finale pour repérer les erreurs de placement
	#Renvoie la première case rencontrée si elle n'est pas vide et ne correspond pas à la case finale
	#Renvoie nil si toutes les cases sont correctes
	def Aide.erreur(grille)
		for i in 0..(grille.taille-1)
			for j in 0..(grille.taille-1)
				caseJ = grille.grilleJ[i][j]
				caseF = grille.grilleF[i][j]
				if caseJ.etat != 0 && caseJ.etat != caseF.etat then
					return caseJ
				end
			end
		end
		return nil
	end

	#Parcourt chaque ligne de la grille du joueur et repère les lignes qui doivent être remplies par des herbes
	#Renvoie la première ligne rencontrée qui doit être complétée par des herbes
	#Renvoie nil si aucune des lignes de la grille ne peut être complétée
	def Aide.ligneCompleterHerbes(grille)

		i = 0
		grille.grilleJ.each do |ligne|
			nbTentesMax = grille.nbTentesLigne[i]
			nbTentes = 0
			ligne.each do |c|
				if c.etat == 1 then
					nbTentes += 1
				end
			end
			if nbTentesMax == nbTentes then
				return i
			end
			i += 1
		end
		return nil
	end

	#Parcourt chaque colonne de la grille du joueur et repère les colonnes qui doivent être remplies par des herbes
	#Renvoie la première colonne rencontrée qui doit être complétée par des herbes
	#Renvoie nil si aucune des colonnes de la grille ne peut être complétée
	def Aide.colonneCompleterHerbes(grille)

		for i in 0..(grille.taille-1)
			nbTentesMax = grille.nbTentesColonne[i]
			nbTentes = 0
			for j in 0..(grille.taille-1)
				c = grille.grilleJ[j][i]
				if c.etat == 1 then
					nbTentes += 1
				end
			end
			if nbTentesMax == nbTentes then
				return i
			end
			i += 1
		end
		return nil
	end
end
