function play(id) {
  var audio = document.getElementById("audio"+id);
  audio.play();
}
// Train javascript
$(".btn_word").click(function() {
  var class_button = $(this).attr('class');
  var word = $(this).val();
  $(this).hide();
  var id = class_button.split(" ");
  var array = document.getElementsByClassName("btn_answer"+id[1])
  for ( let i = 0; i < array.length; i++) {
    if (array[i].value == "") {
      array[i].value += word;
      array[i].innerHTML = word;
      break;
    }
  }
});
$(".btn_check").click(function() {
  var class_button = $(this).attr('class');
  var id = class_button.split(" ");
  var array = document.getElementsByClassName("btn_answer"+id[1])
  var answer = ""
  for ( let i = 0; i < array.length; i++) {
    answer += array[i].value;
  }
  var right_ans = document.getElementById(id[1]).value
  console.log(right_ans);
  if (answer == right_ans) {
    document.getElementById("next").hidden = false;
    document.getElementById("action").hidden = true;
    alert("Correct");
  }
  else {
    alert("Incorrect");
  }
});
$(".btn_undo").click(function() {
  var class_button = $(this).attr('class');
  var id = class_button.split(" ");
  var array = document.getElementsByClassName("btn_answer"+id[1])
  for ( let i = 0; i < array.length; i++) {
    array[i].innerHTML = "";
    array[i].value = ""
  }
  $(".btn_word").show();
});
$(".btn_next").click(function() {
  var class_button = $(this).attr('class');
  var id = class_button.split(" ");
  console.log("game" + (parseInt(id[1])+1));
  document.getElementById("game" + id[1]).hidden = true;
  document.getElementById("game" + (parseInt(id[1])+1)).hidden = false;
});