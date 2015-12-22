# Set default port to 6000 if user doesn't specify
ENV['port'] ||= "6000"

namespace :server do

	task :start do
		config = File.expand_path('../config.ru', File.dirname(__FILE__))
		# exec("thin -e development -R #{config} --debug start")
		exec("shotgun --server=thin --port=#{ENV['port']} #{config}")
	end

end