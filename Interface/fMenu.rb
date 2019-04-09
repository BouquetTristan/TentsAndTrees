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
    		@gMenu = Gtk::Table.new(1,2,false)
        #@gMenu.spacing = 10

    		@ghead = Gtk::Table.new(1,2,false)
        
    			@option = Gtk::Button.new()
          @option.set_relief(:none)
    			@profil = Gtk::Button.new()
          @profil.set_relief(:none)

          @imgP=(Gtk::Image.new(:file =>"./Assets/profil.png"))
          @profil.set_image(@imgP)
          focus_hadjustment=(:start)

          @imgO=(Gtk::Image.new(:file =>"./Assets/option.png"))
          @option.set_image(@imgO)
          focus_hadjustment=(:start)

    			@ghead.attach(@option, 0,1,0,1)
    			@ghead.attach(@profil, 1,2,0,1)
        @gMenu.attach(@ghead, 0,1,0,1)

        @tMenu = Gtk::Table.new(1,3,false)

    		@play = Gtk::Button.new(:label => 'Jouer', :use_underline => nil, :stock_id => nil)
        @play.set_relief(:none)
    		@didac = Gtk::Button.new(:label => 'Didacticiel', :use_underline => nil, :stock_id => nil)
        @didac.set_relief(:none)
    		@score = Gtk::Button.new(:label => 'Classement', :use_underline => nil, :stock_id => nil)
        @score.set_relief(:none)

    		@tMenu.attach(@play, 0,1,0,1)
    		@tMenu.attach(@didac, 0,1,1,2)
    		@tMenu.attach(@score, 0,1,2,3)

        @gMenu.attach(@tMenu, 0,1,1,2)


        @option.signal_connect('clicked') {
               #self.supprimeMoi
               #FPlay.construire(fenetre, 8)
               #@window.show_all
        }
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
              suivant = FScore.new(@window, header, self, unJoueur)
              suivant.ajouteMoi
              @window.show_all 
        }

        @frame.attach(@gMenu,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"./Assets/ImgGame.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
