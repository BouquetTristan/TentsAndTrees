require 'gtk3'

class BoutonGrille


	#=Variable d'instance
	# @bouton		: Le bouton
	# @coordI, @coordJ	: Coordonnée du bouton

	attr_reader :coordJ
	attr_reader :coordI
	attr_reader :bouton
	attr_reader :clic
	attr_writer :bouton
	attr_writer :clic


	#Initialise le bouton (case)
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
	def initialize()
		@bouton = Gtk::Button.new
		@bouton.set_relief(:none)
		@clic = true
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

	#Change l'état du bouton (case) pour adopter l'image correspondante
	# @param etat		//Etat du bouton (case)
	# @return void		//ne renvoie rien
	def chgEtat(etat)

		if(@clic)
			if etat == 0
				@image=(Gtk::Image.new(:file =>"./Assets/Printemps/terre.png", :size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 1
				@image=(Gtk::Image.new(:file =>"./Assets/Printemps/tente.png", :size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 2
				@image=(Gtk::Image.new(:file =>"./Assets/Printemps/arbre.png",:size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 3
				@image=(Gtk::Image.new(:file =>"./Assets/Printemps/herbe.png",:size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
		end
	end

	def indiquerAide(etat)
		if etat == 0
			@image=(Gtk::Image.new(:file =>"./Assets/Printemps/terreS.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@image=(Gtk::Image.new(:file =>"./Assets/Printemps/tenteS.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@image=(Gtk::Image.new(:file =>"./Assets/Printemps/arbreS.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@image=(Gtk::Image.new(:file =>"./Assets/Printemps/herbeS.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end



end
