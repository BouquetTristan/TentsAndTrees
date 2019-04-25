require 'gtk3'
require './Interface/fPlayA.rb'
require './Classes/boutonSaison.rb'

#====== Fenetre aventure du jeu

class FAventure < Page


	#Initialise la page aventure
	# @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
	# @return void			//ne renvoie rien
	def initialize(monApp, header, anciennePage, unJoueur)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)

		@aventMenu = Gtk::ButtonBox.new(:vertical)
    	@aventMenu.layout = :spread

    	@ghead = Gtk::ButtonBox.new(:horizontal)
        @ghead.spacing = 700
    			@option = Gtk::Label.new('')

    			@boxArgent=Gtk::ButtonBox.new(:horizontal)
    				@boxArgent.spacing=1
    				@img =(Gtk::Image.new(:file =>"./Assets/billet.png"))
    				@profil = Gtk::Label.new().set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 15\"> #{unJoueur.argent}</span>")
    				@boxArgent.add(@img)
    				@boxArgent.add(@profil, :expand => true, :fill => false)

    			@ghead.add(@option, :expand => true, :fill => false)
    			@ghead.add(@boxArgent)

        @aventMenu.add(@ghead)

    	@level = Gtk::ButtonBox.new(:horizontal)
    	@level.layout = :spread

		@print = BoutonSaison.new(monApp, "Printemps", unJoueur)
		@ete = BoutonSaison.new(monApp, "Ete", unJoueur)
		@autom = BoutonSaison.new(monApp, "Automne", unJoueur)
		@hiver = BoutonSaison.new(monApp, "Hiver", unJoueur)
		@bonus = BoutonSaison.new(monApp, "Bonus",unJoueur)

		@print.actualiserImg(monApp)
		@ete.actualiserImg(monApp)
		@autom.actualiserImg(monApp)
		@hiver.actualiserImg(monApp)

		@level.add(@print.bouton, :expand => true, :fill => false)
		@level.add(@ete.bouton, :expand => true, :fill => false)
		@level.add(@autom.bouton, :expand => true, :fill => false)
		@level.add(@hiver.bouton, :expand => true, :fill => false)

		@aventMenu.add(@level)
		@level.spacing=monApp.width/15

		if (@bonus.bonusVisible)
			@aventMenu.add(@bonus.bouton, :expand => true, :fill => false)
		end

		@header.btnMenu.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FMenu.new(monApp, @header, self, unJoueur)
		        menu.ajouteMoi
		        @window.show_all
		    }

		@print.bouton.signal_connect('clicked') {
			if (@print.cliquable == false)
				@print.debloquer(monApp)
			end
#			puts unJoueur.niveaux.at(4).at(0)
			@print.lancer(monApp, @header, self)
		}


		@ete.bouton.signal_connect('clicked') {
			if (@ete.cliquable == false)
				@ete.debloquer(monApp)
			end
			@ete.lancer(monApp, @header, self)
		}

		@autom.bouton.signal_connect('clicked') {
			if (@autom.cliquable == false)
				@autom.debloquer(monApp)
			end
			@autom.lancer(monApp, @header, self)
		}

		@hiver.bouton.signal_connect('clicked') {
			if (@hiver.cliquable == false)
				@hiver.debloquer(monApp)
			end
			@hiver.lancer(monApp, @header, self)
		}

		@bonus.bouton.signal_connect('clicked') {
			@bonus.lancer(monApp, @header, self)
		}

		@frame.attach(@aventMenu,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGameA.png",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
