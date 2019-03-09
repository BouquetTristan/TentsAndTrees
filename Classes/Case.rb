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
  def Case.creer(x,y, etat)
      new(x,y, etat)
  end

  #Temporaire, l'état passe de caractères à des entiers
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

  #Renvoie un tableau contenant les cases adjacentes de la case
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
