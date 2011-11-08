class Account(val email: String) {
  def validateEmail(email: String): Unit = {
    if (emailValid(email))
      throw new IllegalArgumentException("Eek! Email empty!")
  }

  def validate {
    validateEmail(email)
  }

  def emailValid(email: String) = {
    email != ""
  }
}
