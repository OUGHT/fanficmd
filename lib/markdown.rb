require 'parslet' 

module Fanficmd
  class Markdown < Parslet::Parser
    # elementary rules
    rule(:lend)     { str("\r") | str("\n") | str("\r\n") }
    rule(:lchar)    { match("[^\r\n]") }
    rule(:lspace)   { match("[ \t]") }
    rule(:eof)      { any.absent? }
    rule(:leeof)    { lend | eof}

    # basic rules
    rule(:sline)    { lspace.repeat(1).as(:line) >> leeof }
    rule(:bline)    { str("").as(:line) >> lend }
    rule(:bsline)   { bline | sline }
    rule(:line)     { lchar.repeat(1).as(:line) >> leeof }
    rule(:aline)    { bsline | line }

    # complex rules
    rule(:text)     { aline.repeat(1) }
    root(:text)
  end
end