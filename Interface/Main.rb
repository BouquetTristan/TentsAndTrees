begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk3'

require './fConnexion.rb'
require './Header.rb'

#Gtk.init

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

def configureMonApp(uneApp)
  ##
  # Taille de la fenêtre
	uneApp.set_default_size(1400,859)
	##
  # Réglage de la bordure
	uneApp.border_width=5
	##
  # On ne peut pas redimensionner
	uneApp.set_resizable(false)
	##
  #L'application est toujours centrée
	uneApp.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
end

if ARGV.size.eql?(0) then

	  monApp = Gtk::Window.new
	  configureMonApp(monApp)

	  # Titre de la fenêtre
		header = Header.new(monApp)

	  ##
	  # Box principale
	  page = FConnexion.new(monApp, header, nil, nil)

	  page.ajouteMoi

	  ######FIN########

	  ##
	  # Ajout du header a la fenetre
	  monApp.titlebar = header

		monApp.show_all

		##
	  #Quand la fenêtre est détruite il faut quitter
		monApp.signal_connect('destroy') {onDestroy}

		Gtk.main
	else
		puts "Usage Error O argument pour le Tents&Trees"
	end
