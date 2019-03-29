require_relative 'Score.rb'



score1 = Score.creer("Facile", 15)
score2 = Score.creer("Facile", 0)
score3 = Score.creer("Facile", 20)
score4 = Score.creer("Facile", 3)

tabS = [score1, score2, score3, score4]
tabSF = []

tabSF<<score1.calculerScore(50)<<score2.calculerScore(70)<<score3.calculerScore(20)<<score4.calculerScore(50)

print Score.triScores(tabSF)
