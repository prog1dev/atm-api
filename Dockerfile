FROM ruby:2.5.3

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

ENV RAILS_ENV production
RUN bundle install

COPY . /app
