require 'gtk3'
require './Page.rb'

require '../Classes/Grille.rb'
require '../Classes/Aide.rb'
require './boutonGrille.rb'
require '../Classes/Chrono.rb'
require './boutonAide.rb'
require './boutonAideVerif.rb'
require './boutonAideHerbe.rb'
require './boutonAideTente.rb'

class FPlayA < Page


		

	def initialize(monApp, header, anciennePage, unJoueur, unsSaison, nbGrille)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@chrono = ChronoInverse.new
        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:horizontal)

        case uneSaison
			      when "Printemps" then
			        @saison = 1
			      when "Été" then
			        @saison = 2
			      when "Automne" then
			        @saison = 3
			      when "Hiver" then
			        @saison = 4
			    end

        tabGrille = commencerAventure(@saison, nbGrille)


	   grilleDeJeu = Grille.creer(tabGrille.at(1), tabGrille.at(2))
	   taille = grilleDeJeu.taille()

        @grille = Gtk::Table.new(taille, taille, false)



		@boutonGrille = [[]]

	# Mise en place des indicateurs de la grille de jeu

		for i in (0..taille-1)
			for j in (0..taille-1)
				lId = Gtk::Label.new(grilleDeJeu.nbTentesLigne[j].to_s)
				@grille.attach(lId, j+1,j+2, 0,1)
			end
			lId2 = Gtk::Label.new(grilleDeJeu.nbTentesColonne[i].to_s)
			@grille.attach(lId2,0,1, i+1,i+2)
		end

	# Création de la grille de jeu.
	# Mise en place d'une matrice composant tous les boutons

		for i in (0..taille-1)
			temp=[]
			for j in (0..taille-1)
					vEtat = grilleDeJeu.grilleJ[i][j].etat
					temp[j] = BoutonGrille.new("./image/#{uneSaison}")
					temp[j].mCoord(i,j)
					temp[j].chgEtat(vEtat)
					@grille.attach(temp[j].bouton, i+1, i+2, j+1,j+2)
			end
			@boutonGrille[i] = temp
		end

	# Appel de l'evenement bouton "cliqué", et modification du bouton cliqué

		@boutonGrille.each{|k|
			k.each{|l|
				l.bouton.signal_connect("clicked"){
		        	grilleDeJeu.grilleJ[l.coordI][l.coordJ].jouerCase()
					@boutonGrille[l.coordI][l.coordJ].chgEtat(grilleDeJeu.grilleJ[l.coordI][l.coordJ].etat)
					grilleDeJeu.enregistrerFichier()
					if (grilleDeJeu.observateur())
						#puts("gagné")
						@chrono.cFin
						unJoueur.finirLaPartie(tabGrille.at(0))
						sleep(2)
						self.supprimeMoi
		  	        	menu = FWin.new(@window, @header, self, unJoueur)
		  	        	menu.ajouteMoi
		  	        	@window.show_all
					end

				}
			}
		}

		@gHelp = Gtk::ButtonBox.new(:vertical)
		@lChrono = Gtk::Label.new("")
		@lChrono.set_markup(("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 20\">"+@chrono.to_s+"</span>\n"))
		@gHelp.add(@lChrono)

		thr=Thread.new{
			@chrono.cStart
			@lChrono.set_markup(("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 20\">"+@chrono.to_s+"</span>\n"))
			if (@chrono.fin)
				self.supprimeMoi
  	        	menu = FWin.new(@window, @header, self, unJoueur)
  	        	menu.ajouteMoi
  	        	@window.show_all
  	        end

 		}

		@boxAide = Gtk::ButtonBox.new(:vertical)

		@lableAide = Gtk::Label.new()

		@boxAide.add(@lableAide)

		# @box1 = Gtk::ButtonBox.new(:horizontal)
		@b1 = BoutonAideVerif.new("1", true)
		@b2 = BoutonAideHerbe.new("2", true)

		# @box1.add(@b1.bouton)
		# @box1.add(@b2.bouton)

		# @box2 = Gtk::ButtonBox.new(:horizontal)
		@b3 = BoutonAideTente.new("3", true)
		# @b4 = BoutonAide.new("4", false)

		# @box2.add(@b3.bouton)
		# @box2.add(@b4.bouton)

		# @box3 = Gtk::ButtonBox.new(:horizontal)
		# @b5 = BoutonAide.new("5", false)
		# @b6 = BoutonAide.new("6", false)

		# @box3.add(@b5.bouton)
		# @box3.add(@b6.bouton)

		@boxAide.add(@b1.bouton)
		@boxAide.add(@b2.bouton)
		@boxAide.add(@b3.bouton)

		@b1.bouton.signal_connect('clicked'){
			@b1.aide(grilleDeJeu, @lableAide, unJoueur)
		}

		@b2.bouton.signal_connect('clicked') {
			@b2.aide(grilleDeJeu, @lableAide, unJoueur)
        }

		@b3.bouton.signal_connect('clicked') {
			@b3.aide(grilleDeJeu, @lableAide, unJoueur)
        }

   #      @b4.bouton.signal_connect('clicked') {
			# if(@b4.cliquable == true)
				
			# end	
   #      }
					

		

		#@bAide = Gtk::Button.new()
#		@help=(Gtk::Image.new(:file =>"./image/Aide.png"))
#		@bAide.set_image(@help)
		@gHelp.add(@boxAide)

		@bPause = Gtk::Button.new()
		@pause=(Gtk::Image.new(:file =>"./image/pause.png"))
		@bPause.set_image(@pause)
		@gHelp.add(@bPause)

		@bPause.signal_connect('clicked') {
			@chrono.cPause
        }

		@gHelp.spacing=70

		@box.add(@grille)
		@box.add(@gHelp)

		@frame.attach(@box,0,1,0,1)

		@bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end

end
