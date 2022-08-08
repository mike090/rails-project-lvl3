# frozen_string_literal: true

class Web::ProfilesControllerTest < ActionDispatch::IntegrationTest
  test 'unauthenticated show redirect' do
    get profile_path
    assert_redirected_to root_path
  end

  test 'authenticated show success' do
    sign_in users(:one)
    get profile_path
    assert_response :success
  end
end
