class Booking < ApplicationRecord
  belongs_to :event, counter_cache: true
  belongs_to :user

  validates :user, :event, presence: true

  validates_uniqueness_of :user_id, scope: :event_id
  validates_uniqueness_of :event_id, scope: :user_id

  def to_s
    user.to_s + " " + event.to_s
  end


  validate :cant_book_to_own_event
  protected
  def cant_book_to_own_event
    if self.new_record?
      if user_id == event.user_id
        errors.add(:base, "You cant book your own event")
      end
    end
  end

  

end
