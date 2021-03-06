require 'rails_helper'

describe 'user checks out of cart' do

  before(:each) do
    @user_1, @user_2 = create_list(:user, 2)
    @merchant = create(:user, :merchant)
    @other_merchant = create(:user, :merchant)
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
    OrderItem.create(order_id: @order_1.id, item_id: @item_1.id, price: 36.26, quantity: 1)
    OrderItem.create(order_id: @order_1.id, item_id: @item_2.id, price: 43.51, quantity: 2)
    OrderItem.create(order_id: @order_1.id, item_id: @item_3.id, price: 48.34, quantity: 1)
    OrderItem.create(order_id: @order_1.id, item_id: @item_4.id, price: 21.76, quantity: 3)
    OrderItem.create(order_id: @order_1.id, item_id: @item_5.id, price: 76.86, quantity: 1)
    OrderItem.create(order_id: @order_2.id, item_id: @item_6.id, price: 36.26, quantity: 4)
    OrderItem.create(order_id: @order_2.id, item_id: @item_7.id, price: 30.22, quantity: 5)
    OrderItem.create(order_id: @order_2.id, item_id: @item_8.id, price: 59.12, quantity: 1)
    OrderItem.create(order_id: @order_2.id, item_id: @item_9.id, price: 59.14, quantity: 1)
  end

  describe 'as a registered user when I visit my cart' do
    it 'I see a checkout button' do

    visit root_path

    click_on "Register"

    expect(current_path).to eq(register_path)

    fill_in :user_name, with: "Test Person"
    fill_in :user_address, with: "123 alphabet lane"
    fill_in :user_city, with: "Denver"
    fill_in :user_state, with: "CO"
    fill_in :user_zip, with: "80205"
    fill_in :user_email, with: "test@test.com"
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"

    click_on "Create User"

    visit items_path

    within(:css, "#item_#{@item_1.id}") do
      click_button "Add to Cart"
    end

    expect(page).to have_content("You now have 1 #{@item_1.name}.")

    visit cart_path

    expect(page).to have_content("Check Out")
    end

    it 'I click on the checkout button and an order is created' do
      visit login_path

      fill_in "Email", with: @user_1.email
      fill_in "Password", with: @user_1.password

      click_on "Log in"

      click_on "Items"

      within(:css, "#item_#{@item_1.id}") do
        click_button "Add to Cart"
      end

      within(:css, "#item_#{@item_2.id}") do
        click_button "Add to Cart"
      end

      visit cart_path

      click_on "Check Out"

      expect(current_path).to eq(profile_orders_path)
      expect(page).to have_content("Order #{Order.last.id}")
      expect(page).to have_content("Cart: 0")
    end
  end


  describe 'as a visitor' do
    it 'I am asked to login before I can checkout' do

      visit items_path

      within(:css, "#item_#{@item_1.id}") do
        click_button "Add to Cart"
      end

      expect(page).to have_content("You now have 1 #{@item_1.name}.")

      visit cart_path

      expect(page).to have_content("You must Register or Login to checkout.")
    end
  end
end
