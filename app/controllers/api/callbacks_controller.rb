module Api
  class CallbacksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:notify]

    def notify
      if params[:event] == 'project.imported'
        handle_project_imported
      elsif params[:event] == 'team.order.completed'
        handle_order_completed
      end

      head :ok
    end

    private

    def handle_project_imported
      project_id = params[:project][:id]
      key_ids = get_keys_for project_id

      order = api_client.create_order 176692,
                                      project_id: project_id,
                                      card_id: 1774,
                                      briefing: 'MT',
                                      source_language_iso: params[:language][:iso],
                                      target_language_isos: %w[fr],
                                      keys: key_ids,
                                      provider_slug: 'google',
                                      translation_tier: 1
      
      Order.create order_id: order.order_id, project_id: project_id, status: order.status
    end

    def handle_order_completed
      order = Order.find_by order_id: params[:order][:id]

      order.update status: 'completed'

      api_client.download_files order.project_id, format: 'yaml',
                                original_filenames: true,
                                filter_langs: %w[fr],
                                filter_data: %w[translated],
                                add_newline_eof: true,
                                triggers: %w[github],
                                indentation: '2sp',
                                yaml_include_root: true
    end

    def get_keys_for(project_id)
      keys = api_client.keys project_id, limit: 5000,
                             filter_filenames: "%LANG_ISO%.yml",
                             filter_translation_lang_ids: 673,
                             filter_untranslated: 1
      
      keys.collection.map(&:key_id)                      
    end
  end
end