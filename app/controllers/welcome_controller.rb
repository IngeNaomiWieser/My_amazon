class WelcomeController < ApplicationController

  def index
      #render 'welcome/index'# points to the index.html.erb file in the views - welcome map. Does this by default, so the render line is redundant.
  end

  def about
  end

  def contact
    
  end

  def submit
    @name = params[:name]
    #by default this will render the submit page in the welcome folder. If you want it to come up in the contact file for example, you do render :contact
    render :contact
  end

end
