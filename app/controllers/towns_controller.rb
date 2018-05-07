class TownsController < ApplicationController
	before_action :set_town, only: [:edit, :update, :destroy, :show]

	def index
		@towns = Town.all
	end

	def import
	  Town.import(params[:file])
	  redirect_to towns_path, notice: 'Towns imported.'
	end

	def show
		@state = @town.state
	end

	def new
    @town = Town.new
    @states = State.all
	end

	def create
		@town = Town.new(town_params)
		if @town.save
		  flash[:success] = "Town was successfully created"
		  redirect_to town_path(@town)
		else
		  render 'new'
		end
	end

	def edit
		@state = @town.state
	end

	def update
		if @town.update(town_params)
		  flash[:success] = "Town was updated successfully"
      redirect_to town_path(@town)
		else
		  render 'edit'
		end
	end

	def destroy
		Town.find(params[:id]).destroy
  	flash[:success] = "Town was successfully deleted!"
    redirect_to states_path
	end

	private
		def set_town
			@town = Town.find(params[:id])
		end

		def town_params
      params.require(:town).permit(:townname, :state_id)
    end
end
