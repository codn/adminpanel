class Capybara::Driver::Node
  def submit_form!
    raise NotImplementedError
  end
end

class Capybara::RackTest::Node
  def submit_form!
    Capybara::RackTest::Form.new(driver, self.native).submit({})
  end
end

class Capybara::Node::Element
  def submit_form!
    wait_until { base.submit_form! }
  end
end