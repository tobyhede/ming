class DocumentsController < ApplicationController
  
  
  before_filter :set_database
  before_filter :set_collection
  
  def index    
      
    @page = params[:page] || 1
    @limit = params[:rp] || 15
    
    @count = @collection.find({"_id" => {"$ne" => "_design"}}).count()
    # @documents = @collection.find({"_id" => {"$ne" => "_design"}},{:offset => 0, :limit => @limit.to_i}).to_a
    @documents = @collection.find({"_id" => {"$nin" => ["_design","test"]}},{:offset => 0, :limit => @limit.to_i}).to_a
    
    # @collections.each{|c|logger.debug(c)}
  
    respond_to do |format|
      format.html { render :action => "index.json", :layout => false }   
      format.js   { render :action => "index.json", :layout => false }
    end
  end
  

  def new
    respond_to do |format|
      # format.html { render }   
      format.js   { render :layout => false }
    end    
  end
  
  def create 
    json = ActiveSupport::JSON.decode(params[:document])      
    @collection.insert(json);

    respond_to do |format|
      format.html { redirect_to database_collection_url(@database.name, @collection.name) }   
      format.js
    end              
  end
    
  def edit
    @document = @collection.find({"_id" => params[:id]}).next_object()
    respond_to do |format|
      format.js   { render :layout => false }
      # format.html { render }   
    end 
  end
  
  def update
    
  end
  
  
  
  protected
  
  def set_database
    @database = @connection.db(params[:database_id])
  end
  
  def set_collection
    @collection = @database.collection(params[:collection_id])
  end
    
end