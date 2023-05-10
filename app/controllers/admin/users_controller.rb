class Admin::UsersController < AdminController
  before_action :find_user, :load_payment, only: %i(show update)

  def index
    @search = User.incre_order.ransack(params[:q])
    @pagy, @users = pagy @search.result,
                          items: Settings.model.limited
  end

  def show
    respond_to :js
  end

  def update
    if @user.update_column(:role, params.dig(:user, :role_before_type_cast))
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".danger")
    end
    redirect_to admin_users_path
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".not_found_user"
    redirect_to admin_users_path
  end

  def load_payment
    @payments = @user.payments
    return if @payments

    flash[:danger] = t ".not_found_payment"
    redirect_to admin_users_path
  end
end
