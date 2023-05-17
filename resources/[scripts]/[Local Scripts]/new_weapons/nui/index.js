window.addEventListener('message', function (event) {
    var nui = event.data;
    if (!nui.name) {
        $('.main').fadeOut(300);
        return;
    } else if ($('.main').css('display') == "none") {
        $('.main').fadeIn(200);
    }

    if ($('.gun_name').text() != nui.name) {
        $('.gun_name').text(nui.name);
        $('.main img').attr('src',"./img/weapons/"+nui.name+".png");
    }

    $('#ammo').css('width',nui.ammoClip+'%');

    $('#firsttan').text(nui.ammoClip);
    $('#lasttan').text(nui.ammoRemaining);
});