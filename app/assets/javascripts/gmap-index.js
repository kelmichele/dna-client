//   clinics.forEach(function(clinic) {
//     if (clinic.latitude && clinic.longitude) {
//       var marker = map.addMarker({
//         lat: clinic.latitude,
//         lng: clinic.longitude,
//         title: clinic.address,
//         infoWindow: {
//           content: '<p><a href="/clinics/' + clinic.id + '" >' + clinic.address + '</a></p>'
//         }
//       });
//     }
//   });

//   var l = document.querySelector("#map").dataset.l;
//   if (l) {
//     var latlngs = l.split(',');
//     var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
//     var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
//     var bounds = new google.maps.LatLngBounds(southWest, northEast);
//     map.fitBounds(bounds, 0);
//   } else {
//     map.fitZoom();
//   }

//   document.querySelector("#redo-search").addEventListener("click", function(e) {
//     e.preventDefault();

//     var bounds = map.getBounds();
//     var position = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

//     Turbolinks.visit('/clinics?l=' + position);
//   });

// });
document.addEventListener("turbolinks:load", function() {
  var map = new GMaps({
    div: '#map',
    lat: 38.9896,
    lng: 75.5050
  });
  window.map = map;

  var clinics = JSON.parse(document.querySelector("#map").dataset.clinics);
  window.clinics = clinics;

  var bounds = new google.maps.LatLngBounds();

  clinics.forEach(function(clinic) {
    if (clinic.latitude && clinic.longitude) {
      var marker = map.addMarker({
        lat: clinic.latitude,
        lng: clinic.longitude,
        title: clinic.address,
        infoWindow: {
          content: '<p><a href="/clinics/' + clinic.id + '" >' + clinic.address + '</a></p>'
        }
      });

      bounds.extend(marker.position);
    }
  });

  map.fitBounds(bounds);
});
