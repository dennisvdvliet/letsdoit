class AddProjectIdToUsers < ActiveRecord::Migration
  def change
    # no integer since for example Trello has string as identifiers
    add_column :users, :project_id, :string
    add_column :users, :tasklist_id, :string
  end
end
