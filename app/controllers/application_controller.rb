require 'mongo'
require 'will_paginate'

class ApplicationController < ActionController::Base
  include Mongo
    
  before_filter :set_connection
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  protected
  
  def set_connection    
    # @connection = Connection.new("aws.mongohq.com", 27017, :auto_reconnect => true)    
    @connection = Connection.new("db.mongohq.com", 27017, :auto_reconnect => true)        
    
  end
end


class Mongo::Cursor
  def paginate(page=1, per_page=15)
    total = self.count
    paginated_array = WillPaginate::Collection.new(page, per_page, total)
    paginated_array.concat(self.to_a)
  end
end
  
