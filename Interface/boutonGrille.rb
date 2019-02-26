require 'gtk2'

class BoutonGrille

	# @bouton
	# @coordI, @coordJ
	# @image

	def initialize()
		@bouton = Gtk::Button.new("")
	end

	def mCoord(i,j)
		@coordI = i
		@coordJ = j
	end

	def mBouton(valeur)
		@bouton.set_label(valeur.to_s)
	end

	def chgEtat(etat)
		if etat == 0
			self.mBouton(0)
		end
		if etat == 1
			self.mBouton(1)
		end
		if etat == 2
			self.mBouton(2)
		end
		if etat == 3
			self.mBouton(3)
		end
	end


	attr_reader :coordI, :coordJ, :bouton
	attr_writer :bouton

end