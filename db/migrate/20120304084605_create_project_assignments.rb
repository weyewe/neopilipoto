class CreateProjectAssignments < ActiveRecord::Migration
  def change
    create_table :project_assignments do |t|

      t.timestamps
    end
  end
end
