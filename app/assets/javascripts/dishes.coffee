# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ##############################################
  ## Add a dish form validation
  $(document).on "click", ".btn-add-dish", ->    
    $(".dishes_form").validate
      rules:
        "dish[name]":
          required: true

        "dish[price]":
          required: true

      messages:
        "dish[name]":
          required: "Dish name is required."

        "dish[price]":
          required: "Price is required."