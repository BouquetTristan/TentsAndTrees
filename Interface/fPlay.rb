require 'gtk3'
require './IGrille.rb'
require './gHelp.rb'
#require './Page.rb'


class FPlay# Page

	def FPlay.construire(fenetre, taille)
		new(fenetre, taille)
	end

	def initialize(fenetre, taille)
		
		@gPlay=Gtk::Table.new(1,3, false)
		fenetre.add(@gPlay)
		
		@grille=Gtk::Table.new(taille,taille, false)
		@gHelp=Gtk::Table.new(3,1, false)

		@gPlay.attach(@grille, 0,1,0,1)
		@gPlay.attach(@gHelp, 2,3,0,1)
		
		@grille = IGrille.new(taille, @grille)
		@gHelp = GHelp.new(@gHelp)

		@fenetre.show_all()
		#destruction fenetre quand "quitter"
		#@fPlay.signal_connect('destroy') {onDestroy}
	end	
end

#builder = FPlay.construire(8)
#Gtk.main
