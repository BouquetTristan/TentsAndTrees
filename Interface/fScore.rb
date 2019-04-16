require 'gtk3'

require './Classes/Page.rb'
require './BaseDeDonnees/FonctionsBDD.rb'


class FScore < Page

     def initialize(monApp, header, anciennePage, unJoueur, tabScore)

     	@tabFacile = Array.new()
     	@tabMoyen = Array.new()
     	@tabDiff = Array.new()

     	super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:vertical)
        @boxBut = Gtk::ButtonBox.new(:horizontal)

        	@btnFac = Gtk::Button.new(:label => 'Facile', :use_underline => nil)
        	@btnMoy = Gtk::Button.new(:label => 'Moyen', :use_underline => nil)
        	@btnDif = Gtk::Button.new(:label => 'Difficile', :use_underline => nil)

        @boxBut.add(@btnFac)
        @boxBut.add(@btnMoy)
        @boxBut.add(@btnDif)
    		
        @tScore = Gtk::Table.new(4,1,false)
        @tScore.row_spacing=20

        actualiserTab(unJoueur)


        case tabScore
        when "facile"
        	tabScore = @tabFacile
        when "moyen"
        	tabScore = @tabMoyen
        when "diff"
        	tabScore = @tabDiff
        end

        for i in (1..unJoueur.recupererScoreJoueurs().length)        
			label = Gtk::Label.new('')
			label.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\"> N° #{i} | Score: #{tabScore[i-1]} | Pseudo: #{unJoueur.recupererScoreJoueurs()[i-1][0]}</span>") 
			@tScore.attach(label,0,1,i-1,i)
		end

        @back = Gtk::Button.new(:label => 'Retour', :use_underline => nil)
        @back.set_relief(:none)

        @btnFac.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(@window, header, self, unJoueur, "facile")
              suivant.ajouteMoi
              @window.show_all 
        }
        
        @btnMoy.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(@window, header, self, unJoueur, "moyen")
              suivant.ajouteMoi
              @window.show_all 
        }

        @btnDif.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(@window, header, self, unJoueur, "diff")
              suivant.ajouteMoi
              @window.show_all 
        }

       @back.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all          
        }

        @box.add(@boxBut)
        @box.add(@tScore)
        @box.add(@back)

        @frame.attach(@box,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"./Assets/ImgGame.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end

    def actualiserTab(unJoueur)
    	for i in (1..unJoueur.recupererScoreJoueurs().length)
    		@tabFacile.push(unJoueur.recupererScoreJoueurs()[i-1][2]).sort
    		@tabMoyen.push(unJoueur.recupererScoreJoueurs()[i-1][3]).sort
    		@tabDiff.push(unJoueur.recupererScoreJoueurs()[i-1][4]).sort
    	end
    end

end
