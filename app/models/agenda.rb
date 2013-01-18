class Agenda < ActiveRecord::Base
  attr_accessible :owner, :title
  has_many :ideas, :dependent => :destroy
  validates :title, :presence => true,
                    :length => { :minimum => 1 }

  def self.agendas_to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |agenda|
        csv << agenda.attributes.values_at(*column_names)
      end
    end
  end

  def self.ideas_to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["Description", "", "Likes"]
      csv << []
      @ideas.each do |idea|
        csv << [idea.description]
        csv << []
      end
    end
  end

end