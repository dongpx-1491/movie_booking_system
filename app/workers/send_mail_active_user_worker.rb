class SendMailActiveUserWorker
  include Sidekiq::Worker
  
  def perform user_id
    @user = User.find_by id: user_id
    return Sidekiq.logger.error(" Cannot found user") unless @user

    @user.send_activation_email
  end
end
