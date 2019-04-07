require 'gtk3'
require './Page.rb'

require '../Classes/Grille.rb'
require '../Classes/Aide.rb'
require './boutonGrilleA.rb'
require '../Classes/Chrono.rb'
require '../Classes/ChronoInverse.rb'
require './boutonAide.rb'
require './boutonAideVerif.rb'
require './boutonAideHerbe.rb'
require './boutonAideTente.rb'
require './fWin.rb'
require '../Classes/Score.rb'

class FPlayA < Page


		

	def initialize(monApp, header, anciennePage, unJoueur, uneSaison, nbGrille)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@nbAidesUtilises = 0

        case uneSaison
			when "Printemps" then
				@saison = 1
			when "Ete" then
				@saison = 1
			when "Automne" then
				@saison = 2
			when "Hiver" then
				@saison = 3
   		end

   		puts @saison

        tabGrille = unJoueur.commencerAventure(@saison, nbGrille)
        puts tabGrille.at(0)
        puts tabGrille.at(1)
        puts tabGrille.at(2)



        case tabGrille.at(2)
        	when "GrillesFaciles" then
        		@temps = 20
        	when "GrillesMoyens" then
        		@temps = 10
        	when "GrillesDificiles" then
        		@temps = 5
        end

    	@gHelp = Gtk::ButtonBox.new(:vertical)
		@chrono = ChronoInverse.new(@temps)
		@gHelp.add(@chrono.lChrono) 

		thr=Thread.new do
			sleep(2)
			@chrono.cStart
			if (@chrono.fin)
				self.supprimeMoi
  	        	menu = FWin.new(@window, @header, self, unJoueur)
  	        	menu.ajouteMoi
  	        	@window.show_all
  	        end
		
 		end

				
		
        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:horizontal)

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
					temp[j] = BoutonGrilleA.new("./image/#{uneSaison}")
					temp[j].mCoord(i,j)
					temp[j].chgEtat(vEtat)
					@grille.attach(temp[j].bouton, i+1, i+2, j+1,j+2)
			end
			@boutonGrille[i] = temp
		end

	# Appel de l'evenement bouton "cliqué", et modification du bouton cliqué
		if(!@chrono.pause)
			@boutonGrille.each{|k|
				k.each{|l|
					l.bouton.signal_connect("clicked"){
			        	grilleDeJeu.grilleJ[l.coordI][l.coordJ].jouerCase()
						@boutonGrille[l.coordI][l.coordJ].chgEtat(grilleDeJeu.grilleJ[l.coordI][l.coordJ].etat)
						grilleDeJeu.enregistrerFichier()
						
						if (grilleDeJeu.observateur())
							unJoueur.finirLaPartie(tabGrille.at(0))
							@chrono.cFin
							@chrono.cRaz
							sleep(2)
							self.supprimeMoi
				  	        	menu = FWin.new(@window, @header, self, unJoueur)
				  	        	menu.ajouteMoi
				  	        	@window.show_all
						end

					}
				}
			}
		end

		@header.btnMenu.signal_connect('clicked') {
			@chrono.cFin
			@chrono.cRaz
	        self.supprimeMoi
	        menu = FMenu.new(@window, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
    	}

		@boxAide = Gtk::ButtonBox.new(:vertical)

		@lableAide = Gtk::Label.new()

		@boxAide.add(@lableAide)

		@b1 = BoutonAideVerif.new("1", true)
		@b2 = BoutonAideHerbe.new("2", true)
		@b3 = BoutonAideTente.new("3", true)
		

		@boxAide.add(@b1.bouton)
		@boxAide.add(@b2.bouton)
		@boxAide.add(@b3.bouton)

		@b1.bouton.signal_connect('clicked'){
			@b1.aide(grilleDeJeu, @lableAide, unJoueur)
			@nbAidesUtilises+=1
		}

		@b2.bouton.signal_connect('clicked') {
			@b2.aide(grilleDeJeu, @lableAide, unJoueur)
			@nbAidesUtilises+=1
        }

		@b3.bouton.signal_connect('clicked') {
			@b3.aide(grilleDeJeu, @lableAide, unJoueur)
			@nbAidesUtilises+=1
        }				

		@gHelp.add(@boxAide)

		@bPause = Gtk::Button.new()
		@pause=(Gtk::Image.new(:file =>"./image/pause.png"))
		@bPause.set_image(@pause)
		@gHelp.add(@bPause)

		@bPause.signal_connect('clicked') {
			@chrono.cPause
			
			if(@chrono.pause)
				@boutonGrille.each{|k|
					k.each{|l|
						l.clic=false
						l.bouton.set_opacity(0.0)
					}
				}
			else
				@boutonGrille.each{|k|
					k.each{|l|
						l.clic=true
						l.bouton.set_opacity(1.0)
					}
				} 
			end
        }

		@gHelp.spacing=70

		@box.add(@grille)
		@box.add(@gHelp)

		@frame.attach(@box,0,1,0,1)

		@bg=(Gtk::Image.new(:file =>"../Assets/ImgGame2.png"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end

end
