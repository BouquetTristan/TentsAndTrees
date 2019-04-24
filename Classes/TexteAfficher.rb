#====== texte à afficher par champ donné
class TexteAfficher


  attr_accessor :gTexteAfficher
  attr_accessor :renvoie


  #création du texte à afficher
  # @param unTexte		//le texte du champ à remplir
  # @param unAffichage		//le remplissage du champ
  # @return void		//ne renvoie rien
     def TexteAfficher.creer(unTexte, unAffichage)
          new(unTexte, unAffichage)
     end

     #initialisiation texte à afficher
     # @param unTexte		//le texte du champ à remplir
     # @param unAffichage	//le remplissage du champ
     # @return void		//ne renvoie rien
     def initialize(unTexte, unAffichage)
          @gTexteAfficher=Gtk::Table.new(1,2, false)

          @label =  Gtk::Label.new("")
          @label.set_markup(("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">"+unTexte+"</span>\n"))
          @renvoie =  Gtk::Label.new("")
          @renvoie.set_markup(("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">"+unAffichage+"</span>\n"))

          @gTexteAfficher.attach(@label, 0,1,0,1)
          @gTexteAfficher.attach(@renvoie, 1,2,0,1)
     end


end
