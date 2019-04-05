require 'gtk3'

require './TexteEntree'
require './Page.rb'

class FWin < Page

     def initialize(monApp, header, anciennePage, unJoueur)

          super(monApp, :vertical, header,  anciennePage, unJoueur)

          @frame = Gtk::Table.new(1,1,false)
          #super(monApp, :vertical, header,  anciennePage, unJoueur)

          label = Gtk::Label.new("Vous avez gagné !!!")

          @frame.attach(label,0,1,0,1)
		
          @frame.attach(@gConnexion, 0,1,0,1)

          @bg = (Gtk::Image.new(:file=>"../Assets/ImgPresentation2.jpg"))

          @frame.attach(@bg, 0,1,0,1)

          self.add(@frame)


     end

end
