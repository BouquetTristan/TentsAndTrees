require 'gtk3'

require './Classes/Page.rb'

#====== Fenetre de fin de partie du jeu
class FFin < Page


  #Initialise la page
  # @param monApp		//l'application
  # @param header		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
  # @param statue		//détermine si le joueur à gagné ou pas
  # @return void		//ne renvoie rien
     def initialize(monApp, header, anciennePage, unJoueur, statue)

          super(monApp, :vertical, header,  anciennePage, unJoueur)

          @frame = Gtk::Table.new(1,1,false)

          if statue == "gagner"

            @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Menu/GameWin.png",:width=> monApp.width, :height=> monApp.height))
            @bg=(Gtk::Image.new(:pixbuf => @pix))

      	  end


          if statue == "perdu"

            @pix = (GdkPixbuf::Pixbuf.new(:file=>"./Assets/Menu/GameOver.png",:width=> monApp.width, :height=> monApp.height))
            @bg=(Gtk::Image.new(:pixbuf => @pix))

      	  end
          @frame.attach(@bg, 0,1,0,1)

          self.add(@frame)


     end

end
