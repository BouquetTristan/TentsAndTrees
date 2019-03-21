require 'gtk3'
#require './fGameMode.rb'
#require './TexteEntree'

class FDidact < Page

	def initialize

		super("", monApp, :vertical, header,  anciennePage)
		self.hautPage.spacing = 220

		@gDida = Gtk::Table.new(1,2, false)

		@header.btnMenu.signal_connect('clicked') {
        	self.supprimeMoi
        	menu = FMenu.new(@window, @header, self)
        	menu.ajouteMoi
        	@window.show_all
    	}
		


