class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session


  # called on everypage this time...should specify which pages
 # before_filter :set_cache_buster


  # we must include the helper we want to use
  # This is handling the authentication
  include SessionsHelper

  # default parameters, maby put i config-file?
  OFFSET = 0
  LIMIT = 20

  # check if user whants offset/limit
  def offset_params
    if params[:offset].present?
      @offset = params[:offset].to_i
    end
    if params[:limit].present?
      @limit = params[:limit].to_i
    end
    @offset ||= OFFSET
    @limit  ||= LIMIT
  end


  def api_key
     api_key = request.headers['X-ApiKey']
     ## here we should check that the key exists
     return true
  end





  protected
  # This is added for handling backbutton "problem" when logged out. Rails is caching the page and
  # we can get the previous page. This is telling pages not to cache in browser (maybe a non problem with https)
  # Dont forget to disable tubrolinks on logout-link
  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
