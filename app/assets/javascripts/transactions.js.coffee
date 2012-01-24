# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

jQuery ->
  $(".best_in_place").best_in_place()
  
  $(".pagination").find("a").attr("data-remote", true)

  $("#transaction_date").datepicker dateFormat: 'yy-mm-dd'

  $("#search_transactions_form").change ->
    $(this).submit()

  $("input[name=income]").change ->
    if $("input[name=income]:checked").val() == "1"
      $("#transaction_envelope").hide()
    else
      $("#transaction_envelope").show()
    
