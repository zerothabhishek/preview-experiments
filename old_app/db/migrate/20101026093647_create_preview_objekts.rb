class CreatePreviewObjekts < ActiveRecord::Migration
  def self.up
    create_table :preview_objekts do |t|
      t.text :objekt
      t.string :klass
      t.integer :idee

      t.timestamps
    end
  end

  def self.down
    drop_table :preview_objekts
  end
end
