class Detail < ActiveRecord::Base
  belongs_to :apartment
  mount_uploader :image, ImageUploader

  validates_presence_of :content, unless: ->(detail){detail.image.present?}
  validates_presence_of :image, unless: ->(detail){detail.content.present?}

end
