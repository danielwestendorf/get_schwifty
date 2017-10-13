
# frozen_string_literal: true

require "application_system_test_case"

class SystemTest < ApplicationSystemTestCase
  test "fibonacci" do
    visit root_path

    within ".take-off-your-pants", wait: 20 do
      assert_content "Fibonacci of #{User.last.fibonacci} is"
    end
  end

  test "renders users" do
    200.times { User.create }
    visit root_path

    within ".mr-bulldops", wait: 20 do
      refute_selector ".double-x-schwifty-1"
      assert_selector ".double-x-schwifty-11"
      assert_selector ".double-x-schwifty-201"
    end
  end

  test "redirection" do
    visit demos_path

    # find ".rendered", wait: 10
    assert_selector ".rendered", wait: 10
  end
end
