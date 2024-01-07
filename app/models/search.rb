class Search < ApplicationRecord
  validates :query, presence: true
  validates :ip_address, presence: true
  attribute :count, :integer, default: 0
end
