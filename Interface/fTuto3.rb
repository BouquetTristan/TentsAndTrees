require 'gtk3'

require './Page.rb'
require './fDidact.rb'


class Ftuto3 < Page

     def initialize(monApp, header, anciennePage)

     	super(monApp, :vertical, header,  anciennePage)

        @frame = Gtk::Table.new(1,1,false)
    		@gImage = Gtk::ButtonBox.new(:vertical)

          @tuto = (Gtk::Image.new(:file =>"./image/Didacticiel/Tuto3.png"))
    		  
    		@gImage.add(@tuto, :expand => true, :fill => false)

        @back = Gtk::Button.new(:label => 'Retour', :use_underline => nil, :stock_id => nil)
        @gImage.add(@back, :expand => true, :fill => false)
      
        @back.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FDidac.new(@window, header, self)
               suivant.ajouteMoi
               @window.show_all          
        }

        @frame.attach(@gImage,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"../Assets/ImgPresentation2.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end

