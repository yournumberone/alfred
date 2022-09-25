require 'rubygems'

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'sinatra', require: 'sinatra/base'
  gem 'omniauth'
  gem 'omniauth-oauth2'
  # gem 'omniauth-alfred', git: 'https://github.com/cybergizer-hq/omniauth-alfred'
  gem 'dotenv'
  gem 'pry'
end

Dotenv.load('.env.memento')

require 'omniauth-oauth2'
require 'json'

module OmniAuth
  module Strategies
    class Alfred < OmniAuth::Strategies::OAuth2
      begin
        require 'dotenv' unless defined?(ENV)

        ALFRED_APP_URL = ENV.fetch('ALFRED_APP_URL', 'https://alfred-cg.herokuapp.com')
      rescue LoadError
        ALFRED_APP_URL = 'https://alfred-cg.herokuapp.com'
      end

      option :name, :alfred

      option :client_options,
             site: ALFRED_APP_URL,
             authorize_path: '/oauth/authorize'

      uid do
        raw_info['uid']
      end

      info do
        {
          email: raw_info['email'],
          alfred_id: raw_info['id'],
          first_name: raw_info['first_name'],
          last_name: raw_info['last_name'],
          name: "#{raw_info['first_name']} #{raw_info['last_name']}",
          avatar_url: raw_info['avatar'],
          dob: raw_info['dob']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/users/me.json').parsed
      end
    end
  end
end

class Memento < Sinatra::Base
  use Rack::Session::Cookie

  use OmniAuth::Builder do
    provider :alfred, ENV['ALFRED_KEY'], ENV['ALFRED_SECRET'], scope: 'User'
  end

  get '/' do
    "<a href='/auth/alfred'>Sign in Alfred</a>"
  end

  get '/auth/:name/callback' do
    auth = request.env['omniauth.auth']
    binding.pry
    "#{auth.inspect}"
  end
end

Memento.run!
