require 'spec_helper'

describe RDCbot do
  context "connecting to hub and handshaking" do
    before(:each) do
      @hub = mock(DCHubConnection)
      DCHubConnection.stub(:new).and_return(@hub)
      @hub.stub(:connect)
    end

    #let(:connection) { DCConnection.new(nil, nil) }

    it "connects to hub" do
      RDCbot.new("bot", "111", 111)
      #RDCbot.
      #socket = mock(TCPSocket)
      #socket.stub(:recv).and_return(DCLockCommand.new("test").to_s)
      #TCPSocket.stub(:new).and_return(socket)
      #connection.stub(:socket).and_return(socket)

      #connection.get_command.should eq DCLockCommand.new("test")
    end


    #it "returns one for test" do
      #@bot.should_receive(:say).and_return("2")
      #@bot.say
    #end
  end
end
