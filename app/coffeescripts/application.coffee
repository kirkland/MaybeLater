class @TasksIndex
  constructor: (@reorderPath, @createPath) ->
    @setupTasksDragDrop()
    @setupNewTaskForm()
    $('#task_title').focus()

  setupTasksDragDrop: ->
    fixHelper = (e, ui) ->
      ui.children().each ->
        $(this).width($(this).width())
      ui

    $('#tasks tbody').sortable(
      items: 'tr',
      helper: fixHelper,
      containment: "#tasks tbody",
      tolerance: 'pointer',
      update: (event, ui) =>
        newTasksOrder = $.map $('#tasks tr').not('.task_template'), (t) ->
          return $(t).attr('data-id')
        $.ajax @reorderPath,
          type: 'POST',
          data:
            ordered_task_ids: newTasksOrder
    ).disableSelection();

  insertNewTask: (title, id) ->
    taskData =
      title: title,
      'id': id
    newRow = $('.task_template').clone().directives({'.task_title': 'title', '@data-id': 'id'}).render(taskData).removeClass('task_template')
    $('#tasks tbody').prepend(newRow)
    newRow

  # used on both dynamically added tasks and initial ones
  setupNewRow: (newRow) ->
    newRow.find('.actions .complete_link').click event, () ->
      event.preventDefault();

  setupNewTaskForm: ->
    $('#task_submit').click event, () =>
      event.preventDefault()
      ajaxData = $('#new_task').serialize()
      title = $('#task_title').val()
      $('#task_title').val('')

      # add new row immediately. we'll populate data attributes when AJAX returns
      newRow = @insertNewTask title
      $.ajax @createPath,
        type: 'POST',
        data: ajaxData,
        success: (data) =>
          newRow.attr('data-id', data.task.id)
          newRow.attr('data-update_path', data.task.updatePath)
          newRow.find('td').removeClass('just_added')
          @setupNewRow newRow
        error: (data) ->
