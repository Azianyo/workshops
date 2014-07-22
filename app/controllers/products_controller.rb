class ProductsController < ApplicationController

  #before_action :authorize_user, only: [:create, :update]
    # redirect_to() unless current_user

  expose(:category)
  expose(:products)
  expose(:product)
  expose(:review) { Review.new }
  expose_decorated(:reviews, ancestor: :product)

  def index
  end

  def show
  end

  def new
  end

  def edit
    if current_user != product.user
      flash[:error] = "You are not allowed to edit this product."
      redirect_to(category_product_url(category, product))
    end
  end

  def create
     # if current_user == nil
    #   redirect_to(new_user_session_path)&&return
    # end

    self.product = Product.new(product_params)

    if product.save
      category.products << product
      redirect_to category_product_url(category, product), notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    # if current_user == nil
    #   redirect_to(new_user_session_path)&&return
    # end

    if current_user != product.user
      flash[:error] = "You are not allowed to edit this product."
      redirect_to(category_product_url(category, product)) && return
    end

    if self.product.update(product_params)
      redirect_to category_product_url(category, product), notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /products/1
  def destroy
    product.destroy
    redirect_to category_url(product.category), notice: 'Product was successfully destroyed.'
  end

  private
    def product_params
      params.require(:product).permit(:title, :description, :price, :category_id)
    end
end
