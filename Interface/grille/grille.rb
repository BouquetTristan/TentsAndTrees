##
# Auteur LeNomDeLEtudiant
# Version 0.1 : Date : Tue Feb 06 07:02:24 CET 2018
#
#	Une grille de jeu est une matrice de case(une case a un seul etat: blanche, noir ou barré)
#	Une grille de jeu est lié à une matrice(de 1 et 0) qui constitue le resultat final du jeu
#	pour savoir si le joueur a gagné, on compare la matrice des cases à la matrice resultat
#	la grille de jeu peut être sauvegardeé pour être repris ulterieurement

require_relative 'case.rb'

class Grille

  attr_accessor:taille
  attr_accessor:grille
  attr_accessor:fich
  attr_accessor:temp
  attr_accessor:tentesL
  attr_accessor:tentesC

  private_class_method:new
  #methode de classe pour creer des objets case
  def Grille.creer(taille,fich)
      new(taille,fich)
  end
  def initialize(taille,fich)

    @taille=taille-1

    @grille=[[]]
    @temp = 0
    @fich=fich
    @tentesL = []
    @tentesC = []

    for i in (0..@taille)
      temp=[]
      for j in (0..@taille)
        temp[j]=Case.creer(i,j)
      end
    @grille[i]=temp
    end


      fichTogrille()
      nbTentesLigne()
      nbTentesColonne()

  end #end of initialize


  def fichTogrille()
    i=-1
    j=0
      f=File.open(@fich,"r")
      f.each_line do |l|
          i +=1
        l.chomp.each_char do |c|

          @grille[i][j].changerEtat(c.to_i)
          j +=1
        end
          j =0

      end
      f.close
      return self
  end #end of fichTogrille



  def grilleTofich()

    f=File.open(@fich,"w")
  @grille.each do |x|
      temp=[]
    x.each do |i|
      temp.push(i.etat)
    end
    f.puts(temp.join.to_s)
  end
  f.close

  end#end of grilleTofich



  def afficheToi()
    @grille.each do |x|
      x.each do |i|
        print i.etat
      end
      puts
    end
  end #end of afficheToi

  def grCaseToGrille()
    tab=[[]]
    @grille.each do |x|
        temp=[]
      x.each do |y|
        temp.push(y.etat)
      end
      tab.push(temp)
    end
    return tab

  end#end grCaseToGrille

   def raz
     for i in (0..@taille)
       for j in (0..@taille)
         @grille[i][j].etat = 0
       end
     end
   end#end raz

end #end of the class Grille

def nbTentesLigne ()
	@grille.each do |ligne|
		nbTentes = 0
		ligne.each do |uneCase|
			if uneCase.etat == 1 then
				nbTentes += 1
			end
		end
		@tentesL.push(nbTentes)
	end
end

def nbTentesColonne ()
	for j in (0..@taille)
		nbTentes = 0
		for i in (0..@taille)
			if @grille[i][j].etat == 1 then
				nbTentes += 1
			end
		end
		@tentesC.push(nbTentes)
	end
end


#grilleJ = Grille.creer(6, "GrilleJ.txt")
#grilleF = Grille.creer(6, "GrilleF.txt")

#print grilleF.tentesL
#print grilleF.tentesC



