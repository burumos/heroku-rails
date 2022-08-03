FROM ruby:3.1.2

ENV WORKSPACE=/usr/local/src

RUN apt update -qq && apt install -y postgresql-client

# create user and group.
RUN groupadd -r --gid 1000 rails && \
    useradd -m -r --uid 1000 --gid 1000 rails

# create directory.
RUN mkdir -p $WORKSPACE $BUNDLE_APP_CONFIG && \
    chown -R rails:rails $WORKSPACE && \
    chown -R rails:rails $BUNDLE_APP_CONFIG

USER rails
WORKDIR ${WORKSPACE}

COPY --chown=rails:rails Gemfile ${WORKSPACE}/Gemfile
COPY --chown=rails:rails Gemfile.lock ${WORKSPACE}/Gemfile.lock
RUN bundle install
COPY --chown=rails:rails . ${WORKSPACE}

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

