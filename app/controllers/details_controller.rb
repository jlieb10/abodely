class DetailsController < ApplicationController
  before_action :set_detail, only: [:update, :destroy]

  # GET /details
  # GET /details.json
  def index
    @details = Detail.all
  end

  # POST /details
  # POST /details.json
  def create
    @detail = Detail.new(detail_params)
    @apartment = Apartment.find(params[:apartment_id])
    respond_to do |format|
      if @detail.save
        format.html { redirect_to @detail.apartment, notice: 'Detail was successfully created.' }
        format.json { render :show, status: :created, location: @detail }
      else
        format.html { render :new }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /details/1
  # PATCH/PUT /details/1.json
  def update
    respond_to do |format|
      if @detail.update(detail_params)
        format.html { redirect_to @detail.apartment, notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @detail }
      else
        format.html { render :edit }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /details/1
  # DELETE /details/1.json
  def destroy
    @apartment = @detail.apartment
    @detail.destroy
    respond_to do |format|
      format.html { redirect_to apartment_path(@apartment), notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_detail
      @detail = Detail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def detail_params
      params.require(:detail).permit(:content, :procon, :apartment_id, :image, :remote_image_url)
    end
end
