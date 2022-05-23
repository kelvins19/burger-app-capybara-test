Given('I visit bburger consumer website') do
    visit '/'
end
  
Then('I should see {string} text') do |string|
    expect(page).to have_selector(:xpath, "//h1[contains(text(), '#{string}')]")
    # expect(page).to have_http_status(200)
    # page.status_code.should == 200
end

Then('I should not see {string} text') do |string|
    expect(page).to have_no_selector(:xpath, "//h1[contains(text(), '#{string}')]")
    discord_notify("Capybara Test: #{page.current_url}", "This website has a problem", 'Please check the server log')
end