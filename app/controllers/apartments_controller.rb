class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]

  # GET /apartments
  # GET /apartments.json
  def index
    @apartments = Apartment.all
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
    @apartment = Apartment.find(params[:id])
    @detail = Detail.new(:apartment_id => @apartment.id)
    @hunt = @apartment.hunt
    @detail = Detail.new
  end

  # GET /hunts/:hunt_id/apartments/new
  def new
    @hunt = Hunt.find(params[:hunt_id])
    @apartment = Apartment.new
    #@cancel_link = hunt_path(@hunt)
  end

  # GET /apartments/1/edit
  def edit
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = Apartment.new(apartment_params)
    @hunt = @apartment.hunt
    respond_to do |format|
      if @apartment.save
        format.html { redirect_to hunt_path(@hunt), notice: 'Apartment was successfully created.' }
        format.json { render :nothing, status: :created, location: @hunt }
      else
        format.html { redirect_to hunt_path(@hunt) }
        format.json { render :nothing, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
          format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { respond_with_bip(@apartment) }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to hunt_path(@hunt), notice: 'Apartment was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      @apartment = Apartment.find(params[:id])
      @hunt = @apartment.hunt
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:address, :link, :contact, :price, :hunt_id, :move_in_date, :status)
    end
end
