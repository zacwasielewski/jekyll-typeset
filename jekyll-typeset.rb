require 'tempfile'
#require 'open3'

module Jekyll
  class Typeset < Plugin

    def initialize(site)
      @site = site
    end

    def options
      return '' if !@site.config.has_key?('typeset')
      options = []

      if @site.config['typeset'].has_key?('ignore')
        options << %(--ignore "#{@site.config['typeset']['ignore']}")
      end
      if @site.config['typeset'].has_key?('only')
        options << %(--only "#{@site.config['typeset']['only']}")
      end

      options.join(' ')
    end

    def convert(html)
      tmp = Tempfile.new('jekyll-typeset')
      begin
        tmp.write(html)
        tmp.rewind
        shell_cmd = "typeset-js #{self.options}".strip
        # Open3 doesn't want to cooperate with -- options,
        # so fall back to the standard backticks instead:
        #out, err, st = Open3.capture3(shell_cmd, tmp.path)
        out = `#{shell_cmd} #{tmp.path}`
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
