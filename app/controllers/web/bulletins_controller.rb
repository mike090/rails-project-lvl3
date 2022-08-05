module Web
  class BulletinsController < ApplicationController
    def new
      require_authentication
      @bulletin = current_user.bulletins.new
    end
  end
end