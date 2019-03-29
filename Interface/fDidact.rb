require 'gtk3'
#require './fGameMode.rb'
#require './TexteEntree'

class FDidact < Page

	def initialize

		super("", monApp, :vertical, header,  anciennePage, unJoueur)
		self.hautPage.spacing = 220

		@gDida = Gtk::Table.new(1,2, false)

		@header.btnMenu.signal_connect('clicked') {
        	self.supprimeMoi
        	menu = FMenu.new(@window, @header, self, unJoueur)
        	menu.ajouteMoi
        	@window.show_all
    	}
