class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { in: 3..20 }, :uniqueness => {alert: "Already Exixts" }
	validates :content, presence: true
end
