class AlbumsController < ApplicationController
  before_action :authenticate_user!, only: [:draft, :myalbum]
  
  def index
    
    @q = Album.ransack(params[:q])
    @albums = @q.result.includes(:tags).where(publish: true).page(params[:page])
    @user_name = User.all
  
  end
  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
  redirect_back(fallback_location: albums_path)
  
  end
  

  def myalbum 
       
    # @my_published_albums = Album.where(user_id: current_user.id, publish: true)  
    # @my_unpublished_albums = Album.where(user_id: current_user.id, publish: false) 
      @myalbums = Album.where(user_id: current_user.id)
    
  end 
  
  def draft
     @my_unpublished_albums = Album.where(user_id: current_user.id, publish: false) 
   
  end  
  
  def show
    @album = Album.find(params[:id])    
  end

  def new
    @album = Album.new    
  end

  def create
    @album = Album.create!(album_params)

    if @album.save
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end    
  end

  def edit
    
    @album =Album.find(params[:id]) 
 
  
 
  end

  def update
    @album = Album.find(params[:id])

    if @album.update!(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end    
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to root_path, status: :see_other
    
  end
  
  

  private
    def album_params
      params.require(:album).permit(:name, :description, :price, :publish, :user_id,:tag_list,:cover, images:[])
      
    end 
 
     
  
end
