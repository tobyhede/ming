class DatabasesController < ApplicationController
  
  def index
    @databases = @connection.database_info
  end

  def show    
    @database = @connection.db(params[:id])
    @collections = @database.collection_names
  end
  
  
  def new    
  end
  
  def create
    name = params[:name]
    begin        
      @database = @connection.db(name)  
      flash[:success] = "Database '#{name}' created successfully"
      redirect_to database_url(@database.name)
    rescue Exception => e
      logger.debug e
      flash.now[:error] = "Please enter a database name"
      render :action => "new"      
    end
  end
  
  def edit    
  end
  
  def destroy
    name = params[:name]
    @connection.drop_database(name)
    redirect_to databases_url
  end
  
end