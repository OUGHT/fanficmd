$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
Coveralls.wear!
require 'pry'
require 'fanficmd'
require 'pp'

class String
  def strip_h(char = '')
    match = "^\s+#{char}"
    regexp = Regexp.new(match)
    self.gsub(regexp, '')
  end
end