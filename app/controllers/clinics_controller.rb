class ClinicsController < ApplicationController
	before_action :set_clinic, only: [:edit, :show, :update, :destroy]

	def index
		@clinics = Clinic.all
	end

	def import
	  Clinic.import(params[:file])
	  redirect_to clinics_path, notice: 'Clinics imported.'
	end

	def show
	end

	def new
    @clinic = Clinic.new
	end

	def create
		@clinic = Clinic.new(clinic_params)
		if @clinic.save
		  flash[:success] = "Clinic was successfully created"
	    redirect_to clinics_path
		else
		  render 'new'
		end
	end

	def edit
	end

	def update
		if @clinic.update(clinic_params)
		  flash[:success] = "Clinic was updated successfully"
	    redirect_to clinics_path(@clinic)
		else
		  render 'edit'
		end
	end

	private
		def set_clinic
			@clinic = Clinic.find(params[:id])
		end

		def clinic_params
      params.require(:clinic).permit(:lab, :detail, :addr1, :addr2, :city, :state, :zip, :phone, :ext, :fax, :latitude, :longitude)
    end
end


