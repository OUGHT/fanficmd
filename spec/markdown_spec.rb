require 'spec_helper'
require 'markdown'

describe Fanficmd::Markdown do
  let(:markdown) { Fanficmd::Markdown.new }

  it 'responds to parse method' do
    expect(markdown).to respond_to(:parse)
  end

  it 'can parse text into lines' do
    str =<<-EOF.strip_h
      Кто даст мне покой,
      Подарит свет?
      Божий сын казнен,
      Ответа нет.

      Я решил идти в обитель бога
      Против воли всех небесных рек.
    EOF

    arr = [
      {line: "Кто даст мне покой,"},
      {line: "Подарит свет?"},
      {line: "Божий сын казнен,"},
      {line: "Ответа нет."},
      {line: ""},
      {line: "Я решил идти в обитель бога"},
      {line: "Против воли всех небесных рек."}
    ]
    begin
      expect(markdown.parse(str)).to eq arr
    rescue Parslet::ParseFailed => failure
      puts failure.cause.ascii_tree
      raise Parslet::ParseFailed
    end
  end

end
