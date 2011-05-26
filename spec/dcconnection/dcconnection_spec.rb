require 'spec_helper'

describe DCConnection do
  context "connection initialization" do
    #before(:each) do
      #@connection = double(DCConnection)
      #@connection.stub!(:connect)#.and_return("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX|")
    #end

    let(:connection) { DCConnection.new(nil, nil) }

    it "hub wellcome message" do
      socket = mock(TCPSocket)
      socket.stub(:recv).and_return(DCCommand::LockString + "|")
      TCPSocket.stub(:new).and_return(socket)
      connection.stub(:socket).and_return(socket)

      connection.get_command.should eq DCCommand.new(DCCommand::LockString)
    end
  end
end

