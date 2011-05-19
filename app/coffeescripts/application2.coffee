class @TasksIndex
  constructor: (@reorderPath) ->
    @setupTasksDragDrop()

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