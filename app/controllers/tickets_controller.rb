class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[show edit update destroy spa_update spa_edit spa_cancel spa_destroy]
  skip_before_action :verify_authenticity_token, only: [:spa_cancel]

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.order("created_at DESC").all
    @ticket = Ticket.new
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    respond_to do |format|
      format.html { render :edit }
    end
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  #----------------------------------------------------------
  #-------------------  SPA ACTIONS -------------------------
  #----------------------------------------------------------

  # GET /spa_tickets
  def spa_index
    @tickets = Ticket.order("created_at DESC").all
    @ticket = Ticket.new
  end

  # POST /tickets/1/spa_edit
  def spa_edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: []
        @ticket.broadcast_edit_to_listeners
      end
    end
  end

  # POST /tickets/1/spa_cancel
  def spa_cancel
    respond_to do |format|
      # format.turbo_stream
      format.html do
        head :no_content
        @ticket.broadcast_edit_cancel_to_listeners
      end
    end
  end

  # POST /spa_tickets
  def spa_create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.turbo_stream do
          render turbo_stream: []
          # @ticket.broadcast_create_to_listeners
        end
      else
      end
    end
  end

  # PATCH /tickets/1/spa_update
  def spa_update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.turbo_stream do
          render turbo_stream: []
          # @ticket.broadcast_update_to_listeners
        end
      else
      end
    end
  end

  # DELETE /tickets/1/spa_destroy
  def spa_destroy
    @ticket.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: []
        # @ticket.broadcast_destroy_to_listeners
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:title, :problem, :fixed)
    end
end
