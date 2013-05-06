class AddIdeasCountToAgendas < ActiveRecord::Migration
  def change
    add_column :agendas, :ideas_count, :integer, :default => 0
  end
end
