require 'gtk2'

require './grille/grille.rb'
require './boutonGrille.rb'

class Test < Gtk::Builder

	def initialize 


		fenetre = Gtk::Window.new
		fenetre.set_default_size(600,400)
		fenetre.border_width=5
		#fenetre.set_window_position(Gtk::Window::CENTER)

		@gPlay=Gtk::Table.new(1,3, false)
		fenetre.add(@gPlay)

		#@separator=Gtk::Separator.new()

		@taille = 4
		@grille=Gtk::Table.new(@taille,@taille, false)
		@gPlay.attach(@grille, 0,1,0,1)
		
		grillej = Grille.creer(@taille,"grille.txt")
		
		@boutonGrille = [[]]

		for i in (0..@taille-1)
			temp=[]
			for j in (0..@taille-1)
				#puts grillej.grille[i][j].etat
					vEtat = grillej.grille[i][j].etat

					temp[j] = BoutonGrille.new
					temp[j].mCoord(i,j)
					temp[j].chgEtat(vEtat)

					
					@grille.attach(temp[j].bouton, i, i+1, j,j+1)
					
			end
			@boutonGrille[i] = temp
		end 


		@boutonGrille.each{|k| 
			k.each{|l|
				l.bouton.signal_connect ("clicked"){
		        
					grillej.grille[l.coordI][l.coordJ].jouerCase()
					@boutonGrille[l.coordI][l.coordJ].chgEtat(grillej.grille[l.coordI][l.coordJ].etat)
					grillej.grilleTofich()	
				}
			}
		}
		
		fenetre.show_all()
		#destruction fenetre quand "quitter"
		fenetre.signal_connect('destroy') {onDestroy}
	end	

	def onDestroy
		puts "Application Ferme"
		Gtk.main_quit
	end
end

builder = Test.new()
Gtk.main