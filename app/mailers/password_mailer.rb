class PasswordMailer < ApplicationMailer

    def registered
        params[:user]

        mail to: "params[:user].email"

    end

end