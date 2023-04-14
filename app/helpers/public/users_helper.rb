module Public::UsersHelper
  def isGuest(email)
    if email.present?
      return email == "guest@email.com"
    end
    return false
  end
end
