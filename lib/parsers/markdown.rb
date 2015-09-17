require 'parslet' 

module Fanficmd
  class Markdown < Parslet::Parser
    # elementary rules
    rule(:eol)      { str("\r\n") | str("\r") | str("\n") }
    rule(:lchar)    { match("[^\r\n]") }
    rule(:space)    { match(" ") }
    rule(:lspace)   { match("[[:blank:]]") }
    rule(:exspace)  { match("[[:space:]]") }
    rule(:eof)      { any.absent? }
    rule(:eolf)     { eol | eof}

    rule(:punct)    { match("[!\"#$%&'()*+,\-./:;<=>?@[\\\]^_`{|}~]") }


    # basic rules
    rule(:sline)    { lspace.repeat(1).as(:line) >> eolf }
    rule(:bline)    { str("").as(:line) >> eol }
    rule(:bsline)   { bline | sline }
    rule(:line)     { lchar.repeat(1).as(:line) >> eolf }
    rule(:aline)    { bsline | line }

    %w[* - _].each_with_index do |s, i|   # Черная магия. Не дышать!
      rule("hruler#{i}") do 
        space.repeat(0,3) >> 
        (
          str(s).repeat(3) >> match("[#{s} ]").repeat(0) |

          str(s).repeat(2) >> space.repeat(0) >> str(s).repeat(1) >> 
          space.repeat(0) >> match("[#{s} ]").repeat(0) |

          str(s).repeat(1) >> space.repeat(0) >> str(s).repeat(2) >> 
          space.repeat(0) >> match("[#{s} ]").repeat(0) |

          str(s).repeat(1) >> space.repeat(0) >> str(s).repeat(1) >> space.repeat(0) >> 
          str(s).repeat(1) >> space.repeat(0) >> match("[#{s} ]").repeat(0) 
        )
      end    
    end
    rule(:hruler)   { (hruler0 | hruler1 | hruler2).as(:hruler) >> eolf }


    # complex rules
    rule(:block)    { hruler | aline }
    rule(:text)     { block.repeat(1) }
    root(:text)
  end
end