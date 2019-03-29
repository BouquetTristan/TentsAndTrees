require 'gtk3'
require './fPlayA.rb'

class FAventure < Page

	def initialize(monApp, header, anciennePage, unJoueur)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		@frame = Gtk::Table.new(1,1,false)

		bloqueE = false
		bloqueA = false
		bloqueH = false

		@aventMenu = Gtk::ButtonBox.new(:vertical)
    	@aventMenu.layout = :spread

    	@level = Gtk::ButtonBox.new(:horizontal)
    	@level.layout = :spread

		@print = Gtk::Button.new
		@ete = Gtk::Button.new
		@autom = Gtk::Button.new
		@hiver = Gtk::Button.new

    	@imgP=(Gtk::Image.new(:file =>"../Assets/VignettePrintemps.png"))
        @print.set_image(@imgP)
        focus_hadjustment=(:start)

        @imgE=(Gtk::Image.new(:file =>"../Assets/VignetteEte.png"))
        @ete.set_image(@imgE)
        focus_hadjustment=(:start)

        @imgA=(Gtk::Image.new(:file =>"../Assets/VignetteAutomne.png"))
        @autom.set_image(@imgA)
        focus_hadjustment=(:start)

        @imgH=(Gtk::Image.new(:file =>"../Assets/VignetteHiver.png"))
        @hiver.set_image(@imgH)
        focus_hadjustment=(:start)

		@level.add(@print, :expand => true, :fill => false)
		@level.add(@ete, :expand => true, :fill => false)
		@level.add(@autom, :expand => true, :fill => false)
		@level.add(@hiver, :expand => true, :fill => false)

		@aventMenu.add(@level)

		@header.btnMenu.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FMenu.new(@window, @header, self, unJoueur)
		        menu.ajouteMoi
		        @window.show_all
		    }

		@print.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FPlayA.new(@window, @header, self, unJoueur)
		        menu.ajouteMoi
		        @window.show_all
		    }

		if(bloqueE == true)
			@ete.signal_connect('clicked') {
			        self.supprimeMoi
			        menu = FPlayA.new(@window, @header, self, unJoueur)
			        menu.ajouteMoi
			        @window.show_all
			    }
		end

		if(bloqueA == true)
		@autom.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FPlayA.new(@window, @header, self)
		        menu.ajouteMoi
		        @window.show_all
		    }
		end
		if(bloqueH == true)
		@hiver.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FPlayA.new(@window, @header, self)
		        menu.ajouteMoi
		        @window.show_all
		    }
		end

		@frame.attach(@aventMenu,0,1,0,1)

		@bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
