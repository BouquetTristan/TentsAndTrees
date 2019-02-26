require 'gtk3'

require_relative 'Menu.rb'
require_relative 'Aventure.rb'
require_relative 'Difficulte.rb'


class GameMode < Gtk::Builder

	def initialize 
	    super()
	    self.add_from_file(__FILE__.sub(".rb",".glade"))
		# Creation d'une variable d'instance par composant identifié dans glade
		puts "Création des variables d'instances"
		self.objects.each() { |p| 	
				unless p.builder_name.start_with?("___object") 
					puts "\tCreation de la variable d'instance @#{p.builder_name}"
					instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
				end
		}
		@fGameMode.show_all

		@bClassic.signal_connect('clicked'){
			@pSuivant = Difficulte.new
			@fGameMode.destroy	
		}

		@bAventure.signal_connect('clicked'){
			@pSuivant = Aventure.new
			@fGameMode.destroy	
		}

		@bTraine.signal_connect('clicked'){
			@pSuivant = Game.new
			@fGameMode.destroy	
		}

		@bBack.signal_connect('clicked'){
			@pLast = Menu.new
			@fGameMode.destroy	
		}

		

	end
end


