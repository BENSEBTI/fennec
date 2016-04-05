class BlacklistsController < ApplicationController
  def index
  	@blacklists = Blacklist.all
  end

  def new
  	@blacklists = Blacklist.new
  end

  def create
  	@blacklists = Blacklist.new(params.require(:blacklist).permit(:platen, :vtype, :comment, :cmodel))
  	if @blacklists.save
  		redirect_to blacklists_path
  	else
  		redirect_to new_blacklist_path
  	end

  end

  def show
  	@blacklists = Blacklist.find(params[:id])
  end

  def edit
  end

  def update
  end

end
