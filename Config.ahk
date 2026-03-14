; ◆◆◆ ユーザー設定(ここから) ◆◆◆

; --- キー動作の設定定義 ---
global config := {
    waitTime    :150,   ; 処理開始までの待機時間
    doubleTap   :100,   ; ダブルタップとみなす間隔
    longTap     :150,   ; 長押しとみなす間隔
    KEY_LANG    :"jp",   ; キーボードの配列(日本語は"jp",英語は"en")
}

; --- レイヤキーとして使うキーを指定する ---
global LayerTrigKeys := [
    "vk1C", ;変換キー
    "vk1D", ;無変換キー
    "RAlt", ;右Alt 
    ]

; --- 組込み変数(連続で送れるホットキーの数)の定義 ---
;"A_HotkeyInterval"ミリ秒に"A_MaxHotkeysPerInterval"個以上送るとエラー
A_HotkeyInterval        := 1000     ; 判定の秒数
A_MaxHotkeysPerInterval := 200      ; 判定の数

; --- 各キーの多機能アクションの定義をする（コメントを外すと有効になります） ---
; Single: 単押し, Double: ダブル, Long: 長押し
global sendActionList := Map(
    ; 1段目
    ; "{1}", { Single: "{1}", Double: "{11}", Long: "{1}" },
    ; "{2}", { Single: "{2}", Double: "{22}", Long: "{2}" },
    ; "{3}", { Single: "{3}", Double: "{33}", Long: "{3}" },
    ; "{4}", { Single: "{4}", Double: "{44}", Long: "{4}" },
    ; "{5}", { Single: "{5}", Double: "{55}", Long: "{5}" },
    ; "{6}", { Single: "{6}", Double: "{66}", Long: "{6}" },
    ; "{7}", { Single: "{7}", Double: "{77}", Long: "{7}" },
    ; "{8}", { Single: "{8}", Double: "{88}", Long: "{8}" },
    ; "{9}", { Single: "{9}", Double: "{99}", Long: "{9}" },
    ; "{0}", { Single: "{0}", Double: "{00}", Long: "{0}" },
    ; "{-}", { Single: "{-}", Double: "{--}", Long: "{-}" },
    ; "{^}", { Single: "{^}", Double: "{^^}", Long: "{^}" },
    ; "{\}", { Single: "{\}", Double: "{\\}", Long: "{\}" },

    ; 2段目
    ; "{q}", { Single: "{q}", Double: "{qq}", Long: "{q}" },
    ; "{w}", { Single: "{w}", Double: "{ww}", Long: "{w}" },
    ; "{e}", { Single: "{e}", Double: "{ee}", Long: "{e}" },
    ; "{r}", { Single: "{r}", Double: "{rr}", Long: "{r}" },
    ; "{t}", { Single: "{t}", Double: "{tt}", Long: "{t}" },
    ; "{y}", { Single: "{y}", Double: "{yy}", Long: "{y}" },
    ; "{u}", { Single: "{u}", Double: "{uu}", Long: "{u}" },
    ; "{i}", { Single: "{i}", Double: "{ii}", Long: "{i}" },
    ; "{o}", { Single: "{o}", Double: "{oo}", Long: "{o}" },
    ; "{p}", { Single: "{p}", Double: "{pp}", Long: "{p}" },
    ; "{@}", { Single: "{@}", Double: "{@@}", Long: "{@}" },
    ; "{[}", { Single: "{[}", Double: "{[[}", Long: "{[}" },

    ; 3段目
    ; "{a}", { Single: "{a}", Double: "{aa}", Long: "{a}" },
    ; "{s}", { Single: "{s}", Double: "{ss}", Long: "{s}" },
    ; "{d}", { Single: "{d}", Double: "{dd}", Long: "{d}" },
    ; "{f}", { Single: "{f}", Double: "{ff}", Long: "{f}" },
    ; "{g}", { Single: "{g}", Double: "{gg}", Long: "{g}" },
    ; "{h}", { Single: "{h}", Double: "{hh}", Long: "{h}" },
    ; "{j}", { Single: "{j}", Double: "{jj}", Long: "{j}" },
    ; "{k}", { Single: "{k}", Double: "{kk}", Long: "{k}" },
    ; "{l}", { Single: "{l}", Double: "{ll}", Long: "{l}" },
     "{;}", { Single: "{-}", Double: "{=}", Long: "{_}" },
     "{:}", { Single: "{#}", Double: "{&}", Long: "{&}" },
    ; "{]}", { Single: "{]}", Double: "{]]}", Long: "{]}" 

    ; 4段目
    ; "{z}", { Single: "{z}", Double: "{zz}", Long: "{z}" },
    ; "{x}", { Single: "{x}", Double: "{xx}", Long: "{x}" },
    ; "{c}", { Single: "{c}", Double: "{cc}", Long: "{c}" },
    ; "{v}", { Single: "{v}", Double: "{vv}", Long: "{v}" },
    ; "{b}", { Single: "{b}", Double: "{bb}", Long: "{b}" },
    ; "{n}", { Single: "{n}", Double: "{nn}", Long: "{n}" },
    ; "{m}", { Single: "{m}", Double: "{mm}", Long: "{m}" },
     "{,}", { Single: "{,}", Double: "{;}", Long: "{;}" },
     "{.}", { Single: "{.}", Double: "{:}", Long: "{:}" },
     "{/}", { Single: "{/}", Double: "{\}", Long: "{|}" },
    ;"{vkE2}", { Single: "{\}", Double: "{\\}", Long: "{\}" }, ; 右シフト横の\のキー

    ; 1段目(Shift+キー)
    ; "{!}", { Single: "{!}", Double: "{!!}", Long: "{!}" },
    ; "{"}", { Single: "{"}", Double: '{"}{"}', Long: '{"}' },
    ; "{#}", { Single: "{#}", Double: "{##}", Long: "{#}" },
    ; "{$}", { Single: "{$}", Double: "{$$}", Long: "{$}" },
    ; "{%}", { Single: "{%}", Double: "{%%}", Long: "{%}" },
    ; "{&}", { Single: "{&}", Double: "{&&}", Long: "{&}" },
     "{'}", { Single: "{'}", Double: '{"}', Long: "{``}" },
     "{(}", { Single: "{(}", Double: "{{}", Long: "{[}" },
     "{)}", { Single: "{)}", Double: "{}}", Long: "{]}" },
    ; "{=}", { Single: "{=}", Double: "{==}", Long: "{=}" },
    ; "{~}", { Single: "{~}", Double: "{~~}", Long: "{~}" },
    ; "{|}", { Single: "{|}", Double: "{||}", Long: "{|}" },

    ; 2段目(Shift+キー)
    ; "{Q}", { Single: "{Q}", Double: "{QQ}", Long: "{Q}" },
    ; "{W}", { Single: "{W}", Double: "{WW}", Long: "{W}" },
    ; "{E}", { Single: "{E}", Double: "{EE}", Long: "{E}" },
    ; "{R}", { Single: "{R}", Double: "{RR}", Long: "{R}" },
    ; "{T}", { Single: "{T}", Double: "{TT}", Long: "{T}" },
    ; "{Y}", { Single: "{Y}", Double: "{YY}", Long: "{Y}" },
    ; "{U}", { Single: "{U}", Double: "{UU}", Long: "{U}" },
    ; "{I}", { Single: "{I}", Double: "{II}", Long: "{I}" },
    ; "{O}", { Single: "{O}", Double: "{OO}", Long: "{O}" },
    ; "{P}", { Single: "{P}", Double: "{PP}", Long: "{P}" },
    ; "{`}", { Single: "{`}", Double: "{``}", Long: "{`}" },
    ; "{{}", { Single: "{{}", Double: "{{{}", Long: "{{}" },

    ; 3段目(Shift+キー)
    ; "{A}", { Single: "{A}", Double: "{AA}", Long: "{A}" },
    ; "{S}", { Single: "{S}", Double: "{SS}", Long: "{S}" },
    ; "{D}", { Single: "{D}", Double: "{DD}", Long: "{D}" },
    ; "{F}", { Single: "{F}", Double: "{FF}", Long: "{F}" },
    ; "{G}", { Single: "{G}", Double: "{GG}", Long: "{G}" },
    ; "{H}", { Single: "{H}", Double: "{HH}", Long: "{H}" },
    ; "{J}", { Single: "{J}", Double: "{JJ}", Long: "{J}" },
    ; "{K}", { Single: "{K}", Double: "{KK}", Long: "{K}" },
    ; "{L}", { Single: "{L}", Double: "{LL}", Long: "{L}" },
     "{+}", { Single: "{+}", Double: "{%}", Long: "{%}" },
     "{*}", { Single: "{*}", Double: "{&}", Long: "{&}" },
    ; "{}}", { Single: "{}}", Double: "{}}}", Long: "{}}" },

    ; 4段目(Shift+キー)
    ; "{Z}", { Single: "{Z}", Double: "{ZZ}", Long: "{Z}" },
    ; "{X}", { Single: "{X}", Double: "{XX}", Long: "{X}" },
    ; "{C}", { Single: "{C}", Double: "{CC}", Long: "{C}" },
    ; "{V}", { Single: "{V}", Double: "{VV}", Long: "{V}" },
    ; "{B}", { Single: "{B}", Double: "{BB}", Long: "{B}" },
    ; "{N}", { Single: "{N}", Double: "{NN}", Long: "{N}" },
    ; "{M}", { Single: "{M}", Double: "{MM}", Long: "{M}" },
     "{<}", { Single: "{<}", Double: "{^}", Long: "{^}" },
     "{>}", { Single: "{>}", Double: "{$}", Long: "{$}" },
     "{?}", { Single: "{?}", Double: "{!}", Long: "{!}" },
    ; "{_}", { Single: "{_}", Double: "{__}", Long: "{_}" },

    "{RButton}",{Single:"+{RButton}", Double:"{RButton}", Long: "{RButton}"}, ; マウスの右クリック
)

; --- レイヤーキーを押した状態で送信する機能を定義する ---
global layerMap := Map(
     "1", "{F1}", 
     "2", "{F2}", 
     "3", "{F3}", 
     "4", "{F4}", 
     "5", "{F5}", 
     "6", "{F6}", 
     "7", "{F7}", 
     "8", "{F8}", 
     "9", "{F9}", 
     "0", "{F10}", 
     "-", "{F11}", 
     "^", "{F12}", 
    ; "\", "{F}", 

    ; "q", "", 
    ; "w", "", 
    ; "e", "", 
    ; "r", "", 
    ; "t", "", 
     "y", "{Home}", 
     "u", "{PgDn}", 
     "i", "{PgUp}", 
     "o", "{End}", 
    ; "p", "", 
    ; "@", "", 
    ; "[", "", 

     "a", "{F15}", 
     "s", "{ESC}", 
     "d", "{Delete}", 
     "f", "{BackSpace}", 
     "g", "{F14}", 
     "h", "{Blind}{Left}", 
     "j", "{Blind}{Down}", 
     "k", "{Blind}{Up}", 
     "l", "{Blind}{Right}", 
    ; ";", "", 
    ; ":", "", 
    ; "]", "", 

     "z", "{Blind}^{z}", 
     "x", "^{x}", 
     "c", "^{Insert}", 
     "v", "+{Insert}", 
    ; "b", "", 
    ; "n", "", 
    ; "m", "", 
    ; ",", "", 
    ; ".", "", 
    ; "/", "", 
    ;"vkE2","",

    "WheelDown","{WheelUp}",
    "LButton","{LButton}{LButton}"
)
; ◆◆◆ ユーザー設定(ここまで) ◆◆◆

; --- 日本語キーボード配列 ---
    keyJp := [
    "1","2","3","4","5","6","7","8","9","0","-","^","\",
    "q","w","e","r","t","y","u","i","o","p","@","[",
    "a","s","d","f","g","h","j","k","l",";",":","]",
    "z","x","c","v","b","n","m",",",".","/","vkE2",
    "Enter",
    "Space",

    ;マウスキーを使用する場合はここに登録
    "RButton",
    "WheelDown",
    ]

; --- 英語キーボード配列 ---
    keyEn := [
    "1","2","3","4","5","6","7","8","9","0","-","=",
    "q","w","e","r","t","y","u","i","o","p","[","]","\"
    "a","s","d","f","g","h","j","k","l",";","'","]",
    "z","x","c","v","b","n","m",",",".","/",
    "Enter",
    "Space",

    ;マウスキーを使用する場合はここに登録
    ;"RButton",
    ;"WheelDown",
    ]

; --- Shiftを押した時の対応表(日本語キーボード用) ---
shiftJp := Map(
	"{1}", "{!}",
	"{2}", '{"}', 
	"{3}", "{#}",
	"{4}", "{$}",
	"{5}", "{%}",
	"{6}", "{&}",
	"{7}", "{'}",
	"{8}", "{(}",
	"{9}", "{)}",
	"{0}", "{ }",
	"{-}", "{=}",
	"{^}", "{~}",
	"{\}", "{|}",
	"{@}", "{``}",
	"{[}", "{{}",
	"{;}", "{+}",
	"{:}", "{*}",
	"{]}", "{}}",
	"{,}", "{<}",
	"{.}", "{>}",
	"{/}", "{?}",
    "{vkE2}", "{_}",
    "{Enter}", "+{Enter}",
    "{Space}", "+{Space}"
	)
    
; --- Shiftを押した時の対応表(英語キーボード用) ---
shiftEn := Map(
	"{1}", "{!}",
	"{2}", "{@}",
	"{3}", "{#}",
	"{4}", "{$}",
	"{5}", "{%}",
	"{6}", "{^}",
	"{7}", "{&}",
	"{8}", "{*}",
	"{9}", "{(}",
	"{0}", "{)}",
	"{-}", "{_}",
	"{=}", "{+}",
	"{[}", "{{}",
	"{]}", "{}}",
	"{;}", "{:}",
	"{'}", '{"}',
	"{]}", "{}}",
	"{,}", "{<}",
	"{.}", "{>}",
	"{/}", "{?}",
    "{Enter}", "+{Enter}",
    "{Space}", "+{Space}"
	)

    hotKeys := ( config.KEY_LANG = "jp" )? keyJp : keyEn
    shiftMap := (config.KEY_LANG = "jp")? shiftJp : shiftEn