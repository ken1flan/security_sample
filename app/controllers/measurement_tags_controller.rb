class MeasurementTagsController < ApplicationController
  before_action :logged_in_user
  before_action :set_measurement_tag, only: [:new, :show, :edit, :update, :destroy]

  def show
    redirect_to new_measurement_tag_path unless @measurement_tag
  end

  def new
    redirect_to @measurement_tag if @measurement_tag
    @measurement_tag ||= current_user.build_measurement_tag
  end

  def edit
  end

  def create
    @measurement_tag = current_user.build_measurement_tag(measurement_tag_params)

    respond_to do |format|
      if @measurement_tag.save
        format.html { redirect_to @measurement_tag, notice: 'Measurement Tag was successfully created.' }
        format.json { render :show, status: :created, location: @measurement_tag }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @measurement_tag.update(measurement_tag_params)
        format.html { redirect_to @measurement_tag, notice: 'Mesurement Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @measurement_tag }
      else
        format.html { render :edit }
        format.json { render json: @measurement_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @measurement_tag.destroy
    respond_to do |format|
      format.html { redirect_to new_measurement_tag_url, notice: 'Mesurement Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_measurement_tag
      @measurement_tag = current_user.measurement_tag
    end

    def measurement_tag_params
      params.require(:measurement_tag).permit(:body)
    end
end
