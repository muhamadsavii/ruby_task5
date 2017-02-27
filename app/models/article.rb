class Article < ActiveRecord::Base
#import excel
 
require 'csv'
require 'roo-xls' 
     
def self.search(search)
 
		where("title LIKE ?","%#{search}%")
		where("content LIKE ?", "%#{search}%")

	end
#def self.import(file)
  
#CSV.foreach(file.path, headers: true) do |row|
    #  Article.create! row.to_hash
   # end  
#end
def self.import(file)
 spreadsheet = Article.open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    article = Article.find_by_id(row["id"]) || new
    article.attributes = row.to_hash
    article.save
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::CSV.new(file.path, packed: false, file_warning: :ignore)
  when ".xls" then Roo::Excel.new(file.path, packed: false, file_warning: :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, packed: false, file_warning: :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end




  
#=================



	#export excel










def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |article|
      csv << article.attributes.values_at(*column_names)
    end
  end
end


    #=================

	#name relation must plural
	
        has_many :comments, dependent: :destroy



        

	  scope :status_active, -> {where(status: 'active')}

	  validates :title, presence: true,

                            length: { minimum: 5 }

        validates :content, presence: true,

                            length: { minimum: 10 }

        validates :status, presence: true

        # ============================
        scope :status_active, -> {where(status: 'active')}
end
