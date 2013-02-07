require_relative '../lib/serveable'
require 'rack'

class Page
  include Serveable::Page

  def initialize(name)
    @name = name
  end

  def content
    "Hello #@name!"
  end

  def url
    "/#{@name.downcase}/index.html"
  end
end

class Site
  include Serveable::Site

  def pages
    [
      Page.new("Dave"),
      Page.new("John"),
      Page.new("Steve")
    ]
  end
end

app = Rack::Builder.new do
  use Rack::ShowExceptions
  run Site.new
end

handler = Rack::Handler.default
handler.run app
