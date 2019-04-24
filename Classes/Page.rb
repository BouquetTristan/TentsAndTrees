require "gtk3"

# Classe représentant une page

class Page < Gtk::Box

  attr_reader :hautPage, :btnRetour, :btnHome, :btnCompte, :enciennePage, :hautPage, :label , :couleur, :window


  #Initialise la page
	# @param monApp		//l'application
	# @param sens    //orientation de le page (vertical/horizontal)
  # @param unHeader		//le titre de la page
  # @param anciennePage		//Le lien de la dernière page
  # @param unJoueur		//le joueur concerné
	# @return void			//ne renvoie rien
  def initialize(monApp, sens, unHeader, anciennePage, unJoueur)

    ##
    # Creation de la Gtk::Box
    super(sens)

    @window = monApp.window
    @header = unHeader
    @enciennePage = enciennePage

  end


  #Methode pour ajouter l'objet actuelle a la fenetre
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
  def ajouteMoi
    @window << self
  end

  #supprime les fenètre fille
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
  def supprimeMoi
    @window.each{ |children|
      unless children.class.eql?(Header) then
        @window.remove(children)
      end
    }
  end

  #Methode pour détruire les fenêtre fille
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
  def detruitMoi
    @window.each{ |children|
      unless children.class.eql?(Header) then
        children.destroy
      end
    }
  end

end
