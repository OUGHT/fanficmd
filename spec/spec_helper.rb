$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'coveralls'
Coveralls.wear!
require 'pry'
require 'fanficmd'
require 'pp'

class String
  def strip_h(border = false)
    regexp = border ? /^ +\|/ : /^ +/
    self.gsub(regexp, '')
  end

  def strip_n
    regexp = /[\r\n]/
    self.gsub(regexp, '')
  end 
end