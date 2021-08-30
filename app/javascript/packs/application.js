

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "bootstrap";

Rails.start();
Turbolinks.start();
require("jquery");
ActiveStorage.start();


import "select2";
import "select2/dist/css/select2.css";

document.addEventListener("turbolinks:load", () => {
  $(".js-select").select2({
    allowClear: true
  });
});