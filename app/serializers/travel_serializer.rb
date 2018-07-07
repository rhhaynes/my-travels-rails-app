class TravelSerializer < ActiveModel::Serializer
  attributes :id, :purpose, :start_date, :end_date
  belongs_to :user
  belongs_to :destination
  has_many :logs
end
