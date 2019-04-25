require 'gtk3'

require './Interface/fDidact.rb'
require './Classes/Page.rb'
require './Interface/fProfil.rb'
require './Interface/fGameMode.rb'
require './Interface/fScore.rb'
require './Interface/fOption.rb'
require './Classes/App.rb'

#====== Fenetre de menu du jeu
class FMenu < Page

  #Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @return void		//ne renvoie rien
     def initialize(monApp, header, anciennePage, unJoueur)

     	super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)
    	@gMenu = Gtk::ButtonBox.new(:vertical)
    	@gMenu2 = Gtk::ButtonBox.new(:horizontal)

    	@option = Gtk::Button.new()
        @option.set_relief(:none)

        @imgO=(Gtk::Image.new(:file =>"./Assets/option.png"))
        @option.set_image(@imgO)
        focus_hadjustment=(:start)
		@gMenu2.add(@option, :expand => true, :fill => false)


    	@profil = Gtk::Button.new()
        @profil.set_relief(:none)

        @imgP=(Gtk::Image.new(:file =>"./Assets/profil.png"))
        @profil.set_image(@imgP)
        focus_hadjustment=(:start)
		@gMenu2.add(@profil, :expand => true, :fill => false)


    		@play = Gtk::Button.new(:label => 'Jouer', :use_underline => nil, :stock_id => nil)
        	@play.set_relief(:none)
    		@didac = Gtk::Button.new(:label => 'Didacticiel', :use_underline => nil, :stock_id => nil)
        	@didac.set_relief(:none)
    		@score = Gtk::Button.new(:label => 'Classement', :use_underline => nil, :stock_id => nil)
        	@score.set_relief(:none)



    		@gMenu.add(@gMenu2)
    		@gMenu.add(@play, :expand => true, :fill => false)
    		@gMenu.add(@didac, :expand => true, :fill => false)
    		@gMenu.add(@score, :expand => true, :fill => false)

        @profil.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FProfil.new(monApp, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }
        @option.signal_connect('clicked') {
             self.supprimeMoi
             suivant = FOption.new(monApp, header, self, unJoueur)
             suivant.ajouteMoi
             @window.show_all
        }
        @play.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FGM.new(monApp, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }
        @didac.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FDidac.new(monApp, header, self, unJoueur)
              suivant.ajouteMoi
              @window.show_all
        }
        @score.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(monApp, header, self, unJoueur, "facile")
              suivant.ajouteMoi
              @window.show_all
        }

        @frame.attach(@gMenu,0,1,0,1)

        @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
