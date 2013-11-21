/* Print string at the top of the dialog box */
function dialog( text ) {
    $("#dialog").css('visibility', 'visible').prepend( text );
};

function avatarOrder( elt ) {
    return elt.prev().length;
};

/* Sign the person in when their avatar is dragged to the shop div */
function sign_in(ev, ui) {
    $(this).append( $(ui.draggable).addClass("atshop").removeClass("athome").end() );
    $.get("shop/sign_in", { person: $(ui.draggable).find(".vno").text(), 
		top: $(ui.draggable).css('top'), 
		left: $(ui.draggable).css('left'),
		order: $("div.shop .atshop").index($(ui.draggable))
		}, 
	sign_in_message
	);
};
function sign_in_message(xml) {
    dialog( $("person", xml).text() + " is in the shop at " + 
	    $("start", xml).text() + "<br />");
}

/* Sign out when avatar is dragged from the shop to the pool div */
function sign_out(ev, ui) {
    $(this).append( $(ui.draggable).addClass("athome").removeClass("atshop").end() );
    $.get("shop/sign_out", 
	  {person: $(ui.draggable).find( ".vno").text()}, 
	  sign_out_message);
};
function sign_out_message(xml) {
    dialog($("person", xml).text() + " signed out at " + 
	   $("end", xml).text() + ", worked " +
	   $("difference", xml).text() + "<br />" );
}

$(document).ready(function() {
  // do stuff when DOM is ready

  $(".athome").draggable({handle: "img"});
  $(".atshop").draggable({handle: "img"});
  $("#v_prev").click(function(event){alert("No worky!  Try the search.");});
  $("#v_next").click(function(event){alert("Not finished yet!  search?");});

  $(".shop").droppable({accept: ".athome", drop: sign_in });
  $(".home").droppable({accept: ".atshop", drop: sign_out });

});

