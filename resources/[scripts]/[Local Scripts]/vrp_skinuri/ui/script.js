$(document).ready(function(){
  // Mouse Controls
  $(".skinCreator").css("display","none");
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var cursor = $('#cursorPointer');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;


  function triggerClick(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
    return true;
  }

  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openSkinCreator == true){
      $(".skinCreator").css("display","block");
    }
    // Close Skin Creator
    if(event.data.openSkinCreator == false){
      $(".skinCreator").fadeOut(50);
    }

    // Click
    if (event.data.type == "click") {
      triggerClick(cursorX - 1, cursorY - 1);
    }
  });


  // Form update
  $('input').change(function(){
    $.post('http://vrp_skinuri/updateSkin', JSON.stringify({
      value: false,
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      skin: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
      glasses: $('.lunettes .active').attr('data'),
      ears: $('.oreilles .active').attr('data'),
      tops: $('.hauts .active').attr('data'),
      pants: $('.pantalons .active').attr('data'),
      shoes: $('.chaussures .active').attr('data'),
      watches: $('.montre .active').attr('data'),
    }));
  });
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://vrp_skinuri/updateSkin', JSON.stringify({
      value: false,
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      skin: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
      glasses: $('.lunettes .active').attr('data'),
      ears: $('.oreilles .active').attr('data'),
      tops: $('.hauts .active').attr('data'),
      pants: $('.pantalons .active').attr('data'),
      shoes: $('.chaussures .active').attr('data'),
      watches: $('.montre .active').attr('data'),
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://vrp_skinuri/updateSkin', JSON.stringify({
      value: true,
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      skin: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
      glasses: $('.lunettes .active').attr('data'),
      ears: $('.oreilles .active').attr('data'),
      tops: $('.hauts .active').attr('data'),
      pants: $('.pantalons .active').attr('data'),
      shoes: $('.chaussures .active').attr('data'),
      watches: $('.montre .active').attr('data'),
    }));
  }); 
  // Rotate player

  // Zoom out camera for clothes
  $('.tab a').on('click', function(e){
    e.preventDefault();
    $.post('http://vrp_skinuri/zoom', JSON.stringify({
      zoom: $(this).attr('data-link')
    }));
  });

  // Test value
  var xTriggered = 0;
  $(document).keypress(function(e){
    e.preventDefault();
    xTriggered++;
    if(e.which == 13){
      $.post('http://vrp_skinuri/test', JSON.stringify({
        value: xTriggered
      }));
    }
  });

});
