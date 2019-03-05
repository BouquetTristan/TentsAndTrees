require 'gtk3'
require './Connexion.rb'
#require './Menu.rb'


class CreateCount < Gtk::Builder

	def initialize 
	    super()
	    self.add_from_file(__FILE__.sub(".rb",".glade"))
		# Creation d'une variable d'instance par composant identifié dans glade
		self.objects.each() { |p| 	
				unless p.builder_name.start_with?("___object") 
					instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
				end
		}
		@fCreaCount.show_all

		@ePassword.visibility=(false)

		@bValid.signal_connect('clicked') {
			if @ePseudo.text == '' 
				@tErrorP.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Pseudo incorrect !</span>\n")
			else 
				if @ePassword.text == '' 
				@tErrorPw.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Mot de passe incorrect !</span>\n")
				end
			end 
			if @eSecret.text != '' 
					@pSuivant = MainMenu.new
					@fCreaCount.destroy	
			end	
		}

		@bBack.signal_connect('clicked') {
					@pLast = Connexion.new
					@fCreaCount.destroy			
		}

			
	end
		
end
builder = CreateCount.new
Gtk.main
