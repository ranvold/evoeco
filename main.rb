require './lib/user'
require './lib/query'
require './lib/spending'

# sizes for dates
DAY = 'day'
MONTH = 'month'
YEAR = 'year'

def print_spendings spendings
  spendings.each do |spending|
    print spending['date'].to_s + ' ' if spending['date'] != nil
    print spending['category'].to_s + ' '
    puts spending['price'].to_s + '$'
  end
end

while 2 + 2 == 4
  puts '1. Register'
  puts '2. Login'
  puts '3. Exit'

  command_from_guest = gets.chomp
  
  puts '============================'

  if command_from_guest == '1'
    print 'Username(one word): '

    username = gets.chomp
    
    if (!User.is_username_empty? username) && (!Query.new.is_username_taken? username)
      print 'Password: '

      password = gets.chomp

      Query.new.register User.new username, password

      puts 'Register was successful.'
    else
      if Query.new.is_username_taken? username
        puts 'Username is already taken.'
      else
        puts 'Username requires at least one character!'
      end
    end

  elsif command_from_guest == '2'
    print 'Username: '

    username = gets.chomp

    print 'Password: '

    password = gets.chomp

    if Query.new.is_login_succed? username, password
      while 2 - 2 == 0
        puts '============================'

        puts '1. Add spending'
        puts '2. Get spending statistics'
        puts '3. Get spending statistics by category'
        puts '4. Get spending statistics by day'
        puts '5. Get spending statistics by month'
        puts '6. Get spending statistics by year'
        puts '7. Delete all spendings'
        puts '8. Delete account and all spendings'
        puts '9. Logout'

        command_from_user = gets.chomp

        puts '============================'

        if command_from_user == '1'
          puts "Date: yyyy.mm.dd\n"\
          "Category: food, housing etc\n"\
          "Price: 18.87$\n"\
          "For example: \'2022.08.28 food 15\'"

          date_cat_price = gets.strip.downcase.split(/\ /)
          
          if (Spending.is_date_correct? date_cat_price[0], DAY) && (Spending.is_price_correct? date_cat_price[2])
            Query.new.add_spending Spending.new date_cat_price[0], date_cat_price[1], date_cat_price[2]
            
            puts "Spending added."
          else
            puts "Input wrong format. Try 'yyyy.mm.dd category price'"
          end

        elsif command_from_user == '2'
          spendings = Query.new.spending_statistics

          print_spendings spendings

        elsif command_from_user == '3'
          print 'Enter category: '

          category = gets.chomp.downcase

          spendings = Query.new.spending_statistics_by_category category

          print_spendings spendings

        elsif command_from_user == '4'
          puts 'Enter yyyy.mm.dd:'

          day = gets.chomp

          if Spending.is_date_correct? day, DAY
            spendings = Query.new.spending_statistics_by_day day

            print_spendings spendings
          else
            puts 'Input wrong format'
          end

        elsif command_from_user == '5'
          puts 'Enter yyyy.mm:'

          month = gets.chomp

          if Spending.is_date_correct? month, MONTH
            spendings = Query.new.spending_statistics_by_month month

            print_spendings spendings
          else
            puts 'Input wrong format'
          end

        elsif command_from_user == '6'
          puts 'Enter yyyy:'

          year = gets.chomp

          if Spending.is_date_correct? year, YEAR
            spendings = Query.new.spending_statistics_by_year year

            print_spendings spendings
          else
            puts 'Input wrong format'
          end

        elsif command_from_user == '7'
          print 'Are you sure to delete all spendings?(y/n): '

          ans = gets.chomp.downcase

          if ans == 'y' || ans == 'yes'
            Query.new.delete_spendings
            puts 'All spendings was deleted'
          end
          
        elsif command_from_user == '8'
          print 'Are you sure to delete your account and all spendings?(y/n): '

          ans = gets.chomp.downcase

          if ans == 'y' || ans == 'yes'
            Query.new.delete_account_and_spendings
            puts 'Your account and all spendings were deleted. You are logout.'
            break
          end

        elsif command_from_user == '9'
          Query.new.logout

          puts 'You are logout.'
          break
        end
      end
    else
      puts 'Username or password incorrect!'
    end

  elsif command_from_guest == '3'
    puts 'Goodbye...'
    break
  end

end