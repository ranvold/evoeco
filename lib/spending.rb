class Spending
  attr_reader :category, :price, :date

  def initialize category, price, date
    @category = category
    @price = price
    @date = date
  end

  def self.is_category_right? category
    categories = ['food', 'housing', 'transportation', 
      'utilities', 'clothing', 'medical', 'other']
    
    categories.include? category
  end

  def self.is_price_correct? price
    price.to_f > 0.0
  end

  def self.is_date_correct? date
    # smth
  end
end