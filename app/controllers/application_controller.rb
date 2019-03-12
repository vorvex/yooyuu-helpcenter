class ApplicationController < ActionController::Base
  helper_method :highlight_hashtag
  
  def highlight_hashtag(str)
    str.gsub!(/\S*#(\[[^\]]+\]|\S+)/, '<a href="/hashtag/\1">\1</a>')
  end
  
  def get_hashtag(str)
    str.scan(/\S*#(\[[^\]]+\]|\S+)/).flatten
  end
  
  def use_hashtag(str)
    get_hashtag(str).eac
  end
end
