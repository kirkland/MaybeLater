function setupTasksIndex(updatePath, createPath) {
  setupTasksDragDrop(updatePath);
  setupNewTaskForm(createPath);
}

function setupNewTaskForm(createPath) {
  $('#task_submit').click(event, function () {
    event.preventDefault();
    var ajaxData = $('#new_task').serialize();
    var content = $('#task_content').val();
    $('#task_content').val('');

    // add new row immediately. we'll populate data-id when AJAX returns
    var newRow = $('#tasks tbody tr').first().clone();
    newRow.attr('data-id', '').find('td').html(content).addClass('just_added');
    newRow.prependTo($('#tasks tbody'));
    
    $.ajax(createPath, {
      type: 'POST',
      data: ajaxData,
      success: function(data) {
//        console.log(data);
        newRow.attr('data-id', data.task.id);
        newRow.find('td').removeClass('just_added');
      },
      error: function(data) {
        //          console.log("error"); 
        //          console.log(data);
      }
    });
  });
}

var fixHelper = function(e, ui) {
  ui.children().each(function() {
      $(this).width($(this).width());
    });
  return ui;
};

function setupTasksDragDrop(updatePath) {
  $('#tasks tbody').sortable({
    items: 'tr',
    helper: fixHelper,
    containment: "#tasks tbody",
    update: function(event, ui) { 
      var newTasksOrder = $.map($('#tasks tr'), function(t) {
        return $(t).attr('data-id');
      });
      //      console.log(newTasksOrder);
      $.ajax(updatePath, {
        type: 'POST',
        data: {
         ordered_task_ids: newTasksOrder
        },
        success: function(data) {
//          console.log(data);
        },
        error: function () {
      //          console.log("something went wrong");
        }
      });
    }
  }).disableSelection();
}
