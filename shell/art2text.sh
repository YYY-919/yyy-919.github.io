#!/usr/bin/env bash

direrr() {
    echo -e "\e[41m[ERROR] You should run me under \e[1;33mthe root of this repository.\e[0m"
    exit 1
}

[[ -d "art" ]] || direrr
[[ -d "text" ]] || direrr

for doc in art/*.md
do
    echo Converting "'${doc:4}'" ...
    raw_doc=$(cat $doc)
    new_doc=${raw_doc//$'\n'/'\n'}
    cat > "text/${doc:4:-3}.html" <<EOF
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="♂DO YOU LIKE VAN YOU SEE ?♂">
    <link rel="icon" href="/static/favicon.ico">
    <title>ArticleBox | HAVE A LOOK</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1.5.0/css/pico.min.css">
    <link rel="stylesheet" href="/static/style.css">
    <style>
        #view {
            text-align: left;
        }
    </style>
</head>
<body>
    <main class="container">
        <h1><a href="/text">ArticleBox</a> | <a href="/">图片</a></h1>
        <div id="content"></div>
        <script src="https://cdn.bootcdn.net/ajax/libs/marked/4.3.0/marked.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.7.0/build/styles/lioshi.min.css">
        <script src="https://cdn.jsdelivr.net/gh/highlightjs/cdn-release@11.7.0/build/highlight.min.js"></script>
        <script>hljs.initHighlightingOnLoad();</script>
        <script>
          var rendererMD = new marked.Renderer();
          marked.setOptions({
            renderer: rendererMD,
            gfm: true,
            tables: true,
            breaks: false,
            pedantic: false,
            sanitize: false,
            smartLists: true,
            smartypants: false
          });
          marked.setOptions({
              highlight: function (code) {
              return hljs.highlightAuto(code).value;
            }
          });
          document.getElementById('content').innerHTML =
            marked.parse('$new_doc');
        </script>
        <footer id="footer">
            <p>————没了————</p>
        </footer>
    </main>
</body>
</html>
EOF
done
