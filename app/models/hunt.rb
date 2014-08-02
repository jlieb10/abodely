class Hunt < ActiveRecord::Base
  has_many :user_hunts
  has_many :users, through: :user_hunts
  has_many :apartments

  validates_presence_of :title
end
