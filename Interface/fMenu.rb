require 'gtk3'
#require './fGameMode.rb'
require './Page.rb'
require './fProfil.rb'
require './fGameMode.rb'


class FMenu < Page

     def initialize(monApp, header, anciennePage)

     	super("Tents & Trees", monApp, :vertical, header,  anciennePage)
        self.hautPage.spacing = 220

    		@gMenu = Gtk::ButtonBox.new(:vertical)
        @gMenu.spacing = 30

    		@ghead = Gtk::ButtonBox.new(:horizontal)
        @ghead.spacing = 500
    			@option = Gtk::Button.new(:label => 'Option', :use_underline => nil, :stock_id => nil)
    			@profil = Gtk::Button.new(:label => 'Profil', :use_underline => nil, :stock_id => nil)
    			@ghead.add(@option, :expand => true, :fill => false)
    			@ghead.add(@profil, :expand => true, :fill => false)
        @gMenu.add(@ghead)

    		@play = Gtk::Button.new(:label => 'Jouer', :use_underline => nil, :stock_id => nil)
    		@didac = Gtk::Button.new(:label => 'Didacticiel', :use_underline => nil, :stock_id => nil)
    		@score = Gtk::Button.new(:label => 'Classement', :use_underline => nil, :stock_id => nil)
    		

    		@gMenu.add(@play, :expand => true, :fill => false)
    		@gMenu.add(@didac, :expand => true, :fill => false)
    		@gMenu.add(@score, :expand => true, :fill => false)
    	


    		@option.signal_connect('clicked') {
               #self.supprimeMoi
               #FPlay.construire(fenetre, 8)
               #@window.show_all         
        }
        @profil.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FProfil.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all  
        }
        @play.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FGM.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all          
        }
        @didac.signal_connect('clicked') {
        }
        @score.signal_connect('clicked') {
        }


        self.add(@gMenu)
	end
end

