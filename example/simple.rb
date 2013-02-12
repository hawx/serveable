require_relative '../lib/serveable'
require 'rack'

class Page
  include Serveable::Item

  def initialize(name)
    @name = name
  end

  def contents
    "Hello #@name!"
  end

  def url
    "/#{@name.downcase}/index.html"
  end
end

class Site
  include Serveable::Site

  def each(&block)
    [
      Page.new("Dave"),
      Page.new("John"),
      Page.new("Steve")
    ].each(&block)
  end
end

app = Rack::Builder.new do
  use Rack::ShowExceptions
  run Site.new
end

handler = Rack::Handler.default
handler.run app
