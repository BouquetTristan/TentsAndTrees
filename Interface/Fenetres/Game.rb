require 'gtk3'
require './GameMode.rb'
require './grille/grille.rb'

class Game < Gtk::Builder

	def initialize 
	    super()
	    self.add_from_file(__FILE__.sub(".rb",".glade"))
		# Creation d'une variable d'instance par composant identifié dans glade
		#puts "Création des variables d'instances"
		self.objects.each() { |p| 	
				unless p.builder_name.start_with?("___object") 
					#puts "\tCreation de la variable d'instance @#{p.builder_name}"
					instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
				end
		}
		@fGame.show_all

		@taille = 6
		@grille=Gtk::Table.new(6,6, false)
		puts("grille ok")
		@grid.attach(@grille, 0,1,1,2)
		puts("grille attaché ok")
					@lCase=Gtk::Label.new 
					@lCase.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">|.   .|</span>\n")
					@grille.attach(@lCase, 0, 1, 0, 1)

		for i in (0..@taille)
			for j in (0..@taille)

					@lCase=Gtk::Label.new 
					@lCase.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">|..|</span>\n")
					@grille.attach(@lCase, i, i+1, j,j+1)

			end
		end 

		puts("grille attaché ok2")

	end	
end

builder = Game.new()
Gtk.main