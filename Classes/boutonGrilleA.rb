require 'gtk3'

#====== La classe BoutonGrilleA caractéise la grille de jeu représenter à l'aide de bouton en guise de case sur l'interface

class BoutonGrilleA

	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton

	attr_reader :coordJ
	attr_reader :coordI
	attr_reader :bouton
	attr_reader :clic
	attr_reader :chemin
	attr_writer :bouton
	attr_writer :clic


	#Initialise le bouton (case)
	# @param chemin		//Le chemin d'accès du dossier contenant les différentes images
	# @return void		//ne renvoie rien
	def initialize(chemin)
		@bouton = Gtk::Button.new
		@bouton.set_relief(:none)
		@clic = true
		@chemin = chemin
	end

	#Détermine les coordonnées du bouton  (case)
	# @param i		//coordonée abscisse
	# @param j		//coordonnée ordonnée
	# @return void		//ne renvoie rien
	def mCoord(i,j)
		@coordI = i
		@coordJ = j
	end

	#Attribut une valeur au bouton (label)
	# @param valeur		//une valeur à afficher
	# @return void		//ne renvoie rien
	def mBouton(valeur)
		@box.set_label(valeur.to_s)
	end

	#Change l'image du bouton en fonction de l'état
	# @param etat 		//un chiffre représentant l'état d'une case
	# @return void		//ne renvoie rien
	def chgEtat(etat)
		if etat == 0
			@image=(Gtk::Image.new(:file =>"#{@chemin}/terre.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@image=(Gtk::Image.new(:file =>"#{@chemin}/tente.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@image=(Gtk::Image.new(:file =>"#{@chemin}/arbre.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@image=(Gtk::Image.new(:file =>"#{@chemin}/herbe.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end

	#Va checher l'image modifier avec un encadré rouge pour indiquer une erreur 
	# @param etat 		//un chiffre représentant l'état d'une case
	# @return void		//ne renvoie rien
	def indiquerAide(etat)
		if etat == 0
			@image=(Gtk::Image.new(:file =>"#{@chemin}/terreS.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@image=(Gtk::Image.new(:file =>"#{@chemin}/tenteS.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@image=(Gtk::Image.new(:file =>"#{@chemin}/arbreS.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@image=(Gtk::Image.new(:file =>"#{@chemin}/herbeS.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end




end
