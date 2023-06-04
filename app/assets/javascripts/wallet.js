$(document).ready(function() {
    // Handle form submission
    $('#add-currency-form').submit(function(event) {
      event.preventDefault();

      // Get form data
      var formData = {
        address: $('#address').val(),
        amount: $('#amount').val()
      };

      // Submit AJAX request
      $.ajax({
        type: 'POST',
        url: '/wallet/add_currency',
        data: formData,
        dataType: 'json',
        success: function(data) {
          // Add new row to table
          var newRow = $('<tr>').attr('data-id', data.id)
            .append($('<td>').text(data.address))
            .append($('<td>').text(data.amount))
            .append($('<td>').append($('<button>').text('Delete').addClass('btn btn-danger delete-btn')));

          $('#currency-table tbody').append(newRow);

          // Clear form
          $('#address').val('');
          $('#amount').val('');
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log('Error:', errorThrown);
        }
      });
    });

    // Handle delete button click
    $('#currency-table').on('click', '.delete-btn', function(event) {
      event.preventDefault();

      // Get row ID and submit AJAX request
      var row = $(this).closest('tr');
      var id = row.data('id');

      $.ajax({
        type: 'DELETE',
        url: '/wallet/delete_currency/' + id,
        dataType: 'json',
        success: function(data) {
          // Remove row from table
          row.remove();
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log('Error:', errorThrown);
        }
      });
    });
  });
