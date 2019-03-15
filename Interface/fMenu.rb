require 'gtk3'
#require './fGameMode.rb'
require './Page.rb'
require './fProfil.rb'
require './fGameMode.rb'


class FMenu < Page

     def initialize(monApp, header, anciennePage)

     	super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
        self.hautPage.spacing = 220

		@gMenu = Gtk::Table.new(5,1, false)

		@ghead = Gtk::Table.new(3,1, false)
			#@titre =  Gtk::Label.new('Tent''s & trees')
			@option = Gtk::Button.new(:label => 'Option', :use_underline => nil, :stock_id => nil)
			@profil = Gtk::Button.new(:label => 'Profil', :use_underline => nil, :stock_id => nil)
			@ghead.attach(@option, 0,1,0,1)
			#@ghead.attach(@titre, 1,2,0,1)
			@ghead.attach(@profil, 2,3,0,1)

		@play = Gtk::Button.new(:label => 'Jouer', :use_underline => nil, :stock_id => nil)
		@didac = Gtk::Button.new(:label => 'Didacticiel', :use_underline => nil, :stock_id => nil)
		@score = Gtk::Button.new(:label => 'Classement', :use_underline => nil, :stock_id => nil)
		

		@gMenu.attach(@ghead, 0,1,0,1)
		@gMenu.attach(@play, 0,1,1,2)
		@gMenu.attach(@didac, 0,1,2,3)
		@gMenu.attach(@score, 0,1,3,4)
	


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

