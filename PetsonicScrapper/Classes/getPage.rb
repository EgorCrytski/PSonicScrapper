require 'nokogiri'
require 'curb'

class GetPageClass

  def initialize
    end

def getPage(url)
  begin
    return Nokogiri::HTML(Curl.get(url).body_str)
  rescue
    raise 'getCatPage error'
  end
end
end
