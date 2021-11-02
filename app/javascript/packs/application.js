// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
import '../stylesheets/application'
require("stylesheets/application.scss")
require('jquery')
//= require_tree .


import "controllers"

// create custom event to brodcast to all stimuls controllers that need google map
window.initMap = function(...args){
  const event = document.createEvent("Events")
  event.initEvent("google-maps-callback", true, true)
  event.args = args
  window.dispatchEvent(event)
}
