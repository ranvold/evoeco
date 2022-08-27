require "./lib/user"
require "./lib/query"
require "./lib/spending"

spending1 = Spending.new 'food', 25, '2022.05.12'

Query.new.is_login_succed? 'user1', '1111'
Query.new.add_spending spending1