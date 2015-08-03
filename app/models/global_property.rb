class GlobalProperty < ActiveRecord::Base

  validates :name, :unit, :symbol, presence: true
  validates :symbol, uniqueness: true

end
