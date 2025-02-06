require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "User Test", email: "usertest@email.com", password: "password123")
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get new_article_path
    assert_response :success

    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {
        title: "Testing successful creation",
        description: "Some description here"
        }
      }
    end

    assert_response :redirect

    follow_redirect!
    assert_response :success
    assert_match "Article was created successfully.", response.body
    assert_match "Testing successful creation", response.body 
  end

  test "get new article form and send invalid request" do
    get new_article_path
    assert_response :success

    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {
        title: " ",
        description: "no"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_match "Article could not be created", response.body 
  end
end
