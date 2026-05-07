<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8"/>

    <#assign oldUri = content.uri!"">
    <#assign newPath = oldUri
      ?replace("^/", "", "r")
      ?replace("^blog/", "", "r")
      ?replace("\\.html$", "/", "r")
    >
    <#assign newUrl = "https://blog.interlis.guru/" + newPath>

    <title>Umgezogen: <#if (content.title)??>${content.title?html}<#else>blog.sogeo.services</#if></title>

    <link rel="canonical" href="${newUrl?html}">
    <meta http-equiv="refresh" content="0; url=${newUrl?html}">
    <meta name="robots" content="noindex, follow">
  </head>
  <body>
    <p>
      Diese Seite ist umgezogen:
      <a href="${newUrl?html}">${newUrl?html}</a>
    </p>

    <script>
      window.location.replace("${newUrl?js_string}");
    </script>
  </body>
</html>