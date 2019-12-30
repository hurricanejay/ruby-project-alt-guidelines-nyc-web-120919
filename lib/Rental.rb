class Rental < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews
    has_many :favorites
    has_many :users, through: :favorites

    def self.highest_rating
        self.maximum(:rating)
    end

    def self.lowest_rating
        self.minimum(:rating)
    end

    def self.average_rating
        self.average(:rating)
    end

end