require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Sports")
    @category_2 = Category.create(name: "Travel")
  end

  test "list categories after categories creation" do
    get categories_path
    assert_select "td", text: @category.name
    assert_select "td", text: @category_2.name
  end
end
