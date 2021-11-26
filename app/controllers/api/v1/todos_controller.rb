# frozen_string_literal: true

module Api
  module V1
    # Todos controller
    class TodosController < ApplicationController
      def index
        todos = Todo
          .all
          .limit(limit)
          .offset(page_number)

        render json: todos
      end

      def limit
        params[:limit] || 25
      end

      def page_number
        params[:page_number] || 0
      end
    end
  end
end
