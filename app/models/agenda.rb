class Agenda < ActiveRecord::Base
  attr_accessible :owner, :title
  has_many :ideas, :dependent => :destroy
  validates :title, :presence => true,
                    :length => { :minimum => 1 }

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |agenda|
        csv << agenda.attributes.values_at(*column_names)
      end
    end
  end
end