# frozen_string_literal: true

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  def unauthorized_action_test(&action)
    action.call
    assert_redirected_to root_path
    assert flash[:warning]
  end

  def action_success_test(&action)
    action.call
    assert_response :success
  end

  test 'unauthorized test' do
    sign_in users(:one)
    unauthorized_action_test { get admin_categories_path }
    unauthorized_action_test { get edit_admin_category_path categories(:one) }
    unauthorized_action_test { get new_admin_category_path }
    unauthorized_action_test do
      post admin_categories_path params: {
        category: {
          title: 'test category'
        }
      }
    end
    unauthorized_action_test do
      patch admin_category_path(categories(:one)), params: {
        category: {
          title: 'test category'
        }
      }
    end
    unauthorized_action_test { delete admin_category_path(categories(:one)) }
  end

  test 'authorized test' do
    sign_in users(:admin)
    action_success_test { get admin_categories_path }
    action_success_test { get edit_admin_category_path(categories(:one)) }
    action_success_test { get new_admin_category_path }
    delete admin_category_path(categories(:empty))
    assert_redirected_to admin_categories_path
    assert_nil Category.find_by id: categories(:empty).id
  end

  test 'should create category' do
    sign_in users(:admin)
    category_name = Faker::Lorem.sentence
    post admin_categories_path params: {
      category: {
        name: category_name
      }
    }
    assert Category.find_by(name: category_name)
    assert_redirected_to admin_categories_path
  end

  test 'should_update_category' do
    category = categories :one
    category_name = Faker::Lorem.sentence
    sign_in users(:admin)
    patch admin_category_path(category), params: {
      category: {
        name: category_name
      }
    }
    category.reload
    assert { category.name == category_name }
    assert_redirected_to admin_categories_path
  end
end
