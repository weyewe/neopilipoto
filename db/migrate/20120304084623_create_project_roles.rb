class CreateProjectRoles < ActiveRecord::Migration
  def change
    create_table :project_roles do |t|

      t.timestamps
    end
  end
end
