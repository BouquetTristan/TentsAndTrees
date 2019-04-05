require 'gtk3'
require './Page.rb'

require '../Classes/Grille.rb'
require '../Classes/Aide.rb'
require './boutonGrille.rb'
<<<<<<< HEAD
require '../Classes/Chrono.rb'
=======
require './boutonAide.rb'
>>>>>>> 52427e72fdd6413505af236e47013096b38fce57

class FPlay < Page


		

	def initialize(monApp, header, anciennePage, unJoueur, difficulte)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@chrono = Chrono.new
        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:horizontal)

	   grilleDeJeu = Grille.creerD(difficulte)

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
					temp[j] = BoutonGrille.new
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
					@b2.cliquable = false
					@b3.cliquable = false
					@b4.cliquable = false
					@b5.cliquable = false
					@b6.cliquable = false
					if (grilleDeJeu.observateur())
						#puts("gagné")
						@chrono.cFin
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
 		}

		@boxAide = Gtk::ButtonBox.new(:vertical)

		@box1 = Gtk::ButtonBox.new(:horizontal)
		@b1 = BoutonAide.new("1", true)
		@b2 = BoutonAide.new("2", false)

		@box1.add(@b1.bouton)
		@box1.add(@b2.bouton)

		@box2 = Gtk::ButtonBox.new(:horizontal)
		@b3 = BoutonAide.new("3", false)
		@b4 = BoutonAide.new("4", false)

		@box2.add(@b3.bouton)
		@box2.add(@b4.bouton)

		@box3 = Gtk::ButtonBox.new(:horizontal)
		@b5 = BoutonAide.new("5", false)
		@b6 = BoutonAide.new("6", false)

		@box3.add(@b5.bouton)
		@box3.add(@b6.bouton)

		@boxAide.add(@box1)
		@boxAide.add(@box2)
		@boxAide.add(@box3)

		@b1.bouton.signal_connect('clicked'){
			if(@b1.cliquable == true)
				if(Aide.erreur(grilleDeJeu) != nil)
					print aide != nil ? "Erreur sur la case #{aide.i} #{aide.j}": "Aucune erreur"
				end	
				@b2.cliquable = true
			end	
        }

		@b2.bouton.signal_connect('clicked') {
			if(@b2.cliquable == true)
				if(Aide.ligneCompleterHerbes(grilleDeJeu) != nil)
					print aide != nil ? "\nLa colonne #{aide} peut être complétée par des herbes": "\nAucune colonne ne peut être complétée par des herbes"
				elsif(Aide.colonneCompleterHerbes(grilleDeJeu) != nil)
					print aide != nil ? "\nLa ligne #{aide} peut être complétée par des herbes": "\nAucune ligne ne peut être complétée par des herbes"
				end
				@b3.cliquable = true
			end	
			
        }

		@b3.bouton.signal_connect('clicked') {
			if(@b3.cliquable == true)
				@b4.cliquable = true
			end	
        }

		@b4.bouton.signal_connect('clicked') {
			if(@b4.cliquable == true)
				aide = Aide.tenteContourCompleter(grilleDeJeu)
				print aide != nil ? "\nLe contour de la tente en #{aide.i} #{aide.j} doit être complété": "\nAucun contour de tente ne peut être complété par des herbes"
				@b5.cliquable = true

			end	
        }

		@b5.bouton.signal_connect('clicked') {
			if(@b5.cliquable == true)
				aide = Aide.arbreTentePlacer(grilleDeJeu)
				print aide != nil ? "\nL'arbre en #{aide.i} #{aide.j} possède une seule possiblité pour une tente": "\nIl n'y a pas d'arbre avec une seule case disponible"
				@b6.cliquable = true
			end
        }

		@b6.bouton.signal_connect('clicked') {
			if(@b6.cliquable == true)
				aide = Aide.arbreAngleHerbe(grilleDeJeu)
				print aide != nil ? "\nL'arbre en #{aide.i} #{aide.j} possède un coin qui est obligatoirement de l'herbe": "\nIl n'y a pas d'arbre avec un coin à compléter"
			end	
        }

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
