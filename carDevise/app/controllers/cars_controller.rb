class CarsController < ApplicationController
  before_action :set_car, only: [:show,:edit, :update, :destroy]
  before_action :authenticate_user!,only: [:edit, :update, :destroy]
  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = current_user.cars.new
  end

  def mycomocasi 
   
  end 
  # GET /cars/1/edit
  def edit
      
    
  end

  # POST /cars
  # POST /cars.json
  def create
    @car =current_user.cars.new(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
  if(current_user == @car.user_id)
    
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  else 
    respond_to do |format|
  format.html { render :file => "#{RAILS_ROOT}/public/404.html"}
  format.json { render json: @car.errors, status: :not_found , notice: 'the user can only update his own cars.' }
    end
  end
 
end

def not_found
  raise ActionController::RoutingError.new('Not Found')
end
  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:name, :model, :year, :user_id)
    end
end
