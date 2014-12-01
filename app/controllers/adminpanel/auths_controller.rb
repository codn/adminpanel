module Adminpanel
  class AuthsController < ApplicationController

    def destroy
      Rails.cache.clear
      super
    end

  private
    def auth_params
      params.require(:auth).permit(:name, :value, :key)
    end
  end
end
