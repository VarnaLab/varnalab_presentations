object Http {
  def urlDecode(in: String) = error("todo")
}

class Account(val name: String, val email: String)

object Account {
  def fromEmail(email: String) = {
    new Account("Unknown", email)
  }

  def apply(email: String) = fromEmail(email)
}

val john = Account.fromEmail("john@example.com")
val mike = Account("mike@example.com")
println(john.email)
