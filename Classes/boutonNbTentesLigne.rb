require 'gtk3'
require './Classes/boutonNbTentes.rb'

#====== La classe BoutonNbTentes représentes les bouton sur le côté gauche de la grille de jeu pour remplire une ligne/colonne d'herbe


class BoutonNbTentesLigne < BoutonNbTentes

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton


	attr_reader :indice
	attr_accessor :bouton
	attr_accessor :clic
	attr_reader :chemin



	#Initialise le bouton de sélection de ligne
	# @param uneGrille		//Grille de jeu
	# @param grilleInterface	//affichage de grille de jeu
	# @param indice		//indice ligne/colonne
	# @param chemin		//Le chemin d'accès du dossier contenant les différentes images
	# @param unJoueur		//Le joueur concerné
	# @param classique		//booléen mode classique ou non
	# @return void			//ne renvoie rien
	def initialize(uneGrille, grilleInterface, indice, chemin, unJoueur, classique)
		super(uneGrille, grilleInterface, indice, chemin, unJoueur, classique)
#		puts "@indice interne #{@indice}"
	end

	#Change l'image du bouton en fonction de l'état
	# @param etat 		//un chiffre représentant l'état d'une case
	# @return void		//ne renvoie rien
	def chgEtat(monApp, etatC, chrono)
		if !etatC
			for i in (0..@grilleDeJeu.taille-1)
				if (@grilleDeJeu.grilleJ[i][@indice].etat != 1 && @grilleDeJeu.grilleJ[i][@indice].etat != 2)
					@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/herbe.png",:width=> monApp.width/25, :height=> monApp.height/25))
					@boutonGrille[i][@indice].bouton.set_image(Gtk::Image.new(:pixbuf => @pix))
					focus_hadjustment=(:start)
					@grilleDeJeu.grilleJ[i][@indice].etat = 3
					if(@classique == true)
						@grilleDeJeu.enregistrerFichier(@joueur.pseudo, chrono)
					end
				end
			end
		end
	end
end
