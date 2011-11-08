import scala.reflect._

class Person(aName: String) {
  private var _name: String = aName
  
  def name = _name
  def name_=(value: String) = _name = value

  def getName = name
  def setName(value: String) = name = value
}

class PersonAuto(aName: String) {
  @BeanProperty
  var name: String = aName
}

class PersonAutoCompact(@BeanProperty var name: String)
