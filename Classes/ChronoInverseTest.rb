require_relative 'ChronoInverse.rb'

c=ChronoInverse.new(120)

thr=Thread.new{
			c.start
}


sleep(3)
c.pause()
sleep(3)
c.pause()
#print "Saisi"
#s = gets
#sleep(3)
#print s
sleep(3)
c.raz()
sleep(5)

