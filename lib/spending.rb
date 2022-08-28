class Spending
  attr_reader :date, :category, :price

  def initialize date, category, price
    @date = date
    @category = category
    @price = price

  end

  # def self.is_category_right? category
  #   categories = ['food', 'housing', 'transportation', 
  #     'utilities', 'clothing', 'medical', 'other']
    
  #   categories.include? category
  # end

  def self.is_price_correct? price
    price.to_f > 0.0
  end

  def self.is_date_correct? date, size
    yyyy_mm_dd = date.split(/\./)

    if yyyy_mm_dd.size == 3 && size == 'day'
      is_day_correct? yyyy_mm_dd[0].to_i, yyyy_mm_dd[1].to_i, yyyy_mm_dd[2].to_i
    elsif yyyy_mm_dd.size == 2 && size == 'month'
      (is_year_correct? yyyy_mm_dd[0].to_i) && (is_month_correct? yyyy_mm_dd[1].to_i)
    elsif yyyy_mm_dd.size == 1 && size == 'year'
      is_year_correct? yyyy_mm_dd[0].to_i
    else
      return false
    end

  end

  private

  def self.is_year_correct? year
    year > 2000 && year < 2100
  end

  def self.is_month_correct? month
    month >= 1 && month <= 12
  end

  def self.is_day_correct? year, month, day
    month31 = [1, 3, 5, 7, 8, 10, 12]

    month30 = [4, 6, 9, 11]

    february = 2

    if month31.include? month
      day >= 1 && day <= 31
    elsif month30.include? month
      day >= 1 && day <= 30
    elsif month == february
      day == 29 if Time.new(year, month, day) != Time.new(year, 03, 01) # Leap year
      day >= 1 && day <= 28
    end
  end
  
end