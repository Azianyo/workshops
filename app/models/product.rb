class Product < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :price

  def average_rating
    reviews.map(&:rating).reduce(:+)/reviews.count.to_f
  end

  validates_format_of :price, :with => /\A\d+\.\d{1,2}\z/
  belongs_to :category
  belongs_to :user
  has_many :reviews
end
