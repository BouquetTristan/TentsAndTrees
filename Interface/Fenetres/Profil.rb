require 'gtk3'

require './ModifCount.rb'
#require './Menu.rb'
require '../../BaseDeDonnees/Joueur.rb'


class Profil < Gtk::Builder

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
		@fProfil.show_all

		@lModif.signal_connect('clicked'){
			@pSuivant = ModifCount.new
			@fProfil.destroy	
		}

		@lDeco.signal_connect('clicked'){
			@fProfil.destroy	
		}

		@bBack.signal_connect('clicked'){
			@pLast = Menu.new
			@fProfil.destroy	
		}

		
			
	end
end
# On lance l'application
builder = Connexion.new()
Gtk.main	
