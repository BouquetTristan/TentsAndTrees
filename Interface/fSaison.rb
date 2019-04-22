require 'gtk3'
require './Interface/fPlayA.rb'

class FSaison < Page

	def initialize(monApp, header, anciennePage, unJoueur, uneSaison)

		super(monApp, :vertical, header,  anciennePage, unJoueur)

		puts "FSaison début"

		@frame = Gtk::Table.new(1,1,false)

		@selecGrille = Gtk::ButtonBox.new(:vertical)
    	@selecGrille.layout = :spread

    	@grilleBox1 = Gtk::ButtonBox.new(:horizontal)
    	@grilleBox1.layout = :spread

    	@grilleBox2 = Gtk::ButtonBox.new(:horizontal)
    	@grilleBox2.layout = :spread

		@grille1 = Gtk::Button.new(:label => '1', :use_underline => nil, :stock_id => nil)
		@grille2 = Gtk::Button.new(:label => '2', :use_underline => nil, :stock_id => nil)
		@grille3 = Gtk::Button.new(:label => '3', :use_underline => nil, :stock_id => nil)
		@grille4 = Gtk::Button.new(:label => '4', :use_underline => nil, :stock_id => nil)
		@grille5 = Gtk::Button.new(:label => '5', :use_underline => nil, :stock_id => nil)
		@grille6 = Gtk::Button.new(:label => '6', :use_underline => nil, :stock_id => nil)


  #      # @print.set_markup("1")
  #       focus_hadjustment=(:start)

  #       @imgE=(Gtk::Image.new(:file =>"../Assets/VignetteEte.png"))
  #       @ete.set_image(@imgE)
  #       focus_hadjustment=(:start)

  #       @imgA=(Gtk::Image.new(:file =>"../Assets/VignetteAutomne.png"))
  #       @autom.set_image(@imgA)
  #       focus_hadjustment=(:start)

  #       @imgH=(Gtk::Image.new(:file =>"../Assets/VignetteHiver.png"))
  #       @hiver.set_image(@imgH)
  #       focus_hadjustment=(:start)

		@grilleBox1.add(@grille1, :expand => true, :fill => false)
		@grilleBox1.add(@grille2, :expand => true, :fill => false)
		@grilleBox1.add(@grille3, :expand => true, :fill => false)
		@grilleBox2.add(@grille4, :expand => true, :fill => false)
		@grilleBox2.add(@grille5, :expand => true, :fill => false)
		@grilleBox2.add(@grille6, :expand => true, :fill => false)

		@selecGrille.add(@grilleBox1)
		@selecGrille.add(@grilleBox2)
		@grilleBox1.spacing=90
		@grilleBox2.spacing=90

		@header.btnMenu.signal_connect('clicked') {
		        self.supprimeMoi
		        menu = FMenu.new(monApp, @header, self, unJoueur)
		        menu.ajouteMoi
		        @window.show_all
		    }

		@grille1.signal_connect('clicked') {
		        self.supprimeMoi
				menu = FPlayA.new(monApp, @header, self, unJoueur, uneSaison,1)
				menu.ajouteMoi
		        @window.show_all
		    }

		@grille2.signal_connect('clicked') {
		        self.supprimeMoi
				menu = FPlayA.new(monApp, @header, self, unJoueur, uneSaison,2)
				menu.ajouteMoi
		        @window.show_all
		    }
		@grille3.signal_connect('clicked') {
		        self.supprimeMoi
				menu = FPlayA.new(monApp, @header, self, unJoueur, uneSaison,3)
				menu.ajouteMoi
		        @window.show_all
		    }
		@grille4.signal_connect('clicked') {
		        self.supprimeMoi
				menu = FPlayA.new(monApp, @header, self, unJoueur, uneSaison,4)
				menu.ajouteMoi
		        @window.show_all
		    }
		@grille5.signal_connect('clicked') {
		        self.supprimeMoi
				menu = FPlayA.new(monApp, @header, self, unJoueur, uneSaison,5)
				menu.ajouteMoi
		        @window.show_all
		    }
		@grille6.signal_connect('clicked') {
		        self.supprimeMoi
				menu = FPlayA.new(monApp, @header, self, unJoueur, uneSaison,6)
				menu.ajouteMoi
		        @window.show_all
		    }


		# if(bloqueE == true)
		# 	@ete.signal_connect('clicked') {
		# 	        self.supprimeMoi
		# 	        menu = FPlayA.new(@window, @header, self, unJoueur)
		# 	        menu.ajouteMoi
		# 	        @window.show_all
		# 	    }
		# end

		# if(bloqueA == true)
		# @autom.signal_connect('clicked') {
		#         self.supprimeMoi
		#         menu = FPlayA.new(@window, @header, self)
		#         menu.ajouteMoi
		#         @window.show_all
		#     }
		# end
		# if(bloqueH == true)
		# @hiver.signal_connect('clicked') {
		#         self.supprimeMoi
		#         menu = FPlayA.new(@window, @header, self)
		#         menu.ajouteMoi
		#         @window.show_all
		#     }
		# end

		@frame.attach(@selecGrille,0,1,0,1)

		@pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGameA.png",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
	end
end
