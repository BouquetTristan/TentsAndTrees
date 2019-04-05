class Header < Gtk::HeaderBar

  attr_reader :btnMenu, :pseudo

  def initialize(monApp)
    super()
    # Titre de la fenêtre
    #self.show_close_button = true
    self.has_subtitle = false

    @window = monApp
    @boxButtons = Gtk::Box.new(:horizontal)
    @boxButtons.spacing = 10

    @btnMenu = Gtk::Button.new(:label => 'Menu', :use_underline => nil, :stock_id => nil)
    @image=(Gtk::Image.new(:file =>"./image/logo.png",:size => :dialog))
    @btnDel = Gtk::Button.new(:label => 'Quitter', :use_underline => nil, :stock_id => nil)
    #@imDel=(Gtk::Image.new(:file =>"./image/logo.png",:size => :dialog))

    @boxButtons.add(@image)
    @boxButtons.add(@btnMenu)
    @boxButtons.add(@btnDel)

    @boxButtons.spacing=15
    self.pack_end(@boxButtons)

        @btnDel.signal_connect('clicked') {
        @window.destroy
    }
  end

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