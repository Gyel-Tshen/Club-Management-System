class Event < ApplicationRecord

    belongs_to :user
    def to_s
        event_name
    end
end
