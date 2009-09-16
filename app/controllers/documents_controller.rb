class DocumentsController < ApplicationController
  
  
  before_filter :set_database
  before_filter :set_collection
  
  def index    
    
    @page = params[:page] || 1
    @limit = params[:rp] || 15
    
    @count = @collection.find({"_id" => {"$ne" => "_design"}}).count()
    # @documents = @collection.find({"_id" => {"$ne" => "_design"}},{:offset => 0, :limit => @limit.to_i}).to_a
    @documents = @collection.find({"_id" => {"$nin" => ["_design","test"]}},{:offset => 0, :limit => @limit.to_i}).to_a

    respond_to do |format|
      format.html { render :action => "index.json", :layout => false }   
      format.js   { render :action => "index.json", :layout => false }
    end
  end
  
  
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