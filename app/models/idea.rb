class Idea < ActiveRecord::Base
  belongs_to :agenda
  attr_accessible :description, :likes
  validates :description, :presence => true,
                    :length => { :minimum => 1 }
end
