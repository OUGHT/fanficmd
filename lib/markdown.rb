require 'parslet' 

module Fanficmd
  class Markdown < Parslet::Parser
    # elementary rules
    rule(:lend)     { str("\r") | str("\n") | str("\r\n") }
    rule(:lchar)    { match("[^\r\n]") }
    rule(:space)    { match(" ") }
    rule(:lspace)   { match("[[:blank:]]") }
    rule(:exspace)  { match("[[:space:]]") }
    rule(:eof)      { any.absent? }
    rule(:leeof)    { lend | eof}

    rule(:punct)    { match("[!\"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]") }


    # basic rules
    rule(:sline)    { lspace.repeat(1).as(:line) >> leeof }
    rule(:bline)    { str("").as(:line) >> lend }
    rule(:bsline)   { bline | sline }
    rule(:line)     { lchar.repeat(1).as(:line) >> leeof }
    rule(:aline)    { bsline | line }


    rule(:bruler)   { str("*").repeat(3) | str("_").repeat(3) | str("-").repeat(3) } # TODO: Add whitespace
    rule(:hruler)   { space.repeat(0,3) >> bruler.as(:hruler) >> space.repeat(0) >> lend }


    # complex rules
    rule(:block)    { hruler | aline }
    rule(:text)     { block.repeat(1) }
    root(:text)
  end
end