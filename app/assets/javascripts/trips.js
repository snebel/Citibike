
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
function addMarker(lat, lng, status) {
  var marker = new google.maps.Marker({
    position: new google.maps.LatLng(lat, lng),
    map: map
  });

  var infowindow = new google.maps.InfoWindow({
    content: status
  });

  google.maps.event.addListener(marker, 'click', function(){ infowindow.open(map, marker); });
}

function handle_current_pos(position) {
  lat = position.coords.latitude;
  lng = position.coords.longitude;

  addMarker(lat, lng, "current location");
}

function handleNoGeolocation(errorFlag) {
  alert("Your browser's locations settings are off. Features that use your current location won't work.");
}



