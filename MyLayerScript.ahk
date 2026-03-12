
layerMap := Map(
    ; "1", "", 
    ; "2", "", 
    ; "3", "", 
    ; "4", "", 
    ; "5", "", 
    ; "6", "", 
    ; "7", "", 
    ; "8", "", 
    ; "9", "", 
    ; "0", "", 
    ; "-", "", 
    ; "^", "", 
    ; "\", "", 

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
     "h", "{Left}", 
     "j", "{Down}", 
     "k", "{Up}", 
     "l", "{Right}", 
    ; ";", "", 
    ; ":", "", 
    ; "]", "", 

    ; "z", "", 
    ; "x", "", 
    ; "c", "", 
    ; "v", "", 
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