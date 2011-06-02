require 'spec_helper'

describe DCCommandBuilder do
  it "correctly parses arguments" do
    DCCommandBuilder.parse("$Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX").
      should eq ["Lock", "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"]

    DCCommandBuilder.parse("Lock EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX").
      should eq ["Lock", "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"]

    DCCommandBuilder.parse("$Lock", "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX").
      should eq ["Lock", "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"]

    DCCommandBuilder.parse("Lock", "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX").
      should eq ["Lock", "EXTENDEDPROTOCOLrujR<cmFE3W4SiPTp=0icpS0i;unix Pk=PtokaX"]
  end

  it "correctly builds common command" do
    DCCommandBuilder.build("Lock 1234567").
      should eq DCLockCommand.new("1234567")
  end

  it "correctly builds Message command" do
    DCCommandBuilder.build("<bot> hello").
      should eq DCMessageCommand.new("bot", "hello")

    DCCommandBuilder.build("<[батоно]Домокун> hello").
      should eq DCMessageCommand.new("[батоно]Домокун", "hello")
  end

  it "correctly builds MyINFO command" do
    DCCommandBuilder.build("MyINFO $ALL [Бот_хаба] [Описание]$ $$[EMail]$0$|$MyINFO $ALL [Ник1] [Описание]<[Клиент] V:[Версия],M:[Режим],H:[Хабы],S:[Слоты]>$[EMail]$[Соедиение][Магический_байт]$ $[Шара]$|$MyINFO $ALL [Ник2] [Описание]<[Клиент] V:[Версия],M:[Режим],H:[Хабы],S:[Слоты]>$[EMail]$[Соедиение][Магический_байт]$ $[Шара]$").
      name.should eq DCMyINFOCommand.type
  end
end
