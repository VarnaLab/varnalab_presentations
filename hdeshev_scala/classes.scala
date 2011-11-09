class Account1(aName: String, anEmail: String) {
  val name = aName
  val email = anEmail
}
val a1 = new Account1("John", "john@example.com")

class Account2(val name: String, val email: String)
val a2 = new Account2("John", "john@example.com")

case class Account3(name: String, email: String)
val a3 = Account3("John", "john@example.com")
