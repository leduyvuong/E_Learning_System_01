require "rails_helper"
RSpec.describe Admin::CategoriesController, type: :request do
  
  current_user = User.first_or_create!(username: "leduyvuong", email: "leduyvuong99@gmail.com",
    password: "123456", password_confirmation: "123456", role: 0)
  
  let(:valid_attributes) do
    {
      id: 1,
      name: "Course name 1",
      decription: "1aDm9VfJOo5LHjEIr0gNFGkkZ49upnaaa",
      status: 1,
      user_id:  current_user.id
    }
  end

  let(:invalid_attributes) do
    {
      id: 2,
      name: "",
      decription: "1aDm9VfJOo5LHjEIr0gNFGkkZ49upna",
      status: 1,
      user_id:  current_user.id
    }
  end

  before(:each) do
    allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { user_id: current_user.id } }
  end

  describe "GET /index" do
    
    it "renders a successful response" do
      category = Category.create! valid_attributes
      get admin_categories_url
      expect(response).to be_successful  
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_category_url
      expect(response).to be_successful  
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      category = Category.create! valid_attributes
      get edit_admin_category_url(id: category.id)
      expect(response).to be_successful  
    end
  end

  describe "POST /create" do
    context "with valid paramaters" do
      it "create a new category" do
        expect do
          post admin_categories_url, params: {category: valid_attributes} 
        end.to change(Category, :count).by(1)
      end

      it "redirects to the created category" do
          post admin_categories_url, params: {category: valid_attributes}
          expect(response).to redirect_to admin_categories_path  
      end
    end

    context "with invalid paramaters" do
      it "create a new category" do
        expect do
          post admin_categories_url, params: {category: invalid_attributes} 
        end.to change(Category, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    context "with a valid category" do
      let(:new_valid_attributes) do
        {
          id: 1,
          name: "Course name 2",
          decription: "1aDm9VfJOo5LHjEIr0gNFGkkZ49upnaaa3",
          status: 1,
          user_id:  current_user.id
        }
      end

      it "Updates the request category" do
        category = Category.create! valid_attributes
        patch admin_category_url(id: category.id), params: {category: new_valid_attributes}
        category.reload
        skip("Add flash for update state")
      end

      it "redirects to the category" do
        category = Category.create! valid_attributes
        patch admin_category_url(id: category.id), params: {category: new_valid_attributes}
        category.reload
        admin_categories_path
        expect(response).to redirect_to edit_admin_category_path(id: category.id)
      end
    end

    context "with a invalid category" do
      let(:new_invalid_attributes) do
        {
          id: 1,
          name: "",
          decription: "1aDm9VfJOo5LHjEIr0gNFGkkZ49upnaaa3",
          status: 1,
          user_id:  current_user.id
        }
      end

      it "render the edit template" do
        category = Category.create! valid_attributes
        patch admin_category_url(id: category.id), params: {category: new_invalid_attributes}
        category.reload
        expect(response).to be_successful 
      end
    end
    
    
  end
  
  describe "DELETE /destroy" do
    let(:unactive_attributes) do
      {
        status: 2,
      }
    end

    let(:active_attributes) do
      {
        status: 1,
      }
    end

    it "unactive the category" do
      category = Category.create! valid_attributes
      delete admin_category_url(id: category.id), params: {category: unactive_attributes}
      category.reload
      expect(response).to redirect_to admin_categories_path 
    end

    it "active the category" do
      category = Category.create! valid_attributes
      delete admin_category_url(id: category.id), params: {category: unactive_attributes}
      category.reload
      delete admin_category_url(id: category.id), params: {category: active_attributes}
      category.reload
      expect(response).to redirect_to admin_categories_path 
    end
  end
  

end
