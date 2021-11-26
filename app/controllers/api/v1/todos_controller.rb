# frozen_string_literal: true

module Api
  module V1
    # Todos controller
    class TodosController < ApplicationController
      before_action :set_todo, only: [:show]

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
    end
  end
end
