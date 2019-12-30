class User < ActiveRecord::Base
    has_many :reviews
    has_many :rentals, through: :reviews
    has_many :favorites
    has_many :favorites, through: :reviews

    def most_recent_review
        self.last.review
    end





end