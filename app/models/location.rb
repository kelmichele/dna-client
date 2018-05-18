class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :lab, presence: true
  validates :addr1, presence: true, uniqueness: { scope: :zip, case_sensitive: false }
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  # default_scope -> { order(state: :asc)}

  def street_addr
    "#{addr1}" + "\n" + "#{addr2}"
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

  def ad_zip
    "#{addr1}, #{zip}"
  end

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file.path)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      location = find_by(addr1: row["addr1"]) || new
      location.attributes = row.to_hash
      location.save!
    end
  end


  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |location|
        csv << location.attributes.values
      end
    end
  end

end

# rake geocode:all CLASS=Location SLEEP=0.25 BATCH=100
