
require 'gtk3'

class BoutonGrille

	# @bouton
	# @coordI, @coordJ

	def initialize()
		@bouton = Gtk::Button.new	
	end

	def mCoord(i,j)
		@coordI = i
		@coordJ = j
	end

	def mBouton(valeur)
		@box.set_label(valeur.to_s)
	end

	def chgEtat(etat)
		if etat == 0
			@image=(Gtk::Image.new(:file =>"./image/rien.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@image=(Gtk::Image.new(:file =>"./image/herbe.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@image=(Gtk::Image.new(:file =>"./image/arbre.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@image=(Gtk::Image.new(:file =>"./image/tente.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end


	attr_reader :coordI, :coordJ, :bouton
	attr_writer :bouton

end




