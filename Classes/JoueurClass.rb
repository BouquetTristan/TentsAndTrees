
#====== La classe JoueurClass permet de créer un objet pour le tableau des scores

class JoueurClass

	#=Variable d'instance
	# @score		: Le score
	# @nomJoueur	: nom du joueur

	attr_accessor :score, :nomJoueur

	#Initialize le bouton
	# @param score    //Le score du joueur
	# @param pseudo   //Le pseudo du joueur
	# @return void  	//ne renvoie rien

	def initialize(score, pseudo)
		@score, @nomJoueur = score, pseudo
	end



end
