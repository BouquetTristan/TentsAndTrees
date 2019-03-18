require 'gtk3'
require './IGrille.rb'
require './gHelp.rb'
require './Page.rb'


class FPlay < Page

	def initialize(monApp, header, anciennePage, taille)
		
		super("", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220

		#@gPlay=Gtk::ButtonBox.new(:horizontal)		
		@grille=Gtk::Table.new(taille,taille, false)
		self.add(@grille)	
		#@gHelp=Gtk::Table.new(3,1, false)
		#@gPlay.add(@grille)		
		#@gPlay.attach(@gHelp, 1,2,0,1)
		@grille = IGrille.new(taille, @grille)
		#@gHelp = GHelp.construire(@gHelp)
	end	
end
