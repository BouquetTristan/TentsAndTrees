require 'gtk3'
require './Interface/fPlayA.rb'
require './Classes/boutonSaison.rb'

class FAventure < Page

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

		@print = BoutonSaison.new("Printemps", unJoueur)
		@ete = BoutonSaison.new("Ete", unJoueur)
		@autom = BoutonSaison.new("Automne", unJoueur)
		@hiver = BoutonSaison.new("Hiver", unJoueur)

		@print.actualiserImg
		@ete.actualiserImg
		@autom.actualiserImg
		@hiver.actualiserImg

		@level.add(@print.bouton, :expand => true, :fill => false)
		@level.add(@ete.bouton, :expand => true, :fill => false)
		@level.add(@autom.bouton, :expand => true, :fill => false)
		@level.add(@hiver.bouton, :expand => true, :fill => false)

		@aventMenu.add(@level)
		@level.spacing=115

		@header.btnMenu.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FMenu.new(monApp, @header, self, unJoueur)
		        menu.ajouteMoi
		        @window.show_all
		    }

		@print.bouton.signal_connect('clicked') {
			@print.debloquer()
			@print.lancer(monApp, @header, self)
		}


		@ete.bouton.signal_connect('clicked') {
			@ete.debloquer()
			@ete.lancer(monApp, @header, self)
		}

		@autom.bouton.signal_connect('clicked') {
			@autom.debloquer()
			@autom.lancer(monApp, @header, self)
		}

		@hiver.bouton.signal_connect('clicked') {
			@hiver.debloquer()
			@hiver.lancer(monApp, @header, self)
		}
		

		@frame.attach(@aventMenu,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
