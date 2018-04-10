$(document).ready(function() {
  $('#paginate a').attr('data-remote', 'true');
});


function hidden_comment_edit(comment_id) {
  $('#comment_' + comment_id).remove();
}
