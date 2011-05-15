function setupTasksIndex(updatePath, createPath) {
  setupTasksDragDrop(updatePath);
  setupNewTaskForm(createPath);
}

function insertNewTask(title, id) {
  var taskData = {
    title: title,
    'id': id
  };

  var newRow = $('.task_template').clone().directives({'.task_title': 'title', '@data-id': 'id'}).render(taskData).removeClass('task_template');
  $('#tasks tbody').prepend(newRow);

  return newRow;
}

function setupNewRow(newRow) {
  newRow.attr('data-id', data.task.id);
  newRow.find('td').removeClass('just_added');
}

function setupNewTaskForm(createPath) {
  $('#task_submit').click(event, function () {
    event.preventDefault();
    var ajaxData = $('#new_task').serialize();
    var title = $('#task_title').val();
    $('#task_title').val('');

    // add new row immediately. we'll populate data-id when AJAX returns
    var newRow = insertNewTask(title);
    
    $.ajax(createPath, {
      type: 'POST',
      data: ajaxData,
      success: function(data) {
//        console.log(data);
        setupNewRow(newRow);
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
    tolerance: 'pointer',

    update: function(event, ui) { 
      var newTasksOrder = $.map($('#tasks tr').not('.task_template'), function(t) {
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
//                console.log("something went wrong");
        }
      });
    }
  }).disableSelection();
}

function updateStatus(ajax_path, task_id, defer_time) {
  $(event.target).closest('tr').remove();
  
  $.ajax(ajax_path, {
    type: 'POST',
    data: {
      task_id: task_id,
      defer_time: defer_time
    },
    success: function(data) {
//      console.log(data);
    },
    error: function(data) {
//      console.log(data.responseText);
    }
  });
}