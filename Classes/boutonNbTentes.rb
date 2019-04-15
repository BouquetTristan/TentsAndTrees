require 'gtk3'

#====== La classe BoutonGrilleA caractéise la grille de jeu représenter à l'aide de bouton en guise de case sur l'interface

class BoutonNbTentes

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton


	attr_accessor :bouton
	attr_accessor :clic
	attr_reader :chemin


	#Initialise le bouton (case)
	# @param chemin		//Le chemin d'accès du dossier contenant les différentes images
	# @return void		//ne renvoie rien
	def initialize(uneGrille, grilleInterface, indice, chemin, unJoueur)
		@bouton = Gtk::Button.new
		# @bouton.set_relief(:none)
		@grilleDeJeu = uneGrille
		@boutonGrille = grilleInterface
		@indice = indice
		@clic = true
		@chemin = chemin
		@joueur = unJoueur
	end

end
