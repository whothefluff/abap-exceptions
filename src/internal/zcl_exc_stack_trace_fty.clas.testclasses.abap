*"* use this source file for your ABAP unit test classes

"! Testing {@link .CURRENT_CALL_STACK_FTY}
class _current_call_stack_fty definition
                              final
                              for testing
                              risk level harmless
                              duration short.

  private section.

    methods get_returns_instance for testing.

endclass.
class _current_call_stack_fty implementation.

  method get_returns_instance.

    "arrange
    final(o) = new current_call_stack_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->get( ) ).

  endmethod.

endclass.

"! Testing {@link .ADT_FORMAT_FTY}
class _adt_format_fty definition
                      final
                      for testing
                      risk level harmless
                      duration short.

  private section.

    methods get_returns_instance for testing.

endclass.
class _adt_format_fty implementation.

  method get_returns_instance.

    "arrange
    final(o) = new adt_format_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->get( ) ).

  endmethod.

endclass.

class _regex_stub definition ##CLASS_FINAL
                  inheriting from cl_abap_regex
                  create public
                  for testing.

  public section.

    types t_canned_answer type ref to cx_sy_matcher.

    methods constructor
              importing
                i_canned_answer type _regex_stub=>t_canned_answer.

    methods create_matcher redefinition.

  protected section.

    data _canned_answer type _regex_stub=>t_canned_answer.

endclass.
class _regex_stub implementation.

  method constructor.

    super->constructor( pattern = `^` ).

    _canned_answer = i_canned_answer.

  endmethod.
  method create_matcher.

    raise exception _canned_answer.

  endmethod.

endclass.

"! Testing {@link .ITAB_FILTER}
class _itab_filter definition
                   final
                   for testing
                   risk level harmless
                   duration short.

  private section.

    methods constructor_sets_attr for testing.

    methods last_consec_finds_consec for testing.

    methods last_consec_stops_at_gap for testing.

    methods last_consec_ignores_unmatched for testing.

    methods last_consec_when_exc_returns_0 for testing.

endclass.
class _itab_filter implementation.

  method constructor_sets_attr.

    "arrange
    final(some_tab) = value string_table( ( `A` ) ).

    "act
    final(o) = new itab_filter( some_tab ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_tab
                                        act = o->_itab->* ).

  endmethod.
  method last_consec_finds_consec.

    "arrange
    final(o) = new itab_filter( value string_table( ) ).

    final(some_tab) = value string_table( ( `match` )
                                          ( `match` )
                                          ( `fail` ) ).

    o->_itab = ref #( some_tab ).

    final(regex) = cl_abap_regex=>create_pcre( `match` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = 2
                                        act = o->last_consecutive( regex ) ).

  endmethod.
  method last_consec_stops_at_gap.

    "arrange
    final(o) = new itab_filter( value string_table( ) ).

    final(some_tab) = value string_table( ( `fail` )
                                          ( `match` )
                                          ( `match` ) ).

    o->_itab = ref #( some_tab ).

    final(regex) = cl_abap_regex=>create_pcre( `match` ).

    "act & assert
    cl_abap_unit_assert=>assert_initial( o->last_consecutive( regex ) ).

  endmethod.
  method last_consec_ignores_unmatched.

    "arrange
    final(o) = new itab_filter( value string_table( ) ).

    final(some_tab) = value string_table( ( `fail` )
                                          ( `fail` ) ).

    o->_itab = ref #( some_tab ).

    final(regex) = cl_abap_regex=>create_pcre( `match` ).

    "act & assert
    cl_abap_unit_assert=>assert_initial( o->last_consecutive( regex ) ).

  endmethod.
  method last_consec_when_exc_returns_0.

    "arrange
    final(o) = new itab_filter( value string_table( ) ).

    final(some_tab) = value string_table( ( `match` ) ).

    o->_itab = ref #( some_tab ).

    final(regex) = new _regex_stub( cast #( cl_abap_testdouble=>create( 'CX_SY_MATCHER' ) ) ).

    "act & assert
    cl_abap_unit_assert=>assert_initial( o->last_consecutive( regex ) ).

  endmethod.

endclass.

"! Testing {@link .ITAB_FILTER_FTY}
class _itab_filter_fty definition
                       final
                       for testing
                       risk level harmless
                       duration short.

  private section.

    methods for_returns_instance for testing.

endclass.
class _itab_filter_fty implementation.

  method for_returns_instance.

    "arrange
    final(o) = new itab_filter_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->for( value string_table( ) ) ).

  endmethod.

endclass.

class _cur_call_stack_fty_stub definition ##CLASS_FINAL
                               inheriting from current_call_stack_fty
                               create public
                               for testing.

  public section.

    methods constructor
              importing
                i_canned_answer type ref to if_xco_cp_std_cur_api_cll_stck.

    methods get redefinition.

  protected section.

    data _canned_answer type ref to if_xco_cp_std_cur_api_cll_stck.

endclass.
class _cur_call_stack_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _canned_answer = i_canned_answer.

  endmethod.
  method get.

    return _canned_answer.

  endmethod.

endclass.

class _adt_format_fty_stub definition ##CLASS_FINAL
                           inheriting from adt_format_fty
                           create public
                           for testing.

  public section.

    types t_canned_answer type ref to if_xco_cs_format.

    methods constructor
              importing
                i_canned_answer type _adt_format_fty_stub=>t_canned_answer.

    methods get redefinition.

  protected section.

    data _canned_answer type _adt_format_fty_stub=>t_canned_answer.

endclass.
class _adt_format_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _canned_answer = i_canned_answer.

  endmethod.
  method get.

    return _canned_answer.

  endmethod.

endclass.

class _itab_filter_stub definition ##CLASS_FINAL
                        inheriting from itab_filter
                        create public
                        for testing.

  public section.

    methods constructor
              importing
                i_canned_answer type i.

    methods last_consecutive redefinition.

  protected section.

    data _canned_answer type i.

endclass.
class _itab_filter_stub implementation.

  method constructor.

    super->constructor( value string_table( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method last_consecutive.

    return _canned_answer.

  endmethod.

endclass.

class _itab_filter_fty_stub definition ##CLASS_FINAL
                            inheriting from itab_filter_fty
                            create public
                            for testing.

  public section.

    methods constructor
              importing
                i_canned_answer type ref to itab_filter.

    methods for redefinition.

  protected section.

    data _canned_answer type ref to itab_filter.

endclass.
class _itab_filter_fty_stub implementation.

  method constructor.

    super->constructor( ).

    _canned_answer = i_canned_answer.

  endmethod.
  method for.

    return _canned_answer.

  endmethod.

endclass.

class _xco_call_stack_stub definition ##CLASS_FINAL
                           create public
                           for testing.

  public section.

    interfaces if_xco_cp_call_stack partially implemented.

    types t_as_text_expected_arg type ref to if_xco_cs_format.

    types t_as_text_result type ref to if_xco_text.

    methods constructor
              importing
                i_from type ref to if_xco_cp_cs_extr_api_from optional
                i_as_text_expected_arg type _xco_call_stack_stub=>t_as_text_expected_arg optional
                i_as_text_result type _xco_call_stack_stub=>t_as_text_result optional.

  protected section.

    data _as_text_expected_arg type _xco_call_stack_stub=>t_as_text_expected_arg.

    data _as_text_result type _xco_call_stack_stub=>t_as_text_result.

endclass.
class _xco_call_stack_stub implementation.

  method constructor.

    if_xco_cp_call_stack~from = i_from.

    _as_text_expected_arg = i_as_text_expected_arg.

    _as_text_result = i_as_text_result.

  endmethod.
  method if_xco_cp_call_stack~as_text.

    return cond #( when io_format eq _as_text_expected_arg
                   then _as_text_result ).

  endmethod.

endclass.

class _xco_strings_value_stub definition ##CLASS_FINAL
                              create public
                              for testing.

  public section.

    interfaces if_xco_strings partially implemented.

    methods constructor
              importing
                i_value type string_table.

endclass.
class _xco_strings_value_stub implementation.

  method constructor.

    if_xco_strings~value = i_value.

  endmethod.

endclass.

class _ definition deferred.

class zcl_exc_stack_trace_fty definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    class-methods class_setup.

    methods setup.

    methods class_constructor_sets_attr for testing.

    methods get_returns_shifted_stack for testing.

    class-methods class_teardown.

    class-data _exception_name_pattern_backup type ref to cl_abap_regex.

    class-data _current_call_stack_fty_backup type ref to current_call_stack_fty.

    class-data _adt_format_fty_backup type ref to adt_format_fty.

    class-data _itab_filter_fty_backup type ref to itab_filter_fty.

endclass.
class _ implementation.

  method class_setup.

    _exception_name_pattern_backup = cast #( zcl_exc_stack_trace_fty=>_exception_name_pattern ).

    _current_call_stack_fty_backup = cast #( zcl_exc_stack_trace_fty=>_current_call_stack_fty ).

    _adt_format_fty_backup = cast #( zcl_exc_stack_trace_fty=>_adt_format_fty ).

    _itab_filter_fty_backup = cast #( zcl_exc_stack_trace_fty=>_itab_filter_fty ).

  endmethod.
  method setup.

    zcl_exc_stack_trace_fty=>_exception_name_pattern = _exception_name_pattern_backup.

    zcl_exc_stack_trace_fty=>_current_call_stack_fty = _current_call_stack_fty_backup.

    zcl_exc_stack_trace_fty=>_adt_format_fty = _adt_format_fty_backup.

    zcl_exc_stack_trace_fty=>_itab_filter_fty = _itab_filter_fty_backup.

  endmethod.
  method class_constructor_sets_attr.

    "arrange & act
    final(o) = new zcl_exc_stack_trace_fty( ).

    final(type) = cast cl_abap_classdescr( cl_abap_typedescr=>describe_by_object_ref( o ) ).

    "assert
    loop at type->attributes reference into final(static_attr) where is_class eq abap_true "#EC CI_STDSEQ
                                                                     and type_kind eq cl_abap_typedescr=>typekind_oref.

      cl_abap_unit_assert=>assert_bound( act = o->(static_attr->*-name)
                                         quit = if_abap_unit_constant=>quit-no ).

    endloop.

  endmethod.
  method get_returns_shifted_stack.

    "arrange
    final(some_text) = cast if_xco_text( cl_abap_testdouble=>create( 'IF_XCO_TEXT' ) ).

    final(some_strings) = new _xco_strings_value_stub( value #( ) ).

    cl_abap_testdouble=>configure_call( some_text )->returning( some_strings ).

    some_text->get_lines( ).

    final(from_of_excl_int_proc_trace) = cast if_xco_cp_cs_extr_api_from( cl_abap_testdouble=>create( 'IF_XCO_CP_CS_EXTR_API_FROM' ) ).

    final(final_call_stack) = cast if_xco_cp_call_stack( cl_abap_testdouble=>create( 'IF_XCO_CP_CALL_STACK' ) ).

    cl_abap_testdouble=>configure_call( from_of_excl_int_proc_trace )->returning( final_call_stack ).

    from_of_excl_int_proc_trace->position( 3 ). "last_consec is 2, so 2 + 1

    final(some_adt_format) = cast if_xco_cs_format( cl_abap_testdouble=>create( 'IF_XCO_CS_FORMAT' ) ).

    final(trace_excl_int_proc) = new _xco_call_stack_stub( i_from = from_of_excl_int_proc_trace
                                                           i_as_text_expected_arg = some_adt_format
                                                           i_as_text_result = some_text ).

    zcl_exc_stack_trace_fty=>_adt_format_fty = new _adt_format_fty_stub( some_adt_format ).

    final(from_of_full_trace) = cast if_xco_cp_cs_extr_api_from( cl_abap_testdouble=>create( 'IF_XCO_CP_CS_EXTR_API_FROM' ) ).

    cl_abap_testdouble=>configure_call( from_of_full_trace )->returning( trace_excl_int_proc ).

    from_of_full_trace->position( 2 ).

    final(result_of_calling_fty_get_full) = new _xco_call_stack_stub( i_from = from_of_full_trace ).

    final(result_of_calling_fty_get) = cast if_xco_cp_std_cur_api_cll_stck( cl_abap_testdouble=>create( 'IF_XCO_CP_STD_CUR_API_CLL_STCK' ) ).

    cl_abap_testdouble=>configure_call( result_of_calling_fty_get )->returning( result_of_calling_fty_get_full ).

    result_of_calling_fty_get->full( ).

    zcl_exc_stack_trace_fty=>_current_call_stack_fty = new _cur_call_stack_fty_stub( result_of_calling_fty_get ).

    final(itab_filter_stub) = new _itab_filter_stub( 2 ).

    zcl_exc_stack_trace_fty=>_itab_filter_fty = new _itab_filter_fty_stub( itab_filter_stub ).

    final(o) = new zcl_exc_stack_trace_fty( ).

    "act
    final(act_trace) = o->get( 'ANY' ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = final_call_stack
                                        act = act_trace ).

  endmethod.
  method class_teardown.

    zcl_exc_stack_trace_fty=>_exception_name_pattern = _exception_name_pattern_backup.

    zcl_exc_stack_trace_fty=>_current_call_stack_fty = _current_call_stack_fty_backup.

    zcl_exc_stack_trace_fty=>_adt_format_fty = _adt_format_fty_backup.

    zcl_exc_stack_trace_fty=>_itab_filter_fty = _itab_filter_fty_backup.

  endmethod.

endclass.
