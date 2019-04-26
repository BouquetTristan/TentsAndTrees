#====== une case est definie par sa position dans la grille de jeu et son état

class Case

  #=Variable d'instance
  # @i     : Coordonnée x de la case
  # @j     : Coordonnée y de la case
  # @etat  : 0 1 2 ou 3
  # - 0 : case noir
  # - 1 : case avec tente
  # - 2 : case avec arbre
  # - 3 : case avec herbe

  attr_accessor:j
  attr_accessor:etat
  attr_accessor:i

  private_class_method:new


#méthode de classe pour créer des objets case
# @param x     //Coordonnée x d'une case
# @param y     //Coordonnée y d'une case
# @param etat   //Une lettre symbolisant un état
# @return void  //ne renvoie rien
  def Case.creer(x,y, etat)
      new(x,y, etat)
  end


  #reçoit une position et un état
  # @param x     //Coordonnée x d'une case
  # @param y     //Coordonnée y d'une case
  # @param etat   //Une lettre symbolisant un état
  # @return void  //ne renvoie rien
  def initialize(x,y, etat)
      @i=x
      @j=y
      case etat
        when "V" then
          @etat= 0
        when "T" then
          @etat = 1
        when "A" then
          @etat = 2
        when "H" then
          @etat = 3
      end
  end


#correspond au changement d'etat dans une case au moment où on joue la case  0->3 / 1->0 / 2->2 /3->1
# @param void    //Ne prend aucun paramètre
# @return void     //modifie l'état de la case en fonction de son état actuel
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


  #Cette méthode est destinée à la programmation, elle consiste à forcer l'état d'une case
  # @param etat    //Prend en paramètre un état
  # @return void     //Ne renvoie rien
  def changerEtat(etat)
    @etat=etat
  end


  #methode pour retourner une case (son Etat)
  # @param void    //Ne prend aucun paramètre
  # @return etat    //Renvoie l'état de la case
  def to_s()
    return @etat.to_s
  end


  #Renvoie un tableau contenant les cases adjacentes de la case
  # @param grille    //Prend en paramètre la grille du jeu
  # @return tab     //renvoie un tableau contenant les cases voisines adjacentes
  def casesVoisines (grille)

    tab = []

    #case en haut
    if i - 1 >= 0 then
      tab<<(grille.grilleJ[i-1][j])
    end

    #case en bas
    if i + 1 < grille.taille then
      tab<<(grille.grilleJ[i+1][j])
    end

    #case à gauche
    if j - 1 >= 0 then
      tab<<(grille.grilleJ[i][j-1])
    end

    #case à droite
    if j + 1 < grille.taille then
      tab<<(grille.grilleJ[i][j+1])
    end

    return tab
  end

  #Renvoie un tableau contenant les cases voisines de la case
  # @param grille //Prend en paramètre la grille du jeu
  # @return tab   //renvoie un tableau comportant les cases voisine adjacent et les cases voisines en diagonal
  def casesVoisinesComplet (grille)
    tab = self.casesVoisines(grille)

     #case en haut à gauche
    if i - 1 >= 0 && j - 1 >= 0 then
      tab<<(grille.grilleJ[i-1][j-1])
    end

    #case en haut à droite
    if i - 1 >= 0 && j + 1 < grille.taille then
      tab<<(grille.grilleJ[i-1][j+1])
    end

    #case en bas à gauche
    if i + 1 < grille.taille && j - 1 >= 0 then
      tab<<(grille.grilleJ[i+1][j-1])
    end

    #case en bas à droite
    if i + 1 < grille.taille && j + 1 < grille.taille then
      tab<<(grille.grilleJ[i+1][j+1])
    end

    return tab
  end

#fin de la classe Case
end
