require 'gtk3'
require './Connexion.rb'
require '../../BaseDeDonnees/Joueur.rb'


class ForgetPW < Gtk::Builder

	def initialize 
	    super()
	    self.add_from_file(__FILE__.sub(".rb",".glade"))
		# Creation d'une variable d'instance par composant identifié dans glade
		self.objects.each() { |p| 	
				unless p.builder_name.start_with?("___object") 
					instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name]) 
				end
		}
		@fPassword.show_all

		@bValid.signal_connect('clicked') {
			joueur = Joueur.new(@ePseudo.text, nil, @eSecret.text)
			if joueur.motDePasseOublier(@ePassword.text) == nil then
				@eSecret.text = ''
			end
			if @ePseudo.text == '' 
				@tErrorP.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Pseudo incorrect !</span>\n")
			else 
				if @eSecret.text == '' 
						@tErrorS.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Réponse secrete incorrect !</span>\n")
				else

					@pSuivant = Connexion.new
					@fPassword.destroy
				end
			end

		}

		@bBack.signal_connect('clicked') {
					@pLast = Connexion.new
					@fPassword.destroy			
		}

			
	end
end

# On lance l'application
builder = ForgetPW.new()
Gtk.main
