require 'byebug'

class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?

  # GET /answers
  # GET /answers.json
  def index
    @answers = Survey.find_by(author_id: session[:user_id]).answers
    # survey_identity = Survey.find_by(author_id: session[:user_id]).id
    # question_identity = Question.all.each.where(survey_id: survey_identity).id
    # @answers = Answer.where(question_id: question_identity)
    # @answers = Answer.where(question_id: question_identification)
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    @survey = Survey.find(answer_params[:id])
      # byebug

    if @survey.update(answer_params)
      redirect_to @survey, notice: 'Answer was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    if @answer.update(answer_params)
      redirect_to @answer, notice: 'Answer was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    redirect_to answers_url, notice: 'Answer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:survey).permit(:id,
        questions_attributes: [:id,
          answers_attributes: [:question_id, :taker_id, :response]])
    end
end
