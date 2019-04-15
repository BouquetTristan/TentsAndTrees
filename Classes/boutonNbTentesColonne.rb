require 'gtk3'
require './Classes/boutonNbTentes.rb'
	
#====== La classe BoutonGrilleA caractéise la grille de jeu représenter à l'aide de bouton en guise de case sur l'interface

class BoutonNbTentesColonne < BoutonNbTentes

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton


	attr_accessor :bouton
	attr_accessor :clic
	attr_reader :chemin
	attr_reader :indice


	#Initialise le bouton (case)
	# @param chemin		//Le chemin d'accès du dossier contenant les différentes images
	# @return void		//ne renvoie rien
	def initialize(uneGrille, grilleInterface, indice, chemin, unJoueur)
		super(uneGrille, grilleInterface, indice, chemin, unJoueur)
		puts "@indice interne #{@indice}"
	end

	#Change l'image du bouton en fonction de l'état
	# @param etat 		//un chiffre représentant l'état d'une case
	# @return void		//ne renvoie rien
	def chgEtat()
		if @clic
			for i in (0..@grilleDeJeu.taille-1)
				if (@grilleDeJeu.grilleJ[@indice][i].etat != 1 && @grilleDeJeu.grilleJ[@indice][i].etat != 2)
					@boutonGrille[@indice][i].bouton.set_image(Gtk::Image.new(:file =>"#{@chemin}/herbe.png", :size => :dialog))
					focus_hadjustment=(:start)
					@grilleDeJeu.grilleJ[@indice][i].etat = 3
					@grilleDeJeu.enregistrerFichier(@joueur.pseudo, nil)
				end
			end
		end
	end
end
