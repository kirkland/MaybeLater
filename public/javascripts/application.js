function setupTasksIndex(updatePath, createPath) {
  setupTasksDragDrop(updatePath);
  setupNewTaskForm(createPath);
}

function setupNewTaskForm(createPath) {
  $('#task_submit').click(event, function () {
  event.preventDefault();
  // show some waiting gif
  var ajaxData = $('#new_task').serialize();
  $('#task_content').val('');
    $.ajax(createPath, {
      type: 'POST',
      data: ajaxData,
      success: function(data) {
	  // stop waiting gif
	  var newRow = $('#tasks tbody tr').first().clone();
	  newRow.attr('data-id', data.task.id).find('td').html(data.task.content);
	  newRow.prependTo($('#tasks tbody'));
      },
      error: function(data) {
//        console.log("error"); 
//        console.log(data);
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
  $('#tasks').sortable({
    items: 'tr',
    helper: fixHelper,
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
//		  	  console.log(data);
        },
        error: function () {
		  //          console.log("something went wrong");
        }
      });
    }
  }).disableSelection();
}
