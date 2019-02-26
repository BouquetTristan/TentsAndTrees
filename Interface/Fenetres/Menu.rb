require 'gtk3'


require_relative 'GameMode.rb'
require_relative 'Profil.rb'
require_relative 'Score.rb'
require_relative 'Didact.rb'


class Menu < Gtk::Builder
	
	def initialize 
	    super()
	    #Création des variable d'instance de la fenêtre .glade
		self.add_from_file(__FILE__.sub(".rb",".glade"))
		# Creation d'une variable d'instance par composant identifié dans glade
		#puts "Création des variables d'instances"
		self.objects.each() { |p| 	
				unless p.builder_name.start_with?("___object") 
					#puts "\tCreation de la variable d'instance @#{p.builder_name}"
					instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
				end
		}

		@fMenu.show_all

		@lProfil.signal_connect('clicked'){
			@pSuivant = Profil.new
			@fMenu.destroy
		}

		@bPlay.signal_connect('clicked'){
			GameMode.new
			@fMenu.destroy
		}

		@bScore.signal_connect('clicked'){
			@pSuivant = Score.new
			@fMenu.destroy
		}

		@bDicta.signal_connect('clicked'){
			@pSuivant = Didact.new
			@fMenu.destroy
		}

		@lDeco.signal_connect('clicked'){
			@fMenu.main_quit
		}

		
		
	end
	
end


#builder = Menu.new()
#Gtk.main