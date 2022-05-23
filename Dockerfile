ARG RUBY_VERSION=2.7.1
FROM ruby:$RUBY_VERSION-slim-buster
ARG BUNDLER_VERSION=2.2.5
RUN apt-get update \
  && apt-get install libxi6 \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
    wget \
    libnss3 \
    libgconf-2-4 \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxss1 \
    lsb-release \
    xdg-utils \
    libgbm1 \
    libxcomposite1 -y \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log
RUN curl -L -o google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome.deb
RUN sed -i 's|HERE/chrome\"|HERE/chrome\" --disable-setuid-sandbox|g' /opt/google/chrome/google-chrome
RUN rm google-chrome.deb
RUN mkdir /cucumber-app
WORKDIR /cucumber-app
ADD . .
RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION
RUN bundle install