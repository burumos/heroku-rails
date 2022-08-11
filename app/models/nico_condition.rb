class NicoCondition < ApplicationRecord
  validates :query, :minimum_views, :limit, presence: true
  validates :minimum_views, :limit, numericality: { only_integer: true }
end
