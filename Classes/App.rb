#====== La classe App représente l'application soit la fentre du jeu avec ses dimenssions

	
class App

	#=Variable d'instance
	# @window				: La fenetre
	# @width, height		: resolution de la fenetre

	attr_accessor :window, :width, :height

	#Initialise l'application
	# @param window		//fentre de l'application
	# @param width, height		//Integer des dimenssions
	# @return void			//ne renvoie rien
	def initialize(window, width, height)
		@window, @width, @height = window, width, height
	end
end