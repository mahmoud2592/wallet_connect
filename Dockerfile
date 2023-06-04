# FROM ruby:3.1.2-alpine3.15
# # RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
# # RUN apk add --no-cache nodejs postgresql-client
# RUN apk add --virtual build-dependencies build-base
# RUN apk add postgresql-dev libffi-dev imagemagick-dev



FROM ruby:3.1.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY Gemfile /myapp/Gemfile

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]
