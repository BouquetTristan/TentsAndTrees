require 'gtk3'
#require '../Interface/fDiff.rb'
#require '../Interface/fMenu.rb'
#require '../Interface/fPlay.rb'
require './TexteAfficher.rb'
require './Page.rb'



class FProfil < Page

	def initialize(monApp, header, anciennePage)

		super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220


		@gProfil = Gtk::Table.new(3,4, false)

		@pseudo = TexteAfficher.creer('Pseudo : ').gTexteAfficher
		@score = TexteAfficher.creer('Score').gTexteAfficher
		@modif =Gtk::Button.new(:label => 'Modifier mes inforamtions', :use_underline => nil, :stock_id => nil)
        @deco = Gtk::Button.new(:label => 'Deconnexion', :use_underline => nil, :stock_id => nil)

		@gProfil.attach(@pseudo, 1,2,1,2)
        @gProfil.attach(@score, 1,2,2,3)
		@gProfil.attach(@modif, 0,1,3,4)
        @gProfil.attach(@back, 1,2,3,4)
        @gProfil.attach(@deco, 2,3,3,4)


		@modif.signal_connect('clicked') {
			self.supprimeMoi
            suivant = FModifC.new(@window, header, self)
            suivant.ajouteMoi
            @window.show_all  		
		}
		@deco.signal_connect('clicked') {
		}


		self.add(@gProfil)

	end
end

