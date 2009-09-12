class DocumentsController < ApplicationController
  
  
  before_filter :set_database
  before_filter :set_collection
  
  
  def create 
    # logger.debug("DocumentsController::create")  
    # logger.debug(params[:document])        
    # logger.debug(json.class)        
    # logger.debug(json["name"])  
        
    json = ActiveSupport::JSON.decode(params[:document])      
    @collection.insert(json);
    redirect_to database_collection_url(@database.name, @collection.name)
  end
  
  
  
  protected
  
  def set_database
    @database = @connection.db(params[:database_id])
  end
  
  def set_collection
    @collection = @database.collection(params[:collection_id])
  end
    
end