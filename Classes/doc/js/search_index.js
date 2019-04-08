var search_data = {"index":{"searchIndex":["aide","case","chrono","chronoinverse","grille","score","affichergrille()","arbreangleherbe()","arbretenteplacer()","cajout()","cfin()","cfin()","cpause()","cpause()","craz()","craz()","cretire()","cstart()","cstart()","calculerscore()","caseestdelherbe()","casesvoisines()","casesvoisinescomplet()","changeretat()","charger()","colonnecompleterherbes()","colonneplacertentes()","creer()","creer()","creer()","creerd()","enregistrerfichier()","erreur()","jouercase()","lignecompleterherbes()","ligneplacertentes()","new()","new()","new()","new()","new()","observateur()","parcourirc()","parcourirh()","parcourirl()","tentecontourcompleter()","tentesplacer()","to_s()","to_s()","to_s()","triscores()"],"longSearchIndex":["aide","case","chrono","chronoinverse","grille","score","grille#affichergrille()","aide::arbreangleherbe()","aide::arbretenteplacer()","chrono#cajout()","chrono#cfin()","chronoinverse#cfin()","chrono#cpause()","chronoinverse#cpause()","chrono#craz()","chronoinverse#craz()","chronoinverse#cretire()","chrono#cstart()","chronoinverse#cstart()","score#calculerscore()","aide::caseestdelherbe()","case#casesvoisines()","case#casesvoisinescomplet()","case#changeretat()","grille::charger()","aide::colonnecompleterherbes()","aide::colonneplacertentes()","case::creer()","grille::creer()","score::creer()","grille::creerd()","grille#enregistrerfichier()","aide::erreur()","case#jouercase()","aide::lignecompleterherbes()","aide::ligneplacertentes()","case::new()","chrono::new()","chronoinverse::new()","grille::new()","score::new()","grille#observateur()","grille#parcourirc()","grille#parcourirh()","grille#parcourirl()","aide::tentecontourcompleter()","aide::tentesplacer()","case#to_s()","chrono#to_s()","chronoinverse#to_s()","score::triscores()"],"info":[["Aide","","Aide.html","","<p>La classe Aide contient des méthodes qui évaluent l&#39;état de la grille du joueur\n"],["Case","","Case.html","","<p>une case est definit par sa position dans la grille de jeu et son etat\n"],["Chrono","","Chrono.html","","<p>La classe chrono représente un chronomètre conçu pour être utilisé en thread ( en parallèle du programme …\n"],["ChronoInverse","","ChronoInverse.html","","<p>La classe chronoInverse représente un compte à rebours conçu pour être utilisé en thread ( en parallèle …\n"],["Grille","","Grille.html","","<p>La classe grille contient des informations relatives à une grille, ainsi qu&#39;une grille actuelle et …\n"],["Score","","Score.html","","<p>La Classe Score définie les critère de calcul du score en fonction de la grille etc\n"],["afficherGrille","Grille","Grille.html#method-i-afficherGrille","(grille)","<p>Affiche la grille de jeu (sans le nombre de tentes)\n\n<pre>@param grille                //Grille de jeu\n@return ...</pre>\n"],["arbreAngleHerbe","Aide","Aide.html#method-c-arbreAngleHerbe","(grille)","<p>Vérifie si un des angles de chaque arbre est obligatoirement de l&#39;herbe\n\n<pre>@param grille             ...</pre>\n"],["arbreTentePlacer","Aide","Aide.html#method-c-arbreTentePlacer","(grille)","<p>Vérifie pour chaque arbre si il ne reste qu&#39;une possibilité pour placer\nune tente\n\n<pre>@param grille   ...</pre>\n"],["cAjout","Chrono","Chrono.html#method-i-cAjout","(n)","<p>ajoute n seconde au chrono\n\n<pre>@param n             //nombre de secondes à ajouter au chrono\n@return void ...</pre>\n"],["cFin","Chrono","Chrono.html#method-i-cFin","()","<p>met la variable @fin sur true ce qui à pour effet de mettre un terme au\nchrono\n\n<pre>@param void          //ne ...</pre>\n"],["cFin","ChronoInverse","ChronoInverse.html#method-i-cFin","()","<p>met la variable @fin sur true ce qui à pour effet de mettre un terme au\nchrono\n\n<pre>@param void          //ne ...</pre>\n"],["cPause","Chrono","Chrono.html#method-i-cPause","()","<p>change la valeur de la variable @pause en true ou en false mettant le\nchrono en pause ou le faisant repartir …\n"],["cPause","ChronoInverse","ChronoInverse.html#method-i-cPause","()","<p>change la valeur de la variable @pause en true ou en false mettant le\nchrono en pause ou le faisant repartir …\n"],["cRaz","Chrono","Chrono.html#method-i-cRaz","()","<p>relance le chrono dans sa configuration initiale\n\n<pre>@param void          //ne prend aucun paramètre\n@return ...</pre>\n"],["cRaz","ChronoInverse","ChronoInverse.html#method-i-cRaz","()","<p>relance le chrono dans sa configuration initiale\n\n<pre>@param void          //ne prend aucun paramètre\n@return ...</pre>\n"],["cRetire","ChronoInverse","ChronoInverse.html#method-i-cRetire","(n)","<p>retire n seconde au chrono\n\n<pre>@param void          //le nombre de scondes à retirer\n@return void         ...</pre>\n"],["cStart","Chrono","Chrono.html#method-i-cStart","()","<p>lance le chrono qui se terminera uniquement en appelant la méthode fin()\n\n<pre>@param void          //ne prend ...</pre>\n"],["cStart","ChronoInverse","ChronoInverse.html#method-i-cStart","()","<p>lance le chrono qui se terminera uniquement en appelant la méthode fin()\n\n<pre>@param void          //ne prend ...</pre>\n"],["calculerScore","Score","Score.html#method-i-calculerScore","(tempsRestant)","<p>Calcule le score en fonction de la difficulté, du temps restant et du\nnombre de feuilles restantes\n\n<pre>@param ...</pre>\n"],["caseEstDeLHerbe","Aide","Aide.html#method-c-caseEstDeLHerbe","(grille)","<p>Vérifie si une case n&#39;est pas adjacente à un arbre\n\n<pre>@param grille        //La grille de jeu\n@return ...</pre>\n"],["casesVoisines","Case","Case.html#method-i-casesVoisines","(grille)","<p>Renvoie un tableau contenant les cases adjacentes de la case\n\n<pre>@param grille    //Prend en paramètre la ...</pre>\n"],["casesVoisinesComplet","Case","Case.html#method-i-casesVoisinesComplet","(grille)","<p>Renvoie un tableau contenant les cases voisines de la case\n\n<pre>@param grille //Prend en paramètre la grille ...</pre>\n"],["changerEtat","Case","Case.html#method-i-changerEtat","(etat)","<p>Cette méthode est destiné à la programmation, elle consiste à forcer\nl&#39;état d&#39;une case\n\n<pre>@param ...</pre>\n"],["charger","Grille","Grille.html#method-c-charger","(diff, num)","<p>Charge une grille sauvegardée lors d&#39;une partie\n\n<pre>@param diff         //difficulté de la grille\n@param ...</pre>\n"],["colonneCompleterHerbes","Aide","Aide.html#method-c-colonneCompleterHerbes","(grille)","<p>Parcourt chaque colonne de la grille du joueur et repère les colonnes qui\ndoivent être remplies par des …\n"],["colonnePlacerTentes","Aide","Aide.html#method-c-colonnePlacerTentes","(grille)","<p>Vérifie si il est possible de placer au moins une tente dans la ligne\n\n<pre>@param grille                //Prend ...</pre>\n"],["creer","Case","Case.html#method-c-creer","(x,y, etat)","<p>methode de classe pour creer des objets case\n\n<pre>@param x     //Coordonnée x d&#39;une case\n@param y     //Coordonnée ...</pre>\n"],["creer","Grille","Grille.html#method-c-creer","(diff, num)","<p>Créé une grille avec une difficulté et un numéro\n\n<pre>@param diff          //difficulté de grille\n@param num ...</pre>\n"],["creer","Score","Score.html#method-c-creer","(diff, nbF)","<p>Création d&#39;un score\n\n<pre>@param diff          //difficulté de la grille\n@param nbF           //nombre de ...</pre>\n"],["creerD","Grille","Grille.html#method-c-creerD","(diff)","<p>Créé une grille avec un niveau de difficulté\n\n<pre>@param diff          //difficulté de grille\n@return void ...</pre>\n"],["enregistrerFichier","Grille","Grille.html#method-i-enregistrerFichier","()","<p>Enregistre la grille dans un fichier en transformant les informations\nconcernant l&#39;état des case …\n"],["erreur","Aide","Aide.html#method-c-erreur","(grille)","<p>Parcourt la grille du joueur et la grille finale pour repérer les erreurs\nde placement\n\n<pre>@param grille  ...</pre>\n"],["jouerCase","Case","Case.html#method-i-jouerCase","()","<p>correspond au changement d&#39;etat dans une case au moment ou on joue la\ncase  0-&gt;3 / 1-&gt;0 / 2-&gt;2 …\n"],["ligneCompleterHerbes","Aide","Aide.html#method-c-ligneCompleterHerbes","(grille)","<p>Parcourt chaque ligne de la grille du joueur et repère les lignes qui\ndoivent être remplies par des herbes …\n"],["lignePlacerTentes","Aide","Aide.html#method-c-lignePlacerTentes","(grille)","<p>Vérifie si il est possible de placer au moins une tente dans la ligne\n\n<pre>@param grille                //Prend ...</pre>\n"],["new","Case","Case.html#method-c-new","(x,y, etat)","<p>reçoit une position et un état\n\n<pre>@param x     //Coordonnée x d&#39;une case\n@param y     //Coordonnée y d&#39;une ...</pre>\n"],["new","Chrono","Chrono.html#method-c-new","()","<p>initialise les variables à 0 et a false\n\n<pre>@param void          //ne prend aucun paramètre\n@return void  ...</pre>\n"],["new","ChronoInverse","ChronoInverse.html#method-c-new","(temps)","<p>initialise les variables à 0 et a false et mémorise le temps initial dans\nla variable @initialize\n\n<pre>@param ...</pre>\n"],["new","Grille","Grille.html#method-c-new","(diff, num)","<p>Méthode d&#39;initialisation\n\n<pre>@param diff          //difficulté de grille\n@param num           //numéro ...</pre>\n"],["new","Score","Score.html#method-c-new","(diff, nbF)","<p>Initialisation\n\n<pre>@param diff          //difficulté de la grille\n@param nbF           //nombre de feuille ...</pre>\n"],["observateur","Grille","Grille.html#method-i-observateur","()","<p>Observateur pour savoir si l&#39;utilisateur a gagner\n\n<pre>@param void          //ne prend aucun paramètre ...</pre>\n"],["parcourirC","Grille","Grille.html#method-i-parcourirC","()","<p>Parcours par colonne de la grille\n\n<pre>@param void         //ne prend aucun paramètre\n@return void         ...</pre>\n"],["parcourirH","Grille","Grille.html#method-i-parcourirH","()","<p>Parcours horizonta par case de la grille\n\n<pre>@param void         //ne prend aucun paramètre\n@return void  ...</pre>\n"],["parcourirL","Grille","Grille.html#method-i-parcourirL","()","<p>Parcours par ligne de la grille\n\n<pre>@param void         //ne prend aucun paramètre\n@return void           ...</pre>\n"],["tenteContourCompleter","Aide","Aide.html#method-c-tenteContourCompleter","(grille)","<p>Vérifie si les cases autour des tentes sont complétées\n\n<pre>@param grille                //Prend la grille ...</pre>\n"],["tentesPlacer","Aide","Aide.html#method-c-tentesPlacer","(grille, ligne, nLigne)","<p>Vérifie si le nombre de tente placable maximum sur la ligne est égale aux\nnombres de tentes restantes …\n"],["to_s","Case","Case.html#method-i-to_s","()","<p>methode pour retourner une case (son Etat)\n\n<pre>@param void    //Ne prend aucun paramètre\n@return etat    //Renvoie ...</pre>\n"],["to_s","Chrono","Chrono.html#method-i-to_s","()","<p>Traduction des secondes en heures/minutes/secondes\n\n<pre>@param void          //ne prend aucun paramètre\n@return ...</pre>\n"],["to_s","ChronoInverse","ChronoInverse.html#method-i-to_s","()","<p>Traduction des secondes en heures/minutes/secondes\n\n<pre>@param void          //ne prend aucun paramètre\n@return ...</pre>\n"],["triScores","Score","Score.html#method-c-triScores","(tabScores)","<p>Tri les scores par ordre décroissant\n\n<pre>@param tabScores             //tableau comportant les scores\n@return ...</pre>\n"]]}}