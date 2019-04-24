begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk3'

require './Interface/fConnexion.rb'
require './Classes/Header.rb'
require './Classes/App.rb'

#Gtk.init

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

def configureMonApp(uneApp)

  ##
  # Taille de la fenêtre
	uneApp.window.set_default_size(uneApp.width,uneApp.height)
	##

  # On ne peut pas redimensionner
	uneApp.window.set_resizable(false)
	##
  #L'application est toujours centrée
	uneApp.window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
end

if ARGV.size.eql?(0) then
	  monApp = App.new(Gtk::Window.new, 1100,678)
	  configureMonApp(monApp)

	  # Titre de la fenêtre
	  header = Header.new(monApp.window)

	  ##
	  # Box principale
	  page = FConnexion.new(monApp, header, nil, nil)

	  page.ajouteMoi



	  ######FIN########

	  ##
	  # Ajout du header a la fenetre
	  monApp.window.titlebar = header

		monApp.window.show_all

		##
	  #Quand la fenêtre est détruite il faut quitter
		monApp.window.signal_connect('destroy') {onDestroy}

		Gtk.main
	else
		puts "Usage Error O argument pour le Tents&Trees"
	end
