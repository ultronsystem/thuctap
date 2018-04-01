class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: "Kích hoạt tài khoản"
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: "Thay đổi mật khẩu"
  end
end
