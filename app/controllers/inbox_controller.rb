class InboxController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    email = Mail.read_from_string(request.body.read)
    body = email.body.parts[0].decoded

    Email.create!(
        subject: email.subject,
        date: email.date,
        from: email.from,
        to: email.to,
        body: body,
        verification_link: body.match(/https?:\/\/[a-zA-Z\d.\/]+/)
      )
  end
end