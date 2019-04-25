
require 'gtk3'
require './Interface/fSaison.rb'

#====== La classe BoutonSaison représente les boutons de l'interface sur la section aventure

class BoutonSaison

	#=Variable d'instance
	# @bouton			: Le bouton
	# @coordI, @coordJ		: Coordonée du bouton
	# @img				: mémorise l'image associé au bouon
	# @numSaison			: enregistre le numéro relatif à la saison
	# @@prix 			: prix de l'aide en feuille

	attr_accessor :cliquable
	attr_accessor :bouton
	attr_reader :bonusVisible


	#Initialise le bouton représentant l'accès aux saisons
	# @param monApp		//Prend l'application
	# @param uneSaison		//Chaine de caracère représentant une des 4 saison (été/hiver/automne/pintemps)
	# @param cliquable		//Booléen pou définir si le bouton sera cliquable ou non
	# @return void			//ne renvoie rien
	def initialize(monApp, uneSaison, unJoueur)
		@bouton = Gtk::Button.new()
        focus_hadjustment=(:start)

		@saison = uneSaison
		@joueur = unJoueur

		case @saison
			when "Printemps" then
				@numSaison = 0
				@joueur.acheterNiveau(@numSaison)
				@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Vignette#{@saison}V.png",:width=> monApp.width/5, :height=> monApp.height/5))
        		@img=(Gtk::Image.new(:pixbuf => @pix))
        		@bouton.set_image(@img)
			when "Ete" then
				@numSaison = 1
				@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Vignette#{@saison}V.png",:width=> monApp.width/5, :height=> monApp.height/5))
        		@img=(Gtk::Image.new(:pixbuf => @pix))
        		@bouton.set_image(@img)
			when "Automne" then
				@numSaison = 2
				@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Vignette#{@saison}V.png",:width=> monApp.width/5, :height=> monApp.height/5))
        		@img=(Gtk::Image.new(:pixbuf => @pix))
        		@bouton.set_image(@img)
			when "Hiver" then
				@numSaison = 3
				@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Vignette#{@saison}V.png",:width=> monApp.width/5, :height=> monApp.height/5))
        		@img=(Gtk::Image.new(:pixbuf => @pix))
        		@bouton.set_image(@img)
			when "Bonus"
				@numSaison = 4
   		end
   		

        @cliquable = @joueur.niveauDeverouille(@numSaison)
        @bonusVisible = self.debloquerBonus()
#   		puts @saison
	end

	#Actualise l'image de la case
	# @param monApp		//Prend l'application
	# @return void			//ne renvoie rien
	def actualiserImg(monApp)
		if (@cliquable)
			@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Vignette#{@saison}.png",:width=> monApp.width/5, :height=> monApp.height/5))
        	@img=(Gtk::Image.new(:pixbuf => @pix))
	        @bouton.set_image(@img)
	    end
	end

	def debloquerBonus()
		#puts @joueur.niveaux.at(4)
		res = true
		if (@joueur.niveauDeverouille(4) == false)
			res = (@joueur.niveauDeverouille(0) && @joueur.niveauDeverouille(1) && @joueur.niveauDeverouille(2) && @joueur.niveauDeverouille(3) && @joueur.acheterNiveau(4))
		end
#		puts "LE resultat #{res} et le niveau bonus #{@joueur.niveauDeverouille(4)}"
		return res
	end



	#Débloque un bouton en le rendant cliquable pour un joueur donné
	# @param monApp		//Prend l'application
	# @return void			//ne renvoie rien
	def debloquer(monApp)
#		puts @saison
#		puts @joueur.niveauDeverouille(@numSaison)
#		puts "cliquable : #{@cliquable}"
		@cliquable = @joueur.acheterNiveau(@numSaison)
		if (@cliquable)
			@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Vignette#{@saison}.png",:width=> monApp.width/5, :height=> monApp.height/5))
        	@img=(Gtk::Image.new(:pixbuf => @pix))
        	@bouton.set_image(@img)
		end      
	end

	#Lance le mode aventure de la saison concerné
	# @param uneApp		//La fenêtre
	# @param unHeader		//La bande en haut (titre de page)
	# @param unePrecedente		//La fenêtre précédente pour destruction
	# @param unJoueur		//Le joueur concerné
	# @return void			//ne renvoie rien
	def lancer(uneApp, unHeader, unePrecedente)
		if (@cliquable == true)
			unePrecedente.supprimeMoi
			suivante = FSaison.new(uneApp, unHeader, unePrecedente, @joueur, @saison)
			suivante.ajouteMoi
			uneApp.window.show_all
		end
   	end



end
