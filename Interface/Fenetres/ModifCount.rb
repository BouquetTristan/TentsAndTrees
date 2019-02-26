require 'gtk3'
require './Profil.rb'

class ModifCount < Gtk::Builder

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
		@fModif.show_all

		@bBack.signal_connect('clicked'){
			@pLast = Profil.new
			@fModif.destroy	
		}

			
	end
end
