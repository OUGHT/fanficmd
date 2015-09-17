require 'parslet' 

module Fanficmd
  class Fanficsme < Parslet::Parser
    # elementary rules
    rule(:eol)      { str("\r\n") | str("\r") | str("\n") }
    rule(:lchar)    { match("[^\r\n]") }
    rule(:space)    { match(" ") }
    rule(:lspace)   { match("[[:blank:]]") }
    rule(:exspace)  { match("[[:space:]]") }
    rule(:eof)      { any.absent? }
    rule(:eolf)     { eol | eof}

    rule(:punct)    { match("[!\"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]") }

    def opentag(tag)
      str("<#{tag}>")
    end

    def closetag(tag)
      str("</#{tag}>")
    end

    def tagged(atom, tag)
      opentag(tag) >> atom >> closetag
    end

    # basic rules
    rule(:sline)    { lspace.repeat(1).as(:line) >> eolf }
    rule(:bline)    { str("").as(:line) >> eol }
    rule(:bsline)   { bline | sline }
    rule(:line)     { lchar.repeat(1).as(:line) >> eolf }
    rule(:aline)    { bsline | line }

    # complex rules
    rule(:block)    { aline }
    rule(:text)     { block.repeat(1) }
    root(:text)
  end
end