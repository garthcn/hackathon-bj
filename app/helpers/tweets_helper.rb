module TweetsHelper
  def get_content(tweet)
    if tweet[:retweeted_status]
      tweet[:retweeted_status][:text]
    else
      tweet[:text]
    end
  end

  def get_short_content(tweet)
    if tweet[:retweeted_status]
      image_tag("icons/retweet.png", :style => "vertical-align: top; padding-top: 0px;") + 
      truncate(get_content(tweet), :length => 50).chomp
    else
      truncate(get_content(tweet), :length => 50).chomp
    end
  end

  def get_all_content(tweet)
    html = ""
    html << tweet.text

    if tweet.thumbnail_pic
      html << "<br />"
      html << link_to(image_tag(tweet.bmiddle_pic, :id => "popover-thumb", :alt => tweet.original_pic), get_pic(tweet), "data-controls-modal" => "modal-from-dom#{@i}", "data-backdrop" => "true", "data-keyboard" => "true") 
    end
    
    if tweet.retweeted_status
      html << "<div class='well' style='margin-top:15px'>"
      html << "#{tweet.retweeted_status.text}"
      if tweet.retweeted_status.thumbnail_pic
        html << "<br />"
        html << link_to(image_tag(tweet.retweeted_status.bmiddle_pic, :id => "popover-thumb", :alt => tweet.retweeted_status.original_pic), get_pic(tweet), "data-controls-modal" => "modal-from-dom#{@i}", "data-backdrop" => "true", "data-keyboard" => "true") 
      end
      html << "</div>" 
    end

    html
  end

  def get_pic(tweet) 
    if tweet.retweeted_status
      if tweet.retweeted_status.original_pic
        tweet.retweeted_status.original_pic
      else 
        nil
      end
    elsif tweet.original_pic
      tweet.bmiddle_pic
    else
      nil
    end
  end
end
