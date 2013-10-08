# coding: utf-8 
# post_footer_filter.rb
# Append every post some footer infomation like original url 
# Kevin Lynx
# 7.26.2012
#
require './plugins/post_filters'

module AppendFooterFilter
  def append(post)
     author = post.site.config['author']
     url = post.site.config['url']
     pre = post.site.config['original_url_pre']
     post.content + %Q[<p class='post-footer'>#{pre or "original link:"}<a href='#{post.full_url}'>#{post.full_url}</a><br/>Written by <a href='#{url}'>#{author}</a>&nbsp;posted at <a href='#{url}'>#{url}</a><br/>版权声明：自由转载-非商用-非衍生-保持署名|<a href="http://creativecommons.org/licenses/by-nc-nd/3.0/deed.zh">Creative Commons BY-NC-ND 3.0</a></p>]
  end 
end

module Jekyll
  class AppendFooter < PostFilter
    include AppendFooterFilter
    def pre_render(post)
      post.content = append(post) if post.is_post?
    end
  end
end

Liquid::Template.register_filter AppendFooterFilter