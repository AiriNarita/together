window.copy = function(e) {
    // クリックしたボタンに紐づくコードの範囲の定義
    let code = e.closest('.highlight-wrap').querySelector('.rouge-code')

    // クリップボードにコードをコピーしてから、ボタンのテキストを変更する
    navigator.clipboard.writeText(code.innerText)
      .then(() => e.innerText = 'Copied')

    // 任意：コピーしたコードが選択されたようにする
    window.getSelection().selectAllChildren(code)
  }
