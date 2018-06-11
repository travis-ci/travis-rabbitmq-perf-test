require 'pathname'
require 'uri'

CONFIG_FILENAME = File.expand_path('~/.rabbitmqadmin.conf')

heroku_app = ARGV.shift || 'travis-rabbitmq-perf-test'

url = `heroku config:get CLOUDAMQP_URL -a #{heroku_app}`.chomp
unless $?.exitstatus == 0
  raise "heroku config:get CLOUDAMQP_URL failed with exit code #{$?.exitstatus}"
end

if url == ''
  raise 'CLOUDAMQP_URL is empty'
end

uri = URI(url)

config = <<-HEREDOC
[default]
hostname = #{uri.host}
port = 443
username = #{uri.user}
password = #{uri.password}
vhost = #{uri.path[1..-1]}
ssl = True
HEREDOC

if File.exists? CONFIG_FILENAME
  print "#{CONFIG_FILENAME} already exists, overwrite? (y/n) "
  answer = $stdin.gets.chomp
  unless ['y', 'yes'].include? answer
    raise 'not overwriting'
  end
end

File.write(CONFIG_FILENAME, config)
