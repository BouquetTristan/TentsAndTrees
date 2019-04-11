require_relative 'Chrono.rb'

c=Chrono.new()

thr=Thread.new{
			c.start
 }


sleep(3)
c.cPause()
sleep(3)
c.cPause()
#print "Saisi"
#s = gets
#sleep(3)
#print s
sleep(3)
c.cRaz()
sleep(5)
