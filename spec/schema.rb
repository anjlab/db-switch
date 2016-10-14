ActiveRecord::Schema.define do
  self.verbose = false

  unless data_source_exists?(:users)
    create_table(:users) do |t|
      t.string :name
      t.integer :age
      t.timestamps
    end
  end
end