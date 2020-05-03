class HasAccessGuard < Clearance::SignInGuard
  def call
    if disallowed_to_access?
      failure('does not have access')
    else
      next_guard
    end
  end

  def disallowed_to_access?
    signed_in? && !current_user.present?
  end
end
