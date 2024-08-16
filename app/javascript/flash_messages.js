document.addEventListener("turbo:load", function() {
    var flashAlert = document.getElementById('flash-alert');
    if (flashAlert) {
      setTimeout(function() {
        flashAlert.style.opacity = '0';
        flashAlert.style.transition = 'opacity 0.5s ease-out';

        setTimeout(function() {
          flashAlert.remove();
        }, 500);
      }, 2000);
    }
});