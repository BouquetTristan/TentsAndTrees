require 'gtk3'
require './IGrille.rb'
require './gHelp.rb'



class FPlay < Gtk::Builder

	def FPlay.construire(taille)
		new(taille)
	end

	def initialize(taille)

		@fPlay = Gtk::Window.new
		@fPlay.set_default_size(600,400)
		@fPlay.border_width=5
		#fenetre.set_window_position(Gtk::Window::CENTER)
		
		@gPlay=Gtk::Table.new(1,3, false)
		#@gHelp
		@fPlay.add(@gPlay)

		#@separator=Gtk::Separator.new()
		
		@grille=Gtk::Table.new(taille,taille, false)
		@gHelp=Gtk::Table.new(3,1, false)

		@gPlay.attach(@grille, 0,1,0,1)
		@gPlay.attach(@gHelp, 2,3,0,1)
		
		@grille = IGrille.new(taille, @grille)
		@gHelp = GHelp.new(@gHelp)

		@fPlay.show_all()
		#destruction fenetre quand "quitter"
		@fPlay.signal_connect('destroy') {onDestroy}
	end	
end

#builder = FPlay.construire(8)
#Gtk.main
