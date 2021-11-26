# frozen_string_literal: true

module Api
  module V1
    # Todos controller
    class TodosController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :display_record_not_found_error_message

      before_action :set_todo, only: %i[show update destroy]

      def index
        todos = Todo
                .all
                .limit(limit)
                .offset(offset)

        render json: todos
      end

      def show
        render json: @todo
      end

      def create
        todo = Todo.new(todo_params)
        if todo.save!
          render(json: todo, status: :created)
        else
          render(json: todo.errors.full_messages, status: :unprocessable_entity)
        end
      end

      def update
        if @todo.update(todo_params)
          render(json: @todo)
        else
          render(json: @todo.errors.full_messages, status: :unprocessable_entity)
        end
      end

      def destroy
        if @todo.destroy
          head :no_content
        else
          render(json: @todo.errors.full_messages, status: :unprocessable_entity)
        end
      end

      private

      def limit
        params[:limit] ? params[:limit].to_i : 25
      end

      def offset
        page_number = params[:page_number].to_i < 1 ? 0 : params[:page_number].to_i
        offset_value = limit * page_number
        number_of_todos = Todo.all.size
        offset_value > number_of_todos ? number_of_todos : offset_value
      end

      def todo_params
        params.require(:todo).permit(:title, :description, :complete)
      end

      def set_todo
        @todo = Todo.find(params[:id])
      end

      def display_record_not_found_error_message
        render(json: { error: "Todo with ID:(#{params[:id]}) Not found" }, status: :not_found)
      end
    end
  end
end
