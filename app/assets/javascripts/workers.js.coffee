# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Volunteers new edit
# Return the next image in the array, or loop back to the beginning
nextImage = () ->
  curImage += 1
  if (curImage >= vImages.length)
    curImage=0
    return vImages[0]
  else
    return vImages[curImage]

# Volunteers new edit
# Return the previous image in the array, or loop to the end
prevImage = ()->
  curImage -= 1
  if (curImage < 0)
    curImage=vImages.length-1
    return vImages[vImages.length-1]
  else
    return vImages[curImage]

# Volunteers new edit
# Replaces avatar image with one from the list
showImage = (src) ->
  newImage = new Image()
  $("#avatar center img").fadeOut("slow").remove()
  $(newImage).attr("src", "/images/default_avatars/" + src).load(() ->
    $(newImage).hide()
    $("#avatar center").html( newImage )
    $(newImage).fadeIn("slow")
  )
  $("input#worker_image").attr("value", src)


# Volunteers new edit
# Return the next image in the array, or loop back to the beginning
nextCheeseImage = () ->
  curImage += 1
  if (curImage >= cheeseImages.length)
    curImage=0
    return cheeseImages[0]
  else
    return cheeseImages[curImage]

# Volunteers new edit
# Return the previous image in the array, or loop to the end
prevCheeseImage = () ->
  curImage -= 1
  if (curImage < 0)
    curImage=cheeseImages.length-1
    return cheeseImages[cheeseImages.length-1]
  else
    return cheeseImages[curImage]

# Volunteers new edit
# Replaces avatar image with one from the list
showCheeseImage = (src) ->
  newImage = new Image()
  $("#avatar center img").fadeOut("slow").remove()
  $(newImage).attr("src", "/images/cheese/" + src).load(() ->
    $(newImage).hide()
    $("#avatar center").html( newImage )
    $(newImage).fadeIn("slow")
  )
  $("input#worker_image").attr("value", src)

