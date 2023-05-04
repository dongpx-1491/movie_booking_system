class Admin::PaymentsController <   AdminController
  before_action :find_payment, except: %i(index)
  before_action :load_ticket, only: %i(show)

  def index
    @pagy, @payments = pagy Payment.incre_order
  end

  def show
    respond_to :js
  end

  def destroy
    if @payment.destroy
      flash[:success] = t ".payment_delete"
    else
      flash[:danger] = t ".payment_delete_failed"
    end
    redirect_to admin_payments_path
  end

  private
  def payment_params
    params.require(:payment).permit(:status)
  end

  def find_payment
    @payment = Payment.find_by id: params[:id]
    return if @payment

    flash[:danger] = t ".not_found_payment"
    redirect_to admin_payments_path
  end

  def load_ticket
    @tickets = @payment.tickets
    return if @tickets

    flash[:danger] = t ".not_found_ticket"
    redirect_to admin_payments_path
  end
end
