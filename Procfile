release: rake dev:deployed
web: bin/rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq -e production -C config/sidekiq.yml
