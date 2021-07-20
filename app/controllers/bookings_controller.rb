class BookingsController < ApplicationController
  
  before_action :set_booking, only: [ :show, :edit, :update, :destroy ]
  before_action :set_event, only: [:new, :create]

  # GET /bookings or /bookings.json
  def index
    @bookings = Booking.all
    authorize @bookings
  end

  # GET /bookings/1 or /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
    authorize @bookings
  end

  # POST /bookings or /bookings.json
  def create
    @booking = current_user.book_event(@event)
    redirect_to registered_events_path, notice: "You have registered to the event"
    
  end

  # PATCH/PUT /bookings/1 or /bookings/1.json
  def update
    authorize @bookings
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1 or /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def registered_booking
    @events = Event.joins(:bookings).where(bookings: {user: current_user})
    render 'index'
  end


  private

    def set_event
      @event = Event.find(params[:event_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit()
    end
end
