# frozen_string_literal: true

# class MovementsController budgetApp
class MovementsController < ApplicationController
  before_action :set_movement, only: %i[show edit update destroy]

  def index
    @movements = Movement.all.where(author_id: current_user)
  end

  def show; end

  def new
    @movement = Movement.new
  end

  def edit; end

  def create
    @movement = Movement.new(movement_params)

    respond_to do |format|
      if @movement.save
        format.html { redirect_to movement_url(@movement), notice: 'Successfully created' }
        format.json { render :show, status: :created, location: @movement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movement.update(movement_params)
        format.html { redirect_to movement_url(@movement), notice: 'Successfully updated' }
        format.json { render :show, status: :ok, location: @movement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to movements_url, notice: 'Successfully deleted' }
      format.json { head :no_content }
    end
  end

  def new_movement
    @movement = Movement.new
    @group = Group.find(params[:group_id])
  end

  def create_movement
    @movement = Movement.new(movement_params)
    if @movement.save
      GroupMovement.create(group_id: params[:group_id], movement_id: @movement.id)
      redirect_to group_path(id: params[:group_id]), notice: 'Successfully added'
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  private

  def set_movement
    @movement = Movement.find(params[:id])
  end

  def movement_params
    params.require(:movement).permit(:name, :amount).merge(author_id: current_user.id)
  end
end
