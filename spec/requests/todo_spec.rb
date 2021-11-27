require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /api/v1/todos/index" do
    it "returns http success" do
      FactoryBot.create(:todo, complete: true)

      get "/api/v1/todos"
      expect(response).to have_http_status(:success)
    end
  end
end
