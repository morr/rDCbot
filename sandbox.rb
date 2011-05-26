#!/usr/bin/ruby
require 'socket'
require 'rubygems'
require 'lib/rdcbot'
require 'ap'

hub_address = '10.8.13.88'#'hale.hopto.org'
hub_port    = 8888

bot = RDCbot.new
bot.nickname = 'morrBot'
bot.description = 'http://shikimori.org'
bot.host = hub_address
bot.port = hub_port
bot.email = 'takandar@gmail.com'

bot.start

#sleep(1)
#bot.say "test"
while bot.alive?
  sleep(3)
end

#command1 = DCCommand.new("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
#command2 = DCCommand.new("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")

#ap command1 == command2


#begin
  #session = "mysession"
  #socket = TCPSocket.new(hub_address, hub_port)
  #socket.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_NODELAY, 1)
  #puts "sending to socket HELO " + session
  #socket.write('HELO ' + session + "\r\n")
  #ap socket.recv(100)
  #socket.close
#rescue Exception => e
   #puts "Exception rescued : " + e.message
#end


#RDCbot.new
