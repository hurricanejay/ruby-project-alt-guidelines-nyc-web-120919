class Review < ActiveRecord::Base
    belongs_to :rental
    belongs_to :user

    def display_review
        review = User.find(self.review_id)
    end

    def all_reviews
        self.all
    end

end