class Event < ApplicationRecord

    belongs_to :user
    has_many :bookings, dependent: :delete_all
    def to_s
        event_name
    end
    
    CATEGORIES = ["UPCOMING", "PAST", "CURRENT"]
    def self.categories
        CATEGORIES.map{ |categories| [categories, categories]}
    end

    include PublicActivity::Model
    tracked owner: Proc.new{ |controller, model| controller.current_user}

    def booked(user)
        self.bookings.where(user_id: [user.id], course_id: [self.id].empty?)
    end

end
