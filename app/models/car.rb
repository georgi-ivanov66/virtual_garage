class Car < ApplicationRecord
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many_attached :images
    validates :make, :model, :description, :transmission, :engine,:user_id, presence: true
    validate :image_type

   def thumbnail input
    return self.images[input].variant(resize: '600x337.5!').processed
   end    

   private
   def image_type
    if images.attached? == false
        errors.add(:images, "are missing!")
        end
        images.each do |image|
            if !image.content_type.in?(%('image/jpeg image/png'))
                errors.add(:images, "can only have JPEG or PNG extensions")
            end
        end
    end
end
