
class TexteAfficher
     def TexteAfficher.creer(unTexte, unAffichage)
          new(unTexte, unAffichage)
     end

     def initialize(unTexte, unAffichage)
          @gTexteAfficher=Gtk::Table.new(1,2, false)

          @label =  Gtk::Label.new("")
          @label.set_markup(("<span foreground=\"#0066FF\" font-desc=\"Courier New bold 20\">"+unTexte+"</span>\n"))
          @renvoie =  Gtk::Label.new("")
          @renvoie.set_markup(("<span foreground=\"#0020FF\" font-desc=\"Courier New bold 20\">"+unAffichage+"</span>\n"))

          @gTexteAfficher.attach(@label, 0,1,0,1)
          @gTexteAfficher.attach(@renvoie, 1,2,0,1)
     end
     attr_accessor :gTexteAfficher
     attr_accessor :renvoie

end
