"! <p class="shorttext synchronized" lang="EN">Stack Trace Factory</p>
class zcl_exc_stack_trace_fty definition
                              public
                              create public.

  public section.

    class-methods class_constructor.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_caller_name | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods get
              importing
                i_caller_name like if_xco_ao_class=>name
              returning
                value(r_val) type ref to if_xco_cp_call_stack.

  protected section.

    class-data _exception_name_pattern type ref to cl_abap_regex.

    class-data _current_call_stack_fty type ref to object.

    class-data _adt_format_fty type ref to object.

    class-data _itab_filter_fty type ref to object.

endclass.
class zcl_exc_stack_trace_fty implementation.

  method class_constructor.

    _exception_name_pattern = cl_abap_regex=>create_pcre( `(?mi)^(CX_|\/.{3}\/CX_|[ZY]CX)` ).

    _current_call_stack_fty = new current_call_stack_fty( ).

    _adt_format_fty = new adt_format_fty( ).

    _itab_filter_fty = new itab_filter_fty( ).

  endmethod.
  method get.

    final(current_call_stack_fty) = cast current_call_stack_fty( _current_call_stack_fty ).

    final(adt_format_fty) = cast adt_format_fty( _adt_format_fty ).

    final(itab_filter_fty) = cast itab_filter_fty( _itab_filter_fty ).

    final(full_trace) = current_call_stack_fty->get( )->full( ).

    final(trace_excluding_int_procedures) = full_trace->from->position( 2 ).

    final(filterable_trace) = trace_excluding_int_procedures->as_text( adt_format_fty->get( ) )->get_lines( )->value.

    final(last_exception_subclass) = itab_filter_fty->for( filterable_trace )->last_consecutive( _exception_name_pattern ).

    return trace_excluding_int_procedures->from->position( last_exception_subclass + 1 ).

  endmethod.

endclass.
