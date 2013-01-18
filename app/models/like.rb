class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :agenda
  belongs_to :idea
  # attr_accessible :title, :body
end
