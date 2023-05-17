var config =
{    
    /*
        Do we want to show the image?
        Note that imageSize still affects the size of the image and where the progressbars are located.
    */
    enableImage: true,
 
    /*
        Relative path the the logo we want to display.
    */
    image: "img/logo.png",

    /*
        Cursor image
    */
    cursorImage: "img/cursor.png",
 
    /*
        How big should the logo be?
        The values are: [width, height].
        Recommended to use square images less than 1024px.
    */
    imageSize: [1024, 768],
 
    /*
        Define the progressbar type
            0 = Single progressbar
            1 = Multiple progressbars
            2 = Collapsed progressbars
     */
    progressBarType: 0,
 
    /*
        Here you can disable some of progressbars.
        Only applys if `singleProgressbar` is false.
    */
    progressBars:
    {
        "INIT_CORE": {
            enabled: false, //NOTE: Disabled because INIT_CORE seems to not get called properly. (race condition).
        },
 
        "INIT_BEFORE_MAP_LOADED": {
            enabled: true,
        },
 
        "MAP": {
            enabled: true,
        },
 
        "INIT_AFTER_MAP_LOADED": {
            enabled: true,
        },
 
        "INIT_SESSION": {
            enabled: true,
        }
    },
 
    /*
        Loading messages will be randomly picked from the array.
        The message is located on the left side above the progressbar.
        The text will slowly fade in and out, each time with another message.
        You can use UTF-8 emoticons inside loading messages!
    */
    loadingMessages:
    [
        /*"달팽이 줍는 중... &#x1f40c;",
        "달팽이를 지도에 배치하는 중... &#x1f40c;",
        "달팽이 밟는 중.... &#x1f40c; &#x1f528;",
        "달팽이를 비벼먹는 중... &#x1f40c; &#x1f462;",
        "달팽이 껍질에 민달팽이를 집어 넣는 중... &#x1f41a",
        "달팽이와 리그 오브 레전드 플레이 중... &#x1f3cf",
        "달팽이와 오버워치 플레이 중... &#x1f9e0;",
        "프랑스 사람에게 달팽이를 파는 중. &#x1f956;",
        "FiveM 마스코트 달팽이를 먹는 중... &#x1f374;",
        "달팽이 파밍 중.. &#x1f60d;",
        "달팽이에게 인사 시키는 중...",
        "달팽이에게 운전을 가르치는 중... &#x1f697;",
        "달팽이와 함께하는 엘리시움 서버 &#x1f3cc;",
        "동물보호협회에 달팽이 학대를 신고하는 중... &#x1f4f1;",
        "이 화면을 보는 동안 다행히도 달팽이는 다치지 않았습니다! &#x1f691;",
		"엘리시움에 접속 중 입니다! 👋",*/
		"",
    ],
 
    /*
        Rotate the loading message every 5000 milliseconds (default value).
    */
    loadingMessageSpeed: 5 * 1000,
 
    /*
        Array of music id's to play in the loadscreen.
        Enter your youtube video id's here. In order to obtain the video ID
        Take whats after the watch?v= on a youtube link.
        https://www.youtube.com/watch?v=<videoid>
        Do not include the playlist id or anything, it should be a 11 digit code.
       
        Do not use videos that:
            - Do not allow embedding.
            - Copyrighted music (youtube actively blocks this).
    */
    music:
    [
        "m4RZUot-aRo",
	/*	"4Q46xYqUwZQ",
    "eEKfWVvADiQ",*/
    ],
 
 
    /*
        Set to false if you do not want any music.
    */
    enableMusic: true,
 
    /*
        Default volume for the player. Please keep this under 50%, to not blowout someones eardrums x)
     */
    musicVolume: 15,
 
    /*
        Should the background change images?
        True: it will not change backgrounds.
        False: it will change backgrounds.
    */
    staticBackground: false,
   
    /*
        Array of images you'd like to display as the background.
        Provide a path to a local image, using images via url is not recommended.
    */
    background:
    [
        "img/bg1.jpg",
    ],
 
    /*
        Time in milliseconds on how fast the background
        should swap images.
     */
    backgroundSpeed: 800 * 1000,

    /*
        Which style of animation should the background transition be?
        zoom = background zooms in and out.
        slide = transtion backgrounds from sliding right and back again.
        fade = fade the background out and back in.
    */
    backgroundStyle: "fade",

    /*
        Should the log be visible? Handy for debugging!
    */
    enableLog: true,
}
