require 'gtk3'

require './Interface/fDiff.rb'
require './Interface/fPlay.rb'
require './Classes/Page.rb'
require './Interface/fAventure.rb'


# Fichier: fGameMode.rb
# Auteur: Marchand Killian
# Description:
# => Menu des modes de jeu
# => C'est ici qu'est regroupé les composants du menu des modes de jeu
# => Ici nous gerons ainsi les évenements lié aux boutons, qui permet d'appeler la page suivante ou bien précédente ainsi que la construction la page.

class FGM < Page

	def initialize(monApp, header, anciennePage, unJoueur)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@mComp = false #Booleanqui definie le mode compete

		@frame = Gtk::Table.new(1,1,false)

		@butons = Gtk::ButtonBox.new(:horizontal)
    	@butons.layout = :spread

		@classic = Gtk::Button.new(:label => 'Classique', :use_underline => nil)
		@classic.set_relief(:none)
		@adven = Gtk::Button.new(:label => 'Aventure', :use_underline => nil)
		@adven.set_relief(:none)
		@comp = Gtk::Button.new(:label => 'Compétition', :use_underline => nil)
		@comp.set_relief(:none)

		@butons.add(@classic, :expand => true, :fill => false)
		@butons.add(@adven, :expand => true, :fill => false)
		@butons.add(@comp, :expand => true, :fill => false)

			@header.btnMenu.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FMenu.new(monApp, @header, self, unJoueur)
		        menu.ajouteMoi
		        @window.show_all
		    }

		@classic.signal_connect('clicked') {
			self.supprimeMoi
			suivant = FDiff.new(monApp, header, self, unJoueur, @mComp)
			suivant.ajouteMoi
      		@window.show_all
		}

		@adven.signal_connect('clicked') {
			self.supprimeMoi
			suivant = FAventure.new(monApp, header, self, unJoueur)
			suivant.ajouteMoi
      		@window.show_all
		}

		@comp.signal_connect('clicked') {
			@mComp=true
			self.supprimeMoi
			suivant = FDiff.new(monApp, header, self, unJoueur, @mComp)
			suivant.ajouteMoi
      		@window.show_all
		}
		@frame.attach(@butons,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end

end
