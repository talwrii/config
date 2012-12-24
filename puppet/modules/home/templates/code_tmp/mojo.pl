#!/usr/bin/perl
use Mojolicious::Lite;

# Simple plain text response
get '/' => {text => 'Hello World!'};

# Route associating "/time" with template in DATA section
get '/time' => 'clock';


get '/ws' => 'ws';

# RESTful web service with JSON and text representation
get '/list/:offset' => sub {
    my $self    = shift;
    my $numbers = [0 .. $self->param('offset')];
    $self->respond_to(
        json => {json => $numbers},
        txt  => {text => join(',', @$numbers)}
    );
};

# Scrape information from remote sites
post '/title' => sub {
    my $self = shift;
    my $url  = $self->param('url') || 'http://mojolicio.us';
    $self->render_text(
        $self->ua->get($url)->res->dom->html->head->title->text);
};

# WebSocket echo service
websocket '/echo' => sub {
    my $self = shift;
Mojo::IOLoop->stream($self->tx->connection)->timeout(300);
    $self->on(message => sub {
                  my ($self, $msg) = @_;
                  $self->send("echo: $msg");
              });
};

app->start;
__DATA__

@@ clock.html.ep
% use Time::Piece;
% my $now = localtime;
The time is <%= $now->hms %>.

@@ ws.html.ep
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
var start;
function WebSocketTest()
{
  if ("WebSocket" in window)
  {
     // Let us open a web socket
     var ws = new WebSocket("ws://localhost:3000/echo");
     ws.onopen = function()
     {
        // Web Socket is connected, send data using send()
        start = new Date().getTime();
        ws.send("Message to send");
        $("#sent").html("sent msg");
     };
     ws.onmessage = function (evt)
     {
        var received_msg = evt.data;
        var timediff = new Date().getTime() - start;
        $("#recv").html("RTT: " + timediff + "<br>Received: " +received_msg);
     };
     ws.onclose = function()
     {
        // websocket is closed.
        alert("Connection is closed...");
     };
  }
  else
  {
     // The browser doesn't support WebSocket
     $("#sent").html("Browser not supported");
  }
}
</script>
</head>
<body>
<a href="javascript:WebSocketTest()">Run WebSocket</a><br>
Sent:<div id='sent'></div><br>
Recv:<div id='recv'></div>

</body>
</html>
