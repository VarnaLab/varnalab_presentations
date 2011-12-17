case class Bytes(value: Int)

object Units {
  implicit def toSize(value: Int) = new SizeInt(value)
}

class SizeInt(val value: Int) {
  def megaBytes = Bytes(value * 1024 * 1024)
}

import Units._
val size = 5.megaBytes
println(size)

