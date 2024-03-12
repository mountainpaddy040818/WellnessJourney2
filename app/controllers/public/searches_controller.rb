class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
  end
  
  if @model == 'user'
    @records = User.search_for(@content, @method)
  else
    @records = HealthRecord.search_for(@content, @method)
  end
  
end
