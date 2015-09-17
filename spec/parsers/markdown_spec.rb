require 'spec_helper'
require 'parsers/markdown'
require 'parslet/convenience'

describe Fanficmd::Markdown do
  let(:markdown) { Fanficmd::Markdown.new }

  it 'responds to parse method' do
    expect(markdown).to respond_to(:parse)
  end

  it 'can parse text into lines' do
    str =<<-EOF.strip_h
      Кто даст мне покой,\r
      Подарит свет?
      Божий сын казнен,
      Ответа нет.

      Я решил идти в обитель бога\rПротив воли всех небесных рек.
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

    expect(markdown.parse(str)).to eq arr
  end

  it 'can parse horizontal rulers' do
    str =<<-EOF.strip_h(true)
      |Наша работа во тьме —
      |Мы делаем, что умеем,
      |Мы отдаём, что имеем —
      |Наша работа — во тьме.
      |Сомнения стали страстью,
      |А страсть стала судьбой.
      |Всё остальное — искусство
      |В безумии быть собой.
      |
      |Гимн хакеров, русский вариант.
      |***
      | ---------     
      |  _ _     _ _______ __________
      | * **
      | -- -   
      |   *** * *
      | ******** *
      |    ___________________
      |*-*
    EOF

    arr = [
      {line:  "Наша работа во тьме —"},
      {line:  "Мы делаем, что умеем,"},
      {line:  "Мы отдаём, что имеем —"},
      {line:  "Наша работа — во тьме."},
      {line:  "Сомнения стали страстью,"},
      {line:  "А страсть стала судьбой."},
      {line:  "Всё остальное — искусство"},
      {line:  "В безумии быть собой."},
      {line:  ""},
      {line:  "Гимн хакеров, русский вариант."},
      {hruler:"***"},
      {hruler:" ---------     "},
      {hruler:"  _ _     _ _______ __________"},
      {hruler:" * **"},
      {hruler:" -- -   "},
      {hruler:"   *** * *"},
      {hruler:" ******** *"},
      {line:  "    ___________________"},
      {line:  "*-*"}
    ]

    expect(markdown.parse(str)).to eq arr
  end
end
