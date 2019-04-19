require 'gtk3'

#====== La classe chronoInverse représente un compte à rebours conçu pour être utilisé en thread ( en parallèle du programme princpal pour chronomètrer une partie)

class ChronoInverse
	#= Variables d'instance
	# @initial		:Stock le temps initial du chrono
	# @start		: boolean en false au lancement du chrono et passe en true lors du premier tosu de boucle.
	# @pause		: boolean met en pause le chrono
	# @chrono		: variable qui stockera le nombre de seconde actuel et qui servira à afficher.
	# @lChrono  : label affichant le chono.

	attr_accessor :start
	attr_accessor :pause
	attr_accessor :chrono
	attr_accessor :lChrono


	#initialise les variables à 0 et a false et mémorise le temps initial dans la variable @initialize
	# @param temps		//Prend un temps de départ en paramètre
	# @return void		//ne renvoie rien
	def initialize(temps)
		@initial=temps
		@start=false
		@pause=false
		@chrono=temps
		@fin=false
		@lChrono=Gtk::Label.new("")
	end

	#lance le chrono qui se terminera uniquement en appelant la méthode fin()
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
	def cStart


			while @chrono >= 0

						if @start==false
							@compteur=@initial
							@start=true
							@lChrono.set_markup(("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">"+@chrono.to_s+"</span>\n"))
						end

						if @pause != true
							sleep(1)
							@chrono -= 1
						end

						@lChrono.set_markup(("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">"+@chrono.to_s+"</span>\n"))


			end
			if @chrono <= 0
				@chrono=0
				@lChrono.set_markup(("<span foreground=\"#FFFFFF\" font-desc=\"Courier New bold 20\">"+@chrono.to_s+"</span>\n"))

			end

	end

	#change la valeur de la variable @pause en true ou en false mettant le chrono en pause ou le faisant repartir
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
	def cPause()
		if @pause==true
			@pause=false
		else
			@pause=true
		end
	end

	#relance le chrono dans sa configuration initiale
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
	def cRaz()
		@start=false
		@pause=false
	end

	#retire n seconde au chrono
	# @param void 		//le nombre de scondes à retirer
	# @return void		//ne renvoie rien
	def cRetire(n)
		@chrono-=n
	end

	# #met la variable @fin sur true ce qui à pour effet de mettre un terme au chrono
	# # @param void		//ne prend aucun paramètre
	# # @return void		//ne renvoie rien
	# def cFin()
	# 	@fin=true
	# end

	#Traduction des secondes en heures/minutes/secondes
	# @param void		//ne prend aucun paramètre
	# @return temps	//Retourne le temps sous format h:m:s
	def to_s

			heures = @chrono/3600
			minutes = (@chrono - (heures*3600)) / 60
			secondes = @chrono - (heures*3600) - (minutes*60)

			h = heures < 10 ? "0" + heures.to_s : heures.to_s
			m = minutes < 10 ? "0" + minutes.to_s : minutes.to_s
			s = secondes < 10 ? "0" + secondes.to_s : secondes.to_s

			return h + ":" + m + ":" + s + "\n"
	end

end # Marqueur de fin de classe
