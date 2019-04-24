require 'gtk3'


require './Classes/Page.rb'
require './Interface/fTuto.rb'

#====== Fenetre du Didacticiel du jeu
class FDidac < Page

  #Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @return void		//ne renvoie rien
     def initialize(monApp, header, anciennePage, unJoueur)

		  super(monApp, :vertical, header,  anciennePage, unJoueur)


        @frame = Gtk::Table.new(1,1,false)
    		@tMain = Gtk::Table.new(1,2,false)


    		@gbouton = Gtk::ButtonBox.new(:horizontal)


    		@tuto1 = Gtk::Button.new()
        @tuto1.set_relief(:none)
    		@tuto2 = Gtk::Button.new()
        @tuto2.set_relief(:none)
    		@tuto3 = Gtk::Button.new()
        @tuto3.set_relief(:none)

        @t1=(Gtk::Image.new(:file =>"./Assets/Didacticiel/t1.png"))
        @tuto1.set_image(@t1)
        @t2=(Gtk::Image.new(:file =>"./Assets/Didacticiel/t2.png"))
        @tuto2.set_image(@t2)
        @t3=(Gtk::Image.new(:file =>"./Assets/Didacticiel/t3.png"))
        @tuto3.set_image(@t3)

    		@gbouton.add(@tuto1, :expand => true, :fill => false)
    		@gbouton.add(@tuto2, :expand => true, :fill => false)
    		@gbouton.add(@tuto3, :expand => true, :fill => false)

    		@gbouton2 = Gtk::ButtonBox.new(:horizontal)

    		@tuto4 = Gtk::Button.new()
        @tuto4.set_relief(:none)
    		@tuto5 = Gtk::Button.new()
        @tuto5.set_relief(:none)

        @t4=(Gtk::Image.new(:file =>"./Assets/Didacticiel/t4.png"))
        @tuto4.set_image(@t4)
        @t5=(Gtk::Image.new(:file =>"./Assets/Didacticiel/t5.png"))
        @tuto5.set_image(@t5)

    		@gbouton2.add(@tuto4, :expand => true, :fill => false)
    		@gbouton2.add(@tuto5, :expand => true, :fill => false)


    		@tMain.attach(@gbouton, 0,1,0,1)
    		@tMain.attach(@gbouton2,0,1,1,2)

    	@header.btnMenu.signal_connect('clicked') {
	        self.supprimeMoi
	        menu = FMenu.new(monApp, @header, self, unJoueur)
	        menu.ajouteMoi
	        @window.show_all
    	}


        @tuto1.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto.new(monApp, header, self, unJoueur, "./Assets/Didacticiel/Tuto1.png")
               suivant.ajouteMoi
               @window.show_all
        }
        @tuto2.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto.new(monApp, header, self, unJoueur, "./Assets/Didacticiel/Tuto2.png")
               suivant.ajouteMoi
               @window.show_all
        }
        @tuto3.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto.new(monApp, header, self, unJoueur, "./Assets/Didacticiel/Tuto3.png")
               suivant.ajouteMoi
               @window.show_all
        }
        @tuto4.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto.new(monApp, header, self, unJoueur, "./Assets/Didacticiel/Tuto4.png")
               suivant.ajouteMoi
               @window.show_all
        }
        @tuto5.signal_connect('clicked') {
               self.supprimeMoi
               suivant = Ftuto.new(monApp, header, self, unJoueur, "./Assets/Didacticiel/Tuto5.png")
               suivant.ajouteMoi
               @window.show_all
        }

        @frame.attach(@tMain,0,1,0,1)


        @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
