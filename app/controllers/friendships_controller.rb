class FriendshipsController < ApplicationController
  def index
    
  end

  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: params[:confirmed])
    if @friendship.save
      redirect_to user_friendships_path, notice: 'Friend request sent'
    else
      redirect_to user_friendships_path, alert: 'Unable to send friend request'
    end
  end

  def destroy
  end
end
