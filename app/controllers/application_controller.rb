class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_for_old_domain

  private

  def check_for_old_domain
    old_domain = ENV["OLD_DOMAIN"]
    new_url = ENV["NEW_URL"]
    if old_domain.present? && new_url.present? && request.url.to_s.include?(old_domain)
      redirect_to new_url, status: :moved_permanently
    end
  end
end
