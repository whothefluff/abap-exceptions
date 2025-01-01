*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

class reader_fty definition ##CLASS_FINAL
                 create public.

  public section.

    methods for_empty_exception
              returning
                value(r_val) type ref to zcl_exception_reader.

endclass.
class reader_fty implementation.

  method for_empty_exception.

    return new zcl_exception_reader( value #( ) ).

  endmethod.

endclass.
