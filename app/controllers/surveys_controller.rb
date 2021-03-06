class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy, :take]
  before_action :logged_in?, except: [:show, :take]
  before_action :survey_taken?, only: [:edit]


  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.where(author_id: session[:user_id])
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    redirect_to surveys_path
  end

  # GET /surveys/new
  def new
    @survey = Survey.new(author_id: session[:user_id])
    @survey.questions.build
  end

  # GET /surveys/1/edit
  def edit
    # @survey = Survey.find_by(id: params[:survey_id])
    @survey.questions.build
    # @survey.questions.build
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      redirect_to @survey, notice: 'Survey was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /surveys/1
  # PATCH/PUT /surveys/1.json
  def update
    if @survey.update(survey_params)
      redirect_to @survey, notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey.destroy
    redirect_to surveys_url, notice: 'Survey was successfully destroyed.'
  end

  def take
    @taker = Taker.create(survey_id: params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survey
      @survey = Survey.find(params[:id])
    end


    def survey_taken?
      if @survey.answers.first
        redirect_to surveys_path, notice: 'You cannot edit a survey that has already been taken.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def survey_params
      params.require(:survey).permit(:author_id, :title, :description,
        questions_attributes: [:id, :survey_id, :question_order, :question_type, :description, :question_text, :required,
          answers_attributes: [:question_id, :taker_id, :response]])
    end
end
