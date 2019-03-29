



class TexteEntree

     def TexteEntree.creer(unTexte, erreur)
          new(unTexte, erreur)
     end

     def initialize(unTexte, erreur)
          @gTexteEntree=Gtk::Table.new(2,3, false)

          @label =  Gtk::Label.new(unTexte)
          @entree =  Gtk::Entry.new
          if (erreur == true)
               @erreur =  Gtk::Label.new()

               @gTexteEntree.attach(@erreur,1,2,1,2)
          end
          @gTexteEntree.attach(@label, 0,1,0,1)
          @gTexteEntree.attach(@entree, 1,2,0,1)



     end
     attr_accessor :entree
     attr_accessor :gTexteEntree
     attr_accessor :erreur

end
