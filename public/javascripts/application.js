function setupTasksIndex(updatePath, createPath) {
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

function setupNewRow(newRow, id, updatePath) {
  newRow.attr('data-id', id);
  newRow.attr('data-update_path', updatePath);
  newRow.find('td').removeClass('just_added');

  newRow.find('.actions .complete_link').click(event, function() {
    event.preventDefault();
//    updateStatus(Ssomeargshere);
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