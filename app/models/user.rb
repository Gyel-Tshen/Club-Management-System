class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_one_attached :avatar
  has_many :events, dependent: :delete_all
  has_many :bookings, dependent: :delete_all



  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: "100x100!").processed
    else
      '/default_profile.jpg'
    end
  end

  def to_s
    email
  end
   
 
  def username
    self.email.split(/@/).first
  end


  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin)
    else
      self.add_role(:member)
    end
  end

  validate :must_have_a_role, on: :update

  def book_event(event)
    self.bookings.create(event: event)
  end

  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have atleat one role")
    end
  end

  
end
