# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  layout 'admin'
  before_action :authorize_admin

  def authorize_admin
    authorize nil, 'admin?'
  end

  def policy_namespace
    Admin
  end
end
