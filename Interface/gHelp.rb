
require 'gtk3'

class GHelp

	def GHelp.constuire(grille)
		new(grille)
	end

	def initialize(grille)

		@Label = Gtk::Label.new('Timer / afficher les aides')
		grille.attach(@Label, 0,1,0,1)

		@bAide = Gtk::Button.new()
		@help=(Gtk::Image.new(:file =>"./image/help.png"))
		@bAide.set_image(@help)
		grille.attach(@bAide, 0,1,1,2)

		@bPause = Gtk::Button.new()
		@pause=(Gtk::Image.new(:file =>"./image/pause.png"))
		@bPause.set_image(@pause)
		grille.attach(@bPause, 0,1,2,3)

	end
end