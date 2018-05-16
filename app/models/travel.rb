class Travel < ApplicationRecord
  belongs_to :user
  belongs_to :destination
  has_many :logs, :dependent => :destroy
  accepts_nested_attributes_for :destination

  validate :start_date_before_end_date

  validates :start_date, :presence => true

  def destination_attributes=(destination)
    self.destination = Destination.find_or_create_by(destination)
    self.destination.update(destination)
  end

  private

  def start_date_before_end_date
    if self.start_date.present? && self.end_date.present? && ( self.end_date - self.start_date ).to_i < 0
      errors.add(:end_date, "cannot be ahead of start date")
    end
  end
end
