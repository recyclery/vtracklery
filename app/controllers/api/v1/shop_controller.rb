class Api::V1::ShopsController < Api::V1::BaseController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  # GET /api/v1/shop.json
  def index
    @shop = Shop.all
  end

  # GET /api/v1/shop/1.json
  def show
  end

  # POST /api/v1/shop.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      format.json do
        if @shop.save
          render action: 'show', status: :created, location: @shop
        else
          render json: @shop.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /api/v1/shop/1.json
  def update
    respond_to do |format|
      format.json do
        if @shop.update(shop_params) then head :no_content
        else
          render json: @shop.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /api/v1/shop/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit()
    end
end
