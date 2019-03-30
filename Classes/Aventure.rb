
require_relative 'Grille.rb'



def tableauPrintemps()
  tab=[]
  for i in 1..6
    tab<<Grille.creer("Facile",2*i)
  end
    return tab
end

def tableauHiver()
  tab=[]
  for i in 1..6
    tab<< Grille.creer("Moyenne",2*i)
  end
    return tab
end

def tableauEte()
  tab=[]
  for i in 1..6
    tab<< Grille.creer("Difficile",2*i)
  end
  return tab
end

def tableauAutomne()
  tab=[]
  for i in 1..6
    tab<< Grille.creer("Facile",2*i+1)
  end
    return tab
end
