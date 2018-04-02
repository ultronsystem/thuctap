namespace :admin do
  # desc "TODO"
  task admin_account: :environment do
    User.create!(fullname: "AAA", email: "admin@gmail.com", password: "112344",
      password_confirmation: "112344", is_admin: true, activated: true)
  end

end
