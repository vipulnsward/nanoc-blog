require 'sinatra'

$output_dir = "/home/ubuntu/work/nginx_web/"
$logs_dir = "/home/ubuntu/.logs"

configure do
  set :port, 2246
  set :bind, '127.0.0.1'
end

post '/' do
  current_dir = File.dirname(__FILE__)
  log_file = "#{$logs_dir}/#{Time.now.iso8601}"

  %x(cd #{current_dir} && git pull origin master)
  %x(cd #{current_dir} && nanoc compile > #{log_file})
  %x(rm -R #{$output_dir}/* 2>> #{log_file})
  %x(cd #{current_dir} && mv #{current_dir}/output/* #{$output_dir}/ 2>> #{log_file})
end