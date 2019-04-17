#!/bin/bash -l

set -e

export RAILS_ENV=${RAILS_ENV:-development}
export NOKOGIRI_USE_SYSTEM_LIBRARIES=1

WITHOUT=""

case ${RAILS_ENV} in
  development)
    ;;
  test)
    WITHOUT="--without development"
    ;;
  production)
    WITHOUT="--without development test"
    ;;
esac

if [ Gemfile -nt /tmp/bundle-installed ]; then
	gem install bundler --no-ri --no-rdoc
  bundle install ${WITHOUT}
  touch /tmp/bundle-installed
fi

case ${RAILS_ENV} in
  test)
		sleep infinity
		;;
	production)
		rm -rf tmp/pids
		rake db:migrate
		rake db:seed
		rake assets:precompile
		if [ "$FORCE_SSL" = "true" ]; then
			puma --config config/puma.rb -b 'ssl://0.0.0.0:3000?key=/etc/ssl/conpinion-customerportal.key&cert=/etc/ssl/conpinion-customerportal.cer'
		else
			puma --config config/puma.rb
		fi
		;;
	development)
		rm -rf tmp/pids
		rake db:migrate
		rake db:seed
		if [ "$FORCE_SSL" = "true" ]; then
			puma --config config/puma.rb -b 'ssl://0.0.0.0:3000?key=/etc/ssl/conpinion-customerportal.key&cert=/etc/ssl/conpinion-customerportal.cer'
^		else
			puma --config config/puma.rb
		fi
		;;
esac
