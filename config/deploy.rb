require 'dotenv'
Dotenv.load
require 'mina/deploy'
require 'mina/bundler'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
require_relative './pm2_tasks'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :ruby_version, File.read(File.expand_path('../.ruby-version', File.dirname(__FILE__))).strip
set :application_name, 'Bhouse web'
set :user, 'ubuntu'
set :forward_agent, true
set :keep_releases, 2
set :repository, 'git@github.com:fisherboat/bhouse.git'
set :shared_files, fetch(:shared_files, []).push('config/ecosystem.config.js')

# set :shared_dirs, fetch(:shared_dirs, []).push('node_modules')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

task :production do
  set :domain, 'tx-shanghai'
  set :deploy_to, '/home/ubuntu/services/bhouse'
  set :node_env, 'production'
  set :branch, 'master'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task setup: :remote_environment do
  command %{cd $HOME/.rbenv/plugins/ruby-build && git pull && cd - }
  command %{rbenv install #{fetch(:ruby_version)} --skip-existing}
  command %{rm -f $HOME/.rbenv/shims/.rbenv-shim && rbenv rehash}
  command %{echo #{fetch(:ruby_version)} > #{fetch(:deploy_to)}/.ruby-version}
  command %{cd #{fetch(:deploy_to)} && gem install bundler --version='#{fetch(:bundler_version)}'}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    command "yarn && NODE_ENV=#{fetch(:node_env)} yarn run generate"
    invoke :'deploy:cleanup'
    # on :launch do
    #   in_path(fetch(:current_path)) do
    #     command "pm2 startOrRestart config/ecosystem.config.js"
    #   end
    # end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs