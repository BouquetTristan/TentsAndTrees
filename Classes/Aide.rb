require_relative 'Grille.rb'

#====== La classe Aide contient des méthodes qui évaluent l'état de la grille du joueur
class Aide


	#Parcourt la grille du joueur et la grille finale pour repérer les erreurs de placement
	# @param grille		//Prend la grille de jeu en paramètre
	# @return case			//Renvoie la première case rencontrée si elle n'est pas vide et ne correspond pas à la case finale attendu
	# @return nil			//Renvoie nil si toutes les cases sont correctes
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
	# @return nil			//Renvoie nil si aucune des colonnes de la grille ne peut être complétée
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
	# @return nil			//Retourne nil si il n'y a aucun arbre avec un seul choix possible
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
	# @return nil			//Retourne nil sinon
	def Aide.arbreAngleHerbe(grille)
		arbreTrouve = nil
		grille.parcourirH() { |uneCase|
			if uneCase.etat == 2 then
				cGE, cDE, cHE, cBE, cGHE, cGBE, cDHE, cDBE = 4,4,4,4,4,4,4,4

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

				if (cGE > 1 && cHE > 1 && cDBE == 0) || (cGE > 1 && cBE > 1 && cDHE == 0) || (cDE > 1 && cHE > 1 && cGBE == 0) || (cDE > 1 && cBE > 1 && cGHE == 0) then
					arbreTrouve = uneCase
					break
				end

			end
		}
		return arbreTrouve
	end




	#Vérifie si il est possible de placer au moins une tente dans la ligne
	# @param grille		//Prend la grille de jeu en paramètre
	# @return numLigne		//Retourne la première ligne où il est possible de placer au moins une tente
	# @return nil			//Retourne nil sinon

	def Aide.lignePlacerTentes(grille)
		nLigne = 0
		grille.parcourirC { |ligne|
			num = Aide.tentesPlacer(grille, ligne, nLigne)
			if num != nil then
				return num
			end
			nLigne += 1
		}
		return nil
	end

	#Vérifie si il est possible de placer au moins une tente dans la ligne
	# @param grille		//Prend la grille de jeu en paramètre
	# @return numLigne		//Retourne la première ligne où il est possible de placer au moins une tente
	# @return nil			//Retourne nil sinon

	def Aide.colonnePlacerTentes(grille)
		nLigne = 0
		grille.parcourirL { |ligne|
			num = Aide.tentesPlacer(grille, ligne, nLigne)
			if num != nil then
				return num
			end
			nLigne += 1
		}
		return nil
	end

	#Vérifie si le nombre de tente placable maximum sur la ligne est égale aux nombres de tentes restantes à placer
	# @param grille	//La grille de jeu
	# @param ligne		//La ligne de la grille sur laquelle on travail
	# @param nLigne	//Le numéro de la ligne sur laquelle on travail
	# @return nLigne	//le numéro de la ligne éligible
	# @return		//nil sinon
	def Aide.tentesPlacer (grille, ligne, nLigne)
		nbTentesRestantes = grille.nbTentesColonne[nLigne]
		compteur = 0
		impair = false
		tentesPlaceMax = 0
		numCase = 0

		ligne.each do |uneCase|



			if uneCase.etat == 0 then
				compteur += 1
			end
			if (uneCase.etat != 0 || (grille.taille-1 == numCase))
				if(grille.taille-1 == numCase)

				end
				tentesPlaceMax += (compteur+1) / 2

				if uneCase.etat == 1 then
					nbTentesRestantes -= 1
				end

				if compteur % 2 == 1 then
					impair = true
				end
				compteur = 0
			end

			numCase += 1

		end
#		print "\nPour la ligne #{nLigne} Le nombre de tentes placables max #{tentesPlaceMax} pour un nb teneRestante de #{nbTentesRestantes}\n"
		if (impair && nbTentesRestantes == tentesPlaceMax) then
			return nLigne
		end
		return nil

	end


	#Vérifie si une case n'est pas adjacente à un arbre
	# @param grille	//La grille de jeu
	# @return uneCase	//La case qui doit être de l'herbe
	# @return	nil // sinon
	def Aide.caseEstDeLHerbe(grille)
		grille.parcourirH { |uneCase|
			if uneCase.etat == 0 then
				arbre = false
				uneCase.casesVoisines(grille).each do |c|
					if c.etat == 2 then
						arbre = true
					end
				end
				if arbre == false then
					return uneCase
				end
			end
		}
		return nil
	end

end
