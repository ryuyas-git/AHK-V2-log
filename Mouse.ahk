global WheelSpeed := 1

; --- マウスホイールの加速機能用のホットキー ---
WheelDown::
WheelUp::
{
  WheelSpeedUp(A_ThisHotkey)
}

; 関数 :WheelSpeedUp
; 機能 :ホイールを回した時の移動量を漸増させる
; 引数 :direction ホイールの回転方向を受ける
WheelSpeedUp(direction)
{
  global WheelSpeed
  WheelSpeed := WheelSpeed * 1.2
  Loop (WheelSpeed)
  {
    Send ("{" . direction . "}")
  }
  ;0.1秒以内に再実行されるとタイマーが上書きされる。
  SetTimer( (*) => WheelSpeed := 1 ,-100)
}
