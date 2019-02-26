require 'gtk2'

class BoutonGrille

	# @bouton
	# @coordI, @coordJ
	# image -> @rien, @arbre, @tente, @herbe
	

	def initialize()
		@bouton = Gtk::Button.new("")
		@image = Gtk::Button.new()
		@rien = Gtk::Image.new('./image/rien.png')
		@arbre = Gtk::Image.new('./image/Arbre.png')
		@tente = Gtk::Image.new('./image/Tente.png')
		@herbe = Gtk::Image.new('./image/herbe.png')
	end

	def mCoord(i,j)
		@coordI = i
		@coordJ = j
	end

	def mBouton(image)
		#@bouton.set_image(image)
	end

	def chgEtat(etat)
		if etat == 0
			#@image.set_from_file('./image/rien.png')
			Gtk::Button.set_image(self, @rien)
		end
		if etat == 1
			self.mBouton(@herbe)
		end
		if etat == 2
			self.mBouton(@arbre)
		end
		if etat == 3
			self.mBouton(@tente)
		end
	end


	attr_reader :coordI, :coordJ, :bouton
	attr_writer :bouton

end