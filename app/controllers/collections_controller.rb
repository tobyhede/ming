class CollectionsController < ApplicationController
  
  before_filter :set_database
  
  def show    
    @collection = @database.collection(params[:id])
   
    @documents = @collection.find("_id" => "_design")
    
    if @documents.count()
      @design = @documents.next_object
      @columns = @design["columns"]
    else
      @documents = @collection.find.to_a
      @columns = @documents.collect{|doc| doc.keys}.flatten.uniq
    end
    
    # logger.debug("================================")
    # logger.debug(@columns)
    # 
    # @design = @documents.find{|d| d["_id"] == "_design"}
    #     
    # if @design
    #   @columns = @design["columns"]
    # else
    #   @columns = @documents.collect{|doc| doc.keys}.flatten.uniq
    # end
    # 
    # @documents.delete(@design)
    # 
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