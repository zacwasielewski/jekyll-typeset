require 'open3'
require 'tempfile'

module Jekyll
  class Typeset < Plugin

    def initialize(site)
      @site = site
    end

    def convert(html)
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

Jekyll::Hooks.register [:page, :post], :post_render do |owner|
  typeset = Jekyll::Typeset.new(owner.site)
  owner.output = typeset.convert(owner.output)
end
