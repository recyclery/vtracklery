# Print string at the top of the dialog box
dialog = (text) ->
  $("#dialog").css('visibility', 'visible').prepend( text )

# Shop#sign_in
#sign_in = (ev, ui) ->
sign_in_message = (xml) ->
  dialog( $("worker", xml).text() + " is in the shop at " + 
	  $("start", xml).text() + "<br />")

sign_out_message = (xml) ->
  dialog($("worker", xml).text() + " signed out at " + 
    $("end", xml).text() + ", worked " +
    $("message", xml).text() +
    " <a href='http://vtrack.ru.lan/work_times/" +
    $("work_time_id", xml).text() +
    "'>change this</a>" +
    "<br />")

sign_in = (ev, ui) ->
  $(this).append( $(ui.draggable).addClass("atshop").removeClass("athome").end() )
  $.get("shop/sign_in", {
    worker: $(ui.draggable).find(".vno").text(), 
    top: $(ui.draggable).css('top'), 
    left: $(ui.draggable).css('left'),
    order: $("div.shop .atshop").index($(ui.draggable))
    }, sign_in_message)

sign_out = (ev, ui) ->
  $(this).append( $(ui.draggable).addClass("athome").removeClass("atshop").end() );
  $.get("shop/sign_out",
    { worker: $(ui.draggable).find(".vno").text() }, sign_out_message)

$(document).ready(() ->
  # do stuff when DOM is ready

  $(".athome").draggable({handle: "img"})
  $(".atshop").draggable({handle: "img"})
  $("#v_prev").click( (event) -> alert("No worky!  Try the search."))
  $("#v_next").click( (event) -> alert("Not finished yet!  search?"))

  $(".shop").droppable({accept: ".athome", drop: sign_in })
  $(".home").droppable({accept: ".atshop", drop: sign_out })
)

