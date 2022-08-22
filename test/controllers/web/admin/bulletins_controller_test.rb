# frozen_string_literal: true

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should publish' do
    sign_in users(:admin)
    bulletin = bulletins(:under_moderation)
    patch publish_admin_bulletin_path(bulletin)
    assert_redirected_to root_path
    bulletin.reload
    assert { bulletin.aasm.current_state == :published }
  end

  test 'should reject' do
    sign_in users(:admin)
    bulletin = bulletins(:under_moderation)
    patch reject_admin_bulletin_path(bulletin)
    assert_redirected_to root_path
    bulletin.reload
    assert { bulletin.aasm.current_state == :rejected }
  end

  test 'should archive' do
    sign_in users(:admin)
    bulletin = bulletins(:published)
    patch archive_admin_bulletin_path(bulletin)
    assert_redirected_to root_path
    bulletin.reload
    assert { bulletin.aasm.current_state == :archived }
  end
end
