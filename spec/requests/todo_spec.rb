require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /api/v1/todos/index" do
    it "returns http success" do
      FactoryBot.create(:todo, complete: true)
      FactoryBot.create(:todo, title: "another todo title", description: "another todo description", complete: true)

      get "/api/v1/todos"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "GET /api/v1/todos/id" do
    it "returns http success" do
      todo = FactoryBot.create(:todo, complete: true)
      FactoryBot.create(:todo, title: "another todo title", description: "another todo description", complete: true)

      get "/api/v1/todos/#{todo.id}"
      expect(response).to have_http_status(:success)
      expect([JSON.parse(response.body)].size).to eq(1)
    end
  end
end
