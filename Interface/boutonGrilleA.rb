
require 'gtk3'
require './boutonGrille.rb'

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


	def indiquerAide(etat)
		if etat == 0
			@image=(Gtk::Image.new(:file =>"#{@chemin}/terreS.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 1
			@image=(Gtk::Image.new(:file =>"#{@chemin}/tenteS.png", :size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 2
			@image=(Gtk::Image.new(:file =>"#{@chemin}/arbreS.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
		if etat == 3
			@image=(Gtk::Image.new(:file =>"#{@chemin}/herbeS.png",:size => :dialog))
			@bouton.set_image(@image)
			focus_hadjustment=(:start)
		end
	end

	attr_reader :chemin


end




