require 'nokogiri' # frozen_string_literal: true
require 'curb' # frozen_string_literal: true

class GetPageClass
  def initialize; end

  def get_page(url)
    Nokogiri::HTML(Curl.get(url).body_str)
  end
end
