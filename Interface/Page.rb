require "gtk3"

# Classe représentant une page

class Page <  Gtk::Box 

  attr_reader :hautPage, :btnRetour, :btnHome, :btnCompte, :enciennePage, :hautPage, :label , :couleur

  def initialize(monApp, sens, unHeader, anciennePage)

    ##
    # Creation de la Gtk::Box
    super(sens)

    @window = monApp
    @header = unHeader
    @enciennePage = enciennePage

  end

  ##
  # Methode pour ajouter l'objet actuelle a la fenetre
  def ajouteMoi
    @window << self
  end

  def supprimeMoi
    @window.each{ |children|
      unless children.class.eql?(Header) then
        @window.remove(children)
      end
    }
  end

  def detruitMoi
    @window.each{ |children|
      unless children.class.eql?(Header) then
        children.destroy
      end
    }
  end

end