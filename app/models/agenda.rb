class Agenda < ActiveRecord::Base
  attr_accessible :owner, :title, :user_id, :ideas_count
  has_many :ideas, :dependent => :destroy
  belongs_to :user
  validates :title, :presence => true,
                    :length => { :minimum => 1 }
end