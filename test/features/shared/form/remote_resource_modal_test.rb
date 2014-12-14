require 'test_helper'

class RemoteResourceModalTest < ViewCase
  fixtures :all

  setup :visit_adminpanel_new_user

  def test_modals_exclude_belongs_to_remote_resources
    visit adminpanel.new_user_path
    # test in belongs_to request
    trigger_modal 'Agregar Rol'
    assert_no_link 'Agregar Permisos'
  end

  def test_modals_exclude_has_many_remote_resources
    # test has_many
    visit adminpanel.new_role_path
    trigger_modal 'Agregar Permisos'
    assert_no_link 'Agregar Rol'
  end

  def test_modals_exclude_file_input
    # test file_field and non file field
    visit adminpanel.new_role_path
    trigger_modal 'Agregar Permisos'
    assert_no_link 'Agregar Rol'
  end

  def test_modals_exclude_exclude_add_images_button
    # test file_field and non file field
    visit adminpanel.new_salesman_path
    trigger_modal 'Agregar Producto'
    assert_no_selector '#add-image-link'
  end

  private
    def visit_adminpanel_new_user
      visit adminpanel.signin_path
      login
    end
end
