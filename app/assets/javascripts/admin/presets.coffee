ajax = null
loadFolders = ->
  select = $('#program_preset_folder_id')
  template = (folder) -> "<option value='#{folder.id}'>#{folder.name}</option>"
  $('#program_preset_user_id').on 'change', (ev) ->
    ajax?.abort?()
    ajax = $.ajax
      type: 'GET'
      url: "/admin/program_presets/user_folders"
      data: user_id: ev.currentTarget.value
      dataType: 'json'
      contentType: 'application/json'
      error: -> ajax = null or console.error(arguments)
      success: (result) ->
        html = result.map(template).join('')
        select.html(html)
        ajax = null

window.GymcloudAdmin.program_presets =
  new: loadFolders
  edit: loadFolders
