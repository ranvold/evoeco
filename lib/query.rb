require 'sqlite3'

class Query

  @@current_user

  def initialize
    @db = SQLite3::Database.new 'db/evoeco.db'

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

    if matching.first['password'] == password
      @@current_user = matching.first['id']
      return true
    else
      return false
    end
  end

  def signup user
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

end