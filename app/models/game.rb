class Game < ApplicationRecord

  has_many :purcharses

  validates :title,{
 		length: { minimum: 10,  maximum: 50 },
 		presence: true
		}
 	validates :description,{
 		length: { minimum: 30 },
 		presence: true
		}
 	validates :image_url,{
 		presence: true
		}

end
