class Product < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :price

  def average_rating
    reviews.map(&:rating).reduce(:+)/reviews.count.to_f
  end

  belongs_to :category
  belongs_to :user
  has_many :reviews
end
