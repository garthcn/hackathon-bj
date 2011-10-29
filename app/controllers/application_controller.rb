class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    begin
      @oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
      if !session[:atoken].blank? && !session[:asecret].blank?
        @oauth.authorize_from_access(session[:atoken], session[:asecret])
      else
        redirect_to "/users/welcome"
      end
    rescue
      redirect_to "/users/welcome"
    end
  end
end
