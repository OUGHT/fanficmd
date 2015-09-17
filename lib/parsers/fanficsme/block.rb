module Fanficmd
  class FanficsmeBlock
    def parse(str)
      str.gsub!(/\r\n/, "\n")
      str.gsub!(/\r/, "\n")

      arr = str.split("\n")
      arr.map! { |s| {line: s} }
    end
  end
end