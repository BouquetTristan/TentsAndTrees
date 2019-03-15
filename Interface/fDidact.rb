require 'gtk3'
#require './fGameMode.rb'
#require './TexteEntree'

class FDidact < Gtk::Builder

	def initialize

		fenetre = Gtk::Window.new
		fenetre.set_default_size(600,400)
		fenetre.border_width=5

		@gDidact = Gtk::Table.new(2,3, false)
		fenetre.add(@gDidact)


          titre =  Gtk::Label.new('Modification de compte')
