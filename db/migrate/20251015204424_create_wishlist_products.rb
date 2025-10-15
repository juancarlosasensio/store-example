class CreateWishlistProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :wishlist_products do |t|
      t.references :wishlist, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :wishlist_products, [:wishlist_id, :product_id], unique: true
  end
end
