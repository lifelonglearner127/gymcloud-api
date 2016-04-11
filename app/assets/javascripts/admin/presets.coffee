ajax = null
loadProgramTemplates = ->
  select = $('#program_preset_program_template_ids')
  template = (record) -> "<option value='#{record.id}'>#{record.name}</option>"
  $('#program_preset_user_id').on 'change', (ev) ->
    ajax?.abort?()
    ajax = $.ajax
      type: 'GET'
      url: "/admin/program_presets/user_program_templates"
      data: user_id: ev.currentTarget.value
      dataType: 'json'
      contentType: 'application/json'
      error: -> ajax = null or console.error(arguments)
      success: (result) ->
        html = result.map(template).join('')
        select.html(html)
        ajax = null

window.GymcloudAdmin.program_presets =
  new: loadProgramTemplates
  edit: loadProgramTemplates
