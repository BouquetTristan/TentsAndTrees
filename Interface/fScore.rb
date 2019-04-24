require 'gtk3'

require './Classes/Page.rb'
require './Classes/JoueurClass.rb'
require './BaseDeDonnees/FonctionsBDD.rb'

#====== Fenetre score du jeu
class FScore < Page


  #Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @param tabScore   //tableau des scores
  # @return void		//ne renvoie rien
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
        	tabScore = @tabFacile.sort do |score_a, score_b|
    			score_a.score <=> score_b.score
			end.reverse
        when "moyen"
        	tabScore = @tabMoyen.sort do |score_a, score_b|
    			score_a.score <=> score_b.score
			end.reverse
        when "diff"
        	tabScore = @tabDiff.sort do |score_a, score_b|
    			score_a.score <=> score_b.score
			end.reverse
        end

      if tabScore.length > 5
        taille = 4
      else
        taille = tabScore.length
      end

      for i in (1..taille)      
			 label = Gtk::Label.new('')
			 label.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\"> N° #{i} | Score: #{tabScore[i-1].score} | Pseudo: #{tabScore[i-1].nomJoueur}</span>") 
			 @tScore.attach(label,0,1,i-1,i)
		  end

        @back = Gtk::Button.new(:label => 'Retour', :use_underline => nil)
        @back.set_relief(:none)

        @btnFac.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(monApp, header, self, unJoueur, "facile")
              suivant.ajouteMoi
              @window.show_all
        }

        @btnMoy.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(monApp, header, self, unJoueur, "moyen")
              suivant.ajouteMoi
              @window.show_all
        }

        @btnDif.signal_connect('clicked') {
              self.supprimeMoi
              suivant = FScore.new(monApp, header, self, unJoueur, "diff")
              suivant.ajouteMoi
              @window.show_all
        }

       @back.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(monApp, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }

        @box.add(@boxBut)
        @box.add(@tScore)
        @box.add(@back)

        @frame.attach(@box,0,1,0,1)

        @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end

    def actualiserTab(unJoueur)
    	for i in (1..unJoueur.recupererScoreJoueurs().length)
    		@tabFacile= @tabFacile.push(JoueurClass.new(unJoueur.recupererScoreJoueurs()[i-1][2], unJoueur.recupererScoreJoueurs()[i-1][0]))
        	@tabMoyen= @tabMoyen.push(JoueurClass.new(unJoueur.recupererScoreJoueurs()[i-1][3], unJoueur.recupererScoreJoueurs()[i-1][0]))
    		@tabDiff= @tabDiff.push(JoueurClass.new(unJoueur.recupererScoreJoueurs()[i-1][4], unJoueur.recupererScoreJoueurs()[i-1][0]))
    	end
    end

end
