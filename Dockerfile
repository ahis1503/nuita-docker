FROM mysql:8.0.18

ENV MYSQL_ALLOW_EMPTY_PASSWORD=1

RUN apt-get update && apt-get install -y \
    git build-essential libssl-dev libreadline-dev \
    zlib1g-dev curl apt-transport-https libmariadb-dev

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH

# Install ruby-build & ruby
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    rbenv install 2.6.2 && \
    rbenv global 2.6.2

# Initiarize ruby encording
ENV RUBYOPT -EUTF-8

# Install bundler
RUN gem install bundler:2.0.2

# Install Node.js
RUN git clone git://github.com/nodenv/nodenv.git ~/.nodenv && \
    echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(nodenv init -)"' >> ~/.bashrc

ENV PATH /root/.nodenv/shims:/root/.nodenv/bin:$PATH

RUN git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build && \
    nodenv install 12.17.0 && \
    nodenv global 12.17.0

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends yarn

# Setup

ENV APP_ROOT /nuita
RUN git clone https://github.com/nuita/nuita.git $APP_ROOT
WORKDIR $APP_ROOT
RUN git checkout create-basic-api

RUN cd server && bundle install
RUN cd client && yarn install --check-files

EXPOSE 3000
EXPOSE 4000

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD [ "bash" ]
