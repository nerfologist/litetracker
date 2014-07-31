class StaticPagesController < ApplicationController
  before_action :require_signed_in!, only: [:root]
  
  def startpage
  end
  
  def root
  end
end