require 'gtk3'

require './Page.rb'

class FWin < Page

     def initialize(monApp, header, anciennePage, unJoueur)

          super(monApp, :vertical, header,  anciennePage, unJoueur)

          @frame = Gtk::Table.new(1,1,false)
          
          @bg = (Gtk::Image.new(:file=>"../Assets/ImgWin.png"))

          @frame.attach(@bg, 0,1,0,1)

          self.add(@frame)


     end

end
