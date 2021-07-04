class GalleryController < ApplicationController

  before_action :authenticate_user!, only: :checkout

  def index
    @furnitures = Store.all
  end

  def checkout
	  	
    if request.post?
        puts session[:price]
        amount_to_charge = session[:price].to_i
    ActiveMerchant::Billing::Base.mode = :test

gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
        :login => 'TestMerchant',
        :password => 'password',
        :test => 'true')

# ActiveMerchant accepts all amounts as Integer values in cents
# $10.00

# The card verification value is also known as CVV2, CVC2, or CID
credit_card = ActiveMerchant::Billing::CreditCard.new(
    :first_name         => params[:first_name],
    :last_name          => params[:last_name],
    :number             => params[:credit_no],
    :month              => params[:check][:month],
    :year               => params[:check][:year],
    :verification_value => params[:verification_number])

    # Validating the card automatically detects the card type
    if credit_card.validate.empty?
response = gateway.purchase(amount_to_charge, credit_card)
puts response.inspect
if response.success?
flash[:notice]="Thank You for using National Bodyline. The order details are sent to your mail"
cart=Cart.find(session[:cart_id].to_i)
cart.destroy
session[:cart_id]=nil
redirect_to :action=>:purchase_complete
#puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
else
flash[:notice] = "Gateway failure.Please try again"
render :action=>"checkout"
end
else
flash[:notice]= "Invalid card details"
   redirect_to :action=>"checkout"
#UserNotifier.purchase_complete(session[:user],current_cart).deliver
end
end
end

def search
    @furnitures = Store.find_by_sql("select * from stores WHERE name like '%#{params[:query]}%' or price like '%#{params[:query]}%' ")
end
end