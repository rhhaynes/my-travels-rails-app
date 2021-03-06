class Destination < ApplicationRecord
  has_many :travels
  has_many :users, :through => :travels
  has_many :logs, :through => :travels

  before_validation :create_slug_from_name
  validate :slug_is_present_and_unique

  validates :name, :presence   => true,
                   :uniqueness => true

  def self.most_popular(n = 15)
    self.left_joins(:users)
        .group(:name)
        .order("COUNT(users.id) DESC")
        .limit(n)
  end

  def to_param
    self.slug
  end

  private

  def create_slug_from_name
    self.slug = self.name.try(:parameterize)
  end

  def slug_is_present_and_unique
    if self.slug.present? && self.class.where.not(:id => self.id).where(:slug => self.slug).any?
      errors.add(:name, "(slug) already exists")
    end
  end
end
