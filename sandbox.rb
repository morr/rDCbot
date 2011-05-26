#!/usr/bin/ruby
require 'socket'
require 'rubygems'
require 'lib/rdcbot'
require 'ap'

hub_address = '10.8.13.88'#'hale.hopto.org'
hub_port    = 8888

bot = RDCbot.new('morrBot', hub_address, hub_port)
bot.listen

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
