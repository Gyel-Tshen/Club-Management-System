class BookingPolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  
    def index?
      @user.has_role?(:admin) 
    end

    def create?
        @user.has_role?(:admin) || @record.user_id == @user.id
    end
    def edit?
        @user.has_role(:admin)
    end
  
    def update?
        @user.has_role?(:admin) || @record.user_id == @user.id
    end
  
    def destory?
        @user.has_role?(:admin)
    end 
end
  