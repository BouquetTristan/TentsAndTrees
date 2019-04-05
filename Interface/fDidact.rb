require 'gtk3'


require './Page.rb'
require './fTuto1.rb'
require './fTuto2.rb'
require './fTuto3.rb'
require './fTuto4.rb'
require './fTuto5.rb'


class FDidac < Page


     def initialize(monApp, header, anciennePage, unJoueur)

		  super(monApp, :vertical, header,  anciennePage, unJoueur)
	

        @frame = Gtk::Table.new(1,1,false)
    		@gMain = Gtk::ButtonBox.new(:vertical)
        @gMain.spacing = 10

    		@gbouton = Gtk::ButtonBox.new(:horizontal)
    		@gbouton.spacing=20

    		@tuto1 = Gtk::Button.new()
    		@tuto2 = Gtk::Button.new()
    		@tuto3 = Gtk::Button.new()

        @t1=(Gtk::Image.new(:file =>"./image/Didacticiel/t1.png"))
        @tuto1.set_image(@t1)
        @t2=(Gtk::Image.new(:file =>"./image/Didacticiel/t2.png"))
        @tuto2.set_image(@t2)
        @t3=(Gtk::Image.new(:file =>"./image/Didacticiel/t3.png"))
        @tuto3.set_image(@t3)
    	
    		@gbouton.add(@tuto1, :expand => true, :fill => false)
    		@gbouton.add(@tuto2, :expand => true, :fill => false)
    		@gbouton.add(@tuto3, :expand => true, :fill => false)

    		@gbouton2 = Gtk::ButtonBox.new(:horizontal)
    		@gbouton2.spacing = 20
    		@tuto4 = Gtk::Button.new()
    		@tuto5 = Gtk::Button.new()
        
        @t4=(Gtk::Image.new(:file =>"./image/Didacticiel/t4.png"))
        @tuto4.set_image(@t4)
        @t5=(Gtk::Image.new(:file =>"./image/Didacticiel/t5.png"))
        @tuto5.set_image(@t5)
    	
    		@gbouton2.add(@tuto4, :expand => true, :fill => false)
    		@gbouton2.add(@tuto5, :expand => true, :fill => false)


    		@gMain.add(@gbouton)
    		@gMain.add(@gbouton2)

    	@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(@window, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
    	}

      
        @tuto1.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto1.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all          
        }
        @tuto2.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto2.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all  
        }
        @tuto3.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto3.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all  
        }
        @tuto4.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto4.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all  
        }
        @tuto5.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto5.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all  
        }

        @frame.attach(@gMain,0,1,0,1)


        @bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end

