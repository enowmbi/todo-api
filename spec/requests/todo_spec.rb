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

  describe "POST /api/v1/todos" do
    let(:valid_params) do
      {
        todo:
        {
          title: "A new todo title",
          description: "New todo description",
          complete: "true"
        }
      }
    end

    let(:invalid_params) do
      {
        todo:
        {
          title: "A new todo title",
          description: "New todo description",
          complete: "true"
        }
      }
    end

    describe "with valid params" do

      before(:each){ post "/api/v1/todos", params: valid_params }

      it "returns http created" do
        expect(response).to have_http_status(:created)
      end

      it "increments todo collection by one(1)" do
        expect{post "/api/v1/todos", params: valid_params}.to change(Todo, :count).by(1)
      end

      it "returns created todo as json" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    xdescribe "with invalid params" do
      before(:each){ post "/api/v1/todos", params: invalid_params }

      it "returns http unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
