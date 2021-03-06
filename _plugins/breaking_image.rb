module Jekyll
  class BreakingImageTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      components = text.split(", ")
      @path = components[0]
      @url = components[1] || @path
      @attributes = components[2]
      @no_bottom_margin = components.include? "no-bottom-margin "
    end

    def render(context)
      image_url = @path

      pre = <<-eos
</article>
</div>
</section>
<div style="background-color:white;">
<section class="container"><div class="row"><article class="content col-md-10 col-md-offset-1"><center>
eos

      post = <<-eos
</center></article>
</div>
</section>
</div>
<section class="container">
<div class="row"><article class="content col-md-8 col-md-offset-2">
eos

      if @no_bottom_margin
        pre.gsub!(/row/m, 'row" style="padding-bottom:0px;')
      end

      img = "<img #{ @attributes } src='#{image_url}'>"
      if @url
        img = "<a href='#{ @url }'>" + img + "</a>"
      end

      return pre + img + post
    end
  end
end

Liquid::Template.register_tag('breaking_image', Jekyll::BreakingImageTag)

