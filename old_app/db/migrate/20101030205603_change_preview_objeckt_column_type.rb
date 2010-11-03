class ChangePreviewObjecktColumnType < ActiveRecord::Migration
  def self.up
    # Turn the objekt column in preview_objkets table to binary type
    change_column(:preview_objekts, :objekt, :binary, :limit => 4.kilobytes)
  end

  def self.down
    # Turn back the objekt column in preview_objkets table to text type
    change_column(:preview_objekts, :objekt, :text)
  end
end
