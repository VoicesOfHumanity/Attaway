$(document).ready(function() {
  $("#hlp_qm").hoverIntent({
    timeout: 500,
    over: function() { $("#hlp_info").fadeIn("speed"); },
    out: function() { $("#hlp_info").fadeOut("speed"); }
  });

  $("#hlp_close").click(function() {
    $("#hlp_info").fadeOut("speed");
    return false;
  });

  $("#hlp_info").hide();
});

