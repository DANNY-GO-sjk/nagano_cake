class Genre < ApplicationRecord
	has_many :items

	enum is_valid: {有効: true, 無効: false}

	validates :name presence: true
end
