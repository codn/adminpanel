require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  fixtures :all

  def test_superuser_permission
    ability = Ability.new(adminpanel_users(:valid))

    assert ability.can?(:manage, :all)
  end

  def test_read_permission
    ability = Ability.new(adminpanel_users(:reader))

    assert ability.can?(:read, Adminpanel::Product)
    assert ability.cannot?(:destroy, Adminpanel::Product)
    assert ability.cannot?(:update, Adminpanel::Product)
    assert ability.cannot?(:create, Adminpanel::Product)
  end

  def test_create_permission
    ability = Ability.new(adminpanel_users(:creator))

    assert ability.cannot?(:destroy, Adminpanel::Product)
    assert ability.cannot?(:update, Adminpanel::Product)
    assert ability.can?(:create, Adminpanel::Product)
  end

  def test_delete_permission
    ability = Ability.new(adminpanel_users(:deleter))

    assert ability.can?(:destroy, Adminpanel::Product)
    assert ability.cannot?(:update, Adminpanel::Product)
    assert ability.cannot?(:create, Adminpanel::Product)
  end

  def test_updater_permission
    ability = Ability.new(adminpanel_users(:updater))

    assert ability.cannot?(:destroy, Adminpanel::Product)
    assert ability.can?(:update, Adminpanel::Product)
    assert ability.cannot?(:create, Adminpanel::Product)
  end

  def test_superuser_permission
    ability = Ability.new(adminpanel_users(:superuser))

    assert ability.cannot?(:destroy, Adminpanel::Product)
    assert ability.can?(:update, Adminpanel::Product)
    assert ability.can?(:create, Adminpanel::Product)
  end
end
