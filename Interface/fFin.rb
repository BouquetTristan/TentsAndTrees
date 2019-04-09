require 'gtk3'

require './Page.rb'

class FFin < Page

     def initialize(monApp, header, anciennePage, unJoueur, statue)

          super(monApp, :vertical, header,  anciennePage, unJoueur)

          @frame = Gtk::Table.new(1,1,false)

          if statue == "gagner"
          
        	  @bg = (Gtk::Image.new(:file=>"../Assets/GameWin.png"))

      	  end


          if statue == "perdu"
          
        	  @bg = (Gtk::Image.new(:file=>"../Assets/GameOver.png"))

      	  end
          @frame.attach(@bg, 0,1,0,1)

          self.add(@frame)


     end

end
