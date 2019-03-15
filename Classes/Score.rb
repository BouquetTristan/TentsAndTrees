class Score

	#@difficulte	La difficulté de la grille
	#@scoreInitial	Le score initial si la grille est complétée
	#@nbFeuilles	Le nombre de feuilles


	attr_reader :difficulte, :scoreInitial, :nbFeuilles

	#Créé un score
	def Score.creer (diff, nbF)
		new(diff,nbF)
	end

	private_class_method :new


	def initialize (diff, nbF)
		@difficulte = diff
		case diff
		when "Facile" then
			@scoreInitial = 180
		when "Moyenne" then
			@scoreInitial = 360
		when "Difficile" then
			@scoreInitial = 600
		end
		@nbFeuilles = nbF
	end

	#Calcule le score en fonction de la difficulté, du temps restant et du nombre de feuilles restantes
	#Param tempsRestant Le temps restant
	def calculerScore (tempsRestant)
		return @scoreInitial + tempsRestant + @nbFeuilles*10
	end

	#Tri les scores par ordre décroissant
	#Renvoie le tableau des scores trié
	def Score.triScores (tabScores)
		return tabScores.sort.reverse
	end

end

	
