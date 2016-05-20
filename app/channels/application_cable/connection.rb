# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :uid

    def connect
      self.uid = cookies.signed[:user_id]
    end
=begin
 identified_by :uid

    def connect
      self.uid = find_verified_user#SecureRandom.uuid
    end

    protected

      def find_verified_user
        if uid = User.find(session[:user_id])
          uid
        else
          reject_unauthorized_connection
        end
      end=end
=end


  end
end
