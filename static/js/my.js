var selectedNode = {};
var savedNode;
var tree = [];
        $.ajaxSetup({
             beforeSend: function(xhr, settings) {
                 function getCookie(name) {
                     var cookieValue = null;
                     if (document.cookie && document.cookie != '') {
                         var cookies = document.cookie.split(';');
                         for (var i = 0; i < cookies.length; i++) {
                             var cookie = jQuery.trim(cookies[i]);
                             // Does this cookie string begin with the name we want?
                         if (cookie.substring(0, name.length + 1) == (name + '=')) {
                             cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                             break;
                         }
                     }
                 }
                 return cookieValue;
             }
             if (!(/^http:.*/.test(settings.url) || /^https:.*/.test(settings.url))) {
                 // Only send the token to relative URLs i.e. locally.
                 xhr.setRequestHeader("X-CSRFToken", getCookie('csrftoken'));
             }
         }
    });

$(document).ready(function() {
  var tagsList = [];
  $.ajax({
      url: '/tags/',
      type: 'GET',
      async: false,
      data: {},
      success: function (data) {
        for (var i = 0; i < data.length; i++) {
          tagsList.push(data[i].fields.tag);
        }
        console.log(tagsList);

      },
      error: function (data) {
        console.log('load tags error');
      },
      cache: false,
      contentType: false,
      processData: false
  });
  // console.log(tagsList);
  $("#id_tags").tagit({
    availableTags: tagsList
    });

  $("#search_tags").tagit({
    availableTags: tagsList,
    tagLimit: 1,
    singleField: true
    });

  });

  $(document).ready(function() {
    $('#id_tags').removeAttr('required');
  });


  $(document).ready(function() {
    $('#search_tags').removeAttr('required');
  });

$(document).ready(function() {
  if ($('input[name=isbn]:checked', '#material-edit-form').val() == 'yes') {
    var isbn = $('#id_isbn_hidden').val();
    $('#id_isbn').append('<input class="form-control isbn" id="isbn" \
            maxlength="13" required="true" \
             type="text">');
    $('#isbn').val(isbn);
  }
});

$(document).ready(function() {
  $('#id_isbn_0').on('change', function() {
    if ($('input[name=isbn]:checked', '#add-form').val() == 'yes') {
      $('#id_isbn').append('<input class="form-control isbn" id="isbn" \
              maxlength="13" required="true" \
               type="text">');
    }
  });

  $('#id_isbn_1').on('change', function() {
    if ($('input[name=isbn]:checked', '#add-form').val() == 'no') {
      $('#isbn').remove();
    }
  });
});


$(document).ready(function() {
  $('#id_isbn_0').on('change', function() {
    var isbn = $('#id_isbn_hidden').val();
    if ($('input[name=isbn]:checked', '#material-edit-form').val() == 'yes') {
      $('#id_isbn').append('<input class="form-control isbn" id="isbn" \
              maxlength="13" required="true" \
               type="text">');
    }
    $('#isbn').val(isbn);
  });

  $('#id_isbn_1').on('change', function() {
    if ($('input[name=isbn]:checked', '#material-edit-form').val() == 'no') {
      $('#isbn').remove();
    }
  });
});

$(document).ready(function() {
    $('#btn-sbmt').click(function(e) {
          // if ($('#reg-form').bootstrapValidator('validate').has('.has-error').length) {
          //     return false;
          // }
          e.preventDefault();
          var formData = new FormData($('#reg-form')[0]);
          $.ajax({
              url: '/signup/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#reg-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                  } else if (data.hasOwnProperty('result')) {
                      $("#reg-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                      '+data.result+'</div><p><a href="/login/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                  }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });
});


$(document).ready(function() {
  if ($('#add_form_add_group').length) {
    $('#film-add').before('<br><label for="idame">Группа доступа</label> \
    <input class="form-control" value="" id="groups" maxlength="50" name="n" type="text"><br>');
  }
});

$(document).ready(function() {
  if ($('#material-edit-form').length) {
    $('#material-edit').before('<br><label for="idame">Группа доступа</label> \
    <input class="form-control" id="groups" value="" maxlength="50" name="n" type="text"><br>');
  }
});

$(document).ready(function() {
  $('#groups').click(function(e) {
    e.preventDefault();
    $('#add_form_add_group').modal('show');
  });
});


$(document).ready(function() {
    $('#btn-group-create').click(function(e) {
          e.preventDefault();
          var formData = new FormData($('#group-form')[0]);
          $.ajax({
              url: '/control/access/create/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#group-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                  } else if (data.hasOwnProperty('result')) {
                      $("#group-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                      '+data.result+'</div><p><a href="/control/access/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                  }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });
});

$(document).on("click", "#del_group", function(e) {
          e.preventDefault();
          group_id = $(event.target).attr('tagid');
          type = $(event.target).attr('type');
          var request = new FormData();
          request.append('group_id', group_id);
          request.append('type', type);
          $.ajax({
            url: '/control/access/',
            type: 'POST',
            contentType: false,
            data: request,
            async: false,
              success: function (data) {
                if (data.hasOwnProperty('result')) {
                  if ($(event.target).attr('type') == "1") {
                    $(event.target).replaceWith( '<a id="del_group" type="0" tagid="'+group_id+'" class="btn btn-warning admin-edit control-item" role="button">Восстановить</a>');
                  } else {
                    $(event.target).replaceWith( '<a id="del_group" type="1" tagid="'+group_id+'" class="btn btn-danger admin-edit control-item" role="button">Удалить</a>');
                  }
                }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });


$(document).ready(function() {
  var par_arr = {};
  $.ajax({
      url: '/rubrik/',
      type: 'GET',
      async: false,
      data: {},
      success: function (data) {
        par_arr = {};
        for (var i = 0; i < data.length; i++) {
          if (data[i].fields.parent_id == null) {
            data_obj = new Object();
            data_obj.text = data[i].fields.name;
            tree[i] = data_obj;
          } else {
            data_obj = new Object();
            data_obj.text = data[i].fields.name;
            data_obj.parent_id = data[i].fields.parent_id;
            data_obj.id = data[i].pk;
            if (tree[data[i].fields.parent_id] == undefined) {
              var parent_id = 0;
              var index = data[i].fields.parent_id;
              var path = [];
              var ind = 0;
              path.push(index);
              while (parent_id != undefined) {
                parent_id = par_arr[index];
                path.unshift(parent_id);
                index = parent_id;
              }
              var a;

              a = tree[path[1]].nodes;
              for (var n = 2; n < path.length; n++) {
                var n_val = path[n];
                for (var x = 0; x < a.length; x++) {
                  if (a[x].id == n_val) {
                    if (a[x].nodes == undefined) {
                      a[x].nodes = [];
                    }
                    a = a[x].nodes;
                    break;
                  }
                }
              }
              a.push(data_obj);
              par_arr[data_obj.id] = data_obj.parent_id;
              // console.log(a);
              // var parent_id = data[i].fields.parent_id;
              // var tree_copy = tree;
              // var node = 0;
              // tree_copy =  JSON.parse(JSON.stringify(tree));
              // for (var i=0; i < tree_copy.length; i++) {
              //   var tree_node = tree_copy[i];
              //   // if (tree_node.nodes != undefined) {
              //   //   for (var n=0; n < tree_node.nodes.length; n++) {
              //   //     if (tree_node.nodes[n].parent_id == parent_id) {
              //   //       tree[i].nodes[n].nodes = [];
              //   //       tree[i].nodes[n].nodes.push(data_obj);
              //   //       node = parent_id;
              //   //     }
              //   //   }
              //   // }
              //   console.log(tree_node[i]);
              // }
            } else {
              if (tree[data[i].fields.parent_id].nodes == undefined) {
                tree[data[i].fields.parent_id].nodes = [];
              }
              tree[data[i].fields.parent_id].nodes.push(data_obj);
              par_arr[data_obj.id] = data[i].fields.parent_id;
            }
          }
        }


      },
      error: function (data) {
        console.log(data)
      },
      cache: false,
      contentType: false,
      processData: false
  });
  $('#tree').treeview({
    data: tree,         // data is not optional
    selectable: true,
    levels : 1,
  });
  $('#show_cat').click(function(e) {
    var nodeId;
    var rubrik = $('#tree').treeview('getSelected', nodeId)[0].text;
    window.location.href = 'http://localhost/search/'+rubrik+'';

  });
});

$(document).ready(function() {
  $('#btn-find').click(function(e) {
    e.preventDefault();

    var title = $('#title').val()
    var tag = $('span.tagit-label').text()
    if (title != '') {
      window.location.href = 'http://localhost/searchtitle/'+title+'';
    }
    if (tag != '') {
      window.location.href = 'http://localhost/searchtag/'+tag+'';
    }
  });
});

$(document).ready(function() {
  if ($('#group-form').length) {
    $('.form-group').append('<br><label for="idame">Пользователи, входящие в группу </label> \
    <input class="form-control" id="users" maxlength="50" name="n" required="true" type="text">');
  }

});

$(document).ready(function() {
  $('#users').click(function(e) {
    e.preventDefault();
    $('#users_dialog').modal('show');
  });
});

var user_id_list = [];

$(document).on("click", "#add_user", function(e){
   e.preventDefault();
   var user_id = $(event.target).attr('userid');
   user_id_list.push(user_id);
   $(event.target).replaceWith( '<a id="add_to" colid="" \
   class="btn btn-warning admin-edit control-item" \
   role="button">Пользователь выбран</a>');
   var a = $("#users").val();
   a = a + $("#"+user_id+"").text() + ', ';
   $("#users").val(a);
   $('#id_users').val(user_id_list);
});

$(document).on("click", "#add_group_to_material", function(e){
   e.preventDefault();
   var group_id = $(event.target).attr('groupid');
   var group = $("a[gr="+group_id+"]").text();
   $('#add_form_add_group').modal('toggle');
   $("#groups").val(group);
   $('#id_group').val(group_id);
});

$(document).on("click", "#btn_group_create", function(e){
           e.preventDefault();
           console.log(user_id_list);
          //  var user_id = $(event.target).attr('userid');
          //  request.append('user_id', tag_id);
          //  request.append('text', text);
          //  request.append('type', type);
          //  $.ajax({
          //      url: '/control/access/create/',
          //      type: 'POST',
          //      data: {'material_id' : material_id, 'collection_id': collection_id},
          //      async: false,
          //      success: function (data) {
          //         $('#myModal').modal('toggle');
          //         $('#add_to_col').replaceWith( '<button id="add_to_col" type="button" \
          //         class="btn btn-success admin-panel"  \
          //         data-toggle="modal" data-target="#myModal">Добавлено в коллекцию</button>');
          //      },
          //      error: function (data) {
          //        console.log(data)
          //      },
          //      cache: false,
          //      contentType: false,
          //      processData: false
          //  });
});

$(document).ready(function() {
  $('#id_rubrik').click(function(e) {
    e.preventDefault();

    console.log(tree);

    $('#rubrik_dialog').modal('show');

    $('#tree').treeview({
      data: tree,         // data is not optional
      selectable: true,
    });
    $('#btn-expand').prop('disabled', false);
    console.log(savedNode);
    if (savedNode) {
      $('#tree').treeview('addNode', [ savedNode.parentId, { text: savedNode.text } ])
      $('#tree').treeview('expandNode', [ 0, { levels: 4, silent: true } ]);
      $('#tree').treeview('selectNode', [ savedNode.nodeId, { silent: true } ]);
    }

  });
});

$(document).ready(function() {

  $('#btn-expand').click(function(e) {
    var newNode;
    var nodeId;
    var parId = $('#tree').treeview('getSelected', nodeId)[0].nodeId;
    newNode = $('#tree').treeview('addNode', [ parId, { text: 'new node' } ]);
    $('#tree').treeview('expandNode', [ parId, { levels: 1, silent: true } ]);
   //
    $('li[data-nodeid='+newNode+']').replaceWith('<li class="list-group-item" \
   style="color:undefined;background-color:undefined;"><span class="indent">\
    </span><span class="icon glyphicon"> \
    </span><span class="icon node-icon"></span> \
    <input class="form-control rubrik-input" id="custom-rubrik" \
    maxlength="50" name="author" placeholder="Введите название рубрики" required="true" type="text"> \
    <button id="btn-add-rubrik" type="button" class="btn btn-success">Добавить рубрику</button> \
    </li>');
    $('.list-group').on("click", "#btn-add-rubrik",
      function() {
        var text = $('#tree').treeview('getNode', newNode).text = $('#custom-rubrik').val();
        $('#tree').treeview('selectNode', [ newNode, { silent: true } ]);
        parentId = $('#tree').treeview('getNode', newNode).parentId;
        selectedNode.id = newNode;
        selectedNode.parentId = parentId;
        selectedNode.text = text;
        console.log(text);

      }
    );
    $('#btn-expand').prop('disabled', true);

  });
});

$(document).ready(function() {

  $('#btn-save').click(function(e) {
    console.log(selectedNode);
    var nodeId;
    // if (jQuery.isEmptyObject(selectedNode)) {
    selectedNode = $('#tree').treeview('getSelected', nodeId)[0];
    // }
    // console.log(selectedNode);

    savedNode = selectedNode;
    // console.log($('#tree').treeview('getNode', savedNode.parentId).text);
    $('#id_rubrik').val(savedNode.text);

    $('#id_rubrik_parent').val($('#tree').treeview('getNode', savedNode.parentId).text);
  });

});
$(document).ready(function() {
    $('#btn-log').click(function(e) {
          e.preventDefault();
          // $('#log-form').bootstrapValidator('validate')
          var formData = new FormData($('#log-form')[0]);
          $.ajax({
              url: '/login/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#log-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                  } else if (data.hasOwnProperty('result')) {
                        $("#log-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                        '+data.result+'</div>');
                        $('.item-reg').remove();
                        $(".not-reg").replaceWith( '<li class="item-custom"> \
                        <a class="item roboto-font" href="/">Личный кабинет</a></li>');
                  }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });
     return false;
});

$(document).on("submit","#add-form", function (e) {
          e.preventDefault();
          $('#id_isbn_hidden').val($('#isbn').val());
          console.log('send');
          var formData = new FormData($('#add-form')[0]);
          $.ajax({
              url: '/control/add/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#add-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                      console.log(data.error);

                  } else if (data.hasOwnProperty('result')) {
                      $("#add-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                      '+data.result+'</div><p><a href="/control/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                  }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });

$(document).ready(function() {
    $('#btn-log').click(function(e) {
          e.preventDefault();
          // $('#log-form').bootstrapValidator('validate')
          var formData = new FormData($('#log-form')[0]);
          $.ajax({
              url: '/login/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#log-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                  } else if (data.hasOwnProperty('result')) {
                        $("#log-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                        '+data.result+'</div>');
                        $('.item-reg').remove();
                        $(".not-reg").replaceWith( '<li class="item-custom"> \
                        <a class="item roboto-font" href="/">Личный кабинет</a></li>');
                  }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });
     return false;
});

$(document).on("submit","#collection-form", function (e) {
          e.preventDefault();
          // $('#log-form').bootstrapValidator('validate')
          var formData = new FormData($('#collection-form')[0]);
          $.ajax({
              url: '/collections/create/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#collection-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                  } else if (data.hasOwnProperty('result')) {
                      $("#collection-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                      '+data.result+'</div><p><a href="/collections/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                  }
              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });


// $(document).on("submit","#add-form", function (e) {
//           e.preventDefault();
//           e.stopImmediatePropagation();
//           $('#id_isbn_hidden').val($('#isbn').val());
//           var formData = new FormData($('#add-form')[0]);
//           $.ajax({
//               url: '/control/add/',
//               type: 'POST',
//               data: formData,
//               async: true,
//               success: function (data) {
//                   if(data.hasOwnProperty('error')) {
//                       if( $('#field-error').length ) {
//                           $('#field-error').text(data.error);
//                       } else {
//                           $("#add-form").append('<br><div class="alert alert-danger" \
//                           role ="alert" id="field-error">'+data.error+'</div>');
//                       }
//                       console.log(data.error);
//
//                   } else if (data.hasOwnProperty('result')) {
//                       $("#add-form").replaceWith( '<div class="alert alert-success" role="alert"> \
//                       '+data.result+'</div><p><a href="/control/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
//                   }
//               },
//               error: function (data) {
//                 console.log(data)
//               },
//               cache: false,
//               contentType: false,
//               processData: false
//           });
//      });
//
$(document).on("submit","#material-edit-form", function (e) {
          e.preventDefault();
          $('#id_isbn_hidden').val($('#isbn').val());
          var formData = new FormData($('#material-edit-form')[0]);
          var material_id = $('#material_id').val();
          for(var pair of formData.entries()) {
             console.log(pair[0]+ ', '+ pair[1]);
          }
          $.ajax({
              url: '/lk/edit/'+material_id+'/',
              type: 'POST',
              data: formData,
              async: true,
              success: function (data) {
                  if(data.hasOwnProperty('error')) {
                      if( $('#field-error').length ) {
                          $('#field-error').text(data.error);
                      } else {
                          $("#material-edit-form").append('<br><div class="alert alert-danger" \
                          role ="alert" id="field-error">'+data.error+'</div>');
                      }
                  } else if (data.hasOwnProperty('result')) {
                      $("#material-edit-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                      '+data.result+'</div><p><a href="/lk/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                  }

              },
              error: function (data) {
                console.log(data)
              },
              cache: false,
              contentType: false,
              processData: false
          });
     });

$(document).on("click", "#material-delete", function(e){
           e.preventDefault();
           var material_id = $('#material_id').val();
           $.ajax({
               url: '/lk/delete/'+material_id+'/',
               type: 'POST',
               data: {'material_id' : $('material_id').val()},
               async: false,
               success: function (data) {
                  if (data.hasOwnProperty('result')) {
                   $("#material-edit-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                   '+data.result+'</div><p><a href="/lk/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                  }
               },
               error: function (data) {
                 console.log(data)
               },
               cache: false,
               contentType: false,
               processData: false
           });
});

$(document).on("click", "#add_to", function(e){
           e.preventDefault();
           var material_id = $('#material_id').val();
           var collection_id = $(event.target).attr('colid')
           $.ajax({
               url: '/addcollection/'+material_id+'/'+collection_id+'/',
               type: 'POST',
               data: {'material_id' : material_id, 'collection_id': collection_id},
               async: false,
               success: function (data) {
                  $('#myModal').modal('toggle');
                  $('#add_to_col').replaceWith( '<button id="add_to_col" type="button" \
                  class="btn btn-success admin-panel"  \
                  data-toggle="modal" data-target="#myModal">Добавлено в коллекцию</button>');
               },
               error: function (data) {
                 console.log(data)
               },
               cache: false,
               contentType: false,
               processData: false
           });
});

$(document).on("click", "#remove_from", function(e){
           e.preventDefault();
           var material_id = $(event.target).attr('matid');
           var collection_id = $('#collection_id').val();
           $.ajax({
               url: '/delfrom/'+material_id+'/'+collection_id+'/',
               type: 'POST',
               data: {'material_id' : material_id, 'collection_id': collection_id},
               async: false,
               success: function (data) {
                  $(event.target).replaceWith( '<button type="button" \
                  class="btn btn-danger admin-edit control-item"  \
                  data-toggle="modal" data-target="#myModal">Удалено</button>');
               },
               error: function (data) {
                 console.log(data)
               },
               cache: false,
               contentType: false,
               processData: false
           });
});

$(document).on("click", "#edit_rubrik", function(e){
    e.preventDefault();
    var rubrik_id = $(event.target).attr('rubrikid');
    var text = $("a[rubr="+rubrik_id+"]").text();
    $(".list-group-item[rubrikid="+rubrik_id+"]").replaceWith('<li rubrikid="'+rubrik_id+'" \
        class="list-group-item list-rubrik"> <input class="form-control rubrik-edit" id="rubrik_title" \
        maxlength="50" rubrikid="'+rubrik_id+'" name="title" required="true" type="text" \
          value="'+text+'"> \
          <a id="save_edit" rubrikid="'+rubrik_id+'" \
          class="btn btn-primary admin-edit control-item-rub" \
                  role="button">Сохранить</a> \
      </li>');
});

$(document).on("click", "#save_edit", function(e){
  e.preventDefault();
  var rubrik_id = $(event.target).attr('rubrikid');
  var text = $("input[rubrikid="+rubrik_id+"]").val();
  var request = new FormData();
  request.append('rubrik_id', rubrik_id);
  request.append('name', text);
  $.ajax({
      url: '/control/rubrikedit/',
      type: 'POST',
      contentType: false,
      data: request,
      async: false,
      success: function (data) {
        $(".list-group-item.list-rubrik[rubrikid="+rubrik_id+"]").replaceWith('<li rubrikid="'+rubrik_id+'" \
            class="list-group-item"> <a rubr="'+rubrik_id+'" href=""><b>'+text+'<b></a> \
              <a id="edit_rubrik" rubrikid="'+rubrik_id+'" \
              class="btn btn-success admin-edit control-item" \
                      role="button">Редактировать</a> \
          </li>');
      },
      error: function (data) {
        console.log('error');
      },
      cache: false,
      processData: false
  });
});

$(document).on("click", "#edit_tag", function(e){
    e.preventDefault();
    var tag_id = $(event.target).attr('tagid');
    var text = $("a[tag="+tag_id+"]").text();
    if ($('#del_tag').length) {
      $(".list-group-item").replaceWith('<li \
          class="list-group-item list-rubrik"> <input class="form-control rubrik-edit" id="tag_title" \
          maxlength="50" tagid="'+tag_id+'" name="title" required="true" type="text" \
            value="'+text+'"> \
            <a id="del_tag" tagid="'+tag_id+'" \
            class="btn btn-danger admin-edit control-item-rub" \
            role="button">Удалить</a> \
            <a id="save_tag" tagid="'+tag_id+'" \
            class="btn btn-primary admin-edit control-item-rub" \
                    role="button">Сохранить</a></li> ');
    } else {
      $(".list-group-item").replaceWith('<li \
          class="list-group-item list-rubrik"> <input class="form-control rubrik-edit" id="tag_title" \
          maxlength="50" tagid="'+tag_id+'" name="title" required="true" type="text" \
            value="'+text+'"> \
            <a id="restore_tag" tagid="'+tag_id+'" \
            class="btn btn-warning admin-edit control-item-rub" \
            role="button">Восстановить</a> \
            <a id="save_tag" tagid="'+tag_id+'" \
            class="btn btn-primary admin-edit control-item-rub" \
                    role="button">Сохранить</a></li> ');
    }
});

$(document).on("click", "#save_tag", function(e){
  e.preventDefault();
  var tag_id = $(event.target).attr('tagid');
  var text = $("input").val();
  var type = "save";
  var request = new FormData();
  request.append('tag_id', tag_id);
  request.append('text', text);
  request.append('type', type);
  $.ajax({
      url: '/control/tags/',
      type: 'POST',
      contentType: false,
      data: request,
      async: false,
      success: function (data) {
        if ($('#del_tag').length) {
          $(".list-group-item.list-rubrik").replaceWith('<li  \
              class="list-group-item"> <a tag="'+tag_id+'" href=""><b>'+text+'<b></a> \
                <a id="del_tag" tagid="'+tag_id+'" \
                class="btn btn-danger admin-edit control-item" \
                role="button">Удалить</a> \
                <a id="edit_tag" tagid="'+tag_id+'" \
                class="btn btn-success admin-edit control-item" \
                        role="button">Редактировать</a> \
            </li>');
        } else {
          $(".list-group-item.list-rubrik").replaceWith('<li  \
              class="list-group-item"> <a tag="'+tag_id+'" href=""><b>'+text+'<b></a> \
                <a id="restore_tag" tagid="'+tag_id+'" \
                class="btn btn-warning admin-edit control-item" \
                role="button">Восстановить</a> \
                <a id="edit_tag" tagid="'+tag_id+'" \
                class="btn btn-success admin-edit control-item" \
                        role="button">Редактировать</a> \
            </li>');
        }
      },
      error: function (data) {
        console.log('error');
      },
      cache: false,
      processData: false
  });
});

$(document).on("click", "#del_tag", function(e){
  e.preventDefault();
  var tag_id = $(event.target).attr('tagid');
  var type = "del";
  var request = new FormData();
  request.append('tag_id', tag_id);
  request.append('type', type);
  $.ajax({
      url: '/control/tags/',
      type: 'POST',
      contentType: false,
      data: request,
      async: false,
      success: function (data) {
        if ($('#edit_tag').length) {
          $(event.target).replaceWith('<a id="restore_tag" tagid="'+tag_id+'" \
                class="btn btn-warning admin-edit control-item" \
                role="button">Восстановить</a>');
        } else {
          $(event.target).replaceWith('<a id="restore_tag" tagid="'+tag_id+'" \
                class="btn btn-warning admin-edit control-item-rub" \
                role="button">Восстановить</a>');
        }
      },
      error: function (data) {
        console.log('error');
      },
      cache: false,
      processData: false
  });
});

$(document).on("click", "#restore_tag", function(e){
  e.preventDefault();
  var tag_id = $(event.target).attr('tagid');
  var type = "restore";
  var request = new FormData();
  request.append('tag_id', tag_id);
  request.append('type', type);
  $.ajax({
      url: '/control/tags/',
      type: 'POST',
      contentType: false,
      data: request,
      async: false,
      success: function (data) {
        if ($('#edit_tag').length) {
          $(event.target).replaceWith('<a id="del_tag" tagid="'+tag_id+'" \
                class="btn btn-danger admin-edit control-item" \
                role="button">Удалить</a>');
        } else {
          $(event.target).replaceWith('<a id="del_tag" tagid="'+tag_id+'" \
                class="btn btn-danger admin-edit control-item-rub" \
                role="button">Удалить</a>');
        }
      },
      error: function (data) {
        console.log('error');
      },
      cache: false,
      processData: false
  });
});

$(document).on("click", "#approve_rubrik", function(e){
           e.preventDefault();
           var rubrik_id = $(event.target).attr('rubrikid');
           var request = new FormData();
           request.append('rubrik_id', rubrik_id);
           $.ajax({
               url: '/control/rubrik/',
               type: 'POST',
               contentType: false,
               data: request,
               async: false,
               success: function (data) {
                 $(".btn.btn-warning.admin-edit.control-item[rubrikid="+rubrik_id+"]").replaceWith('<button type="button" \
                 id="approve_rubrik" rubrikid="'+rubrik_id+'" class="btn btn-success admin-edit control-item"  \
                 data-toggle="modal" data-target="#myModal">Одобрено</button>');
               },
               error: function (data) {
                 console.log('error');
               },
               cache: false,
               processData: false
           });
});


$(document).on("click", "#approve", function(e){
           e.preventDefault();
           var material_id = $(event.target).attr('matid');
           var status = $(event.target).attr('status');
           $.ajax({
               url: '/control/materials/approve/'+material_id+'/'+status+'/',
               type: 'POST',
               data: {'material_id' : material_id},
               async: false,
               success: function (data) {
                  var status = $(event.target).attr('status');
                  if (status == "1") {
                    status = "0"
                  }
                  else {
                    status = "1"
                  }
                  var matid = $(event.target).attr('matid');
                  if ($(event.target).attr('class') == 'btn btn-success admin-panel') {
                    $(".btn.btn-default.admin-panel").replaceWith('<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-warning admin-panel"  \
                    >Отклонить</button>');
                    $(event.target).replaceWith( '<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-default admin-panel"  \
                    data-toggle="modal" data-target="#myModal">Одобрено</button>');

                  }
                  else if ($(event.target).attr('class') == 'btn btn-warning admin-panel') {
                    $(".btn.btn-default.admin-panel").replaceWith('<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-success admin-panel"  \
                    >Одобрить</button>');
                    $(event.target).replaceWith( '<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-default admin-panel"  \
                    data-toggle="modal" data-target="#myModal">Отклонено</button>');
                  }
                  else if ($(event.target).attr('class') == 'btn btn-success admin-edit control-item') {
                    var matId = $(event.target).attr('matid');
                    $(".btn.btn-default.admin-edit.control-item[matid="+matId+"]").replaceWith('<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-warning admin-edit control-item"  \
                    data-toggle="modal" data-target="#myModal">Отклонить</button>');
                    $(event.target).replaceWith( '<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-default admin-edit control-item"  \
                    data-toggle="modal" data-target="#myModal">Одобрено</button>');
                  }
                  else if ($(event.target).attr('class') == 'btn btn-warning admin-edit control-item') {
                    var matId = $(event.target).attr('matid');
                    $(".btn.btn-default.admin-edit.control-item[matid="+matId+"]").replaceWith('<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-success admin-edit control-item"  \
                    data-toggle="modal" data-target="#myModal">Одобрить</button>');
                    $(event.target).replaceWith( '<button type="button" \
                    id="approve" matid="'+matid+'" status="'+status+'" class="btn btn-default admin-edit control-item"  \
                    data-toggle="modal" data-target="#myModal">Отклонено</button>');
                  }
               },
               error: function (data) {
                 console.log(data)
               },
               cache: false,
               contentType: false,
               processData: false
           });
});

$(document).on("click", "#unapprove", function(e){
           e.preventDefault();
            $(event.target).replaceWith( '<button type="button" \
            class="btn btn-sucess admin-edit control-item"  \
            data-toggle="modal" data-target="#myModal">Отклонено</button>');
});

$(document).on("click", "#block_user", function(e){
           e.preventDefault();
           var user_id = $(event.target).attr('userid');
           var type = $(event.target).attr('typeb');
           if (type == "1") {
             type = "0";
           }
           else {
             type = "1";
           }
           $.ajax({
               url: '/control/block/user/'+user_id+'/'+type+'/',
               type: 'POST',
               data: {'user_id' : user_id},
               async: false,
               success: function (data) {
                  if ($(event.target).attr('typeb') == '0') {
                     $(event.target).replaceWith( '<button type="button" \
                     id="block_user" typeb="'+type+'" userid="'+user_id+'" class="btn btn-danger admin-edit control-item"  \
                     data-toggle="modal" data-target="#myModal">Разблокировать</button>');
                  } else {
                    $(event.target).replaceWith( '<button type="button" \
                    id="block_user" typeb="'+type+'" userid="'+user_id+'" class="btn btn-warning admin-edit control-item"  \
                    data-toggle="modal" data-target="#myModal">Заблокировать</button>');
                  }
               },
               error: function (data) {
                 console.log(data)
               },
               cache: false,
               contentType: false,
               processData: false
           });

});

$(document).on("click", "#material-restore", function(e){
           e.preventDefault();
           var material_id = $('#material_id').val();
           $.ajax({
               url: '/lk/restore/'+material_id+'/',
               type: 'POST',
               data: {'material_id' : $('material_id').val()},
               async: false,
               success: function (data) {
                 if (data.hasOwnProperty('result')) {
                  $("#material-edit-form").replaceWith( '<div class="alert alert-success" role="alert"> \
                  '+data.result+'</div><p><a href="/lk/" class="btn btn-primary btn-back" role="button">'+data.button+'</a></p>');
                 }
               },
               error: function (data) {
                 console.log(data)
               },
               cache: false,
               contentType: false,
               processData: false
           });
});
