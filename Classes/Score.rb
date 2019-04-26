#====== La Classe Score définie les critères de calcul du score en fonction de la grille etc

class Score

	#=Variables d'instance
	# @difficulte		: La difficulté de la grille
	# @scoreInitial		: Le score initial si la grille est complétée
	# @nbFeuilles		: Le nombre de feuilles (qui déterminera le nombre d'aide disponsible)


	attr_reader :scoreInitial
	attr_reader :nbFeuilles
	attr_reader :difficulte


	#Création d'un score
	# @param diff		//difficulté de la grille
	# @param nbF		//nombre de feuille pour la grille
	# @return void		//ne renvoie rien
	def Score.creer (diff, nbF)
		new(diff,nbF)
	end

	private_class_method :new

	#Initialisation
	# @param diff		//difficulté de la grille
	# @param nbF		//nombre de feuille pour la grille
	# @return void		//ne renvoie rien
	def initialize (diff, nbF)
		@difficulte = diff
		case diff
		when "Facile" then
			@scoreInitial = 180
		when "Moyenne" then
			@scoreInitial = 360
		when "Difficile" then
			@scoreInitial = 720
		end
		@nbFeuilles = nbF
	end



	#Calcule le score en fonction de la difficulté, du temps restant et du nombre de feuilles restantes
	# @param tempsRestant		//Le temps restant à la fin de la partie
	# @return score			//Le score calculé
	def calculerScore (tempsRestant)
		return @scoreInitial + tempsRestant.to_i + @nbFeuilles*10
	end


	#Renvoie le tableau des scores trié

	#Tri les scores par ordre décroissant
	# @param tabScores		//tableau comportant les scores
	# @return tab		//un tableau de score trié
	def Score.triScores (tabScores)
		return tabScores.sort.reverse
	end

end
