"! <p class="shorttext synchronized" lang="EN">Integration Testing</p>
"!
"! @testing ZCX_NO_CHECK
"! @testing ZCX_STATIC_CHECK
"! @testing ZCL_EXCEPTION_READER
"! @testing ZCL_NO_CHECK_EXC_AGGR_FTY
"! @testing ZCL_STATIC_CHECK_EXC_AGGR_FTY
class zcl_exceptions_it definition
                        public
                        final
                        create private
                        for testing
                        risk level harmless
                        duration short.

  public section.

    methods no_check_exc_t100_text for testing.

    methods no_check_exc_t100_dyn_text for testing.

    methods static_check_exc_t100_text for testing.

    methods static_check_exc_t100_dyn_text for testing.

    methods reader_uses_index for testing.

    methods reader_uses_depth for testing.

    methods subexc_rets_good_stack for testing.

    methods subexc_rets_basic_stack for testing.

    methods no_check_aggr_fty_rets_inst for testing.

    methods static_chk_aggr_fty_rets_inst for testing.

endclass.
class zcl_exceptions_it implementation.

  method no_check_exc_t100_text.

    "arrange
    try.

      raise exception new cx_abap_auth_check_exception( textid = cx_abap_auth_check_exception=>unsupported_value_range
                                                        message_prefix = `pre` ).

    catch cx_abap_auth_check_exception into final(t100_msg) ##NO_HANDLER.

    endtry.

    "act
    final(e) = new zcx_no_check( t100_msg ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t100_msg->get_text( )
                                        act = e->text( ) ).

  endmethod.
  method no_check_exc_t100_dyn_text.

    "arrange
    try.

      raise exception type cx_abap_api_state message e001(ZEXC) with 1 2 3 4.

    catch cx_abap_api_state into final(t100_msg) ##NO_HANDLER.

    endtry.

    "act
    final(e) = new zcx_no_check( t100_msg ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t100_msg->get_text( )
                                        act = e->text( ) ).

  endmethod.
  method static_check_exc_t100_text.

    "arrange
    try.

      raise exception new cx_abap_auth_check_exception( textid = cx_abap_auth_check_exception=>unsupported_value_range
                                                        message_prefix = `pre` ).

    catch cx_abap_auth_check_exception into final(t100_msg) ##NO_HANDLER.

    endtry.

    "act
    final(e) = new zcx_static_check( t100_msg ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t100_msg->get_text( )
                                        act = e->text( ) ).

  endmethod.
  method static_check_exc_t100_dyn_text.

    "arrange
    try.

      raise exception type cx_abap_api_state message e001(ZEXC) with 1 2 3 4.

    catch cx_abap_api_state into final(t100_msg) ##NO_HANDLER.

    endtry.

    "act
    final(e) = new zcx_static_check( t100_msg ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = t100_msg->get_text( )
                                        act = e->text( ) ).

  endmethod.
  method reader_uses_index.

    "arrange
    final(cause) = new zcx_static_check( ).

    final(e) = new zcx_no_check( i_previous = cause ).

    final(reader) = new zcl_exception_reader( e ).

    "act & assert
    cl_abap_unit_assert=>assert_true( xsdbool( reader->first( )-exc eq e
                                               and reader->last( )-exc eq cause ) ).

  endmethod.
  method reader_uses_depth.

    "arrange
    final(cause) = new zcx_static_check( ).

    final(e) = new zcx_no_check( i_previous = cause ).

    final(reader) = new zcl_exception_reader( e ).

    "act & assert
    cl_abap_unit_assert=>assert_true( xsdbool( reader->deepest( )-exc eq e
                                               and reader->shallowest( )-exc eq cause ) ).

  endmethod.
  method subexc_rets_good_stack.

    "act
    try.

      raise exception new zcx_named_by_convention( ).

    catch zcx_named_by_convention into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value string_table( ( `ZCL_EXCEPTIONS_IT    subexc_rets_good_stack [method]` ) )
                                        act = value string_table( let st = e->stack_trace( )->as_text( xco_cp_call_stack=>format->adt( ) )->get_lines( )->value in
                                                                  ( st[ 1 ] ) ) ).

  endmethod.
  method subexc_rets_basic_stack.

    "act
    try.

      raise exception new zcl_exc_wrongly_named( ).

    catch zcl_exc_wrongly_named into final(e).

    endtry.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = value string_table( ( `ZCL_EXC_WRONGLY_NAMED    constructor [method]` ) )
                                        act = value string_table( let st = e->stack_trace( )->as_text( xco_cp_call_stack=>format->adt( ) )->get_lines( )->value in
                                                                  ( st[ 1 ] ) ) ).

  endmethod.
  method no_check_aggr_fty_rets_inst.

    "arrange
    final(o) = new zcl_no_check_exc_aggr_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->from( value #( ( ) ) ) ).

  endmethod.
  method static_chk_aggr_fty_rets_inst.

    "arrange
    final(o) = new zcl_static_check_exc_aggr_fty( ).

    "act & assert
    cl_abap_unit_assert=>assert_bound( o->from( value #( ( ) ) ) ).

  endmethod.

endclass.
