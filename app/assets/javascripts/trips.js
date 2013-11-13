
var mapOptions = {
  center: new google.maps.LatLng(40.741, -73.9898),
  zoom: 14,
  mapTypeId: google.maps.MapTypeId.ROADMAP
};

//displays directions from orig to dest,
//entered as strings
function calcRoute(orig, dest, mode) {
  var request = {
    origin: orig,
    destination: dest,
    travelMode: google.maps.TravelMode.BICYCLING
  };
  directionsService.route(request, function(result, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(result);
    }
  });
}

//adds a marker with info window to a map
//fix this to take icon and window action as params
function addMarker(lat, lng, status, open) {
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(lat, lng),
    map: map
    //icon: image_url 
  });

  var infowindow = new google.maps.InfoWindow({
    content: status
    
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.open(map, marker); });

  if (open) { infowindow.open(map, marker); }
}

function handleNoGeolocation(error) {
  switch(error.code)
  {
    case error.PERMISSION_DENIED:
      return "User denied the request for Geolocation.";
    case error.POSITION_UNAVAILABLE:
      return "Location information is unavailable.";
    case error.TIMEOUT:
      return "The request to get user location timed out.";
    case error.UNKNOWN_ERROR:
      return "An unknown error occurred.";
  }
}

function link_address() {
  if (document.getElementById('address').innerHTML.trim() != "searching...") {
    document.getElementById('trip_origin').value = document.getElementById('address').innerHTML;
  }
}

