FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir -p /var/ruby/moviebase
WORKDIR /var/ruby/moviebase
ADD Gemfile* /var/ruby/moviebase/
RUN bundle install

ADD . /var/ruby/moviebase/