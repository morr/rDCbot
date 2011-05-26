require 'spec_helper'

describe DCCommand do
  it "correctly parses arguments" do
    command = DCCommand.new("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command.name.should eq "Lock"
    command.data.should eq "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"

    command = DCCommand.new("Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command.name.should eq "Lock"
    command.data.should eq "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"

    command = DCCommand.new("Lock" ,"EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command.name.should eq "Lock"
    command.data.should eq "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"

    command = DCCommand.new("$Lock" ,"EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command.name.should eq "Lock"
    command.data.should eq "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"
  end

  it "correctly compared with another DCCommand" do
    command1 = DCCommand.new("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command2 = DCCommand.new("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command1.should eq command2

    command3 = DCCommand.new("$Lock1 EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX")
    command3.should_not eq command1

    command4 = DCCommand.new("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX1")
    command4.should_not eq command1
  end
end
