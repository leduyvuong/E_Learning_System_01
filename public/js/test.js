
var h = parseInt(time / 60);
var p = time % 60;
var s = 00;
start()

function start()
{

    if (s === -1){
        p -= 1;
        s = 59;
    }

    if (p === -1){
        h -= 1;
        p = 59;
    }

    if (h == -1){
        clearTimeout(timeout);
        document.getElementById("btn_test").click();
    }

    if (h < 10) {
      document.getElementById("h").innerText = "0" + h.toString() + " : ";
    }
    else {
      document.getElementById("h").innerText = h.toString()+ " : ";
    }

    if (p < 10) {
      document.getElementById("p").innerText = "0" + p.toString()+ " : ";
    }
    else {
      document.getElementById("p").innerText = p.toString()+ " : ";
    }

    if (s < 10) {
      document.getElementById("s").innerText = "0" + s.toString();
    }
    else {
      document.getElementById("s").innerText = s.toString();
    }

    if (s < 30 && h <= 0 && p <= 0 ) {
      document.getElementById("s").style.color = "red";
    }

    timeout = setTimeout(function(){
        s--;
        start();
    }, 1000);
}