class PlatesController < ApplicationController
  before_action :set_plate, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  def detective
    
    @req = JSON.parse(request.body.read)
    
    # data from results 
    
    r = @req["results"][0]
    plate = r["plate"]
    confidence  = r["confidence"]
    processing  = r["processing_time_ms"]
    
    # data from regions_of_interest

    coordinates = r["coordinates"][0]
    x = coordinates["x"]
    y = coordinates["y"]
    
    #general data 
    uuid    =     @req["uuid"]
    camid   =     @req["camera_id"]
    siteid  =     @req["site_id"]

    @ringo = Blacklist.exists?(platen: plate)

    
    @enreg = Plate.new(plate_params)
    @enreg.siteid = siteid
    @enreg.camid = camid
    @enreg.plate = plate
    @enreg.confidence = confidence
    @enreg.process = processing
    @enreg.x = x
    @enreg.y = y
    @enreg.uuid = uuid
    if @ringo 
      @enreg.blacklisted = "true"
    else
      @enreg.blacklisted = "false"
    end
    @enreg.save
    
    render json: "thank you #{plate}, #{confidence}, #{processing}, #{x}, #{y}, #{uuid}, #{camid}, #{siteid} "
    
  end
  # GET /plates
  # GET /plates.json
  def index
    @plates = Plate.all
  end

  # GET /plates/1
  # GET /plates/1.json
  def show
  end

  # GET /plates/new
  def new
    @plate = Plate.new
  end

  # GET /plates/1/edit
  def edit
  end

  # POST /plates
  # POST /plates.json
  def create
    @plate = Plate.new(plate_params)

    respond_to do |format|
      if @plate.save
        format.html { redirect_to @plate, notice: 'Plate was successfully created.' }
        format.json { render :show, status: :created, location: @plate }
      else
        format.html { render :new }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plates/1
  # PATCH/PUT /plates/1.json
  def update
    respond_to do |format|
      if @plate.update(plate_params)
        format.html { redirect_to @plate, notice: 'Plate was successfully updated.' }
        format.json { render :show, status: :ok, location: @plate }
      else
        format.html { render :edit }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plates/1
  # DELETE /plates/1.json
  def destroy
    @plate.destroy
    respond_to do |format|
      format.html { redirect_to plates_url, notice: 'Plate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plate
      @plate = Plate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plate_params
      params.require(:plate).permit(:siteid, :camid, :plate, :confidence, :process, :x, :y, :uuid, :blacklisted)
    end
end
