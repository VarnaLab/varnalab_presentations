case class Person(name: String)

val people = Some(Person("John")) :: Some(Person("Mike")) :: None :: Nil
val secondName = people match {
  case head :: Some(Person(name)) :: tail => Some(name)
  case _ => None
}

println(secondName)

val protocolParser = "([^:]+):.*".r
val parsed = "http://google.com" match {
  case protocolParser(proto) => proto
}
println(parsed)
