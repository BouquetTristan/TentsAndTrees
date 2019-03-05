require 'gtk3'
#require './Menu.rb'
require './CreateCount.rb'
require './ForgetPW.rb'



class Connexion < Gtk::Builder

	def initialize 
	    super()
	    #Création des variable d'instance de la fenêtre .glade
	    self.add_from_file(__FILE__.sub(".rb",".glade"))
	    self.objects.each() { |p| 	
			unless p.builder_name.start_with?("___object") 
				instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
			end
		}

		@fConnexion.show_all
		# COnfiguration des objets de la fenêtre
		@ePassword.visibility=(false)
		
			
		
		@bConnexion.signal_connect('clicked') {
			if @ePseudo.text == '' || @ePassword.text == ''
				@connexionError.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur mot de passe ou identifiant</span>\n")
			else 
				
				#@pSuivant = Menu.new
				#puts("coucou")
				#@fConnexion.destroy	
			end	
		}

		@lPassword.signal_connect('clicked'){
			@pSuivant = ForgetPW.new
			@fConnexion.destroy	
		}

		@lCount.signal_connect('clicked'){
			@pSuivant = CreateCount.new
			@fConnexion.destroy	
		}

	
	end	
	
end

# On lance l'application
builder = Connexion.new()
Gtk.main	

