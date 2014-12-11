class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  respond_to :html

    def index
    @Items = Item.all
  end

  def show
  end

  def new
    @item = current_user.Items.build
  end

  def edit
  end

  def create
    @item = current_user.Items.build
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @Item.destroy
    redirect_to Items_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = item.find(params[:id])
    end

    def correct_user
      @item = current_user.Items.find_by(id: params[:id])
      redirect_to Items_path, notice: "Not authorized to edit this item" if @item.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:description, :image)
    end
end