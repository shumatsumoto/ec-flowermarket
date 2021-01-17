class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy]
  before_action :search_product, only: [:index]
  before_action :ranking_product, only: [:index]

  # GET /products
  # GET /products.json
  def index
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @order = Order.find_by(product_id: @product.id)
    @card = Card.where(user_id: current_user.id).first
    unless @card.present?
      redirect_to card_index_path
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def purchase
    @card = Card.where(user_id: current_user.id).first
    @product = Product.find(params[:id])
    @order = Order.new
    @order.user_id = current_user.id
    @order.product_id = @product.id
    @order.count = params[:count]
    @order.total_price = @product.price * @order.count
    if @order.save!
      #Payjp 秘密鍵取得
      Payjp.api_key = 'sk_test_245b715118ddb546982b02d4'
      charge = Payjp::Charge.create(
        amount: @order.total_price,
        customer: Payjp::Customer.retrieve(@card.customer_id),
        currency: 'jpy'
      )
      redirect_to root_path, notice: '購入しました'
    else
      flash[:alert] = '購入に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :price, :image, :summery)
    end

    def require_admin
      if !current_user.admin_flag?
        redirect_to products_path
      end
    end

    def search_product
      @q = Product.ransack(params[:q])
      @products = @q.result(distinct: true)
    end

    def ranking_product
      @product_group = Order.group(:product_id).sum(:total_price)
      @ranking = Hash[ @product_group.sort_by{ |_, v| -v } ]
    end
end
