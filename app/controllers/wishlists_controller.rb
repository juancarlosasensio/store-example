class WishlistsController < ApplicationController
  before_action :set_user
  before_action :authorize_user
  before_action :set_wishlist, only: [:show, :destroy, :remove_product]
  before_action :set_or_create_wishlist, only: [:add_product]

  def show
  end

  def destroy
    @wishlist.destroy
    redirect_to root_path, notice: "Wishlist was successfully deleted."
  end

  def add_product
    product = Product.find_by(id: params[:product_id])

    unless product
      redirect_to user_wishlist_path(@user), alert: "Product not found."
      return
    end

    if @wishlist.products.exists?(id: product.id)
      redirect_to user_wishlist_path(@user), alert: "Product is already in wishlist."
      return
    end

    if @wishlist.products << product
      redirect_to user_wishlist_path(@user), notice: "Product added to wishlist."
    else
      redirect_to user_wishlist_path(@user), alert: "Failed to add product to wishlist."
    end
  end

  def remove_product
    product = Product.find_by(id: params[:product_id])

    unless product
      redirect_to user_wishlist_path(@user), alert: "Product not found."
      return
    end

    if @wishlist.products.delete(product)
      redirect_to user_wishlist_path(@user), notice: "Product removed from wishlist."
    else
      redirect_to user_wishlist_path(@user), alert: "Failed to remove product from wishlist."
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def authorize_user
    return if Current.user && Current.user.id == @user.id

    redirect_to root_path, alert: "You can only access your own wishlist."
  end

  def set_wishlist
    @wishlist = @user.wishlist
    return if @wishlist

    redirect_to root_path, alert: "Wishlist not found. Please create one first."
  end

  def set_or_create_wishlist
    @wishlist = @user.wishlist || @user.create_wishlist
  end
end
