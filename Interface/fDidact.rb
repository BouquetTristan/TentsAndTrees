require 'gtk3'
#require './fGameMode.rb'
require './Page.rb'
require './fTuto1.rb'
require './fTuto2.rb'
require './fTuto3.rb'
require './fTuto4.rb'
require './fTuto5.rb'


class FDidac < Page


     def initialize(monApp, header, anciennePage)

		super("", monApp, :vertical, header,  anciennePage, unJoueur)
		self.hautPage.spacing = 220

     	super(monApp, :vertical, header,  anciennePage)


        @frame = Gtk::Table.new(1,1,false)
    		@gMain = Gtk::ButtonBox.new(:vertical)

    		@gbouton = Gtk::ButtonBox.new(:horizontal)
    		@gbouton.spacing=20

    		@tuto1 = Gtk::Button.new(:label => '1', :use_underline => nil, :stock_id => nil)
    		@tuto2 = Gtk::Button.new(:label => '2', :use_underline => nil, :stock_id => nil)
    		@tuto3 = Gtk::Button.new(:label => '3', :use_underline => nil, :stock_id => nil)
    	
    		@gbouton.add(@tuto1, :expand => true, :fill => false)
    		@gbouton.add(@tuto2, :expand => true, :fill => false)
    		@gbouton.add(@tuto3, :expand => true, :fill => false)

    		@gbouton2 = Gtk::ButtonBox.new(:horizontal)
    		@gbouton2.spacing = 20
    		@tuto4 = Gtk::Button.new(:label => '4', :use_underline => nil, :stock_id => nil)
    		@tuto5 = Gtk::Button.new(:label => '5', :use_underline => nil, :stock_id => nil)
    	
    		@gbouton2.add(@tuto4, :expand => true, :fill => false)
    		@gbouton2.add(@tuto5, :expand => true, :fill => false)


    		@gMain.add(@gbouton)
    		@gMain.add(@gbouton2)

    	@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(@window, @header, self)
	        menu.ajouteMoi
	        @window.show_all
<<<<<<< HEAD
    	}

      
        @tuto1.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto1.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all          
        }
        @tuto2.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto2.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all  
        }
        @tuto3.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto3.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all  
        }
        @tuto4.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto4.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all  
        }
        @tuto5.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto5.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all  
        }

        @frame.attach(@gMain,0,1,0,1)


        @bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end

