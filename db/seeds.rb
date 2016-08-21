User.create(email: ENV.fetch('ADMIN_EMAIL'), password: ENV.fetch('ADMIN_PASSWORD'))
