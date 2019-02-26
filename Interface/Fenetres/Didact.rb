require 'gtk3'
require './Menu.rb'


class Didact < Gtk::Builder

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
		@fDidact.show_all

		@bLeft.signal_connect('clicked'){
				#Changement de l'image (precedente)
		}

		@bRight.signal_connect('clicked'){
				#Changement de l'image (suivante)
		}

		@bBack.signal_connect('clicked'){
			@pLast = Menu.new
			@fDidact.destroy	
		}

			
	end
end
