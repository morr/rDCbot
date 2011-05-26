require 'spec_helper'

describe DCCommand do
  it "correctly parses arguments" do
    command = DCLockCommand.new("EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command.name.should eq "Lock"
    command.data.should eq "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"
    command.key.should eq "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix"
  end

  it "correctly compared with another DCCommand" do
    command1 = DCLockCommand.new("EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command2 = DCLockCommand.new("EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command1.should eq command2
  end
end
