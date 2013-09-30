# Handles transition animation for flash notices.
$(document).ready ->
  setTimeout ->
    $('.notice').animate({ marginLeft: 0, opacity: 0 }, 900)
  , 3000