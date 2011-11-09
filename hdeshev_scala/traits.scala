trait AccountReader {
  def db: AccountDb
  def accountId: String

  def account = db.find(accountId)
}

trait HttpHeaderAccount { self : Controller =>
  def accountId = header("Account-Id")
}

class AccountController 
  extends Controller 
  with AccountReader 
  with HttpHeaderAccount {
  def db = new AccountDb
}

trait Controller {
  def header(name: String) = "todo"
}

class AccountDb {
  def find(id: String) = error("todo")
}
