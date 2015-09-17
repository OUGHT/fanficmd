require 'spec_helper'
require 'parsers/fanficsme/block'

describe Fanficmd::FanficsmeBlock do
  let(:fanficsme) { Fanficmd::FanficsmeBlock.new }

  it "can parse text into lines" do
    str =<<-EOF.strip_h
      Кто даст мне покой,\r
      <i>Подарит</i> свет?
      Божий сын казнен,
      Ответа нет.

      Я решил идти в <b>обитель бога\rПротив</b> воли всех небесных рек.
    EOF

    arr = [
      {line: "Кто даст мне покой,"},
      {line: "<i>Подарит</i> свет?"},
      {line: "Божий сын казнен,"},
      {line: "Ответа нет."},
      {line: ""},
      {line: "Я решил идти в <b>обитель бога"},
      {line: "Против</b> воли всех небесных рек."}
    ]

    expect(fanficsme.parse(str)).to eq arr
  end

end
