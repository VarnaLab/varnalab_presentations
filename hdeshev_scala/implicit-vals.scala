import scala.xml._

case class Person(name: String)

trait XmlSerializer[T] {
  def toXml(in: T): Node
}

implicit object PersonSerializer extends XmlSerializer[Person] {
  def toXml(in: Person) = <person><name>{in.name}</name></person>
}

def toXml[T](in: T)(implicit serializer: XmlSerializer[T]) =
  serializer.toXml(in)

val xml = toXml(Person("John"))
println(xml)
