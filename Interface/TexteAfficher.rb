
class TexteAfficher
     def TexteAfficher.creer(unTexte)
          new(unTexte)
     end

     def initialize(unTexte)
          @gTexteAfficher=Gtk::Table.new(1,2, false)

          @label =  Gtk::Label.new(unTexte)
          @renvoie =  Gtk::Label.new("resultat")

          @gTexteAfficher.attach(@label, 0,1,0,1)
          @gTexteAfficher.attach(@renvoie, 1,2,0,1)
     end
     attr_accessor :gTexteAfficher

end
