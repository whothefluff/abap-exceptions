*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

"! Wraps un-mockable behavior
class current_call_stack_fty definition ##CLASS_FINAL
                             create public.

  public section.

    methods get
              returning
                value(r_val) type ref to if_xco_cp_std_cur_api_cll_stck.

endclass.
class current_call_stack_fty implementation.

  method get.

    return xco_cp=>current->call_stack.

  endmethod.

endclass.

"! Wraps un-mockable behavior
class adt_format_fty definition ##CLASS_FINAL
                     create public.

  public section.

    methods get
              returning
                value(r_val) type ref to if_xco_cs_format.

endclass.
class adt_format_fty implementation.

  method get.

    return xco_cp_call_stack=>format->adt( ).

  endmethod.

endclass.

class _itab_filter definition deferred.

"! <p class="shorttext synchronized" lang="EN">ITAB filter</p>
"!
"! Shouldn't be necessary, but
"! {@link XCO_CP_CALL_STACK}=>line_pattern->method(
"! )->{@link CL_XCO_CP_CS_LP_METHOD.meth:WHERE_CLASS_NAME_MATCHES }(
"! <em>PCRE_REGEX</em> ) is not working
class itab_filter definition
                  create public
                  friends _itab_filter.

  public section.

    methods constructor
              importing
                i_itab type any table.

    "! <p class="shorttext synchronized" lang="EN">Returns the last consecutive index found, starting from 1</p>
    "!
    "! Since it starts from 1, any matches after the first index are not
    "! taken into account and the returned value is 0
    "!
    "! @parameter i_regex | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods last_consecutive
              importing
                i_regex type ref to cl_abap_regex
              returning
                value(r_val) type i.

  protected section.

    data _itab type ref to data.

endclass.
class itab_filter implementation.

  method constructor.

    create data _itab like i_itab.

    _itab->* = i_itab.

  endmethod.
  method last_consecutive.

    try.

      final(matches) = i_regex->create_matcher( table = _itab->* )->find_all( ).

    catch cx_sy_matcher ##NO_HANDLER. "defaults to no findings when an error occurs

    endtry.

    return reduce i( init max = 0
                     for <m> in matches
                     next max = cond #( when <m>-line eq max + 1
                                        then max + 1
                                        else max ) ).

  endmethod.

endclass.

"! Wraps un-mockable behavior
class itab_filter_fty definition ##CLASS_FINAL
                      create public.

  public section.

    methods for
              importing
                i_itab type any table
              returning
                value(r_val) type ref to itab_filter.

endclass.
class itab_filter_fty implementation.

  method for.

    return new itab_filter( i_itab ).

  endmethod.

endclass.
