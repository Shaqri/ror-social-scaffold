module UserHelper
  def add_friend(user)
    link_to('Add friend', user_friendships_path(user_id: current_user.id, friend_id: user.id, confirmed: false), method: :post )
  end
  
  def cancel_friend_request(user)
    link_to('Cancel', user_cancel_request_path(id: user.id, user_id: current_user.id), method: :delete)
  end

end
