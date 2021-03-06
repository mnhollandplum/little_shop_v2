require 'rails_helper'

describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status}
  end

  describe "Relationships" do
    it { should belong_to :user}
    it { should have_many(:items).through(:order_items)}
    it { should have_many(:order_items)}
  end

  describe "Methods" do

    before(:each) do
      @user_1, @user_2 = create_list(:user, 2)
      @merchant = create(:user, :merchant)
      @other_merchant = create(:user, :merchant)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
      @order_1 = @user_1.orders.create(status: 'pending')
      @order_2 = @user_2.orders.create(status: 'pending')
      @order_3 = @user_2.orders.create(status: 'pending')
      @item_1 = Item.create( name: "Oval Link Chain Belt",	description: "Add something a little unexpected with this oval link chain belt that takes your look from casual to chic in an instant.", price:	36.26, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0625201317031085M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @other_merchant.id )
      @item_2 = Item.create( name: "Liz Claiborne® Tipped Tank Top - Petite",	description: "Beat the heat in our crepe tank top with contrast tipping for extra sizzle.  roundneck gently rounded hem polyester washable imported", price:	43.51, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP1220201417021434M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @other_merchant.id )
      @item_3 = Item.create( name: "St. John’s Bay® Inlet Mens Canvas Boat Shoes",	description: "Casual in canvas, these preppy slip-on boat shoes are ideal for laid-back living.   cotton canvas upper slip on with lace-up detail contrast stitching canvas lining textile/rubber sole", price: 48.34, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP1215201417013852M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @other_merchant.id )
      @item_4 = Item.create( name: "Nike® 6-pk. Performance Crew Socks - Boys",	description: "Classic crew socks with the best logo in sports.   cotton/polyester/spandex washable imported", price:	21.76, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0321201319025100C.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp", enabled: true, inventory: 100, user_id: @merchant.id )
      @item_5 = Item.create( name: "Deer Stags® Herman Mens Fringed Loafers",	description: "Classic loafer style dresses up casual outfits, perfect for business casual offices. Men's loafers feature a leather-blend upper with fringe and tassel decoration.   leather/synthetic upper SUPRO comfort built-in orthotic slip-on durable rubber sole", price:	76.86, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0409201317002388M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
      @item_6 = Item.create( name: "Okie Dokie® Bessie Girls Bumptoe Shoes - Toddler",	description: "Cute and comfy, the adorable strap shoes are great for everyday play.   synthetic upper flexible strap near ankle for a secure fit rubber sole", price:	36.26, thumbnail: "http://s7d9.scene7.com/is/image/JCPenney/DP1116201517012676M.tif?hei=380&amp;wid=380&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
      @item_7 = Item.create( name: "New Balance® Jojo Womens Sandals",	description: "Head to the pool or lounge at the beach in these casual, lightweight women's sandals. A synthetic, stretchable upper provides a personalized fit.   synthetic upper soft Lycra upper moldable footbed lightweight EVA sole", price:	30.22, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0207201417175260M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
      @item_8 = Item.create( name: "St. John's Bay® Drape-Front Jacquard Cardigan - Petite",	description: "imported machine washable cotton/acrylic/other fiber", price:	59.12, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP1016201517095585M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
      @item_9 = Item.create( name: "Deer Stags® Mack Boys Hiking Boots - Little Kids/Big Kids",	description: "Lace-up boys' hiking boots from Deer Stags feature a durable synthetic upper and a rugged rubber sole. Water- and oil-resistant for superior traction in any situation.   synthetic upper lace-up oil-resistant water-resistant rubber sole", price:	59.14, thumbnail: "http://s7d2.scene7.com/is/image/JCPenney/DP0403201317013346M.tif?wid=65&hei=65&fmt=jpg&op_usm=.4,.8,0,0&resmode=sharp2", enabled: true, inventory: 100, user_id: @merchant.id )
      @order_item_1 = OrderItem.create(order_id: @order_1.id, item_id: @item_1.id, price: 36.26, quantity: 1)
      @order_item_2 = OrderItem.create(order_id: @order_1.id, item_id: @item_2.id, price: 43.51, quantity: 2)
      @order_item_3 = OrderItem.create(order_id: @order_1.id, item_id: @item_3.id, price: 48.34, quantity: 1)
      @order_item_4 = OrderItem.create(order_id: @order_1.id, item_id: @item_4.id, price: 21.76, quantity: 3)
      @order_item_5 = OrderItem.create(order_id: @order_1.id, item_id: @item_5.id, price: 76.86, quantity: 1)
      @order_item_6 = OrderItem.create(order_id: @order_2.id, item_id: @item_6.id, price: 36.26, quantity: 4)
      @order_item_7 = OrderItem.create(order_id: @order_2.id, item_id: @item_7.id, price: 30.22, quantity: 5)
      @order_item_8 = OrderItem.create(order_id: @order_2.id, item_id: @item_8.id, price: 59.12, quantity: 1)
      @order_item_9 = OrderItem.create(order_id: @order_2.id, item_id: @item_9.id, price: 59.14, quantity: 1)
    end

    it "should return the total quantity of an order" do
      total_quantity = @order_1.total_quantity
      expect(total_quantity).to eq(8)
    end

    it "should return the total price of an order" do
      total_price = @order_1.total_price
      expect(total_price).to eq(226.73)
    end

    it "should cancel an order" do
      expect(@order_1.status).to eq('pending')
      @order_1.cancel
      expect(@order_1.status).to eq('cancelled')
    end

    it "should return all items in an order for a given merchant" do
      items = @order_1.items_for_merchant(@merchant)

      expect(items).to eq([@item_4, @item_5])
    end

    it 'should update status to complete if all items are fulfilled' do

      expect(@order_1.status).to eq('pending')

      @order_item_1.fulfill
      @order_item_2.fulfill
      @order_item_3.fulfill
      @order_item_4.fulfill
      @order_item_5.fulfill

      expect(@order_1.update_status).to eq("Order status updated to complete.")
      expect(@order_1.status).to eq('complete')
    end

    it 'should not update status if any items are pending' do

      expect(@order_1.status).to eq('pending')

      @order_item_1.fulfill
      # @order_item_2.fulfill
      # @order_item_3.fulfill
      @order_item_4.fulfill
      @order_item_5.fulfill

      expect(@order_1.update_status).to eq("Order status is pending.")
      expect(@order_1.status).to eq('pending')
    end
  end
end
