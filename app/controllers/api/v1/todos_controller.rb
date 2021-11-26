# frozen_string_literal: true

module Api
  module V1
    # Todos controller
    class TodosController < ApplicationController
      def index
        todos = Todo
                .all
                .limit(limit)
                .offset(offset)

        render json: todos
      end

      def limit
        params[:limit] ? params[:limit].to_i : 25
      end

      def offset
        page_number = params[:page_number].to_i < 1 ? 0 : params[:page_number].to_i
        offset_value = limit * page_number
        number_of_todos = Todo.all.size
        offset_value > number_of_todos ? number_of_todos : offset_value
      end
    end
  end
end
