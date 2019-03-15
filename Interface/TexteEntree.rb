



class TexteEntree

     def TexteEntree.creer(unTexte, erreur)
          new(unTexte, erreur)
     end

     def initialize(unTexte, erreur)
          @gTexteEntree=Gtk::Table.new(1,3, false)

          @label =  Gtk::Label.new(unTexte)
          @entree =  Gtk::Entry.new
          if (erreur == true)
               @erreur =  Gtk::Label.new("Erreur mot de passe ou identifiant incorrect")
               @gTexteEntree.attach(@erreur,2,3,0,1)
          end
          @gTexteEntree.attach(@label, 0,1,0,1)
          @gTexteEntree.attach(@entree, 1,2,0,1)



     end
     attr_accessor :gTexteEntree

end
