map = undefined
initialize = ->
  if $('#map-field').val().lenght != 0
    center = $('#map-field').val()
  else
    x = '20.968034, -89.631717'
    z = x.split(',')[0]

  console.log z
  hola = new (google.maps.LatLng)(x)


  mapOptions =
    zoom: 11
    center: {lat: -34.397, lng: 150.644}
  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)

  google.maps.event.addListener map, 'click', (e) ->
    placeMarker e.latLng, map
    lat = e.latLng.lat()
    lng = e.latLng.lng()
    setValue lat, lng
    return
  return

setValue = (lat, lng) ->
  $('#map-field').val lat + ',' + lng
  return

placeMarker = (position, map) ->
  marker = new (google.maps.Marker)(
    position: position
    map: map)
  map.panTo position
  return

google.maps.event.addDomListener window, 'load', initialize

$(document).ready initialize
$(document).on 'page:load', initialize
