Given('I visit bburger consumer website') do
    visit '/'
end
  
Then('I should see {string} text') do |string|
    if !(page.has_selector?(:xpath, "//h1[contains(text(), '#{string}')]"))
        discord_notify("Capybara Test: #{page.current_url}", "This website has a problem", 'Please check the server log')
    end
end

Then('I should not see {string} text') do |string|
    expect(page).to have_no_selector(:xpath, "//h1[contains(text(), '#{string}')]")
    discord_notify("Capybara Test: #{page.current_url}", "This website has a problem", 'Please check the server log')
end