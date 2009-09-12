class CollectionsController < ApplicationController
  
  before_filter :set_database
  
  def show    
    @collection = @database.collection(params[:id])
    @documents = @collection.find()
  
    # result = ActiveSupport::JSON.decode("{test, value}")   
    # logger.debug("=====================")
    # logger.debug(result)
  end
  
  
  def new    
  end
  
  def create
    name = params[:name]
    begin        
      @collection = @database.collection(name)
      flash[:success] = "Collection '#{@collection.name}' created successfully in Database '#{@database.name}' "
      redirect_to database_collection_url(@database.name, @collection.name)
    rescue Exception => e
      logger.debug e
      flash.now[:error] = "Please enter a collection name"
      render :action => "new"      
    end
  end
  
  def edit    
  end
  
  
  protected
  
  def set_database
    @database = @connection.db(params[:database_id])
  end
end