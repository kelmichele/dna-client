class Town < ApplicationRecord
	validates :townname, presence: true, uniqueness: { scope: :state_id, case_sensitive: false }
	belongs_to :state
	validates :state_id, presence: true

  default_scope -> { order(townname: :asc)}

 	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      town = find_by(townname: row["townname"]) || new
      town.attributes = row.to_hash
      town.save!
    end
  end

end
