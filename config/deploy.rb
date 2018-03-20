# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, 'tb-advanced'
set :repo_url, 'git@github.com:dendomenko/tb-advanced.git' # change this to your git server

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

after 'deploy:publishing', 'deploy:restart', 'ts:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:reload'
  end

  task :stop do
    invoke 'unicorn:stop'
  end
end

namespace :ts do
  task :restart do
    invoke 'thinking_sphinx:stop'
    invoke 'thinking_sphinx:start'
  end
end