require 'gtk3'
require './TexteEntree'
require './Page.rb'

class FModifC < Page

	def initialize(monApp, header, anciennePage)

		super("Modifier votre compte", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220


		@gModifC = Gtk::ButtonBox.new(:vertical)
		@gModifC.spacing = 30


		@pseudo = TexteEntree.creer('Pseudo : ', true).gTexteEntree
        @mdp = TexteEntree.creer('Mot de passe : ', false).gTexteEntree
        @question =  Gtk::Label.new('Quel est votre lieux de vacance préféré?')
        @reponse = TexteEntree.creer('Reponse : ', false).gTexteEntree


		@gModifC.add(@pseudo, :expand => true, :fill => false)
        @gModifC.add(@mdp, :expand => true, :fill => false)
        @gModifC.add(@question, :expand => true, :fill => false)
        @gModifC.add(@reponse, :expand => true, :fill => false)

		self.add(@gModifC)

	end

end

