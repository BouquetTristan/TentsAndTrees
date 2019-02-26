require 'gtk3'
require './Game.rb'
require './GameMode.rb'

class Aventure < Gtk::Builder

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
		@fAventure.show_all

			
	end
end
