# frozen_string_literal: true

# name: discourse-blank-pages
# about: Add blank pages and scripts on custom routes
# version: 0.0.2
# authors: Teddy Zhang
# url: TODO
# required_version: 2.7.0

PLUGIN_NAME ||= "discourse-blank-pages".freeze

Discourse::Application.config.autoload_paths += Dir["#{__dir__}/app/views/application"]

after_initialize do
  module ::DiscourseBlankPages
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseBlankPages
    end

    class ApplicationController < ::ActionController::Base
      # Include modules needed to render application layout
      include CanonicalURL::ControllerExtensions
    end

    class BlankPageController < ApplicationController
      def show
        page_id = params[:page_id]
  
        redirect_to_404 && return unless SiteSetting.valid_routes.present?
        valid_routes = SiteSetting.valid_routes.split('|')
        redirect_to_404 && return unless valid_routes.include?(page_id)
  
        render 'layouts/application'
      end
  
      def redirect_to_404
        redirect_to '/404', status: 302
      end
    end
  
    Engine.routes.draw do
      get "/*page_id", to: "blank_page#show"
    end
  end

  Discourse::Application.routes.append do
    mount ::DiscourseBlankPages::Engine, at: '/pages'
  end
end