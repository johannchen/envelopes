$ ->
  $("input[name=income]").change ->
    if $("input[name=income]:checked").val() == "1"
      $("#transaction_envelope").hide()
    else
      $("#transaction_envelope").show()
    
