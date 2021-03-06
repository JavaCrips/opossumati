class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :survey

  validates :question_text, presence: true
  validates :question_order, presence: true

  accepts_nested_attributes_for :answers

end
