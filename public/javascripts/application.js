function setupTasksIndex(updatePath, createPath) {
  setupTasksDragDrop(updatePath);
  setupNewTaskForm(createPath);

  // set up complete/other links for each existing row
  $.each($('#tasks tr'), function(index, row) {
    setupNewRow($(row));
  });
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

function updateStatus(ajax_path, task_id, defer_time) {
  $(event.target).closest('tr').remove();
  
  $.ajax(ajax_path, {
    type: 'POST',
    data: {
      task_id: task_id,
      defer_time: defer_time
    },
    success: function(data) {
     // console.log(data);
    },
    error: function(data) {
     // console.log(data.responseText);
    }
  });
}

function setupNewRow(newRow, id, updatePath) {
  // this first part is only applicable for rows added dynamically
  if (id) {
    newRow.attr('data-id', id);
    newRow.attr('data-update_path', updatePath);
    newRow.find('td').removeClass('just_added');
  }

  newRow.find('.actions .complete_link').click(event, function() {
    event.preventDefault();

    updateStatus(newRow.attr('data-update_path'), newRow.attr('data-id'), 0);
  });            
}

function setupNewTaskForm(createPath) {
  $('#task_submit').click(event, function () {
    event.preventDefault();
    var ajaxData = $('#new_task').serialize();
    var title = $('#task_title').val();
    $('#task_title').val('');

    // add new row immediately. we'll populate data attributes when AJAX returns
    var newRow = insertNewTask(title);
    
    $.ajax(createPath, {
      type: 'POST',
      data: ajaxData,
      success: function(data) {
        setupNewRow(newRow, data.task.id, data.task.update_path);
      },
      error: function(data) {
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
