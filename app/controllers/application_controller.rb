class ApplicationController < ActionController::Base
  protect_from_forgery
  def authorize
    begin
      @oauth = Weibo::OAuth.new(Weibo::Config.api_key, Weibo::Config.api_secret)
      @oauth.authorize_from_access(session[:atoken], session[:asecret])
    rescue
      redirect_to "/users/welcome"
    end
  end
end
