class Plate < ActiveRecord::Base
	validates :plate , presence: true
end
