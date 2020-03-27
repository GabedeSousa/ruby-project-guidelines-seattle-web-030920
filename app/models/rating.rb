class Rating < ActiveRecord::Base
    belongs_to :practice
    belongs_to :viewer

    # def self.delete_rating
    #     Rating.select(:rating).delete
    # end

    # def self.update_rating(id, practice_id, viewer_id)
    #     Rating.new(id, self, practice_id, viewer)
    # end
    
    
end




