class Account(val name: String, val email: String)

object Account {
  def apply(email: String) = {
    new Account("Unknown", email)
  }
}

val john = Account("john@example.com")
println(john.email)
