# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(".restaurant_form").validate
      rules:
        "restaurant[cafename]":
          required: true

        "restaurant[cafelocation]":
          required: false

        "restaurant[zipcode]":
          required: true
        
      messages:
        "restaurant[cafename]":
          required: "Restaurant name is required."

        "restaurant[zipcode]":
          required: "Restaurant zipcode is required."
  