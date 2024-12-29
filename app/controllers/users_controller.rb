class UsersController < ApplicationController
  def index
    @potential_friends = User.potential_friends.where.not(id: current_user.id)

    @pending_followers = current_user.pending_followers
    @accepted_followers = current_user.followers


    @pending_followings = current_user.pending_followings
    @accepted_followings = current_user.followings
  end
end
