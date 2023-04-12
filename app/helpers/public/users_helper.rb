module Public::UsersHelper
  def isGuest
    current_user.email == "guest@email.com"
  end
end
