#!/bin/sh
echo "Installation des gems en cours, veuillez patienter !"

  sudo gem install gtk3
  sudo gem install thread
  sudo gem install sqlite3
  ruby BDD.rb
  ruby Main.rb
