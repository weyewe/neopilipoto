class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|

      t.timestamps
    end
  end
end
