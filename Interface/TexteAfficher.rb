
class TexteAfficher
     def TexteAfficher.creer(unTexte, unAffichage)
          new(unTexte, unAffichage)
     end

     def initialize(unTexte, unAffichage)
          @gTexteAfficher=Gtk::Table.new(1,2, false)

          @label =  Gtk::Label.new(unTexte)
          @renvoie =  Gtk::Label.new(unAffichage)

          @gTexteAfficher.attach(@label, 0,1,0,1)
          @gTexteAfficher.attach(@renvoie, 1,2,0,1)
     end
     attr_accessor :gTexteAfficher
     attr_accessor :renvoie

end
