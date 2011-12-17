def add(x: Int)(y: Int) = x + y

val increment = add(1)_
val incremented = increment(10)

println(incremented)
