$( "#lesson_category_id" ).select2();
$( "#content_lesson_id" ).select2();
$( "#category_name" ).select2();

function play(id) {
  var audio = document.getElementById("audio"+id);
  audio.play();
}