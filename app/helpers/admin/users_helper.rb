# frozen_string_literal: true

module Admin::UsersHelper
  def app_access_checkboxes(app_list:, current_apps:)
    app_list.map do |app|
      "<div class='custom-control custom-checkbox'>
          <input type='checkbox'
             name='user[oauth_application_ids][]'
             class='custom-control-input'
             id='app_#{app.id}'
             value='#{app.id}'
             #{'checked' if current_apps.include?(app.name)}>
             #{label_tag("app_#{app.id}", app.name,
                         class: 'custom-control-label')}
      </div>"
    end.join(' ').html_safe
  end
end
