require 'spec_helper'

describe DCHubConnection do
  context "connection initialization" do
    #let(:connection) { DCConnection.new(nil, nil) }

    it "crates new socket with options" do
      socket = mock(TCPSocket)
      socket.stub(:setsockopt).with(any_args())
      socket.should_receive(:setsockopt).once.with(any_args())

      TCPSocket.stub(:new).and_return(socket)
      TCPSocket.should_receive(:new).once

      connection = DCHubConnection.new("123", 123)
      connection.connect
    end

    it "receives hub wellcome message" do
      socket = mock(TCPSocket)
      socket.stub(:recv).and_return(DCLockCommand.new("test").to_s)
      TCPSocket.stub(:new).and_return(socket)

      connection = DCHubConnection.new(nil, nil)
      connection.stub(:socket).and_return(socket)

      connection.get_command.should eq DCLockCommand.new("test")
    end
  end
end

