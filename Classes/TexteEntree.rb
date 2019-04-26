#====== message d'erreur par champ donné



class TexteEntree

  attr_accessor :entree
  attr_accessor :gTexteEntree
  attr_accessor :erreur


  #création du texte à entrer
  # @param unTexte		//le texte du champ à remplir
  # @param erreur		//l'erreur à afficher en cas de problème
  # @return void		//ne renvoie rien
     def TexteEntree.creer(unTexte, erreur)
          new(unTexte, erreur)
     end


     #initialisation du texte à afficher
     # @param unTexte		//le texte du champ à remplir
     # @param erreur		//l'erreur à afficher en cas de problème
     # @return void		//ne renvoie rien
     def initialize(unTexte, erreur)
          @gTexteEntree=Gtk::Table.new(2,3, false)

          @label =  Gtk::Label.new("")
          @label.set_markup("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 11\">"+unTexte+"</span>")
          @entree =  Gtk::Entry.new
          if (erreur == true)
               @erreur =  Gtk::Label.new()

               @gTexteEntree.attach(@erreur,1,2,1,2)
          end
          @gTexteEntree.attach(@label, 0,1,0,1)
          @gTexteEntree.attach(@entree, 1,2,0,1)



     end


end
