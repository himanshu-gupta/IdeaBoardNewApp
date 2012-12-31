class Agenda < ActiveRecord::Base
  attr_accessible :owner, :title
  has_many :ideas, :dependent => :destroy
  validates :title, :presence => true,
                    :length => { :minimum => 1 }
end
