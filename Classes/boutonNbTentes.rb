require 'gtk3'

#====== La classe BoutonNbTentes représentes les bouton sur le côté de la grille de jeu pour remplire une ligne/colonne d'herbe

class BoutonNbTentes

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton


	attr_accessor :clic
	attr_reader :chemin
	attr_accessor :bouton


	#Initialise le bouton
	# @param uneGrille		//Grille de jeu
	# @param grilleInterface	//affichage de grille de jeu
	# @param indice		//indice ligne/colonne
	# @param chemin		//Le chemin d'accès du dossier contenant les différentes images
	# @param unJoueur		//Le joueur concerné
	# @return void			//ne renvoie rien
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
