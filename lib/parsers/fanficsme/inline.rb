require 'parslet' 

module Fanficmd
  class FanficsmeInline < Parslet::Parser
    # elementary rules
    rule(:eol)      { str("\r\n") | str("\r") | str("\n") }
    rule(:lchar)    { match("[^\r\n]") }
    rule(:tchar)    { match("[<>]") }
    rule(:ntchar)   { match("[^\r\n<>]") }
    rule(:space)    { str(" ") }
    rule(:lspace)   { match("[[:blank:]]") }
    rule(:exspace)  { match("[[:space:]]") }
    rule(:eof)      { any.absent? }
    rule(:eolf)     { eol | eof}

    def opentag(tag)
      str("<#{tag}>")
    end

    def closetag(tag)
      str("</#{tag}>")
    end

    def tagged(atom, tag, name=nil)
      opentag(tag) >> ( name ? atom.as(name) : atom ) >> closetag(tag)
    end

    # basic rules
    rule(:text)     { ntchar.repeat(1).as(:text) }
    rule(:text?)    { text.maybe }

    rule(:italic)   { tagged(span, "i", :italic) }
    rule(:bold)     { tagged(span, "b", :bold) }
    rule(:strike)   { tagged(span, "s", :strike) }
    rule(:under)    { tagged(span, "u", :under) }
    
    rule(:tag)      { bold | italic | strike | under}
    rule(:element)  { tag | text }

    rule(:span)     { element.repeat(1) }

    # complex rules
    rule(:inline)   { span.repeat(1) }
    root(:inline)
  end
end