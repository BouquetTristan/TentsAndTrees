<img src="./Assets/Autres/ImgPresentation.jpg" width="1500" align="center">

# Des arbres et des tentes

## Description du Projet


Notre projet, qui se déroule dans le cadre de notre deuxième semestre de troisième année de licence Informatique, a pour but de nous faire programmer en langage Ruby une version, fonctionnelle sur une interface dont les spécificitées seront précisées par nos professeurs en charge du projet, de ce jeu. Notre équipe se compose de **MATHEY Benjamin (Chef de projet), DAD Aurélien (Documentaliste), AKRATE El Mehdi, BOUQUET Tristan, JOLLIET Corentin, MARCHAND Killian, PAULMERY Yann, SEMAMRA Kévin**.<br/>

Pour suivre l'avancement du projet, c'est ici -> https://trello.com/b/JAVYpZdL/todo-list-des-arbres-et-des-tentes


## Description du jeu

### Comment lancer le jeu
Mettez vous dans le répertoire TentsAndTrees. </br>
Pour lancer le jeu vous devez exécuter la commande "bundle" dans un terminal (mise à jour et installation des gems utilisées). </br>
Une fois cette première étape effectué, vous devez executer la commande "rake" dans ce même terminal. </br>

### Règles
Des arbres et des tentes est un jeu où le joueur doit compléter une grille en plaçant des tentes et de l'herbe. Les arbres sont présents de base sur la grille et le joueur doit assigner à chaque arbre une tente. La tente doit se trouver sur une case adjacente mais pas en diagonale. Enfin, le joueur doit respecter le nombre de tente que doit comporter les lignes et les colonnes de la grille.<br/>

### Description de notre jeu
Nous avons décidé de créer un jeu familial et détente. <br/>
- Le premier mode de jeu est nommé "Classique" et permet au joueur de jouer sur une grille de niveau aléatoire pour son simple plaisir. Le joueur dispose d'aide gratuite et illimitée pour finir la grille plus facilement.<br/>
- Le deuxième mode est l'Aventure et demande au joueur de réussir des grilles dans un temps imparti pour continuer à avancer dans ce mode de jeu. Cependant, le joueur ne subit aucun malus s'il ne réussit pas à terminer la grille à temps sauf celui de devoir la recommencer. En terminant des grilles, le joueur gagne des étoiles après avoir terminé une grille pour la première fois qui serviront à acheter les autres niveaux. A chaque niveau terminé entièrement, le joueur augmente son crédit d'aide pour le mode compétition.<br/>
  Un niveau bonus est activé après avoir fini toutes les grilles.<br/>
- Enfin, le troisième et dernier mode de jeu est nommé "Compétition" qui donne la possibilité au joueur de choisir un niveau de difficulté parmis trois (Facile, Moyen, Difficile) et une grille est affichée sans le nombre de tente sur les lignes et les colonnes. Le joueur a la possibilité de l'accepter ou d'en trouver une autre, aléatoirement. Les aides coûtent un nombre de feuille mais donnent de gros bonus pour terminer la grille plus facilement. A la fin de la partie, un score est calculé à la fin et les meilleurs scores sont affichés dans une page de l'accueil.<br/>

### L'histoire de notre jeu
Nous avons créé une petite histoire pour le mode aventure afin de donner une meilleure expérience de jeu à l'utilisateur. Ce mode aventure est divisé en 4 niveaux de 6 tableaux chacun et un niveau caché. Chaque niveau représente une saison (Printemps, Eté, Automne, Hiver) et le dernier tableau est une grille très difficile permettant aux joueurs d'avoir un sentiment s'accomplissement après l'avoir fini.<br/>
Un niveau bonus est un niveau pollué, il est là pour sensibiliser le public à la normalisation de la pollution dans la nature. Les gens voient la pollution devenir une part du paysage alors nous décideons de les récompenser avec ce qu'il pense être normal.<br/>
