# README
This test kit can be run on Linux, macOS, and Windows (via WSL).

## System requirements

1. Google Chrome or any other Chromium-based web browsers
2. Ruby 2.7.1p83: Install it via rbenv/ruby-install/rvm, never use OS provided Ruby.

[*Installing Ruby on Ubuntu*](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-20-04) Follow Step 1 - 3
## Installation Procedure
Copy the env by running this command
> cp .env.example .env

Download all the dependencies:
> bundle install

If you don't have bundle installed yet, run this
> gem install bundler

Set up the test
> cucumber --init

## Running the test
To run the test, run this command inside this repo:
> cucumber

To run the test and generate html report:
> cucumber features --format html --out reports/reports_$(date +"%FT%T").html
The report will be saved in html format in `reports` directory

## Running the test in headful mode

For eyeball debugging, you can display the browser as the test is running by commenting the 'HEADLESS=true' in .env

## Running the test in headful mode (WSL)

For Windows Subsystem for Linux, additional step are needed to install X display server:

On Windows:

1. Download and install [VcXsrv X Server](https://sourceforge.net/projects/vcxsrv/)
2. Windows Defender Firewall: Allow VcXsrv to communicate on both private and public networks
3. Start XLaunch, choose `Multiple windows`, set the `Display number` to 0, click on `Next`
4. Select `Start no client`, click on `Next`
5. Tick all the checkboxes

Going back to WSL terminal:

1. Find out the host IP by running `cat /etc/resolv.conf`, look for the line with 'nameserver'
2. add `export DISPLAY=<the host IP>:0.0` (without `<` and `>`) and `export LIBGL_ALWAYS_INDIRECT=1` to your shell profile
3. reload your shell profile (e.g. `source ~/.profile`)

[*Source...*](https://www.youtube.com/watch?v=4SZXbl9KVsw)

## Cheatsheet
Cucumber: https://gist.github.com/yuriiik/5728701
Capybara: https://gist.github.com/tomas-stefano/6652111
