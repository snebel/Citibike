      // //GEOLOCATION API
      // navigator.geolocation.getCurrentPosition(handleGeolocation, handleNoGeolocation);

      // function handleGeolocation(position) {
      //   var lat = position.coords.latitude;
      //   var lng = position.coords.longitude;
      //   var cookie_val = lat + "|" + lng;
      //   document.cookie = "lat_lng=" + escape(cookie_val); path = '/places';
      //   setAddress(lat, lng);
      //   map.setCenter(new google.maps.LatLng(lat, lng));
      //   addMarker(lat, lng, "YOU ARE HERE", true);

      //   // <% lat_lng = cookies["lat_lng"].split("|") %>
      //   // <% lat = lat_lng.first.to_f %>
      //   // <% lng = lat_lng.last.to_f %>
      //   // <% stas = Trip.find_closest_stations(lat, lng) %>
      // };

      // function setAddress(latitude, longitude) {
      //   geocoder = new google.maps.Geocoder();
      //   latlng = new google.maps.LatLng(latitude, longitude);

      //   result = geocoder.geocode({'latLng': latlng}, function(results, status) {
      //     if (status == google.maps.GeocoderStatus.OK) {
      //       current_address = results[0].formatted_address;
      //       $("#address").html(current_address); 
      //     }
      //     else
      //       { $("#address").html("Geocoder failed due to: " + status); }
      //   });
      // };
      
      // function initialize() {
      //   var mapOptions = {
      //     center: new google.maps.LatLng(<%=@lat%>, <%=@lng%>),
      //     //center: new google.maps.LatLng(40.741, -73.9898),
      //     zoom: <%= @zoom %>,
      //     mapTypeId: google.maps.MapTypeId.ROADMAP
      //   };

      //   map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

      //   new google.maps.BicyclingLayer().setMap(map);

      //   <% get_stations.each do |sta| %>
      //     addMarker(<%= sta["latitude"] %>, <%= sta["longitude"] %>, "Bikes: <%= sta["availableBikes"] %> Docks: <%= sta["availableDocks"] %>")
      //   <% end %>
      // } //end initialize

      // google.maps.event.addDomListener(window, 'load', initialize);