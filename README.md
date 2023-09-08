# abap-exceptions

Exceptions that implement the message interface and that take a message in the constructor

The interface has a type so a message from an exception like this should be sent with "MESSAGE ..." (without the TYPE addition)

Since ABAP 7.53 the addition USING MESSAGE can be used to throw an exception with the current message variables of sy structure, making creating an exception of this type by feeding it a ZCL_SY_MESSAGE object somewhat obsolete

While it is technically possible to modify the value of the attribute "severity" of the new interface, the code was implemented assuming that the severity and the type will match