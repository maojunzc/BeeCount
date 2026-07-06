Add-Type -TypeDefinition @"
using System;
using System.Net;
using System.Text;
using System.IO;

public class SimpleServer {
    public static void Start(string directory, int port) {
        var prefix = $"http://localhost:{port}/";
        var listener = new HttpListener();
        listener.Prefixes.Add(prefix);
        listener.Start();
        Console.WriteLine($"Serving {directory} on {prefix}");
        
        while (true) {
            var context = listener.GetContext();
            var url = context.Request.Url.AbsolutePath;
            var filePath = Path.Combine(directory, url.TrimStart('/'));
            
            if (File.Exists(filePath)) {
                var ext = Path.GetExtension(filePath).ToLower();
                var contentType = "text/html";
                if (ext == ".css") contentType = "text/css";
                else if (ext == ".js") contentType = "application/javascript";
                else if (ext == ".png") contentType = "image/png";
                else if (ext == ".jpg") contentType = "image/jpeg";
                else if (ext == ".svg") contentType = "image/svg+xml";
                
                var bytes = File.ReadAllBytes(filePath);
                context.Response.ContentType = contentType + "; charset=utf-8";
                context.Response.ContentLength64 = bytes.Length;
                context.Response.OutputStream.Write(bytes, 0, bytes.Length);
                context.Response.OutputStream.Close();
            } else {
                context.Response.StatusCode = 404;
                var msg = Encoding.UTF8.GetBytes("Not Found: " + url);
                context.Response.OutputStream.Write(msg, 0, msg.Length);
                context.Response.OutputStream.Close();
            }
        }
    }
}
"@ -Language CSharp

[SimpleServer]::Start("C:\Users\maoju\Desktop\蜜蜂记账\BeeCount-main", 8090)
