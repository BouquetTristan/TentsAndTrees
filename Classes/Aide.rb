require_relative 'Grille.rb'

#====== La classe Aide contient des méthodes qui évaluent l'état de la grille du joueur
class Aide

	
	#Parcourt la grille du joueur et la grille finale pour repérer les erreurs de placement
	# @param grille		//Prend la grille de jeu en paramètre
	# @return case		//Renvoie la première case rencontrée si elle n'est pas vide et ne correspond pas à la case finale attendu
	# @return nil		//Renvoie nil si toutes les cases sont correctes
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
	# @param grille		//Prend la grille de jeu en paramètre
	# @return ligne		//Renvoie la première ligne rencontrée qui doit être complétée par des herbes
	# @return nil		//Renvoie nil si aucune des lignes de la grille ne peut être complétée
	def Aide.ligneCompleterHerbes(grille)

		i = 0
		grille.parcourirL { |ligne|
			nbTentesMax = grille.nbTentesLigne[i]
			nbTentes = 0
			nbArbres = 0
			nbHerbes = 0
			ligne.each do |c|
				if c.etat == 1 then
					nbTentes += 1
				elsif c.etat == 2 then
					nbArbres += 1
				elsif c.etat == 3 then
					nbHerbes += 1
				end

			end
			if nbTentesMax == nbTentes && nbHerbes < (grille.taille - nbArbres - nbTentesMax) then
				return i
			end
			i += 1
		}
		return nil
	end



	#Parcourt chaque colonne de la grille du joueur et repère les colonnes qui doivent être remplies par des herbes
	# @param grille		//Prend la grille de jeu en paramètre
	# @return colonne		//Renvoie la première colonne rencontrée qui doit être complétée par des herbes des herbes
	# @return nil		//Renvoie nil si aucune des colonnes de la grille ne peut être complétée
	def Aide.colonneCompleterHerbes(grille)

		i = 0
		grille.parcourirC { |ligne|
			nbTentesMax = grille.nbTentesColonne[i]
			nbTentes = 0
			nbArbres = 0
			nbHerbes = 0
			ligne.each do |c|
				if c.etat == 1 then
					nbTentes += 1
				elsif c.etat == 2 then
					nbArbres += 1
				elsif c.etat == 3 then
					nbHerbes += 1
				end

			end
			if nbTentesMax == nbTentes && nbHerbes < (grille.taille - nbArbres -nbTentesMax) then
				return i
			end
			i += 1
		}
		return nil
	end

	

	#Vérifie si les cases autour des tentes sont complétées
	# @param grille		//Prend la grille de jeu en paramètre
	# @return tente		//Retourne la première tente rencontrée avec ses alentours non complétés
	# @return nil		//Retourne nil si tous les alentours de chaque tente ont étés complétés
	def Aide.tenteContourCompleter(grille)
		caseTrouvee = nil
		grille.parcourirH() { |uneCase|
			if uneCase.etat == 1 then
				casesVoisines = uneCase.casesVoisinesComplet(grille)
				casesVoisines.each do |c|
					if c.etat == 0 then
						caseTrouvee = uneCase
						break
						
					end
				end
			end
			
		}
		return caseTrouvee
	end



	#Vérifie pour chaque arbre si il ne reste qu'une possibilité pour placer une tente
	# @param grille		//Prend la grille de jeu en paramètre
	# @return arbre		//Retourne le premier arbre rencontré qui ne possède pas de tente et un seul choix restant pour la place
	# @return nil		//Retourne nil si il n'y a aucun arbre avec un seul choix possible
	def Aide.arbreTentePlacer(grille)
		arbreTrouve = nil
		grille.parcourirH() { |uneCase|
			if uneCase.etat == 2 then
				nbCasesVides = 0
				tentes = false
				casesVoisines = uneCase.casesVoisines(grille)

				casesVoisines.each do |c|
					if c.etat == 0 then
						nbCasesVides +=1
					elsif c.etat == 1 then
						tentes = true
					end
				end

				if !tentes && nbCasesVides == 1 then
					arbreTrouve = uneCase
					break
				end 
			end
		}
		return arbreTrouve
	end



	#Vérifie si un des angles de chaque arbre est obligatoirement de l'herbe
	# @param grille		//Prend la grille de jeu en paramètre
	# @return arbre		//Retourne le premier arbre rencontré avec un angle contenant forcément de l'herbe
	# @return nil		//Retourne nil sinon
	def Aide.arbreAngleHerbe(grille)
		arbreTrouve = nil
		grille.parcourirH() { |uneCase|
			if uneCase.etat == 2 then
				cGE, cDE, cHE, cBE, cGHE, cGBE, cDHE, cDBE = nil #Toutes les variables à nil (l'affectation se fait pour la première, les autres sont automatiquement misent à nil)
				casesVoisines = uneCase.casesVoisinesComplet(grille)

				casesVoisines.each do |c|
	
					if c.i < uneCase.i then
						if c.j < uneCase.j then
							cGHE = c.etat
						elsif c.j == uneCase.j then
							cHE = c.etat
						else
							cDHE = c.etat
						end
					elsif c.i == uneCase.i then
						if c.j < uneCase.j then
							cGE = c.etat
						else
							cDE = c.etat
						end
					else
						if c.j < uneCase.j then
							cGBE = c.etat
						elsif c.j == uneCase.j then
							cBE = c.etat
						else
							cDBE = c.etat
						end
					end					
				end
	
				if ((cGE != 0 || cGE == nil) && (cHE != 0 || cHE == nil) && cDBE == 0) ||  ((cGE != 0 || cGE == nil) && (cBE != 0 || cBE == nil) && cDHE == 0) || ((cDE != 0|| cDE == nil) && (cHE != 0 || cHE == nil) && cGBE == 0) || ((cDE != 0 || cDE == nil) && (cBE != 0 || cBE == nil) && cGHE == 0) then
					arbreTrouve = uneCase
					break
				end
			end
		}
		return arbreTrouve
	end

end
