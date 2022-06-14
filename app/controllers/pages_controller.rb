class PagesController < ApplicationController
  def index
    gon.user = { name: 'John', role: 'Admin', id: '2' }
    HomeJob.perform_later
  end
end
