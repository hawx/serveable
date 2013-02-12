module Serveable

  # Include {Serveable::Site} into an object that responds to #each, which
  # returns items that expose the same interface (or include) {Item}, to allow
  # it to be run with Rack.
  module Site

    # @return [Array] Returns the payload for the given environment passed.
    def call(env)
      paths_equal = lambda do |a,b|
        short = a.sub(/index\.html\Z/, '')
        return a == b || short == b || short[0..-2] == b
      end

      found = Missing
      each do |item|
        if paths_equal.call(item.url, env['REQUEST_PATH'])
          found = item
        end
      end

      found.serve
    end
  end

  # The Item module expects the object extending/class including it to respond
  # to the #url and #content methods, it then defines the #serve method which is
  # used by {Site}.
  module Item

    # @return [String] The contents of the Item to be served.
    def contents; end

    # @return [String] Full url (including /index.html) to the item.
    def url; end

    # @return [Array] Payload for rack. Contains, in order, the status, the
    #   headers and the body.
    def serve
      mime = Rack::Mime.mime_type ::File.extname(url)
      [200, {"Content-Type" => mime}, [contents]]
    end
  end

  # The sole missing file is served when no matching item is found.
  Missing = Object.new
  def Missing.serve
    [404, {}, ["404 not found"]]
  end

end
