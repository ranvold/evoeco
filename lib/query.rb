require 'sqlite3'

class Query

  @@current_user

  def initialize
    @db = SQLite3::Database.new 'db/evoeco.sqlite3'

    @db.results_as_hash = true

    @db.execute 'CREATE TABLE IF NOT EXISTS
      "users"
      (
        "id" INTEGER PRIMARY KEY,
        "username" TEXT,
        "password" TEXT
      )'

    @db.execute 'CREATE TABLE IF NOT EXISTS
      "spendings"
      (
        "id" INTEGER PRIMARY KEY,
        "user_id" INTEGER,
        "category" TEXT,
        "price" REAL,
        "date" TEXT,
        FOREIGN KEY (user_id)
          REFERENCES users (id)
      )'
  end

  def is_username_taken? username
    matching = @db.execute "SELECT username FROM users 
    WHERE username='#{username}'"

    matching.size != 0
  end

  def is_login_succed? username, password
    matching = @db.execute "SELECT * FROM users 
    WHERE username='#{username}'"

    if !matching.empty? && matching.first['password'] == password
      @@current_user = matching.first['id']
      return true
    else
      return false
    end
  end

  def logout
    @@current_user = 0
  end

  def register user
    @db.execute 'INSERT INTO
      users
      (
        username,
        password
      )
      values (?, ?)', [user.username, user.password]
  end

  def add_spending spending
    @db.execute 'INSERT INTO
      spendings
      (
        user_id,
        category,
        price,
        date
      )
      values (?, ?, ?, ?)', [@@current_user, 
        spending.category, spending.price, spending.date]
  end

  def spending_statistics
    @db.execute "SELECT date, category, SUM(price) as price FROM spendings
      WHERE user_id='#{@@current_user}' GROUP BY category, date"
  end

  def spending_statistics_by_category category
    @db.execute "SELECT date, category, SUM(price) as price FROM spendings
      WHERE user_id='#{@@current_user}' AND category='#{category}' GROUP BY date"
  end

  def spending_statistics_by_day day
    @db.execute "SELECT category, SUM(price) as price FROM spendings
      WHERE user_id='#{@@current_user}' AND date='#{day}' GROUP BY category"
  end

  def spending_statistics_by_month month
    @db.execute "SELECT category, SUM(price) as price FROM spendings
      WHERE user_id='#{@@current_user}' AND date>='#{month + '.01'}' 
        AND date<='#{month + '.31'}' GROUP BY category"
  end

  def spending_statistics_by_year year
    @db.execute "SELECT category, SUM(price) as price FROM spendings
      WHERE user_id='#{@@current_user}' AND date>='#{year + '.01.01'}' 
        AND date<='#{year + '.12.31'}' GROUP BY category"
  end

  def delete_spendings
    @db.execute "DELETE FROM spendings 
      WHERE user_id='#{@@current_user}'"
  end

  def delete_account_and_spendings
    delete_spendings  
    
    @db.execute "DELETE FROM users 
      WHERE id='#{@@current_user}'"

    logout
  end
  
end