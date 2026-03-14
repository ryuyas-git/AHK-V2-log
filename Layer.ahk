
layerMap := Map(
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
)

;レイヤー時のホットキー登録
HotIf (*) => GetKeyState("vk1C", "P") || GetKeyState("vk1D", "P") || GetKeyState("RAlt","P")
for key in hotkeys
    HotKey("*$" . key, MyLayerAction)

HotIf

*RAlt::return
*vk1C::return
*vk1D::return

MyLayerAction(input) {
    global layerMap
    cleanKey := RegExReplace(input, "[*$ ]*(.|sc..|vk..)", "$1")
    
    if layerMap.Has(cleanKey) {
        Send(layerMap[cleanKey])
    } else {
        ; 定義がない場合は、とりあえずそのままのキーを送る（あるいは無視する）
        Send("{" . cleanKey . "}")
    }
}