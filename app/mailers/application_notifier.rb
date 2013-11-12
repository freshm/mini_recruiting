class ApplicationNotifier < ActionMailer::Base
  default from: "admin@mini-recruiting.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.new_application.subject
  #
  def new_application(vacancy, user)
    @vacancy = vacancy
    @user = user
    admins = Admin.all
    
    mail to: @vacancy.admin.email, subject: "New Job Application by #{@user.fullname} for #{@vacancy.title}"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.forwarded_application.subject
  #
  def forwarded_application(assignment)
    @moderator = assignment.manager
    @vacancy = assignment.job_application.vacancy
    @user = assignment.job_application.user
    @assignment = assignment

    mail to: @moderator.email, subject: "A job apllication was forwarded to you."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.reviewd_application.subject
  #
  def reviewed_application(moderator, vacancy, user)
    @moderator = moderator
    @vacancy = vacancy
    @user = user

    mail to: @vacancy.admin.email, subject: "Application by #{@user.fullname} for #{@vacancy.title} was reviewed by #{@moderator.fullname} as good"
  end


  def bad_reviewed_application(moderator, vacancy, user)
    @moderator = moderator
    @vacancy = vacancy
    @user = user

    mail to: @vacancy.admin.email, subject: "Application by #{@user.fullname} for #{@vacancy.title} was reviewed by #{@moderator.fullname} as bad"
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.accepted_application.subject
  #
  def accepted_application(vacancy, user)
    @vacancy = vacancy
    @user = user

    mail to: @user.email, subject: "Your application for #{@vacancy.title} was accepted."
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.accepted_application.subject
  #
  def accepted_application_moderator(vacancy, user)
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.application_notifier.rejected_application.subject
  #
  def rejected_application(vacancy, user)
    @user = user
    @vacancy = vacancy

    mail to: user.email, subject: "Your application for #{@vacancy.title} was rejected."
  end
end
