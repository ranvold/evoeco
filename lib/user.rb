class User
  attr_reader :username, :password

  def initialize username, password
    @username = username
    @password = password
  end

  def self.is_username_empty? username
    username.to_s.empty?
  end

end