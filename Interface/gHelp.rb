

class GHelp

	def GHelp.constuire(grille)
		new(grille)
	end

	def initialize(grille)

		@Label = Gtk::Label.new('Timer / afficher les aides')
		grille.attach(@Label, 0,1,0,1)

		@bAide = Gtk::Button.new('Aide')
		grille.attach(@bAide, 0,1,1,2)

		@Label = Gtk::Label.new('Bouton Pause')
		grille.attach(@Label, 0,1,2,3)

	end
end