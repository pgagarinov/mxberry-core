The library was originally developed as an auxilary library for [Ellipsodal Toolbox for Matlab](https://github.com/SystemAnalysisDpt-CMC-MSU/ellipsoids) project 
back in 2014. In 2016 it was decided to extract the library from "Ellipsoidal Toolbox" so that it can be developed as a separate and independent open-source project.

Right from the begining we have been following Test Driven Development (TTD) approach by implementing and extending a test coverage
for most of the library functions. Our ideology is to cover every new feature with meanigful tests and every bug found - with negative tests.

Features
------------
* **Configuration management** - Version-tracked hostname-specific configurations stored as plain xml for easier editing and
scm system integration
* **Containers** 
    - On-disk hash maps in `mxberry.core.cont.ondisk` package. 
    - `mxberry.core.cont.MapExtended` is an extension of built-in `containers.Map` class that supports 
        - conversion to structures
        - union of hash maps
        - deep copies
        - comparison

* **Input parameter parsing functions** `mxberry.core.parseparext` and `mxberry.core.parseparams` for easier input parameters parsing
input parameters checking functions in `mxberry.core.check` package
* **OOP helper classes**

    - **for handle classes**  - `mxberry.core.obj.HandleObjectCloner`
class designed as a parent class
for handle objects that require such features as 
         - automatic deep copy
         - comparison, sorting
         - support for `ismember` and `unique` operations
Check out tests in `mxberry.core.obj.test` package for more details

     - **for emulation of static properties** - `mxberry.core.obj.StaticPropStorage` class emulate static properties via persistent variables.
Check out tests in `mxberry.core.obj.test` package for more details

* **ismember and unique functions for arbitrary types** - `mxberry.core` package contains a lot of functions with `ismember*` and `unique*`
name patterns for different types of unique-like and ismember-like operations. 
mxberry.core.ismember and mxberry.core.unique use these operations to implement `ismember`
and `unique` for arbitrary types. 
Check out tests in `mxberry.core.test.IsMemberTC` test case for more details

* **Easier Matlab exceptions handling** - `mxberry.core.MExceptionUtils` class provides methods for converting Matlab exceptions
into plain text and hyper text strings.
* **Useful generic-purpose functions in** - `mxberry.core` package, such as 
`absrelcompare` for comparing arrays using both relative and absolute tolerances
`getcallername` and `getcallernameext` for generating names of callers
`throwerror` and `throwwarn` for throwing warnings and exceptions with automatically
generated identifiers

and a few others

* **Helper functions for different built-in types**
    -  `mxberry.core.string` - woring with strings
    -  `mxberry.core.struct` - structures
    -  `mxberry.core.cell` - cells

* **Utility functions for working with filers and directions** are located in `mxberry.io` package. All these functions are implemented
in Java so they are free of filename and path length limit problems on Windows platforms.

* **Java static path management** - `mxberry.java.AJavaStaticPathMgr` class is designed as extendable abstract class
for much easier management of java static path in Matlab, including an automatic
deployment of 'jar' files. See `mxberry.selfmnt.JavaStaticPathMgr` class for an 
example of AJavaStaticPathMgr abstract methods implementation for a deployment of MatrixBerry Core library.

* **System information** - `mxberry.system` package contains functions for getting 
    - pid of current Matlab process
    - computer name
    - current user name
    - names and parameters of all network interfaces

* **XML serialization and de-serialization of Matlab structures** in `mxberry.xml.xmlformat` package.
