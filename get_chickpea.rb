# `sudo gem install colorize`
# `sudo gem install pry`
require 'open3'
require 'colorize'
require 'pry'
#sets up a development server
####################################
######### --- Pre-requisites --- ###
####################################
#- ruby 2.0+
#- git 1.8+

####################################
######### --- Configuration --- ####
####################################

@aws_vars = { AWS_ACCOUNT_NUMBER: ENV['AWS_ACCOUNT_NUMBER'],
              AWS_REGION: ENV['AWS_REGION'],
              AWS_ACCESS_KEY_ID: ENV['AWS_ACCESS_KEY_ID'],
              AWS_SECRET_ACCESS_KEY: ENV['AWS_SECRET_ACCESS_KEY'] }

@aws_vars.each do |k,v|
  env_variable = `source ~/.bash_profile && echo #{v}`.chomp
  if env_variable.empty?
    puts "please enter #{k}"
    @aws_vars[k] = gets.chomp
    `echo "export #{k}=#{@aws_vars[k]}" >> ~/.bash_profile`
  end
end

@debug = true
@add_swap_memory = true
@code_directory = "/root/code"
@app_name = "chickpea-app"
@working_directory = "#{@code_directory}/#{@app_name}"
@github_repo = "mhamouda1/chickpea-app"
@recommended_linux = "CentOS Linux release 7.6.1810"
@installations = ["tmux", "vim", "ag", "docker", "docker-compose"]
@scripts_dir = "linux_installations"

####################################
######### --- Debug --- ############
####################################
if @debug
  puts "using #{`printf $(cat /etc/*-release | head -n 1)`}, recommended Linux distribution is #{@recommended_linux}".blue
  puts "using #{@working_directory} as working directory".blue
end

####################################
#### --- Directory Structure --- ###
####################################
if !File.directory?(@code_directory)
  `mkdir -p #{@code_directory}`
  Dir.chdir(@code_directory) do
    `git clone https://github.com/#{@github_repo}`
  end
end

####################################
######### --- Installations --- ####
####################################
#TODO: swap memory adds 4GB, want to add 2GB
if @add_swap_memory
  IO.popen("bash ./#{@scripts_dir}/add_swap_memory.sh") { |io| while (line = io.gets) do puts line end }
end

@installations.each do |installation|
  IO.popen("bash ./#{@scripts_dir}/#{installation}.sh") { |io| while (line = io.gets) do puts line end } if `which #{installation} 2>&1` =~ /no #{installation}/
end

####################################
## - Linux System ENV variables - ##
####################################


####################################
########## --- Done! --- ###########
####################################
puts "Setup complete!".green
