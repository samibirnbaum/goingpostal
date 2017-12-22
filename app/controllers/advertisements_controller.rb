class AdvertisementsController < ApplicationController
  def index
    @ads = Advertisement.all
  end

  def show
    id_query = params[:id]
    @advert = Advertisement.find(id_query)
  end

  def new
    @advert = Advertisement.new
  end

  def create
    @advert = Advertisement.new
    @advert.title = params[:advertisement][:title]
    @advert.copy = params[:advertisement][:copy]
    @advert.price = params[:advertisement][:price]

    if @advert.save
      flash[:notice] = "New advertisement successfully saved"
      redirect_to(advertisement_path(Advertisement.last.id))
    else
      flash.now[:alert] = "Error in processing your new advertisement - Please try again."
      render :new
    end
  end
end
