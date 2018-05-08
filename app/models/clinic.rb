class Clinic < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :lab, presence: true
  validates :addr1, presence: true, uniqueness: { scope: :city, case_sensitive: false }
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  default_scope -> { order(id: :asc)}

  def street_addr
    [addr1, addr2].compact.join(" , ")
  end

  def city_state
    "#{city}, #{state}"
  end

  def address
    [street_addr, city_state, zip].compact.join(" , ")
  end

  def full_address
    "#{street_addr}" + "\n" + "#{city_state} #{zip}" + "\n"
  end

  def address_changed?
    addr1_changed? || addr2_changed? || city_changed? || state_changed? || zip_changed?
  end

 	def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      clinic = find_by(addr1: row["addr1"]) || new
      clinic.attributes = row.to_hash
      clinic.save!
    end
  end
end

# rake geocode:all CLASS=Clinic SLEEP=0.25 BATCH=100
