# frozen_string_literal: true

module Api
  module V1
    # Todos controller
    class TodosController < ApplicationController
      def index
        render json: Todo.all
      end
    end
  end
end
