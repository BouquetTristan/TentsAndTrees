require 'gtk3'

require './Page.rb'


class FScore < Page

     def initialize(monApp, header, anciennePage, unJoueur)

     	super(monApp, :vertical, header,  anciennePage, unJoueur)

        @frame = Gtk::Table.new(1,1,false)

        @box = Gtk::ButtonBox.new(:vertical)
    		
        @tScore = Gtk::Table.new(3,5,false)

        @back = Gtk::Button.new(:label => 'Retour', :use_underline => nil)
        @back.set_relief(:none)

        @box.add(@tScore)
        @box.add(@back)

        @tScore.each{|k|
            k.each{|m|
              puts('1')
                
                if k==0
                    label=Gtk::Label.new("")
                    label.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">test</span>\n")
                    @tScore.attach(label, m,m+1,k,k+1)    
                end
              puts('2')
                if m==0
                    label1=Gtk::Label.new("")
                    label1.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">test</span>\n")
                    @tScore.attach(label1, m,m+1,k,k+1) 
                end
              puts('3')
            }
        }

        @back.signal_connect('clicked') {
               self.supprimeMoi
               suivant = FMenu.new(@window, header, self, unJoueur)
               suivant.ajouteMoi
               @window.show_all          
        }


        @frame.attach(@box,0,1,0,1)

        @bg=(Gtk::Image.new(:file =>"../Assets/ImgGame2.png"))
        @frame.attach(@bg,0,1,0,1)

        self.add(@frame)
    end
end
