
require 'gtk3'

class BoutonGrille

	# @bouton
	# @coordI, @coordJ

	def initialize()
		@bouton = Gtk::Button.new
		@clic = true
	end

	def mCoord(i,j)
		@coordI = i
		@coordJ = j
	end

	def mBouton(valeur)
		@box.set_label(valeur.to_s)
	end

	def chgEtat(etat)

		if(@clic)
			if etat == 0
				@image=(Gtk::Image.new(:file =>"./image/Printemps/terre.png", :size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 1
				@image=(Gtk::Image.new(:file =>"./image/Printemps/tente.png", :size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 2
				@image=(Gtk::Image.new(:file =>"./image/Printemps/arbre.png",:size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
			if etat == 3
				@image=(Gtk::Image.new(:file =>"./image/Printemps/herbe.png",:size => :dialog))
				@bouton.set_image(@image)
				focus_hadjustment=(:start)
			end
		end
	end


	attr_reader :coordI, :coordJ, :bouton, :clic
	attr_writer :bouton, :clic

end
