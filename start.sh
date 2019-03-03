#!/bin/bash
bundle check || bundle install
yarn install
bundle exec puma -C config/puma.rb