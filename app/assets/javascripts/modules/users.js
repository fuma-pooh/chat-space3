$(function() {
  function addUser(user) {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">${user.name}</p>
                  <div class="ChatMember__add ChatMember__button" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>
                `;
    $("#UserSearchResult").append(html);
  }

  function addNoUser() {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">ユーザーが見つかりません</p>
                </div>
                `;
    $("#UserSearchResult").append(html);
  }

  function addMember(name, id) {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">${name}</p>
                  <input name="group[user_ids][]" type="hidden" value="${id}" />
                  <div class="ChatMember__remove ChatMember__button">削除</div>
                </div>
                `;
    $(".ChatMembers").append(html);
  }

  $("#UserSearch__field").on("keyup", function() {
    let input = $("#UserSearch__field").val();
    $.ajax({
      type: "GET",
      url: "/users",
      data: { keyword: input },
      dataType: "json"
    })

    .done(function(users) {
      $("#UserSearchResult").empty();
      if (users.length !== 0) {
        users.forEach(function(user) {
          addUser(user);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoUser();
      }
    })
    .fail(function() {
      alert("通信エラーです。ユーザーが表示できません。");
    });
  });


  $("#UserSearchResult").on("click", ".ChatMember__add", function() {
    const userName = $(this).attr("data-user-name");
    const userId = $(this).attr("data-user-id");
    $(this).parent().remove();
    addMember(userName, userId);
  });
  $(".ChatMembers").on("click", ".ChatMember__remove", function() {
    $(this).parent().remove();
  });
});



// val();メソッド
// フォームの値を取得する時に使用するメソッド
// emptyメソッドを使用して,すでに検索結果欄で出力されている投稿情報を
// 削除する（これを実装しないと、一つ前の検索結果が残り続けてしまう）

// $("#UserSearchResult").onすることで親要素の情報を取得することができます
// appendさせて作成したHTMLから情報を取得する際、
// 親要素の情報を用いることで値の取得を可能にしています

// 追加ボタンの対象であるユーザー情報を変数へ代入し、HTMLを描画します。
// その際、検索結果欄からメンバー欄へ移動するように見せるために検索結果欄からremoveメソッドを使用してHTMLは削除しましょう

// ユーザーの追加や削除の情報は addMember というメソッドを作成してコントロール

// メンバーを追加する際に情報を user_idsへ追加できるような仕組みを作り、
// 削除ボタンを押すと同時にその情報も削除されるように実装しています