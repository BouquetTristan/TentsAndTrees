require 'gtk3'
require './TexteEntree'
require './Page.rb'

class FModifC < Page

	def initialize(monApp, header, anciennePage)

		super("Modifier votre compte", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220

		@gModifC = Gtk::ButtonBox.new(:vertical)
          @gModifC.spacing = 30

          @pseudo = TexteEntree.creer('Pseudo : ', false)
          @mdp = TexteEntree.creer('Mot de passe : ', true)
          @question =  Gtk::Label.new('Quel est votre lieux de vacances préféré?')
          @reponse = TexteEntree.creer('Reponse : ', true)
          @valider = Gtk::Button.new(:label => 'Valider les modifications', :use_underline => nil, :stock_id => nil)

          @gModifC.add(@pseudo.gTexteEntree, :expand => true, :fill => false)
          @gModifC.add(@mdp.gTexteEntree, :expand => true, :fill => false)
          @gModifC.add(@question, :expand => true, :fill => false)
          @gModifC.add(@reponse.gTexteEntree, :expand => true, :fill => false)
          @gModifC.add(@valider, :expand => true, :fill => false)

		@pseudo.entree.text = 

		@valider.signal_connect('clicked') {


			joueur = Joueur.new(@pseudo.entree.text, @mdp.entree.text, @reponse.entree.text)

			puts("OK nouveau joueur\n")
			if (@pseudo.entree.text == '' || @mdp.entree.text == '')
				#@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
				@mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur entrer un pseudo et un mot de passe</span>\n")
			end
			if (@reponse.entree.text =='')
				#@pseudo.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">/!\\ Erreur entrer un pseudo et un mot de passe</span>\n")
				@reponse.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Répondez a la question</span>\n")

			elsif joueur.inscrire() == 0 then
				puts("Joueur\n")
				@mdp.entree.text = ''
				puts("mdp sans rien\n")
				@mdp.erreur.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 10\">Erreur L'utilisateur est déjà enregistré</span>\n")


			else
				self.supprimeMoi
				suivant = FMenu.new(@window, header, self)
				suivant.ajouteMoi
				@window.show_all
			end
		}

		self.add(@gModifC)

	end

end
