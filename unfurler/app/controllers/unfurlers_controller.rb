class UnfurlersController < ApplicationController
  def index; end
  def create; puts params.to_yaml; redirect_to :root; end
end
