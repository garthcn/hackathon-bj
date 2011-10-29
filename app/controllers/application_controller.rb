class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    if !check_authorize
      redirect_to "/users/welcome"
    end
  end

  def check_authorize
    result = true
    begin
      @oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
      if !session[:atoken].blank? && !session[:asecret].blank?
        @oauth.authorize_from_access(session[:atoken], session[:asecret])
      else
        result = false
      end
    rescue
      result = false
    end
    return result
  end

end
