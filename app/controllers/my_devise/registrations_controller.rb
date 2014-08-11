class MyDevise::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        redirect_to new_hunt_path
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    user = current_user
    unless user.blank?
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      params[:user].delete(:email) if params[:user][:email].blank?

      current_password = params[:user][:current_password]
      params[:user].delete(:current_password)

      if user.valid_password?(current_password) && user.update_attributes(user_params)
        flash[:notice] = "User updated successfully."
        render :action => 'edit'
      else
        flash[:notice] = "Please enter your password to update profile."
        render :action => 'edit'
      end
    else
      render :action => 'edit'
    end

    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      #respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      #respond_with resource
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :profpic)
    end


end
