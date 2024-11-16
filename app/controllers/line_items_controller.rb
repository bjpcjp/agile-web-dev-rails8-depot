class LineItemsController < ApplicationController
  include CurrentCart # concern - book pg 125
  before_action :set_cart,      only: %i[ create ] # book pg 125
  before_action :set_line_item, only: %i[ show edit update destroy ]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items or /line_items.json
  def create
    p = Product.find(params[:product_id]) # book pg 126
    # @line_item = LineItem.new(line_item_params)
    @line_item = @cart.line_items.build(product: p) # book pg 126

    respond_to do |format|
      if @line_item.save # book pg 126
        # format.html { redirect_to @line_item, notice: "Line item was successfully created." }
        format.html { redirect_to @line_item.cart, notice: "Line item was successfully created." }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    @line_item.destroy!

    respond_to do |format|
      format.html { redirect_to line_items_path, status: :see_other, notice: "Line item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.expect(line_item: [ :product_id, :cart_id ])
    end
end
