*"* use this source file for your ABAP unit test classes

class _msg_vars_reader_safe_r_stub definition ##CLASS_FINAL
                                   inheriting from zcl_msg_vars_reader
                                   create public
                                   for testing.

  public section.

    types: begin of t_args,
             begin of expected,
               msg type ref to if_message,
               fallback type symsg,
             end of expected,
             canned_answer type symsg,
           end of t_args.

    types: begin of t_last_call_args,
             msg type ref to if_message,
             fallback type symsg,
           end of t_last_call_args.

    types t_canned_answer type symsg.

    methods constructor
              importing
                i_args type _msg_vars_reader_safe_r_stub=>t_args.

    methods safe_read redefinition.

  protected section.

    data _args type _msg_vars_reader_safe_r_stub=>t_args.

endclass.
class _msg_vars_reader_safe_r_stub implementation.

  method constructor.

    super->constructor( value #( ) ).

    _args = i_args.

  endmethod.
  method safe_read.

    return cond #( when i_fallback eq _args-expected-fallback
                        and i_msg eq _args-expected-msg
                   then _args-canned_answer ).

  endmethod.

endclass.

class _xco_message_spy definition ##CLASS_FINAL
                       create public
                       for testing.

  public section.

    interfaces: if_xco_message partially implemented.

    data last_t100_dyn_msg type ref to if_t100_dyn_msg read-only.

endclass.
class _xco_message_spy implementation.

  method if_xco_message~write_to_t100_dyn_msg.

    last_t100_dyn_msg = io_t100_dyn_msg.

  endmethod.

endclass.

class _xco_msg_value_stub definition ##CLASS_FINAL
                          create public
                          for testing.

  public section.

    interfaces: if_xco_message partially implemented.

    methods constructor
              importing
                i_val type symsg.

endclass.
class _xco_msg_value_stub implementation.

  method constructor.

    if_xco_message~value = i_val.

  endmethod.
  method if_xco_message~write_to_t100_dyn_msg.

    return.

  endmethod.

endclass.

class _ definition deferred.

class zcx_static_check definition local friends _.

"! <p class="shorttext synchronized" lang="EN">Tests</p>
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  private section.

    class-methods class_setup.

    methods setup.

    methods const_sets_attr for testing.

    "! Verifies a side-effect, which is why it's a separate test
    methods const_calls_xco_wtm_w_self for testing.

    methods xco_get_messages_delegates for testing.

    methods xco_get_short_text_delegates for testing.

    methods xco_get_text_delegates for testing.

    methods xco_get_type_delegates for testing.

    methods xco_overwrite_delegates for testing.

    methods xco_place_string_delegates for testing.

    methods xco_write_to_t100dyn_delegates for testing.

    methods stack_trace_returns_attribute for testing.

    methods msg_vars_rets_xco_msg_value for testing.

    methods text_returns_same_as_msg_stmt for testing.

    methods ctext_returns_same_as_msg_stmt for testing.

    methods default_message_vars_returns for testing.

    class-methods class_teardown.

    class-data _type_severities_backup type ref to zcl_msg_type_severity_pairs.

    class-data _stack_trace_fty_backup type ref to zcl_exc_stack_trace_fty.

    class-data _msg_vars_reader_backup type ref to zcl_msg_vars_reader.

    class-data _xco_msg_fty_backup type ref to zcl_xco_msg_fty.

endclass.
class _ implementation.

  method class_setup.

    _type_severities_backup = zcx_static_check=>_type_severities.

    _stack_trace_fty_backup = zcx_static_check=>_stack_trace_fty.

    _msg_vars_reader_backup = zcx_static_check=>_msg_vars_reader.

    _xco_msg_fty_backup = zcx_static_check=>_xco_msg_fty.

  endmethod.
  method setup.

    zcx_static_check=>_type_severities = _type_severities_backup.

    zcx_static_check=>_stack_trace_fty = _stack_trace_fty_backup.

    zcx_static_check=>_msg_vars_reader = _msg_vars_reader_backup.

    zcx_static_check=>_xco_msg_fty = _xco_msg_fty_backup.

  endmethod.
  method const_sets_attr.

    "arrange
    final(some_msg_vars) = value symsg( msgv2 = `...` ).

    final(some_msg) = cast if_t100_message( cl_abap_testdouble=>create( 'IF_T100_MESSAGE' ) ).

    final(fb) = new zcx_static_check( )->default_message_vars( ).

    final(reader_stub) = new _msg_vars_reader_safe_r_stub( value #( expected = value #( msg = some_msg
                                                                                        fallback = fb )
                                                                    canned_answer = some_msg_vars ) ).

    zcx_static_check=>_msg_vars_reader = reader_stub.

    final(some_stack) = cast if_xco_cp_call_stack( cl_abap_testdouble=>create( 'IF_XCO_CP_CALL_STACK' ) ).

    final(some_stack_fty) = cast zcl_exc_stack_trace_fty( cl_abap_testdouble=>create( 'ZCL_EXC_STACK_TRACE_FTY' ) ).

    cl_abap_testdouble=>configure_call( some_stack_fty )->returning( some_stack ).

    some_stack_fty->get( conv #( cl_abap_typedescr=>describe_by_object_ref( new zcx_static_check( ) )->get_relative_name( ) ) ).

    zcx_static_check=>_stack_trace_fty = some_stack_fty.

    final(some_severity) = if_abap_behv_message=>severity-warning.

    final(some_type_sevs) = cast zcl_msg_type_severity_pairs( cl_abap_testdouble=>create( 'ZCL_MSG_TYPE_SEVERITY_PAIRS' ) ).

    cl_abap_testdouble=>configure_call( some_type_sevs )->returning( some_severity ).

    some_type_sevs->severity_of( some_msg_vars-msgty ).

    zcx_static_check=>_type_severities = some_type_sevs.

    final(some_xco_msg) = cast if_xco_message( new _xco_msg_value_stub( some_msg_vars ) ).

    final(some_xco_msg_fty) = cast zcl_xco_msg_fty( cl_abap_testdouble=>create( 'ZCL_XCO_MSG_FTY' ) ).

    cl_abap_testdouble=>configure_call( some_xco_msg_fty )->returning( some_xco_msg ).

    some_xco_msg_fty->for( some_msg_vars ).

    zcx_static_check=>_xco_msg_fty = some_xco_msg_fty.

    final(previous) = cast cx_root( cl_abap_testdouble=>create( 'CX_STATIC_CHECK' ) ).

    "act
    final(o) = new zcx_static_check( i_previous = previous
                                     i_t100_message = some_msg ).

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( o->_stack_trace eq some_stack
                                               and o->if_abap_behv_message~m_severity eq some_severity
                                               and o->_xco_message eq some_xco_msg
                                               and o->previous eq previous
                                               and o->textid is initial
                                               and o->if_xco_message~value eq some_msg_vars ) ).

  endmethod.
  method const_calls_xco_wtm_w_self.

    "arrange
    final(some_msg_vars) = value symsg( msgv2 = `...` ).

    final(fb) = new zcx_static_check( )->default_message_vars( ).

    final(some_msg_vars_reader) = new _msg_vars_reader_safe_r_stub( value #( expected = value #( fallback = fb )
                                                                             canned_answer = some_msg_vars ) ).

    zcx_static_check=>_msg_vars_reader = some_msg_vars_reader.

    final(some_xco_msg_fty) = cast zcl_xco_msg_fty( cl_abap_testdouble=>create( 'ZCL_XCO_MSG_FTY' ) ).

    final(xco_spy) = new _xco_message_spy( ).

    cl_abap_testdouble=>configure_call( some_xco_msg_fty )->returning( xco_spy ).

    some_xco_msg_fty->for( some_msg_vars ).

    zcx_static_check=>_xco_msg_fty = some_xco_msg_fty.

    "act
    final(o) = new zcx_static_check( ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = o
                                        act = xco_spy->last_t100_dyn_msg ).

  endmethod.
  method xco_get_messages_delegates.

    "arrange
    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(some_messages) = value sxco_t_messages( ( xco_stub ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_messages )->and_expect( )->is_called_once( ).

    xco_stub->if_xco_news~get_messages( ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_messages
                                        act = cast if_xco_news( e )->get_messages( ) ).

  endmethod.
  method xco_get_short_text_delegates.

    "arrange
    final(some_short_text) = cast if_xco_message_short_text( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE_SHORT_TEXT' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_short_text )->and_expect( )->is_called_once( ).

    xco_stub->get_short_text( ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_short_text
                                        act = cast if_xco_message( e )->get_short_text( ) ).

  endmethod.
  method xco_get_text_delegates.

    "arrange
    final(some_text) = `ads asdfkajñklñ jñkljaj`.

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_text )->and_expect( )->is_called_once( ).

    xco_stub->get_text( ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_text
                                        act = cast if_xco_message( e )->get_text( ) ).

  endmethod.
  method xco_get_type_delegates.

    "arrange
    final(some_type) = xco_cp_message=>type->for( 'S' ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_type )->and_expect( )->is_called_once( ).

    xco_stub->get_type( ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_type
                                        act = cast if_xco_message( e )->get_type( ) ).

  endmethod.
  method xco_overwrite_delegates.

    "arrange
    final(some_ovrwrt_msg) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(some_msgty) = 'Z'.

    final(some_msgid) = conv symsgid( 'TEST' ).

    final(some_msgno) = conv symsgno( '123' ).

    final(some_msgv1) = conv symsgv( 'V1' ).

    final(some_msgv2) = conv symsgv( 'V2' ).

    final(some_msgv3) = conv symsgv( 'V3' ).

    final(some_msgv4) = conv symsgv( 'V4' ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_ovrwrt_msg ).

    xco_stub->overwrite( iv_msgty = some_msgty
                         iv_msgid = some_msgid
                         iv_msgno = some_msgno
                         iv_msgv1 = some_msgv1
                         iv_msgv2 = some_msgv2
                         iv_msgv3 = some_msgv3
                         iv_msgv4 = some_msgv4 ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_ovrwrt_msg
                                        act = cast if_xco_message( e )->overwrite( iv_msgty = some_msgty
                                                                                   iv_msgid = some_msgid
                                                                                   iv_msgno = some_msgno
                                                                                   iv_msgv1 = some_msgv1
                                                                                   iv_msgv2 = some_msgv2
                                                                                   iv_msgv3 = some_msgv3
                                                                                   iv_msgv4 = some_msgv4 ) ).

  endmethod.
  method xco_place_string_delegates.

    "arrange
    final(some_string) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->returning( some_string ).

    final(some_input) = `Test string`.

    xco_stub->place_string( iv_string = some_input
                            iv_msgv1 = conv #( 1 )
                            iv_msgv2 = conv #( 2 )
                            iv_msgv3 = conv #( 3 )
                            iv_msgv4 = conv #( 4 ) ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_string
                                        act = cast if_xco_message( e )->place_string( iv_string = some_input
                                                                                      iv_msgv1 = '1'
                                                                                      iv_msgv2 = '2'
                                                                                      iv_msgv3 = '3'
                                                                                      iv_msgv4 = '4' ) ).

  endmethod.
  method xco_write_to_t100dyn_delegates.

    "arrange
    final(xco_stub) = cast if_xco_message( cl_abap_testdouble=>create( 'IF_XCO_MESSAGE' ) ).

    cl_abap_testdouble=>configure_call( xco_stub )->and_expect( )->is_called_once( ).

    final(o) = new zcx_static_check( ).

    xco_stub->write_to_t100_dyn_msg( o ).

    final(e) = new zcx_static_check( ).

    e->_xco_message = xco_stub.

    "act
    cast if_xco_message( e )->write_to_t100_dyn_msg( o ).

    "assert
    cl_abap_testdouble=>verify_expectations( xco_stub ).

  endmethod.
  method stack_trace_returns_attribute.

    "arrange
    final(some_stack) = cast if_xco_cp_call_stack( cl_abap_testdouble=>create( 'IF_XCO_CP_CALL_STACK' ) ).

    final(e) = new zcx_static_check( ).

    e->_stack_trace = some_stack.

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = some_stack
                                        act = e->stack_trace( ) ).

  endmethod.
  method msg_vars_rets_xco_msg_value.

    "arrange
    final(o) = new zcx_static_check( ).

    o->if_xco_message~value = value #( msgv3 = `test` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = o->message_variables( )
                                        act = o->if_xco_message~value ).

  endmethod.
  method text_returns_same_as_msg_stmt.

    "arrange
    final(var1) = 'ex1'.

    final(var3) = 'ex2'.

    message e001(ZEXC) with var1 '' var3 into final(t).

    final(e) = new zcx_static_check( ).

    xco_cp=>message( value #( msgid = 'ZEXC'
                              msgno = 001
                              msgv1 = var1
                              msgv3 = var3 ) )->write_to_t100_dyn_msg( e ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t
                                        act = e->text( ) ).

  endmethod.
  method ctext_returns_same_as_msg_stmt.

    "arrange
    final(var1) = 'ex1'.

    final(var3) = 'ex2'.

    message e001(ZEXC) with var1 '' var3 into final(t).

    final(e) = new zcx_static_check( ).

    xco_cp=>message( value #( msgid = 'ZEXC'
                              msgno = 001
                              msgv1 = var1
                              msgv3 = var3 ) )->write_to_t100_dyn_msg( e ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t
                                        act = e->c_text( ) ).

  endmethod.
  method default_message_vars_returns.

    "arrange
    final(o) = new zcx_static_check( ).

    "act & assert
    cl_abap_unit_assert=>assert_not_initial( o->default_message_vars( ) ).

  endmethod.
  method class_teardown.

    zcx_static_check=>_type_severities = _type_severities_backup.

    zcx_static_check=>_stack_trace_fty = _stack_trace_fty_backup.

    zcx_static_check=>_msg_vars_reader = _msg_vars_reader_backup.

    zcx_static_check=>_xco_msg_fty = _xco_msg_fty_backup.

  endmethod.

endclass.
