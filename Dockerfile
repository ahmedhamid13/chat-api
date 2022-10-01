FROM ruby:2.7.6

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs netcat
RUN gem install bundler:2.2.21
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

COPY lib/docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

ADD . /app

EXPOSE 3000