require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "in_stock" do
    mail = ProductMailer.with(product: products(:tshirt), subscriber: subscribers(:davide)).in_stock
    assert_equal "In stock", mail.subject
    assert_equal [ "davide@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Good news!", mail.body.encoded
  end
end
