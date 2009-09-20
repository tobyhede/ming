class CollectionsController < ApplicationController
  
  before_filter :set_database
  
  def show    
    
    @collection = @database.collection(params[:id])
   
    # @collection.clear
    # require "faker"
    # 1000.times do |i| 
    #   @collection.insert({"first_name" => Faker::Name.first_name, "last_name" => Faker::Name.last_name})       
    # end
        
    @design_document = @collection.find("_id" => "_design")

    sort = {"$natural:" => "1"}      
    @columns = ["_id", "_data"]         
          
    if @design_document.count() == 1
      @design = @design_document.next_object
      @columns = @design["columns"]  || @columns
      sort = @design["sort"] || sort
    end
    
    # logger.debug("==========================")
    # logger.debug(@design["columns"])
    # logger.debug(sort_order)
  
    @page = (params[:page] || 1).to_i
    @per_page = (params[:per_page] || 15).to_i
    
    offset = (@page-1) * @per_page
        
    @count = @collection.find({"_id" => {"$ne" => "_design"}}).count()
    @documents = @collection.find({"_id" => {"$ne" => "_design"}},{:offset => offset, :limit => @per_page, :sort => sort}).paginate(@page, @per_page)
    # @documents = @collection.find().paginate(@page, @per_page)
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
    @database = @connection.db(params[:database_id], :pk => IdFactory.new)
  end
  
  
  
end