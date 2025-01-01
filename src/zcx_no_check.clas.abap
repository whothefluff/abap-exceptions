"! <p class="shorttext synchronized" lang="EN">Excs. with No Check of RAISING Clause with t100 message</p>
"!
"! Inherits from {@link CX_NO_CHECK}
class zcx_no_check definition
                   public
                   inheriting from cx_no_check
                   create public.

  public section.

    interfaces: if_abap_behv_message,
                if_xco_message.

    types t_text type c length 200.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN">Creates an exception. Can use a t100 msg</p>
    "!
    "! @parameter i_t100_message | <p class="shorttext synchronized" lang="EN">t100 message</p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_t100_message type ref to if_t100_message optional
                i_previous like previous optional
                preferred parameter i_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Returns this exception's message variables</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods message_variables
              returning
                value(r_val) type symsg.

    "! <p class="shorttext synchronized" lang="EN">Returns this exception's text</p>
    "!
    "! String version of {@link .meth:C_TEXT}
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Exception text</p>
    methods text
              returning
                value(r_val) type string.

    "! <p class="shorttext synchronized" lang="EN">Returns this exception's text</p>
    "!
    "! Char version of {@link .meth:TEXT}
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Exception text</p>
    methods c_text
              returning
                value(r_val) type zcx_no_check=>t_text.

    "! <p class="shorttext synchronized" lang="EN">Returns the sequence of calls leading to this exception</p>
    "!
    "! <p>
    "! This method has a limitation: it will start from the repository
    "! object that contains an exception class with a name that doesn't
    "! use the typical CX prefix.
    "! </p>
    "! <p>
    "! This applies in particular to local classes. It's probably not
    "! worth the extra compute needed to fix this
    "! </p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Call stack</p>
    methods stack_trace
              returning
                value(r_val) type ref to if_xco_cp_call_stack.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods default_message_vars
              returning
                value(r_val) type symsg.

  protected section.

    class-data _type_severities type ref to zcl_msg_type_severity_pairs.

    class-data _stack_trace_fty type ref to zcl_exc_stack_trace_fty.

    class-data _msg_vars_reader type ref to zcl_msg_vars_reader.

    class-data _xco_msg_fty type ref to zcl_xco_msg_fty.

    data _stack_trace type ref to if_xco_cp_call_stack.

    data _xco_message type ref to if_xco_message.

endclass.
class zcx_no_check implementation.

  method class_constructor.

    _type_severities = new zcl_msg_type_severity_pairs( i_severity_of_default = if_abap_behv_message=>severity-error
                                                        i_type_of_default = xco_cp_message=>type->error->value ).

    _stack_trace_fty = new zcl_exc_stack_trace_fty( ).

    _msg_vars_reader = new zcl_msg_vars_reader( _type_severities ).

    _xco_msg_fty = new zcl_xco_msg_fty( ).

  endmethod.
  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    textid = value #( ).

    _stack_trace = _stack_trace_fty->get( 'ZCX_NO_CHECK' ).

    final(msg_vars) = _msg_vars_reader->safe_read( i_fallback = default_message_vars( )
                                                   i_msg = i_t100_message ).

    if_abap_behv_message~m_severity = _type_severities->severity_of( msg_vars-msgty ).

    final(xco_msg) = _xco_msg_fty->for( msg_vars ).

    xco_msg->write_to_t100_dyn_msg( me ).

    if_xco_message~value = xco_msg->value.

    _xco_message = xco_msg.

  endmethod.
  method if_xco_news~get_messages.

    return cast if_xco_news( _xco_message )->get_messages( ).

  endmethod.
  method if_xco_message~get_short_text.

    return _xco_message->get_short_text( ).

  endmethod.
  method if_xco_message~get_text.

    return _xco_message->get_text( ).

  endmethod.
  method if_xco_message~get_type.

    return _xco_message->get_type( ).

  endmethod.
  method if_xco_message~overwrite.

    return _xco_message->overwrite( iv_msgty = iv_msgty
                                    iv_msgid = iv_msgid
                                    iv_msgno = iv_msgno
                                    iv_msgv1 = iv_msgv1
                                    iv_msgv2 = iv_msgv2
                                    iv_msgv3 = iv_msgv3
                                    iv_msgv4 = iv_msgv4 ).

  endmethod.
  method if_xco_message~place_string.

    return _xco_message->place_string( iv_string = iv_string
                                       iv_msgv1 = iv_msgv1
                                       iv_msgv2 = iv_msgv2
                                       iv_msgv3 = iv_msgv3
                                       iv_msgv4 = iv_msgv4 ).

  endmethod.
  method if_xco_message~write_to_t100_dyn_msg.

    _xco_message->write_to_t100_dyn_msg( io_t100_dyn_msg ).

  endmethod.
  method message_variables.

    return if_xco_message~value.

  endmethod.
  method text.

    return me->if_message~get_text( ).

  endmethod.
  method c_text.

    return me->if_message~get_text( ).

  endmethod.
  method stack_trace.

    return _stack_trace.

  endmethod.
  method default_message_vars.

    return corresponding #( if_t100_message=>default_textid
                            mapping msgid = msgid
                                    msgno = msgno
                            except * ).

  endmethod.

endclass.
