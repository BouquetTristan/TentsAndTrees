require "gtk3"

# Classe représentant une page

class Page

	def initialize

		fenetre = Gtk::Window.new
		fenetre.set_default_size(700,400)
		fenetre.border_width=5
		fenetre.set_resizable(true)
		fenetre.set_window_position(Gtk::Window::POS_CENTER_ALWAYS)

		#Creation table
		table = Gtk::Table.new(2,1, FALSE)
		fenetre.add(table)

		image = Gtk::Image.new(:file => "Images/Picross_logo.png", :size => :dialog)

		table.attach_defaults(image, 0,1,0,1)

	end

	def ajouter
		table.attach_defaults(self, 1,2,0,1)
	end

	def onDestroy
		puts "L'application est fermé !"
		Gtk.main_quit
	end

end