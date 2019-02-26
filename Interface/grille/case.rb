class Case
  # une case est definit par sa position dans la grille de jeu et son etat
  attr_accessor:i
  attr_accessor:j
  attr_accessor:etat

  #etat etant 0 1 2 ou 3 :
  #0: case noir
  #1: case avec tente
  #2: case avec arbre
  #3: case avec herbe




  private_class_method:new
#methode de classe pour creer des objets case
  def Case.creer(x,y)
      new(x,y)
  end

  def initialize(x,y)
      @i=x
      @j=y
      @etat=0
  end
#correspond au moment ou changement d'etat dans une case au moment ou on joue la case  0->3 / 1->0 / 2->2 /3->1
  def jouerCase()
    if self.etat==0
      @etat=3
    elsif self.etat==1
      @etat=0
    elsif self.etat==2
      @etat=2
    elsif self.etat==3
      @etat=1
    end
  end
  #içi cette methode est bcp plus destiner a la programation si on veut changer de case en forçant le changement
  def changerEtat(etat)
    @etat=etat
  end
  #methode pour retourner une case pour moi retourner une case est retourner son etat
  def to_s()
    return @etat.to_s
  end
#fin de la classe Case
end
