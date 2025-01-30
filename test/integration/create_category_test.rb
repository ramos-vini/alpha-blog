require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get new_category_path
    assert_response :success

    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: {name: "Travel"}}
    end

    assert_response :redirect

    follow_redirect!
    assert_response :success
    assert_match "Travel", response.body 
  end

  test "get new category form and send invalid request" do
    get new_category_path
    assert_response :success

    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: " "}}
    end

    assert_response :unprocessable_entity
    assert_match "Category could not be created", response.body 
  end
end
