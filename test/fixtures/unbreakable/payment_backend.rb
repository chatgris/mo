# encoding: UTF-8
class PaymentBackend
  def initialize(args, provider)
    @order = Order.find(@notify.item_id || args['item_number'])
  end
end
