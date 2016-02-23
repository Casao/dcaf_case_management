class CasesController < ApplicationController
  def index
  	@patient = Patient.new
    @p_case = @patient.cases.build
    @urgent_cases = Case.where(urgent_flag: true)
  end

  def search
    name_match = Patient.where(name: params[:search])
    primary_match = Patient.where(primary_phone: params[:search])
    secondary_match = Patient.where(secondary_phone: params[:search])
    patients = name_match | primary_match | secondary_match
    @results = []
    patients.each do |patient|
      @results << patient.cases.most_recent
    end

    respond_to do |format|
        format.js
    end
  end

  private

  def case_params
    params.require(:patient).permit(:primary_phone)
  end


end
