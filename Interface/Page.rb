require "gtk3"

# Classe représentant une page

class Page < Gtk::Box

  attr_reader :hautPage, :btnRetour, :btnHome, :btnCompte, :enciennePage, :hautPage, :label , :couleur

  def initialize(unTitre, monApp, sens, unHeader, anciennePage)

    ##
    # Creation de la Gtk::Box
    super(sens)

    @hautPage = Gtk::Box.new(:horizontal)

    @label =  Gtk::Label.new(unTitre.to_s)
    @hautPage.add(@label, :expand => true, :fill => true)

    self.pack_start(@hautPage, :expand => false, :fill => true)

    self.spacing = 100

    @window = monApp
    @header = unHeader
    @enciennePage = enciennePage

    @header.btnRetour.signal_connect('clicked') {
      if (!anciennePage.eql?(nil)) then
        self.supprimeMoi
        anciennePage.ajouteMoi
        @window.show_all
      end
    }

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