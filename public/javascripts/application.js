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
