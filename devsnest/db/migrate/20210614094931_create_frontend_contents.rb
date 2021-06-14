class CreateFrontendContents < ActiveRecord::Migration[6.0]
  def change
    create_table :frontend_contents do |t|
      t.string :name
      t.text :summary
      t.string :github_link
      t.string :web_view_link
      t.string :youtube_link
      t.date :project_start
      t.date :project_end

      t.timestamps
    end
  end
end
