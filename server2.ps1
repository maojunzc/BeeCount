$tcpListener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, 8091)
$tcpListener.Start()
Write-Host "Server running on http://localhost:8091/"

while ($true) {
    $client = $tcpListener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = [System.IO.StreamReader]::new($stream)
    $requestLine = $reader.ReadLine()
    
    if ($requestLine -match 'GET\s+(\S+)') {
        $url = $Matches[1]
        $filePath = "C:\Users\maoju\Desktop\蜜蜂记账\BeeCount-main" + $url.Replace('/', '\')
        
        if (Test-Path $filePath -PathType Leaf) {
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $ext = [System.IO.Path]::GetExtension($filePath)
            $contentType = switch ($ext) {
                '.html' { 'text/html; charset=utf-8' }
                '.css'  { 'text/css; charset=utf-8' }
                '.js'   { 'application/javascript; charset=utf-8' }
                '.png'  { 'image/png' }
                '.jpg'  { 'image/jpeg' }
                default { 'application/octet-stream' }
            }
            $header = "HTTP/1.1 200 OK`r`nContent-Type: $contentType`r`nContent-Length: $($content.Length)`r`nConnection: close`r`n`r`n"
            $headerBytes = [System.Text.Encoding]::UTF8.GetBytes($header)
            $stream.Write($headerBytes, 0, $headerBytes.Length)
            $stream.Write($content, 0, $content.Length)
        } else {
            $body = [System.Text.Encoding]::UTF8.GetBytes("Not Found: $url")
            $header = "HTTP/1.1 404 Not Found`r`nContent-Type: text/plain; charset=utf-8`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
            $headerBytes = [System.Text.Encoding]::UTF8.GetBytes($header)
            $stream.Write($headerBytes, 0, $headerBytes.Length)
            $stream.Write($body, 0, $body.Length)
        }
    }
    $stream.Close()
    $client.Close()
}
