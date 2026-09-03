import { Controller } from "@hotwired/stimulus"
// import {application} from "controllers/application"
// eagerLoadControllersfrom("controllers", application)

import Flatpickr from "flatpickr"
// application.register("flatpickr", Flatpickr)

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
      mode: "multiple",
      dateFormat: "Y-m-d"
  })
  }
}
