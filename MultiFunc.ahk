; --- 疑似的な入出力ストリーム ---
global streamSelf := Array()

; --- 状態定義 (ENUMの代わり) ---
class KeyState {
    static IDLE         := 0 ; 待機
    static QUICK_SEND   := 1 ; すぐに送る
    static REMOVE_NOISE := 2 ; ゴミ捨て
    static WAIT_PROCESS := 3 ; 観測待機
    static DOUBLE_TAP   := 4 ; ダブル確定
    static SINGLE_LONG  := 5 ; 単押し・長押し確定
}

; --- シフト以外のホットキーが効かないように条件付けを行う(ここから) ---
HotIf (*) => !GetKeyState("Ctrl", "P") 
          && !GetKeyState("Alt", "P") 
          && !GetKeyState("LWin", "P") 
          && !GetKeyState("RWin", "P")
          && !GetKeyState("vk1C", "P") ; 変換キー
          && !GetKeyState("vk1D", "P") ; 無変換キー
          && !GetKeyState("RAlt", "P") 

; --- ホットキーの登録 ---
for key in hotkeys
{
	wildKeyDown := "*$" . key
	wildKeyUp := "*$" . key . " Up"
	HotKey(wildKeyDown, Down_Push)
	HotKey(wildKeyUp, Up_Push)
}

HotIf 
; --- シフト以外のホットキーが効かないように条件付けを行う(ここまで) ---

; 関数:     Down_Push
; 機能:     keyDownの入力ストリームへの登録
; 引数:     input (自動的にA_ThisHotkeyを受ける)
Down_Push(input)
{
	global streamSelf
	downKey := "{" . RegExReplace(input, "[*$ ]*(.|sc...|vk..)", "$1") . "}"
	downKey := isShiftOn(downKey)
	k := ( streamSelf.Length > 0 ) ? streamSelf[-1] : 0
	if ( ( k == 0 ) || ( downKey != k.Key ) || k.Type != "Down"  )
	{
		streamSelf.Push( {key: downKey, time: A_TickCount, Type: "Down" } )
	}
	processFunc()
}

; 関数:     Up_Push
; 機能:     keyUpの入力ストリームへの登録
; 引数:     input (自動的にA_ThisHotkeyを受ける)
Up_Push(input)
{
	global streamSelf
	upKey := RegExReplace(input, "[*$ ]*(.|sc..|vk..)( Up|)", "$1")
	upKey := isShiftOn(upKey)
	streamSelf.Push( { key: upKey, time: A_TickCount, Type: "Up" } )
	processFunc()
}

; 関数:     processFunc()
; 機能:     出力関数(mainOutFunc)の再帰処理のための関数
; 引数:     なし
processFunc()
{
	if( mainOutFunc() )
	{
		SetTimer(processFunc,-1)
	}
	else
	{
		return
	}
}

; 関数:     mainOutFunc
; 機能:     入出力ストリームの判定を行い出力関数を呼びだす
; 引数:     なし
mainOutFunc()
{
    ; ==========================================
    ; 0. 変数準備
    ; ==========================================
    global streamSelf
    local currentState := KeyState.IDLE
    local result := {key: "", action: ""}

    ; ==========================================
    ; 1. 入力処理 (Input Processing)
    ; ==========================================
    if (streamSelf.Length == 0) 
		{
			return false
		}
    first   := streamSelf.Has(1) ? streamSelf[1] : 0
    second  := streamSelf.Has(2) ? streamSelf[2] : 0
    third   := streamSelf.Has(3) ? streamSelf[3] : 0
    elapsed := A_TickCount - first.Time

    ; ==========================================
    ; 2. 判定処理 (Decision Processing)
    ; ==========================================
    
    ; --- ステップA: 現在の状態(State)を特定する ---
    if (first.Type == "Up") {
        currentState := KeyState.REMOVE_NOISE
    } 
    else if !(sendActionList.Has(first.Key))
    {
        currentState := KeyState.QUICK_SEND
    }
    else if (elapsed < config.waitTime) {
        currentState := KeyState.WAIT_PROCESS
    } 
    else if (third != 0 
    && (first.Key == third.Key 
    && ( first.Type == third.Type ) 
    && (third.Time - second.Time < config.doubleTap))) {
        currentState := KeyState.DOUBLE_TAP
    }
    else if (second != 0) {
        currentState := KeyState.SINGLE_LONG
    }
    ; --- ステップB: 状態に基づいて結果(Action)を生成し、キューを操作する ---
    switch currentState
    {
        case KeyState.REMOVE_NOISE:
            streamSelf.RemoveAt(1)
            return true

        case KeyState.QUICK_SEND:
            result := {key: first.Key, action: "Quick"}
            streamSelf.RemoveAt(1)

        case KeyState.WAIT_PROCESS:
            return true

        case KeyState.DOUBLE_TAP:
            result := {key: first.Key, action: "Double"}
            streamSelf.RemoveAt(1, 3)

        case KeyState.SINGLE_LONG:
            type := ( ( second.Time - first.Time ) >= config.longTap ) ? "Long" : "Single"
            result := {key: first.Key, action: type}
            streamSelf.RemoveAt(1)

        case KeyState.IDLE:
            return true

        default:
            MsgBox("異常です")
            return false ; 想定外のときはタイマーを止める
    }

    ; ==========================================
    ; 3. 出力処理 (Output Processing)
    ; ==========================================
    if (result.action != "") {
        ExecuteAction(result.key, result.action)
    }

    return true
}

; 関数:     ExecuteAction
; 機能:     出力関数
; 引数:     keyName(出力するトリガキー)
; 引数:     keyAction(キーアクションの判定結果)
ExecuteAction(keyName, keyAction) {
    outputAction := "NoAction"

    if sendActionList.Has(keyName) ; リストに機能定義あり
    {
        actionTrig := sendActionList[keyName] ; Getを使わず直接参照でOK
        switch (keyAction)
        {
            case "Single":  outputAction := actionTrig.Single
            case "Double":  outputAction := actionTrig.Double
            case "Long":    outputAction := actionTrig.Long
            default:        outputAction := "NoAction" 
        }
    }
    else ; リストに機能定義なし
    {
        switch (keyAction)
        {
            case "Double":  outputAction := keyName . keyName
            case "Quick" :  outputAction := keyName
            default:        outputAction := keyName
        }
    }

    if (outputAction != "NoAction")
    {
        if IsObject(outputAction) ; 関数実行の場合
        {
            outputAction.Call()
        }
        else ; 通常Send
        {
            ;MsgBox(outputAction)
            Send(outputAction)
        }
    }
}

; 関数:     isShiftOn
; 機能:     入力ストリームに入れる前のキーの加工(Shift同時押し)
; 引数:     k(入力された物理キー)
isShiftOn(k)
{
	global shiftMap
	; Shiftが押されていないなら、そのまま返す
	if !GetKeyState("Shift", "P")
	{
		return k
	}
	; もし辞書に登録があればその文字を返し、なければ大文字にして返す
	return shiftMap.Has(k) ? shiftMap[k] : StrUpper(k)
}