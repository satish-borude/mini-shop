class User < ApplicationRecord
	has_secure_password
	has_one :cart
	has_many :orders
	scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
end
