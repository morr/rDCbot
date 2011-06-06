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

      connection = DCHubConnection.new("123", 123, lambda { })
      connection.connect
    end

    it "receives message and triggers callback" do
      socket = mock(TCPSocket)
      socket.stub(:recv).and_return(DCLockCommand.new("test").to_s)
      TCPSocket.stub(:new).and_return(socket)

      callback = lambda {|command| puts command.to_s }
      callback.should_receive(:call).once

      connection = DCHubConnection.new(nil, nil, callback)
      connection.stub(:socket).and_return(socket)
      IO.stub(:select).and_return([[socket], nil , nil])

      connection.fetch_command
    end
  end
end

