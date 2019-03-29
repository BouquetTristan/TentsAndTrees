require 'gtk3'
#require './fGameMode.rb'
require './TexteEntree'
require './Page.rb'
require './fMenu.rb'

class FMdpOublie < Page

     def initialize(monApp, header, anciennePage)

        super(monApp, :vertical, header,  anciennePage)

        @frame = Gtk::Table.new(1,1,false)

    	@gMdpOublie = Gtk::ButtonBox.new(:vertical)
        @gMdpOublie.spacing = 30

    	@pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
        @newMdp = TexteEntree.creer('Nouveau mot de passe : ', false).gTexteEntree
        @question =  Gtk::Label.new('Quel est votre lieux de vacance préféré?')
        @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree
        @connexion = Gtk::Button.new(:label => 'Connexion', :use_underline => nil, :stock_id => nil)

    		@gMdpOublie.add(@pseudo, :expand => true, :fill => false)
    		@gMdpOublie.add(@newMdp, :expand => true, :fill => false)
    		@gMdpOublie.add(@question, :expand => true, :fill => false)
    		@gMdpOublie.add(@reponse, :expand => true, :fill => false)
    		@gMdpOublie.add(@connexion, :expand => true, :fill => false)

    	@connexion.signal_connect('clicked') {
            self.supprimeMoi
            suivant = FMenu.new(@window, header, self)
            suivant.ajouteMoi
            @window.show_all          
        }

        @frame.attach(@gMdpOublie,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)

	end

end

