# Serveable makes creating a simple rack-runnable site easy. All you have to do
# is stick to the script. First it is expected that your have a site object,
# collecting all the files. This could be written just for this purpose instead
# of exposing methods on a previous object if desired. Secondly another set of
# objects representing pages.
#
# The site object needs to extend +Serveable::Site+ (or the class needs to
# include it), and each page object needs to extend +Serveable::Page+ (or again,
# the page's class needs to include it). You can then do some basic rack setup
# and run the site!
module Serveable

  # The Site module expects the object extending/class including it to have an
  # instance method called #pages. This method should return a list of objects
  # which have extended +Serveable::Page+.
  module Site

    # @return [Array] Returns the payload for the given environment passed.
    def call(env)
      page = pages.find {|page|
        paths_equal?(page.url, env['REQUEST_PATH'])
      } || MissingFile

      page.serve
    end

    private

    def paths_equal?(a, b)
      short = a.sub(/index\.html\Z/, '')

      a == b || short == b || short[0..-2] == b
    end
  end

  # The Page module expects the object extending/class including it to respond
  # to the #url and #content methods.
  module Page

    # @return [String] The contents of the Page to be served.
    def content; end

    # @return [String] Full url (including /index.html) to the page.
    def url; end

    # @return [String] Mime type for the page based on the extension of #url.
    def mime
      Rack::Mime.mime_type ::File.extname(url)
    end

    # @return [Array] Payload for rack. Contains, in order, the status, the
    #   headers and the body.
    def serve
      [200, {"Content-Type" => mime}, [content]]
    end
  end

  MissingFile = Object.new
  def MissingFile.serve
    [404, {}, ["404 file not found"]]
  end

end
