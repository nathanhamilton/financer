@Minicalify = class Minicalify

  constructor: (minDate, maxDate) ->
    $(".minicaled").minical
      read_only: false
      minDate: minDate
      maxDate: maxDate
      appendTo: -> this
