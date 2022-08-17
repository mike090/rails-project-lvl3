# frozen_string_literal: true

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'index' do
    get bulletins_path
    assert_response :success
  end

  test 'unauthenticated new redirect to root' do
    get new_bulletin_path
    assert_redirected_to root_path
  end

  test 'authenticated new success' do
    sign_in users(:one)
    get new_bulletin_path
    assert_response :success
  end

  test 'unauthenticated show success' do
    get bulletin_path(bulletins(:published))
    assert_response :success
  end

  test 'authenticated create' do
    title = Faker::Lorem.sentence
    category = categories :one
    user = users :one
    sign_in user
    post bulletins_path, params: {
      bulletin: {
        title: title,
        description: 'Bulletin content',
        category_id: category.id,
        image: fixture_file_upload('bulletin_default.jpg', 'image/png')
      }
    }
    assert_redirected_to root_path
    assert(Bulletin.find_by(title: title, user: user, category: category))
  end

  test 'authorized update' do
    bulletin = bulletins :draft
    title = Faker::Lorem.sentence
    sign_in bulletin.user
    put bulletin_path(bulletin), params: {
      bulletin: {
        title: title,
        description: 'Bulletin content',
        category_id: bulletin.category.id,
        image: fixture_file_upload('bulletin_default.jpg', 'image/png')
      }
    }
    assert { Bulletin.find(bulletin.id).title == title }
    assert_redirected_to root_path
  end

  test 'unauthorized edit ;)' do
    sign_in Struct.new(:name, :email).new('user', 'email@mail.io')
    get edit_bulletin_path(bulletins(:draft))
    assert_redirected_to root_path
    assert flash[:warning]
  end
end
