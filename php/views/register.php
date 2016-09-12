<div class="header">
  <h1>ユーザー登録</h1>
</div>

<? if (flash('notice')): ?>
<div id="notice-message" class="alert alert-danger">
  <?= escape_html(flash('notice')) ?>
</div>
<? endif ?>

<div class="submit">
  <form method="post" action="/register">
    <div class="form-account-name">
      <span>アカウント名</span>
      <input type="text" name="account_name">
    </div>
    <div class="form-password">
      <span>パスワード</span>
      <input type="password" name="password">
    </div>
    <div class="form-submit">
      <input type="submit" name="submit" value="submit">
    </div>
  </form>
</div>
