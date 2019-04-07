
require 'gtk3'

class BoutonGrilleA < BoutonGrille

	# @bouton
	# @coordI, @coordJ

	def initialize(chemin)
		super()
		@chemin = chemin
	end

	def chgEtat(etat)
		if etat == 0
			@image=(Gtk::Image.new(:file =>"#{@chemin}/terre.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@image=(Gtk::Image.new(:file =>"#{@chemin}/tente.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@image=(Gtk::Image.new(:file =>"#{@chemin}/arbre.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@image=(Gtk::Image.new(:file =>"#{@chemin}/herbe.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end

end




