FROM ruby

RUN apt-get update
RUN apt-get install -y opam
RUN opam init
RUN opam switch 4.06.0
RUN gem install bundler
ADD . /itamae-plugin-resource-opam
WORKDIR /itamae-plugin-resource-opam
RUN bundle install --path .bundle/gems
RUN bundle exec itamae local ./samples/recipe.rb
