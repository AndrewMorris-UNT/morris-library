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
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to @item, notice: 'Item was successfully created'
    respond_with(@item)
    else
    render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      rediect_to @item, notice: 'Item was successfully updated'
      respond_with(@item)
    else
      render action 'edit'
    end
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
    @item = current_user.items.find_by(id: params[:id])
    redirect_to items_path, notice: "Not authorized to edit this item" if @item.nil? 
  end

    def item_params
      params.require(:item).permit(:description, :image)
    end
end
