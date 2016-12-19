class UsersController < ApplicationController
  load_and_authorize_resource
  add_breadcrumb User.model_name.human(count: 2), :users_path

  def index
    @q = @users.search(params[:q])
    @q.sorts = 'family_name asc' if @q.sorts.empty?
    @users = @q.result.page(params[:page])
  end

  def show
    add_breadcrumb @user.display_name, @user
  end

  def new
    add_breadcrumb I18n.t('titles.new_model', model: User.model_name.human), new_user_path
  end

  def create
    if user_params[:password] != user_params[:repeat_password]
      @user.errors.add :repeat_password, t('views.users.errors.repeat_password_must_match_the_password')
      render :new
    else
      if user_params[:skip_confirmation] == '1'
        @user.confirmed_at = DateTime.now
      end
      if @user.save
        redirect_to users_path, notice: t('messages.model_was_successfully_created',
          model: User.model_name.human)
      else
        add_breadcrumb I18n.t('titles.new_model', model: User.model_name.human), new_user_path
        render :new
      end
    end
  end

  def edit
    add_breadcrumb @user.display_name, @user
  end

  def edit_email
    add_breadcrumb @user.display_name, @user
  end

  def edit_password
    add_breadcrumb @user.display_name, @user
  end

  def update
    if user_params[:new_email]
      if @user == current_user && !current_user.valid_password?(user_params[:current_password])
        @user.errors.add :current_password, :provide_your_current_password
        render :edit_email
      else
        if user_params[:new_email].present?
          if @user.update email: user_params[:new_email]
            redirect_to my_account_path, flash: { success: t('views.users.your_email_was_updated_successfully') }
          else
            redirect_to edit_email_my_account_path, flash: { alert: 'error' }
          end
        else
          redirect_to my_account_path, flash: { notice: t('views.users.your_email_wasnt_updated') }
        end
      end
    elsif user_params[:new_password]
      if @user == current_user && !current_user.valid_password?(user_params[:current_password])
        @user.errors.add :current_password, :provide_your_current_password
        render :edit_password
      else
        if user_params[:new_password].present? &&
          if user_params[:repeat_password].present? &&
            user_params[:new_password] == user_params[:repeat_password] &&
            @user.update(password: user_params[:new_password])
            bypass_sign_in @user if @user == @current_user
            redirect_to my_account_path, flash: { success: t('views.users.your_password_was_updated_successfully') }
          else
            redirect_to edit_password_my_account_path, flash: { alert: t('views.users.invalid_password_error') }
          end
        else
          redirect_to my_account_path, flash: { notice: t('views.users.your_password_wasnt_updated') }
        end
      end
    else
      if @user.update user_params
        redirect_to users_path, notice: t('messages.model_was_successfully_updated',
          model: User.model_name.human)
      else
        render :edit
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: t('messages.model_was_successfully_deleted',
      model: User.model_name.human)
  end

  private
  def user_params
    params.require(:user).permit :family_name, :email, :password, :roles,
      :new_email, :new_password, :repeat_password, :current_password,
      :skip_confirmation
  end
end
