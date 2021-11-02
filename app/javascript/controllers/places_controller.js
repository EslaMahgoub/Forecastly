// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "field", "map" ]

  connect() {
    // if google maps is loaded, initilize stimulus controller immediately
    if (typeof(google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(51.9, 19.1),
      zoom: 4
    })

    var options = {
      types: ['(cities)'],
     };
    
    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget, options)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29),
    })
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()
    if(!place.geometry) {
      window.alert(`No details available for this input: ${place.name}`)
      return
    }
    // move the map to the place
    if(place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(17)
    }
    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)
    
    this.latitudeTarget.value = place.geometry.location.lat()
    this.longtitudeTarget.value = place.geometry.location.lng()
  }
  keydown(event) {
    if(event.key == "Enter"){
      event.preventDefault()
    }
  }
}
