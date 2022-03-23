module Api::V1
  class GalleriesController < ApplicationController

  def index
    @galleries = Gallery.all.order('id DESC')
    render json: @galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
    render json: @gallery
  end

  def create
    @gallery = Gallery.create(gallery_params)
    @gallery.save
    render json: @gallery
  end

  def destroy
    gallery = Gallery.find(params[:id])
    gallery.destroy
  end

  protected
    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.permit( :item, :id)
    end

  end
end
