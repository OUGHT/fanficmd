require 'spec_helper'
require 'parsers/fanficsme/inline'
require 'parslet/convenience'

describe Fanficmd::FanficsmeInline do
  let(:fanficsme) { Fanficmd::FanficsmeInline.new }

  it "can parse simple text" do
    str = "О существовании антивирусов и файрволлов кузен краем уха слышал, " +
          "но, видимо, так до конца и не поверил в их существование."

    arr = [{text: "О существовании антивирусов и файрволлов кузен краем уха слышал, " + 
                  "но, видимо, так до конца и не поверил в их существование."}]

    expect(fanficsme.parse(str)).to eq arr
  end

  it "can parse plain italic and bold text" do
    str ="<b>— Время!</b><i> — напомнил</i> Флитвик, сделав <i>очередную</i> пометку в тетради."

    arr = 
    [
      {bold: [{text: "— Время!"}] },
      {italic: [{text: " — напомнил"}] },
      {text: " Флитвик, сделав "},
      {italic: [{text: "очередную"}] },
      {text: " пометку в тетради."}
    ]

    expect(fanficsme.parse(str)).to eq arr
  end

  it "can parse nested u/s/b/i text" do
    str = "<s>Протиснувшись <i>мимо <u>велосипеда</u></i>, </s>Гарри <b>прошел</b> в кухню."
    
    arr = [
      {:strike=>
        [
          {:text=>"Протиснувшись "},
          {:italic=>
            [
              {:text=>"мимо "}, 
              {:under=>[{:text=>"велосипеда"}] }
            ]
          },
          {:text=>", "}
        ]
      },
      {:text=>"Гарри "},
      {:bold=>[{:text=>"прошел"}] },
      {:text=>" в кухню."}
    ]

    expect(fanficsme.parse(str)).to eq arr
  end

end
