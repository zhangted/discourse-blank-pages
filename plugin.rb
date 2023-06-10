# frozen_string_literal: true

# name: discourse-blank-pages
# about: Add blank pages and scripts on custom routes
# version: 0.0.1 
# authors: Teddy Zhang
# url: TODO
# required_version: 2.7.0

PLUGIN_NAME ||= "discourse-blank-pages".freeze

after_initialize do
  module ::DiscourseBlankPages
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseBlankPages
    end

    Engine.routes.draw do
      get "/*page_id", to: ->(env) {
        request = ActionDispatch::Request.new(env)
        page_id = request.path_parameters[:page_id]

        valid_routes = SiteSetting.valid_routes.split('|')
        unless valid_routes.include?(page_id)
          response_headers = { 'Content-Type' => 'text/html', 'Location' => '/404' }
          return [302, response_headers, '']
        end

        rendered_content = ApplicationController.render(inline: '', layout: 'layouts/application')

        [200, {'Content-Type' => 'text/html'}, [rendered_content]]
      }
    end
  end
  
  Discourse::Application.routes.append do
    mount ::DiscourseBlankPages::Engine, at: '/pages'
  end
end