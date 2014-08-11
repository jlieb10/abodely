class UsersController < ApplicationController
  def show
  	@user = current_user
  end

  def update
        binding.pry

  end
end
