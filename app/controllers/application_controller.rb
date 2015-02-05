class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  # called on everypage this time...should specify which pages
 # before_filter :set_cache_buster
  
  
  # we must include the helper we want to use
  include SessionsHelper
  
  
  protected
  # This is added for handling backbutton problem when logged out. Rails is caching the page and
  # we can get the previous page. This is telling pages not to cache in browser (maybe a non problem with https)
  # Dont forget to disable tubrolinks on logout-link
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
