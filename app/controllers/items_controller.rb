class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  respond_to :html

  def index
    @items = Item.all
    respond_with(@items)
  end

  def show
    respond_with(@item)
  end

  def new
    @item = current_user.items.build
    respond_with(@item)
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params[:entry])
    @item.save
    respond_with(@item)
  end

  def update
    @item.update(item_params)
    respond_with(@item)
  end

  def destroy
    @item.destroy
    respond_with(@item)
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

  def correct_user
    @item = current_user.entries.find_by(id: params[:id])
    redirect_to items_path, notice: "Not authorized to edit this entry" if @item.nil? 
  end

    def item_params
      params.require(:item).permit(:description, :image)
    end
end
