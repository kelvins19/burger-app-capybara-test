# include 'support/env'

Given('I visit bburger consumer website') do
    visit '/'
end
  
Then('I will see {string} text') do |string|
    expect(page).to have_selector(:xpath, "//h1[contains(text(), '#{string}')]")
    # expect(page).to have_http_status(200)
    # page.status_code.should == 200
end

Then('I will not see {string} text') do |string|
    expect(page).to have_no_selector(:xpath, "//h1[contains(text(), '#{string}')]")
    discord_notify("#{page.current_url}", "Website  is Down", 'Please check the server')
end