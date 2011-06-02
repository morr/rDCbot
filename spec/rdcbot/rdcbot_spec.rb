require 'spec_helper'

describe RDCbot do
  it "adds callback" do
    bot = RDCbot.new
    callbacks = bot.callbacks.include?(DCLockCommand) ? bot.callbacks[DCLockCommand].size : 0
    callback = lambda {|command| }
    bot.add_callback(DCLockCommand, callback)
    bot.callbacks[DCLockCommand].size.should eq(callbacks+1)
    bot.callbacks[DCLockCommand].last.should eq(callback)
  end

  it "fires all callbacks" do
    bot = RDCbot.new
    callbacks = bot.callbacks.include?(DCLockCommand) ? bot.callbacks[DCLockCommand].size : 0
    callback = lambda {|command| }
    callback.should_receive(:call).twice
    bot.add_callback(DCMessageCommand, callback)
    bot.add_callback(DCMessageCommand, callback)
    bot.fire(DCMessageCommand.new("test", "test"))
  end

  context "connecting to hub and handshaking" do
    before(:each) do
      @hub = mock(DCHubConnection)
      DCHubConnection.stub(:new).and_return(@hub)
      @hub.stub(:connect)

      @nickname = 'test'
    end

    #let(:connection) { DCConnection.new(nil, nil) }

    it "handshakes with hub" do
      expecting_command = DCSupportsCommand

      hub = mock(DCHubConnection)
      DCHubConnection.stub(:new).and_return(hub)
      hub.stub(:connect)

      bot = RDCbot.new
      bot.nickname = @nickname

      hub.stub(:send_command).with do |v|
        if v.class == expecting_command
          case expecting_command.name
            when DCSupportsCommand.name
              expecting_command = DCKeyCommand

            when DCKeyCommand.name
              expecting_command = DCValidateNickCommand

            when DCValidateNickCommand.name
              expecting_command = DCVersionCommand

            when DCVersionCommand.name
              expecting_command = DCGetNickListCommand

            when DCGetNickListCommand.name
              expecting_command = DCMyINFOCommand

            when DCMyINFOCommand.name
              true

            else
              false
          end
        else
          false
        end
      end.and_return do |v|
        if v.class == DCValidateNickCommand
          bot.fire(DCHelloCommand.new(@nickname))
        end
      end

      Thread.stub(:new).and_return(true)

      bot.start
      bot.fire(DCLockCommand.new("key"))
    end
  end
end
