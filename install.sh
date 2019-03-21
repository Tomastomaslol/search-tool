if ! ruby -v; then printf 'Error missing ruby. please install ruby'; fi
if ! bundler -v; then gem install bundler; fi
bundle install
printf  '\nInstall successful\n'
printf 'Application doumentation:\n'
bundle exec rspec -f d
printf 'Install successful starting application:\n'
. start.sh
