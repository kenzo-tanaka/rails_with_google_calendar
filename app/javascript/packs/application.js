// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
import $ from "jquery";

import 'bootstrap';
import '../stylesheets/application'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).on("turbolinks:load", function() {
  $('#display-events').on('click', function () {
    $.ajax({
      url: '/schedules/daily',
      type: 'GET'
    }).then(function(response){
      $('#events').val(response.events)
    })
  });

  $('#copy-events').on('click', function(){
    let copyText = document.getElementById('events');
    copyText.select();
    copyText.setSelectionRange(0, 99999);

    document.execCommand('copy');
    alert('予定をコピーしました！');
  })
});
