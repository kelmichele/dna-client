class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :lab, presence: true
  validates :addr1, presence: true, uniqueness: { scope: :city, case_sensitive: false }
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  default_scope -> { order(state: :asc)}

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

  def abbrv_to_names
    abbrv_to_names("AL" => "Alabama", "AK" => "Alaska", "AZ" => "Arizona", "AR" => "Arkansas", "CA" => "California", "CO" => "Colorado", "CT" => "Connecticut", "DE" => "Delaware", "FL" => "Florida", "GA" => "Georgia", "HI" => "Hawaii", "ID" => "Idaho", "IL" => "Illinois", "IN" => "Indiana", "IA" => "Iowa", "KS" => "Kansas", "KY" => "Kentucky", "LA" => "Louisiana", "ME" => "Maine", "MD" => "Maryland", "MA" => "Massachusetts", "MI" => "Michigan", "MN" => "Minnesota", "MS" => "Mississippi", "MO" => "Missouri", "MT" => "Montana", "NE" => "Nebraska", "NV" => "Nevada", "NH" => "New Hampshire", "NJ" => "New Jersey", "NM" => "New Mexico", "NY" => "New York", "NC" => "North Carolina", "ND" => "North Dakota", "OH" => "Ohio", "OK" => "Oklahoma", "OR" => "Oregon", "PA" => "Pennsylvania", "RI" => "Rhode Island", "SC" => "South Carolina", "SD" => "South Dakota", "TN" => "Tennessee", "TX" => "Texas", "UT" => "Utah", "VT" => "Vermont", "VA" => "Virginia", "WA" => "Washington", "DC" => "Washington DC", "WV" => "West Virginia", "WI" => "Wisconsin", "WY" => "Wyoming")
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
