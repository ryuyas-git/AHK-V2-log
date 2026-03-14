
;関数名 :ChkLayerTrig
;機能   :レイヤキーが押されているかチェックする
;引数   :可変長引数
ChkLayerTrig(*)
{
    for k in LayerTrigKeys
    {
        if( GetKeyState(k,"P") )
        {
            return true
        } 
    }
    return false
}

;レイヤー時のホットキー登録
HotIf (*) => ChkLayerTrig()
    for key in hotkeys
        HotKey("*$" . key, MyLayerAction)
HotIf

; トリガキーを無効化(トリガとしてだけ使いたいため)
for key in LayerTrigKeys {
    HotKey("*" . key, (*) => 0) ; *指定キー :: return と同じ意味になる
}

;関数名 :MyLayerAction
;機能   :レイヤーキーが押されているときの動作を送信する
;引数   :input (自動的にA_ThisHotkeyを受ける)
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