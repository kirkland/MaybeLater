function setupTasksIndex(updatePath, createPath) {
  setupTasksDragDrop(updatePath);
  setupNewTaskForm(createPath);
}

function setupNewTaskForm(createPath) {
  $('#task_submit').click(event, function () {
	  event.preventDefault();
	  //    console.log($('#new_task').serialize());
        $.ajax(createPath, {
    	    type: 'POST',
	    data: $('#new_task').serialize()
		    //		    success: function(data) { console.log(data);},
		    //            error: function(data) { console.log("error"); console.log(data); }
		    })
	      
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
