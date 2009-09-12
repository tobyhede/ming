require 'mongo'

class ApplicationController < ActionController::Base
  include Mongo
    
  before_filter :set_connection
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected
  
  def set_connection    
    @connection = Connection.new
  end
end
