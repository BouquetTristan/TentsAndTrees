class Header < Gtk::HeaderBar


  attr_reader :btnMenu, :pseudo

  #Initialise le titre de page
	# @param monApp		//l'application qui recevra la barre de titre
	# @return void			//ne renvoie rien
  def initialize(monApp)
    super()
    # Titre de la fenêtre
    #self.show_close_button = true
    self.has_subtitle = false

    @window = monApp
    @boxButtons = Gtk::Box.new(:horizontal)
    @boxButtons.spacing = 400

    @box = Gtk::Box.new(:horizontal)
    @boxb = Gtk::Box.new(:horizontal)

    @titre = Gtk::Label.new("")
    @titre.set_markup("<span foreground=\"#EF2929\" font-desc=\"Courier New bold 20\">Tents and Trees</span>")
    @btnMenu = Gtk::Button.new(:label => 'Menu', :use_underline => nil, :stock_id => nil)
    @image=(Gtk::Image.new(:file =>"./Assets/logo.png",:size => :dialog))
    @btnDel = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)
    #@imDel=(Gtk::Image.new(:file =>"./image/logo.png",:size => :dialog))

    @box.add(@image)
    @box.add(@titre)
    @boxButtons.add(@box)

    @boxb.add(@btnMenu)
    @boxb.add(@btnDel)
    @boxButtons.add(@boxb)


    self.pack_end(@boxButtons)

        @btnDel.signal_connect('clicked') {
        @window.destroy
    }
  end

  #Ajoute un bouton
	# @param void		//ne prend aucun paramètre
	# @return void		//ne renvoie rien
  def ajouterB()
  	@btnMenu = Gtk::Button.new(:label => 'Menu', :use_underline => nil, :stock_id => nil)

    @boxButtons.add(@btnMenu)

    @btnMenu.signal_connect('clicked') {
        self.supprimeMoi
        menu = FMenu.new(@window, @header, self)
        menu.ajouteMoi
        @window.show_all
    }

  end

end
