
require 'gtk3'

class BoutonAide

	# @bouton
	# @coordI, @coordJ
	# @@prix : prix de l'aide en feuille

	def initialize(uneValeur, cliquable)
		@bouton = Gtk::Button.new(:label => uneValeur, :use_underline => nil, :stock_id => nil)
		@cliquable = cliquable
	end
	attr_accessor :bouton, :cliquable


end