document.addEventListener('DOMContentLoaded', function() {
  const savedEntryButtons = document.querySelectorAll('.saved-entry-button');

  // Enable "Save" button for saved entries
  savedEntryButtons.forEach(function(button) {
    button.disabled = false;
    button.value = 'Save';
    button.addEventListener('click', handleSaveEntry);
  });

  function handleSaveEntry(event) {
    const button = event.target;
    button.disabled = true;
    button.value = 'Saving...';

    const tr = button.closest('tr');
    const walletAddress = tr.querySelector('.wallet-address').innerText;
    const amount = tr.querySelector('.amount').innerText;

    // Send an AJAX request to save the entry
    fetch('/wallets/save_entry', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ wallet_address: walletAddress, amount: amount })
    })
      .then(function(response) {
        if (response.ok) {
          button.value = 'Saved';
          button.removeEventListener('click', handleSaveEntry);
        } else {
          button.disabled = false;
          button.value = 'Save';
        }
      })
      .catch(function(error) {
        console.error(error);
        button.disabled = false;
        button.value = 'Save';
      });
  }
});
