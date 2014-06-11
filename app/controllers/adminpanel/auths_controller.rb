module Adminpanel
  class AuthsController < ApplicationController
  private
    def auth_params
      params.require(:auth).permit(:name, :value, :key)
    end
  end
end
