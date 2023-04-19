class SendMailResetPassWorker
  include Sidekiq::Worker

  def perform user_id
    @user = User.find_by id: user_id
    return Sidekiq.logger.error("Cannot found user") unless @user

    @user.create_reset_digest
    @user.send_password_reset_email
  end
end
