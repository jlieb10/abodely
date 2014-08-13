class Apartment < ActiveRecord::Base
  belongs_to :hunt
  has_many :details

  validates_presence_of :address
end
