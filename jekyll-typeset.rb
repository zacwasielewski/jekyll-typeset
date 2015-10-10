require 'open3'
require 'tempfile'

module Jekyll
  class TypesetConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /^.*$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      self.typeset(content)
    end

    def typeset(html)
      tmp = Tempfile.new('jekyll-typeset')
      begin
        tmp.write(html)
        tmp.rewind
        out, err, st = Open3.capture3('typeset-js', tmp.path)
      ensure
        tmp.close
        tmp.unlink
      end
      out
    end
  end
end
