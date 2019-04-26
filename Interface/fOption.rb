require 'gtk3'

require './Classes/Page.rb'

#====== Fenetre d'option du jeu
class FOption < Page

  #Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @return void		//ne renvoie rien
     def initialize(monApp, header, anciennePage, unJoueur)

     	super(monApp, :vertical, header,  anciennePage, unJoueur)

      @frame = Gtk::Table.new(1,1,false)
    	@gMenu = Gtk::ButtonBox.new(:vertical)

      @label = Gtk::Label.new()
      @label.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">Choississez votre taille d'écran !</span>\n")

    	@screen1 = Gtk::Button.new(:label =>'1205 x 740', :use_underline => nil, :stock_id => nil)
      @screen2 = Gtk::Button.new(:label =>'1465 x 900', :use_underline => nil, :stock_id => nil)    

      @gMenu.add(@label, :expand => true, :fill => false)
    	@gMenu.add(@screen1, :expand => true, :fill => false)
    	@gMenu.add(@screen2, :expand => true, :fill => false)

       @screen1.signal_connect('clicked') {
              monApp.width = 1205
              monApp.height = 740
              monApp.window.resize(monApp.width,monApp.height)
               self.supprimeMoi
               suivant = FOption.new(monApp, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }
        @screen2.signal_connect('clicked') {
              monApp.width = 1465
              monApp.height = 900
              monApp.window.resize(monApp.width,monApp.height)
               self.supprimeMoi
               suivant = FOption.new(monApp, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all
        }
        @header.btnMenu.signal_connect('clicked') {
                self.supprimeMoi
                menu = FMenu.new(monApp, @header, self, unJoueur)
                menu.ajouteMoi
                @window.show_all
            }

        @frame.attach(@gMenu,0,1,0,1)

        @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Menu/ImgGame.jpg",:width=> monApp.width, :height=> monApp.height))
        @bg=(Gtk::Image.new(:pixbuf => @pix))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end