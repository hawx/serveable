module Serveable

  module Site
    def serve(path)
      (pages.find {|page| paths_equal?(page.url, path) } ||
         MissingFile).serve
    end
    
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

  module Page    
    def mime
      Rack::Mime.mime_type ::File.extname(url)
    end
    
    def serve
      [200, {"Content-Type" => mime}, [content]]
    end
  end
  
  MissingFile = Object.new
  def MissingFile.serve
    [404, {}, ["404 file not found"]]
  end
  
end
