*"* use this source file for your ABAP unit test classes

class _stc_exc_aggr_fty_from_stub definition ##CLASS_FINAL
                                  inheriting from zcl_static_check_exc_aggr_fty
                                  create public
                                  for testing.

  public section.

    types t_canned_answer type ref to zcx_static_check_aggr.

    methods constructor
              importing
                i_canned_answer type _stc_exc_aggr_fty_from_stub=>t_canned_answer.

    methods from redefinition.

    data captured_list type zcx_static_check_aggr=>t_list read-only.

  protected section.

    data _canned_answer type _stc_exc_aggr_fty_from_stub=>t_canned_answer.

endclass.
class _stc_exc_aggr_fty_from_stub implementation.

  method constructor.

    super->constructor( ).

    _canned_answer = i_canned_answer.

  endmethod.
  method from.

    captured_list = i_list.

    return _canned_answer.

  endmethod.

endclass.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods from_returns_empty for testing.

    methods append_adds_to_inst for testing.

    "! Target can be invalid reference
    methods append_initializes_inst_1 for testing.

    "! Source can be invalid reference
    methods append_initializes_inst_2 for testing.

endclass.
class _ implementation.

  method from_returns_empty.

    "arrange
    final(o) = new zcl_static_check_exc_aggr_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_not_bound( o->from( value #( ) ) ).

  endmethod.
  method append_adds_to_inst.

    "arrange
    final(result_of_from) = new zcx_static_check_aggr( value #( ) ).

    final(o) = new _stc_exc_aggr_fty_from_stub( result_of_from ).

    final(previous_errors) = new zcx_static_check_aggr( value #( let random_generator = cl_abap_random=>create( cl_abap_random=>seed( ) ) in
                                                                 for i = 0 until i gt random_generator->intinrange( low = 2
                                                                                                                    high = 50 )
                                                                 ( cast #( cl_abap_testdouble=>create( 'ZCX_NO_CHECK' ) ) ) ) ).

    final(new_errors) = new zcx_static_check_aggr( value #( let random_generator = cl_abap_random=>create( cl_abap_random=>seed( ) ) in
                                                            for i = 0 until i gt random_generator->intinrange( low = 2
                                                                                                               high = 50 )
                                                            ( cast #( cl_abap_testdouble=>create( 'ZCX_NO_CHECK' ) ) ) ) ).

    "act & assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->append( i_exceptions = new_errors
                                                          i_to_previous = previous_errors ) eq result_of_from
                                               and o->captured_list eq value zcx_static_check_aggr=>t_list( ( lines of previous_errors->untyped_list( ) )
                                                                                                            ( lines of new_errors->untyped_list( ) ) ) ) ).

  endmethod.
  method append_initializes_inst_1.

    "arrange
    final(result_of_from) = new zcx_static_check_aggr( value #( ) ).

    final(o) = new _stc_exc_aggr_fty_from_stub( result_of_from ).

    final(new_errors) = new zcx_static_check_aggr( value #( let random_generator = cl_abap_random=>create( cl_abap_random=>seed( ) ) in
                                                            for i = 0 until i gt random_generator->intinrange( low = 2
                                                                                                               high = 50 )
                                                            ( cast #( cl_abap_testdouble=>create( 'ZCX_NO_CHECK' ) ) ) ) ).

    "act & assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->append( i_exceptions = new_errors
                                                          i_to_previous = value #( ) ) eq result_of_from
                                               and o->captured_list eq new_errors->untyped_list( ) ) ).

  endmethod.
  method append_initializes_inst_2.

    "arrange
    final(result_of_from) = new zcx_static_check_aggr( value #( ) ).

    final(o) = new _stc_exc_aggr_fty_from_stub( result_of_from ).

    final(old_errors) = new zcx_static_check_aggr( value #( let random_generator = cl_abap_random=>create( cl_abap_random=>seed( ) ) in
                                                            for i = 0 until i gt random_generator->intinrange( low = 2
                                                                                                               high = 50 )
                                                            ( cast #( cl_abap_testdouble=>create( 'ZCX_NO_CHECK' ) ) ) ) ).

    "act & assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->append( i_exceptions = value #( )
                                                          i_to_previous = old_errors ) eq result_of_from
                                               and o->captured_list eq old_errors->untyped_list( ) ) ).

  endmethod.

endclass.
