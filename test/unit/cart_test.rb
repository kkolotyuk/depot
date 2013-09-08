require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add_unique_product" do
    current_item = carts(:one).add_product(products(:ruby).id)
    assert !current_item.invalid?
    assert current_item.quantity == 1
    assert current_item.price == products(:ruby).price
  end

  test "add_duplicate_product" do
    current_item = carts(:one).add_product(products(:ruby).id)
    assert current_item.save, 'The first product saved'
    current_item = carts(:one).add_product(products(:ruby).id)
    assert current_item.save, 'The second product saved'
    assert carts(:one).line_items.count == 1, "The cart has only one line_item #{carts(:one).line_items.count}"
    assert current_item.quantity == 2, 'The line_item quantity is 2'
    assert current_item.price == products(:ruby).price, 'The price of line_item equals the price of product'
  end
end
