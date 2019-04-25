require 'gtk3'

#====== La classe BoutonGrilleA caractéise la grille de jeu représenter à l'aide de bouton en guise de case sur l'interface

class BoutonGrille

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
	# @param monApp		//Application
	# @return void		//ne renvoie rien
	def initialize(monApp, chemin)
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
	def chgEtat(monApp, etat)
		if @clic
			if etat == 0
				@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/terre.png",:width=> monApp.width/25, :height=> monApp.height/25))
				@image = (Gtk::Image.new(:pixbuf => @pix))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 1
				@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/tente.png",:width=> monApp.width/25, :height=> monApp.height/25))
				@image=(Gtk::Image.new(:pixbuf => @pix))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 2
				@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/arbre.png",:width=> monApp.width/25, :height=> monApp.height/25))
				@image=(Gtk::Image.new(:pixbuf => @pix))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 3
				@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/herbe.png",:width=> monApp.width/25, :height=> monApp.height/25))
				@image=(Gtk::Image.new(:pixbuf => @pix))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
		end
	end

	#Va checher l'image modifier avec un encadré rouge pour indiquer une erreur 
	# @param etat 		//un chiffre représentant l'état d'une case
	# @return void		//ne renvoie rien
	def indiquerAide(monApp, etat)
		if etat == 0
			@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/terreS.png",:width=> monApp.width/25, :height=> monApp.height/25))
			@image = (Gtk::Image.new(:pixbuf => @pix))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/tenteS.png",:width=> monApp.width/25, :height=> monApp.height/25))
			@image=(Gtk::Image.new(:pixbuf => @pix))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/arbreS.png",:width=> monApp.width/25, :height=> monApp.height/25))
			@image=(Gtk::Image.new(:pixbuf => @pix))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@pix = (GdkPixbuf::Pixbuf.new(:file =>"#{@chemin}/herbeS.png",:width=> monApp.width/25, :height=> monApp.height/25))
			@image=(Gtk::Image.new(:pixbuf => @pix))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end
end
