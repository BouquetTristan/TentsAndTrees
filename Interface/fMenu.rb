require 'gtk3'

require './Interface/fDidact.rb'
require './Classes/Page.rb'
require './Interface/fProfil.rb'
require './Interface/fGameMode.rb'
require './Interface/fScore.rb'


class FMenu < Page

     def initialize(monApp, header, anciennePage, unJoueur)

     	super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)
    		@gMenu = Gtk::Table.new(1,4,false)
        
    		@profil = Gtk::Button.new()
        @profil.set_relief(:none)

        @imgP=(Gtk::Image.new(:file =>"./Assets/profil.png"))
        @profil.set_image(@imgP)
        focus_hadjustment=(:start)

        @gMenu.attach(@profil, 0,1,0,1)

    		@play = Gtk::Button.new(:label => 'Jouer', :use_underline => nil, :stock_id => nil)
        @play.set_relief(:none)
    		@didac = Gtk::Button.new(:label => 'Didacticiel', :use_underline => nil, :stock_id => nil)
        @didac.set_relief(:none)
    		@score = Gtk::Button.new(:label => 'Classement', :use_underline => nil, :stock_id => nil)
        @score.set_relief(:none)

    		@gMenu.attach(@play, 0,1,1,2)
    		@gMenu.attach(@didac, 0,1,2,3)
    		@gMenu.attach(@score, 0,1,3,4)

        @profil.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FProfil.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }
        @play.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FGM.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }
        @didac.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FDidac.new(@window, header, self, unJoueur)
              suivant.ajouteMoi
              @window.show_all  
        }
        @score.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(@window, header, self, unJoueur, "facile")
              suivant.ajouteMoi
              @window.show_all 
        }

        @frame.attach(@gMenu,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"./Assets/ImgGame.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
