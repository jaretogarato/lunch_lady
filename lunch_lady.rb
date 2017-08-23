require 'pry'

# - the user chooses from a list of main dishes
# - the user chooses 2 side dish items
# - computer repeats users order
# - computer totals lunch items and displays total

# wallet class
# OR have a user class, and let the user have a wallet
# dish class
# menu items: hash

class Dish
  attr_accessor :dish, :price

  def initialize(dish, price)
    @dish = dish
    @price = price
  end

  def display_item(item_number)
    dish_length = dish.length
    gap_length = 30 - dish_length
    gap = " "
    i = 0

    while i < (gap_length - 1) do
      gap = gap + " "
      i = i + 1
    end

    "#{item_number}) #{@dish} #{gap} $#{'%.02f' % @price}"
  end
end

class Diner
  attr_accessor :name, :balance, :order
  # give user a name, a wallet, and, in an array, an order

  def initialize
    @name = ''
    @balance = ''
    @order = []
  end

  def get_user_info
    puts 'What is your first name?'
    @name = gets.strip
    puts 'How much money do you have in your wallet?'
    @balance = gets.strip
  end
end

class LunchLady
  attr_accessor :menu, :side_menu, :diner

  def initialize
    @sides = 2;
    @diner = Diner.new
    @menu = []
    @side_menu = []
    @menu << Dish.new('Corn & Capers', 2.49)
    @menu << Dish.new('Maple Meatballs', 4.49)
    @menu << Dish.new('Tangy Tacos', 4.99)
    @menu << Dish.new('Purple Potatoes', 2.99)

    @side_menu << Dish.new('Aged Applesauce', 1.49)
    @side_menu << Dish.new('Burnt Butter', 0.49)
    @side_menu << Dish.new('Fried Fritters', 2.99)
    @side_menu << Dish.new('Steamy Salad', 2.99)
    @side_menu << Dish.new('Cold Slaw', 1.00)
    @side_menu << Dish.new('Soggy Stew', 2.25)
  end

  def say_howdy
    puts "\n\n\n\n\n"
    puts "---------------------------------------"
    puts "~ Welcome To The Lunch Lady Cafeteria ~"
    puts "---------------------------------------\n\n"
    puts "You can order a main dish and two sides."

    @diner.get_user_info
    show_main_menu
  end

  def show_main_menu
    puts "\n************   MAIN MENU   ************"
    puts "---------------------------------------"
    @menu.each_with_index do |item, index|
      puts item.display_item(index + 1)
    end
    puts "---------------------------------------\n"

    get_main_order
  end

  def say_goodbye
    puts "Thanks for visiting."
    exit
  end

  def get_main_order
    puts "What would you like for your main dish?"
    puts "Select a number or type 'exit' to leave."

    user_choice = gets.downcase.strip
    if user_choice == 'exit'
      puts 'See you next time.'
      say_goodbye
      exit
    else
      # main_order_number = gets.strip.to_i - 1
      main_order_number = user_choice.to_i - 1

      if @menu[main_order_number].price.to_f > @diner.balance.to_f
        puts "You can't afford that dish. Try another?"
        show_main_menu
      else
        @diner.order << @menu[main_order_number]
        @diner.balance = @diner.balance.to_f - @menu[main_order_number].price.to_f
        puts "You ordered #{@menu[main_order_number].dish}"
        puts "Your wallet balance is now $#{@diner.balance.round(2)}\n"
        puts "Please select your first side."
        puts "(Select a number or type 'exit' to leave.)"
        show_side_menu
      end
    end
  end

  def show_total
    puts "---------------------------------------"
    puts " Order up for #{@diner.name}!"
    puts " Your order:"
    puts " #{@diner.order[0].dish}"
    puts " #{@diner.order[1].dish}"
    puts " #{@diner.order[2].dish}"
    puts " -----"
    diner_total = (@diner.order[0].price + @diner.order[1].price + @diner.order[0].price).round(2)
    puts " Your total: $#{diner_total}"
    puts " Enjoy your meal."
    puts "---------------------------------------"

  end

  def show_side_menu
    puts "\n************   SIDE MENU   ************"
    puts "---------------------------------------"

    @side_menu.each_with_index do |item, index|
      puts item.display_item(index + 1)
    end
    # binding.pry
    get_side_order
  end

  def get_side_order
    user_choice = gets.downcase.strip
    if user_choice == 'exit'
      puts 'See you next time.'
      say_goodbye
      exit
    else
      side_order_number = user_choice.to_i - 1
      if @side_menu[side_order_number].price.to_f > @diner.balance.to_f
        puts "You can't afford that dish. Try another?"
        show_side_menu
      else
        @diner.order << @side_menu[side_order_number]
        @diner.balance = @diner.balance.to_f - @side_menu[side_order_number].price.to_f
        puts "You ordered #{@side_menu[side_order_number].dish}"
        puts "Your wallet balance is now $#{@diner.balance.round(2)}\n"
        if @sides == 2
          @sides = 1
          puts "Please select your second side"
          puts "(Select a number or type 'exit' to leave.)"
          show_side_menu
        elsif @sides == 1
          @sides = 0
          show_total
        end
      end
    end
  end
end

lunch_lady = LunchLady.new
lunch_lady.say_howdy
