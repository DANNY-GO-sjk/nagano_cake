class Item < ApplicationRecord
	enum is_valid: {販売中: true,　販売停止中: false}
end
