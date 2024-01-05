class Search < ApplicationRecord
  validates :query, presence: true
  validates :ip_address, presence: true

  def self.analytics
    group(:query).order('COUNT(*) DESC').count
  end
end
