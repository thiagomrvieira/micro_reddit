document.addEventListener('turbo:load', function() {
  const sortButton = document.getElementById('sortButton');
  const sortDropdown = document.getElementById('sortDropdown');
  const dropdownItems = sortDropdown.querySelectorAll('a');

  sortButton.addEventListener('click', function() {
    sortDropdown.classList.toggle('hidden');
  });

  document.addEventListener('click', function(event) {
    if (!sortButton.contains(event.target) && !sortDropdown.contains(event.target)) {
      sortDropdown.classList.add('hidden');
    }
  });

  dropdownItems.forEach(function(item) {
    item.addEventListener('click', function() {
      sortDropdown.classList.add('hidden');
    });
  });
});
