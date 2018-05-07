class State < ApplicationRecord
	validates :name, presence: true
	validates :abv, presence: true
	has_many :towns, dependent: :destroy

  default_scope -> { order(name: :asc)}
	# State.find_each(&:save)
end
