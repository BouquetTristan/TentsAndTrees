require 'gtk3'

require './Classes/Page.rb'


class FScore < Page

     def initialize(monApp, header, anciennePage, unJoueur)

     	super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:vertical)
    		
        @tScore = Gtk::ListStore.new(3, :string, :int, :string)

        @back = Gtk::Button.new(:label => 'Retour', :use_underline => nil)
        @back.set_relief(:none)


       @back.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all          
        }

        @box.add(@tScore)
        @box.add(@back)

        @frame.attach(@box,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"./Assets/ImgGame.jpg"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
