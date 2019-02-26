class Label < Gtk::Label

	def initialize(text, color, size){
		super()
		self.set_markup(writeText(text, color, size))
		
	end

	def writeText(text, color, size){
		chaine = "<span foreground=\"#"
	    chaine = chaine + color
	    chaine = chaine + "\" font-desc=\"Copperplate "
	    chaine = chaine + size
	    chaine = chaine + "\" >"
	    chaine = chaine + text
	    chaine = chaine + "</span>"
	    return chaine
	end

end