class EventsController < ApplicationController
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]
  
  # GET /events or /events.json
  def index
    if(params.has_key?(:event_category))
      @events = Event.where(event_category: params[:event_category]).order("created_at desc")
    else
      @events = Event.all
      
    end
   
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    authorize :event
  end

  # POST /events or /events.json
  def create
    authorize :event
    @event = Event.new(event_params)
    @event.user = current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    authorize :event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  def registered
    @events = Event.joins(:bookings).where(bookings: {user: current_user})
    if @events.empty?
      redirect_to events_path, notice: "You have not registered any events"
      
    else
      render 'registred'
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    
    @event.destroy
    authorize :event
    
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.xml  { head :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name, :event_category)
    end
end
