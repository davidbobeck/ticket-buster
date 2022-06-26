class PagesController < ApplicationController
  def home
  end

  def about
  end

  def async_turbo_frame
    # binding.irb
    # render html: "<h1.text-center>This is cool</h1>"
    # render :async_turbo_frame, status: :ok

    # respond_to do |format|
    #   format.html
    # end
    sleep(2)
  end
end
