class Log < ApplicationRecord
  belongs_to :travel
  has_one :user, :through => :travel
  has_one :destination, :through => :travel

  validates :title, :presence   => true,
                    :uniqueness => {:scope => :travel, :message => "has already been used"}
end
