require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  
  def setup
    @category = Category.new(name: "sports")
  end

  test "category should be valid" do
  	assert @category.valid?
  end

  test "name should be present" do 
    @category.name = " "
    assert_not @category.valid?
  end

  test "name should be unique" do
  	@category.save
  	category2 = Category.new(name: "sports")
  	assert_not category2.valid?
  end

  test "name should not be too long" do
   @category = Category.new(name: "This Is the Sports Section")
   assert_not @category.valid?
  end

  test "name should not be too short" do
  	@category = Category.new(name: "S")
  	assert_not @category.valid?
  end
end
