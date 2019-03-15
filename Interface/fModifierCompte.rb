require 'gtk3'
#require './fGameMode.rb'
require './TexteEntree'
require './Page.rb'

class FModifC < Page

	def initialize(monApp, header, anciennePage)

		super("Mode de Jeu", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220


		@gMdpOublie = Gtk::Table.new(7,1, false)


		@pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
          @newMdp = TexteEntree.creer('Mot de passe : ', false).gTexteEntree
          @question =  Gtk::Label.new('Quel est votrelieux de vacance préféré?')
          @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree
          @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)


		@gMdpOublie.attach(@pseudo, 0,1,1,2)
		@gMdpOublie.attach(@newMdp, 0,1,2,3)
        @gMdpOublie.attach(@question, 0,1,3,4)
		@gMdpOublie.attach(@reponse, 0,1,4,5)
		@gMdpOublie.attach(@connexion, 0,1,5,6)



		@connexion.signal_connect('clicked') {
			self.supprimeMoi
			FPlay.construire(fenetre, 8)
			@window.show_all		
		}


		self.add(@gMdpOublie)

	end

end

