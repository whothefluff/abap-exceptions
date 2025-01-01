*"* use this source file for your ABAP unit test classes

class _no_check_aggr_size_stub definition ##CLASS_FINAL
                               inheriting from zcx_no_check_aggr
                               create public
                               for testing.

  public section.

    types t_canned_answer type i.

    methods constructor
              importing
                i_canned_answer type _no_check_aggr_size_stub=>t_canned_answer.

    methods size redefinition.

  protected section.

    data _canned_answer type _no_check_aggr_size_stub=>t_canned_answer.

endclass.
class _no_check_aggr_size_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method size.

    return _canned_answer.

  endmethod.

endclass.

class _no_check_aggr_list_stub definition ##CLASS_FINAL
                               inheriting from zcx_no_check_aggr
                               create public
                               for testing.

  public section.

    types t_canned_answer type zcx_no_check_aggr=>t_list.

    methods constructor
              importing
                i_canned_answer type _no_check_aggr_list_stub=>t_canned_answer.

    methods untyped_list redefinition.

  protected section.

    data _canned_answer type _no_check_aggr_list_stub=>t_canned_answer.

endclass.
class _no_check_aggr_list_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _canned_answer = i_canned_answer.

  endmethod.
  method untyped_list.

    return _canned_answer.

  endmethod.

endclass.

class _ definition deferred.

class zcx_no_check_aggr definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    methods constructor_sets_attr for testing.

    methods untyped_list_rets_attr for testing.

    methods is_empty_rets_true_for_no_size for testing.

    methods is_empty_rets_false_for_size for testing.

    methods size_rets_lines_of_list for testing.

    methods default_message_vars_returns for testing.

endclass.
class _ implementation.

  method constructor_sets_attr.

    "arrange
    final(some_list) = value zcx_no_check_aggr=>t_list( ( cast #( cl_abap_testdouble=>create( 'ZCX_NO_CHECK' ) ) )
                                                        ( ) ).

    "act
    final(o) = new zcx_no_check_aggr( some_list ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = some_list
                                        act = o->_list ).

  endmethod.
  method untyped_list_rets_attr.

    "arrange
    final(o) = new zcx_no_check_aggr( value #( ) ).

    final(some_list) = value zcx_no_check_aggr=>t_list( ( cast #( cl_abap_testdouble=>create( 'ZCX_NO_CHECK' ) ) )
                                                        ( ) ).

    o->_list = some_list.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_list
                                        act = o->untyped_list( ) ).

  endmethod.
  method is_empty_rets_true_for_no_size.

    "arrange
    final(o) = new _no_check_aggr_size_stub( 0 ).

    "act & assert
    cl_abap_unit_assert=>assert_true( o->is_empty( ) ).

  endmethod.
  method is_empty_rets_false_for_size.

    "arrange
    final(o) = new _no_check_aggr_size_stub( 1 ).

    "act & assert
    cl_abap_unit_assert=>assert_false( o->is_empty( ) ).

  endmethod.
  method size_rets_lines_of_list.

    "arrange
    final(some_list) = value _no_check_aggr_list_stub=>t_canned_answer( ( )
                                                                        ( cast #( cl_abap_testdouble=>create( 'ZCX_STATIC_CHECK' ) ) )
                                                                        ( ) ).

    final(o) = new _no_check_aggr_list_stub( some_list ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = 3
                                        act = o->size( ) ).

  endmethod.
  method default_message_vars_returns.

    "arrange
    final(o) = new zcx_no_check_aggr( value #( ) ).

    "act & assert
    cl_abap_unit_assert=>assert_not_initial( o->default_message_vars( ) ).

  endmethod.

endclass.
