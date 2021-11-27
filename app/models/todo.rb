# frozen_string_literal: true

# Todo model
class Todo < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :complete, presence: true
end
