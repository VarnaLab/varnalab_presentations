Световна доминация със Scala<br/>Христо Дешев - @hdeshev
=======
---

Кратка история на езика
=======================
- 1995 и нататък - Мартин Одерски е един от създателите на Pizza - функционален език, който се компилира до Java байткод. Това води до проекта GJ и по-късно до интегрирането на generics в новите версии на Java.
- Одерски започва да работи по Scala през 2001 и първата версия излиза през 2003.
- 2004 - Scala за .NET
- 2006 - Scala 2.0
- 2010 - Scala 2.8
- Сега - Scala 2.9

---

Защо Scala?
===========

- Компактен - с малко код казваме много. Висока продуктивност.
- Продуктивни сме от самото начало.
- Мощен - въпреки повърхностната прилика с Java, езикът предлага много повече.
- Добра стандартна библиотека.
- Достъп до огромно количество Java код.

---

Автоматично разпознаване на типовете
====================================

Няма нужда да се повтаряме:

**Java**

    !java
    HashMap<String, Integer> m = new HashMap<String, Integer>(); 

**Scala**

    !scala
    val m = Map("one" -> 1, "two" -> 2)

Въпреки краткият запис, това все още е език със статични типове, проверявани от компилатора.

## Пишем код бързо както в някой динамичен език.
## Получаваме всичките предимства на статичните езици.

---

Истински обектен език
========

- няма примитиви, които да не са обекти.
- Всеки наследява от Any
- Имаме познатите класове за описание на функционалност,
- Много механизми за бързо дефиниране на нови типове,
- лесни singleton обекти.
- и traits!

---

Класове
=======
Java стил:

    !scala
    class Account1(aName: String, anEmail: String) {
      val name = aName
      val email = anEmail
    }
    val a1 = new Account1("John", "john@example.com")

Малко по-добре:

    !scala
    class Account2(val name: String, val email: String)
    val a2 = new Account2("John", "john@example.com")

И още по-добре:

    !scala
    case class Account3(name: String, email: String)
    val a3 = Account3("John", "john@example.com")
---

Методи
======

Напълно описани параметри и върнат тип

    !scala
    def validateEmail(email: String): Unit = {
      if (emailValid(email))
        throw new IllegalArgumentException("Eek! Email empty!")
    }

Връщаме нищо (Unit)? Може и по-кратко

    !scala
    def validate {
      validateEmail(email)
    }

Автоматично познаваме върнатия тип (Boolean)

    !scala
    def emailValid(email: String) = {
      email != ""
    }

---

Свойства (Properties)
=====================
**Java стил**

    !scala
    class Person(aName: String) {
      private var _name: String = aName
      def name = _name
      def name_=(value: String) = _name = value
      def getName = name
      def setName(value: String) = name = value
    }

Автоматично генерирани:

    !scala
    class PersonAuto(aName: String) {
      @BeanProperty
      var name: String = aName
    }

И най-компактно:

    !scala
    class PersonAutoCompact(@BeanProperty var name: String)

---

Objects
========
Singletons с анонимен клас.

    !scala
    object Http {
      def urlDecode(in: String) = error("todo")
    }

Лесни singleton имплементации, лесни factories, за съжаление - лесен начин да работиш с глобални данни.

---

Companion objects
=================
Scala няма статични методи! Симулираме ги като слагаме методи на т.нар. companion objects:

    !scala
    class Account(val name: String, val email: String)

    object Account {
      def fromEmail(email: String) = {
        new Account("Unknown", email)
      }

      def apply(email: String) = fromEmail(email)
    }

    val john = Account.fromEmail("john@example.com")
    val mike = Account("mike@example.com")

*apply* е специален метод - с него обектът вече се държи като функция.

---

Case classes
============
- по-умни data object имплементации.
- компилаторът ни помага и безплатно получаваме:
    - companion objects с правилните *apply* имплементации
    - *copy* метод, за лесно клониране
    - методите за сравнение и хеш код на обектите
    - поддържка на pattern matching.

---

Traits
======
- интерфейси
- но и с имплементация
- композиране на функционалност

---

Traits - пример
===============
    !scala
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
    
---

Implicit conversions
====================
Автоматично конвертиране от един обект в друг, чрез маркиране на метода за конверсия с *implicit*.

Удобно за добавяне на методи в съществуващи класове. Още известно като Pimp My Library.

    !scala
    object Units {
      implicit def toSize(value: Int) = new SizeInt(value)
    }

    class SizeInt(val value: Int) {
      def megaBytes = Bytes(value * 1024 * 1024)
    }

    import Units._
    val size = 5.megaBytes

По-мощно от т.нар. *extension methods* в други езици (C#).

---

Implicit parameters/values
==========================

- Маркираме определени стойности (val или object) като implicit.
- Маркираме и параметри на методи като такива.
- Ако по време на извикване, компилаторът вижда стойност от нужния тип, я подава автоматично и не ни кара да пишем.

Пример

    !scala
    implicit object PersonSerializer extends XmlSerializer[Person] {
      def toXml(in: Person) = <person><name>{in.name}</name></person>
    }
    def toXml[T](in: T)(implicit serializer: XmlSerializer[T]) =
      serializer.toXml(in)

    val xml = toXml(Person("John"))

---

Implicit values ползи - конфигурация
====================================
За какво ни е всичко това? Пример - конфигурация на *lift-json* библиотеката

    !scala

    implicit val formats = new DefaultFormats {
      override def dateFormatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }

---

Implicit parameters ползи - Typeclasses
=================================

Реален пример от [sjson](https://github.com/debasishg/sjson/) библиотеката:

    !scala
    object Protocols {
      // person abstraction
      case class Person(lastName: String, firstName: String, age: Int)

      // protocol definition for person serialization
      object PersonProtocol extends DefaultProtocol {
        import dispatch.json._
        import JsonSerialization._

        implicit object PersonFormat extends Format[Person] {
          def reads(json: JsValue): Person = json match {
            //...
          }

          def writes(p: Person): JsValue = //...
        }
      }
    }
    
    //...
    val js = tojson(Person("Smith", "John", 28))
    

---

Pattern matching
================
<strike>Switch на стероиди</strike>

Едновременно проверка за определена структура от обекти и измъкване на подобекти.

Компактен код:

    !scala

    val people = Some(Person("John")) :: Some(Person("Mike")) :: None :: Nil
    val secondName = people match {
      case head :: Some(Person(name)) :: tail => Some(name)
      case _ => None
    }

Разширяеми - интересни API:

    !scala
    val protocolParser = "([^:]+):.*".r
    val parsed = "http://google.com" match {
      case protocolParser(proto) => proto
    }

---

Functions
=========

Първокласни обекти.

    !scala
    val add5 = (num: Int) => num + 5
    val sum = add5(3)

Подаваме ги като параметри (и няма нужда да им разписваме типовете, когато компилаторът ги знае):

    !scala
    List(1, 2, 3).map(n => n * 2)

Толкова често ги ползваме, че имаме и по-лесен синтаксис:

    !scala
    List(1, 2, 3).map(_ * 2)

За всяка функция, компилаторът генерира анонимен клас с познатия ни метод *apply*.

---

Mutable vs. Immutable
=====================
- Програмирането с мутиращи данни не се окуражава.
- Но пък и не се забранява с фанатизъм.

- val vs. var
- scala.collection.immutable vs. scala.collection.mutable

---

Currying
========
Методите могат да имат по няколко списъка с параметри.

И можем да ги извикваме "частично" като подаваме само някои от тях.

Резултатът са нови функции:

    !scala
    def add(x: Int)(y: Int) = x + y

    val increment = add(1)_
    val incremented = increment(10)
---

Отново - защо да се занимавам със Scala
=======================================

- Ако програмирате за JVM, ще си подобрите производителността.
    - Започнете бавно и с отделни компоненти (тестовете например).
    - Без проблем ще работите със съществуващия Java код.
- Този септември чакаме съживеният Scala .NET компилатор!
- Ще сте почти веднага по-продуктивни, ако използвате Scala като по-добра Java.
- Има мноооого за учене за функционалната страна на Scala.
    - Не се отчайвайте от това. Всяка малка победа ви прави по-добър програмист.

---

Въпроси?
=======
---

Бонуси
=================
- Всичко в Scala e израз
- Uniform access principle
- Partial functions
- lazy vals
- By-name метод параметри
- Gotchas - JVM type erasure :-)

