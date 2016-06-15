FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim
RUN npm install -g phantomjs

RUN mkdir /myapp

WORKDIR /tmp
COPY Gemfile /tmp/Gemfile
COPY Gemfile.lock /tmp/Gemfile.lock
RUN bundle install

ADD . /myapp
WORKDIR /myapp
RUN RAILS_ENV=development bundle exec rake assets:precompile --trace
CMD ["rails","server","-b","0.0.0.0"]
