require 'gtk3'
require './Classes/Page.rb'

require './Classes/Grille.rb'
require './Classes/Aide.rb'
require './Classes/boutonGrille.rb'
require './Classes/Chrono.rb'
require './Classes/boutonAide.rb'
require './Classes/boutonAideVerif.rb'
require './Classes/boutonAideHerbe.rb'
require './Classes/boutonAideTente.rb'
require './Classes/boutonNbTentesColonne.rb'
require './Classes/boutonNbTentesLigne.rb'
require './Interface/fFin.rb'
require './Classes/Score.rb'

#====== Fenetre pour jouer1 du jeu
class FPlay < Page

	#Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
	# @param difficulte		//la difficulté choisis
	# @param grilleDeJeu		//Grille du jeu
	# @param compet		//boolen indiquant si nous somme en mode compétiton ou non
  # @return void		//ne renvoie rien
	def initialize(monApp, header, anciennePage, unJoueur, difficulte, grilleDeJeu, compet)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@nbAidesUtilises = 0



		@gHelp = Gtk::ButtonBox.new(:vertical)

		if (compet)
			@nbFeuilles = unJoueur.creditAide
			@boxFeuilles=Gtk::ButtonBox.new(:horizontal)
				@boxFeuilles.spacing=1
				@img =(Gtk::Image.new(:file =>"./Assets/feuille.png"))
				@profil = Gtk::Label.new().set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 15\"> #{@nbFeuilles.to_s}</span>")
				@boxFeuilles.add(@img)
				@boxFeuilles.add(@profil, :expand => true, :fill => false)
				@gHelp.add(@boxFeuilles)
		end

		@chrono = Chrono.new


		thr=Thread.new do
			#sleep(2)
			@chrono.cStart

 		end



        @frame = Gtk::Table.new(1,1,false)

        @gChrono = Gtk::ButtonBox.new(:vertical)
        @gChrono.add(@chrono.lChrono)

        @box = Gtk::ButtonBox.new(:horizontal)

	    taille = grilleDeJeu.taille()

        @grille = Gtk::Table.new(taille, taille, false)



		@boutonGrille = [[]]

	# Mise en place des indicateurs de la grille de jeu

		tabBout=[]

		for j in (0..taille-1)
			tabBout[j] = BoutonNbTentesColonne.new(grilleDeJeu, @boutonGrille, j, "./Assets/Printemps", unJoueur)
			tabBout[j].bouton.set_label(grilleDeJeu.nbTentesLigne[j].to_s)
			@grille.attach(tabBout[j].bouton, j+1,j+2, 0,1)

		end

		tabBout.each { |l|
			l.bouton.signal_connect("clicked"){
				l.chgEtat
				if (grilleDeJeu.observateur())
					@score = Score.creer(difficulte, @nbAidesUtilises)
					if(compet)
						if(difficulte == "Facile")
							unJoueur.modifierInformationsFinDePartie(@score.calculerScore((300-@chrono.chrono)), difficulte, @nbAidesUtilises)
						end
						if(difficulte == "Moyenne")
								unJoueur.modifierInformationsFinDePartie(@score.calculerScore((180-@chrono.chrono)), difficulte, @nbAidesUtilises)
						end
						if(difficulte == "Difficile")
									unJoueur.modifierInformationsFinDePartie(@score.calculerScore((120-@chrono.chrono)), difficulte, @nbAidesUtilises)
						end

					end

					@chrono.cFin
					@chrono.cRaz
					thr.kill
					sleep(1)
					self.supprimeMoi
		  	        	menu = FFin.new(monApp, @header, self, unJoueur, "gagner")
		  	        	menu.ajouteMoi
		  	        	@window.show_all
				end
			}
		}

		for i in (0..taille-1)
			tabBout[i] = BoutonNbTentesLigne.new(grilleDeJeu, @boutonGrille, i, "./Assets/Printemps", unJoueur)
			tabBout[i].bouton.set_label(grilleDeJeu.nbTentesColonne[i].to_s)
			@grille.attach(tabBout[i].bouton,0,1, i+1,i+2)
		end

		tabBout.each { |l|
			l.bouton.signal_connect("clicked"){
				l.chgEtat
				if (grilleDeJeu.observateur())
					@score = Score.creer(difficulte, @nbAidesUtilises)
					if(compet)
						if(difficulte == "Facile")
							unJoueur.modifierInformationsFinDePartie(@score.calculerScore((300-@chrono.chrono)), difficulte, @nbAidesUtilises)
						end
						if(difficulte == "Moyenne")
								unJoueur.modifierInformationsFinDePartie(@score.calculerScore((180-@chrono.chrono)), difficulte, @nbAidesUtilises)
						end
						if(difficulte == "Difficile")
									unJoueur.modifierInformationsFinDePartie(@score.calculerScore((120-@chrono.chrono)), difficulte, @nbAidesUtilises)
						end

					end

					@chrono.cFin
					@chrono.cRaz
					thr.kill
					sleep(1)
					self.supprimeMoi
		  	        	menu = FFin.new(monApp, @header, self, unJoueur, "gagner")
		  	        	menu.ajouteMoi
		  	        	@window.show_all
				end
			}
		}

	# Création de la grille de jeu.
	# Mise en place d'une matrice composant tous les boutons

		for i in (0..taille-1)
			temp=[]
			for j in (0..taille-1)
					vEtat = grilleDeJeu.grilleJ[i][j].etat
					temp[j] = BoutonGrille.new(monApp,"./Assets/Printemps")
					temp[j].mCoord(i,j)
					temp[j].chgEtat(monApp, vEtat)
					@grille.attach(temp[j].bouton, i+1, i+2, j+1,j+2)
			end
			@boutonGrille[i] = temp
		end

	# Appel de l'evenement bouton "cliqué", et modification du bouton cliqué
		if(!@chrono.pause)
			@boutonGrille.each{|k|
				k.each{|l|
					l.bouton.signal_connect("clicked"){
						if @aide != nil
							if @aide.instance_of? Case
								@boutonGrille[@aide.i][@aide.j].chgEtat(monApp, grilleDeJeu.grilleJ[@aide.i][@aide.j].etat)
							else
								for i in (0..taille-1)
									@boutonGrille[@aide][i].chgEtat(monApp, grilleDeJeu.grilleJ[@aide][i].etat)
									@boutonGrille[i][@aide].chgEtat(monApp, grilleDeJeu.grilleJ[i][@aide].etat)
								end
							end
							@lableAide.set_markup('')

							@aide = nil
						end
			        	grilleDeJeu.grilleJ[l.coordI][l.coordJ].jouerCase()
						@boutonGrille[l.coordI][l.coordJ].chgEtat(monApp, grilleDeJeu.grilleJ[l.coordI][l.coordJ].etat)
						grilleDeJeu.enregistrerFichier(unJoueur.pseudo, nil)

						if (grilleDeJeu.observateur())
							@score = Score.creer(difficulte, @nbAidesUtilises)
							if(compet)
								if(difficulte == "Facile")
									unJoueur.modifierInformationsFinDePartie(@score.calculerScore((300-@chrono.chrono)), difficulte, @nbAidesUtilises)
								end
								if(difficulte == "Moyenne")
										unJoueur.modifierInformationsFinDePartie(@score.calculerScore((180-@chrono.chrono)), difficulte, @nbAidesUtilises)
								end
								if(difficulte == "Difficile")
											unJoueur.modifierInformationsFinDePartie(@score.calculerScore((120-@chrono.chrono)), difficulte, @nbAidesUtilises)
								end

							end

							@chrono.cFin
							@chrono.cRaz
							thr.kill
							sleep(1)
							self.supprimeMoi
				  	        	menu = FFin.new(monApp, @header, self, unJoueur, "gagner")
				  	        	menu.ajouteMoi
				  	        	@window.show_all
						end

					}
				}
			}
		end

		@header.btnMenu.signal_connect('clicked') {
			# @chrono.cFin
			# @chrono.cRaz
	        self.supprimeMoi
	        menu = FMenu.new(monApp, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
	        thr.kill
    	}

		@boxAide = Gtk::ButtonBox.new(:vertical)

		@lableAide = Gtk::Label.new()

		@boxAide.add(@lableAide)


		if (compet)
			@b1 = BoutonAideHerbe.new("Aide Herbe : 2 feuilles", true)
			@b2 = BoutonAideTente.new("Aide Tente : 3 feuilles", true)
			@b3 = BoutonAideVerif.new("Verification : 5 feuilles", true)
		else
			@b1 = BoutonAideHerbe.new("Aide Herbe", true)
			@b2 = BoutonAideTente.new("Aide Tente", true)
			@b3 = BoutonAideVerif.new("Verification", true)
		end


		@boxAide.add(@b1.bouton)
		@boxAide.add(@b2.bouton)
		@boxAide.add(@b3.bouton)

		@b1.bouton.signal_connect('clicked'){
			if @aide != nil
				if @aide.instance_of? Case
					@boutonGrille[@aide.i][@aide.j].chgEtat(monApp, grilleDeJeu.grilleJ[@aide.i][@aide.j].etat)
				else
					for i in (0..taille-1)
						@boutonGrille[@aide][i].chgEtat(monApp, grilleDeJeu.grilleJ[@aide][i].etat)
						@boutonGrille[i][@aide].chgEtat(monApp, grilleDeJeu.grilleJ[i][@aide].etat)
					end
				end

				@aide = nil
			end
			if (compet)
				tempo = @nbFeuilles - @b1.prix
				if(tempo >= 0)
					@nbFeuilles = tempo

					@profil.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 15\"> #{@nbFeuilles}</span>")

					@aide = @b1.aide(monApp, grilleDeJeu, @lableAide, unJoueur, @boutonGrille)
					@nbAidesUtilises+=1
				else
					@lableAide.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Vous ne pouvez plus utiliser cette aide</span>")
				end
			else
				@aide = @b1.aide(monApp, grilleDeJeu, @lableAide, unJoueur, @boutonGrille)
				@nbAidesUtilises+=1
			end
		}

		@b2.bouton.signal_connect('clicked') {
			if @aide != nil
				if @aide.instance_of? Case
					@boutonGrille[@aide.i][@aide.j].chgEtat(monApp, grilleDeJeu.grilleJ[@aide.i][@aide.j].etat)
				else
					for i in (0..taille-1)
						@boutonGrille[@aide][i].chgEtat(monApp, grilleDeJeu.grilleJ[@aide][i].etat)
						@boutonGrille[i][@aide].chgEtat(monApp, grilleDeJeu.grilleJ[i][@aide].etat)
					end
				end

				@aide = nil
			end
			if (compet)
				tempo = @nbFeuilles - @b2.prix
				if(tempo >= 0)
					@nbFeuilles = tempo

					@profil.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 15\"> #{@nbFeuilles}</span>")

					@aide = @b2.aide(monApp, grilleDeJeu, @lableAide, unJoueur, @boutonGrille)
					@nbAidesUtilises+=1
				else
					@lableAide.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Vous ne pouvez plus utiliser cette aide</span>")
				end
			else
				@aide = @b2.aide(monApp, grilleDeJeu, @lableAide, unJoueur, @boutonGrille)
				@nbAidesUtilises+=1
			end
        }

		@b3.bouton.signal_connect('clicked') {
			if @aide != nil
				if @aide.instance_of? Case
					@boutonGrille[@aide.i][@aide.j].chgEtat(monApp, grilleDeJeu.grilleJ[@aide.i][@aide.j].etat)
				else
					for i in (0..taille-1)
						@boutonGrille[@aide][i].chgEtat(monApp, grilleDeJeu.grilleJ[@aide][i].etat)
						@boutonGrille[i][@aide].chgEtat(monApp, grilleDeJeu.grilleJ[i][@aide].etat)
					end
				end

				@aide = nil
			end
			if (compet)
				tempo = @nbFeuilles - @b3.prix
				if(tempo >= 0)
					@nbFeuilles = tempo

					@profil.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 15\"> #{@nbFeuilles}</span>")

					@aide = @b3.aide(monApp, grilleDeJeu, @lableAide, unJoueur, @boutonGrille)
					@nbAidesUtilises+=1
				else
					@lableAide.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">Vous ne pouvez plus utiliser cette aide</span>")
				end
			else
				@aide = @b3.aide(monApp, grilleDeJeu, @lableAide, unJoueur, @boutonGrille)
				@nbAidesUtilises+=1
			end
        }


		@gHelp.add(@boxAide)

		@bPause = Gtk::Button.new()
		@bPause.set_relief(:none)
		@pause=(Gtk::Image.new(:file =>"./Assets/pause.png"))
		@bPause.set_image(@pause)
		@gChrono.add(@bPause)

		@bPause.signal_connect('clicked') {
			@chrono.cPause

			if(@chrono.pause)
				@boutonGrille.each{|k|
					k.each{|l|
						l.clic=false
						l.bouton.set_opacity(0.0)
					}
				}
				@pause=(Gtk::Image.new(:file =>"./Assets/Play.png"))
				@bPause.set_image(@pause)

				@b1.cliquable = false
				@b2.cliquable = false
				@b3.cliquable = false

				
			else
				@boutonGrille.each{|k|
					k.each{|l|
						l.clic=true
						l.bouton.set_opacity(1.0)
					}
				}
				@pause=(Gtk::Image.new(:file =>"./Assets/pause.png"))
				@bPause.set_image(@pause)

				@b1.cliquable = true
				@b2.cliquable = true
				@b3.cliquable = true
			end
        }

		@gHelp.spacing=70

		@box.add(@gChrono)
		@box.add(@grille)
		@box.add(@gHelp)

		@frame.attach(@box,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end

end
