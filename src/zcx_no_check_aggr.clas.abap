"! <p class="shorttext synchronized" lang="EN">No check aggregate error</p>
"!
"! <p>Contains a collection of errors.</p>
"! <p>Inherits from {@link ZCX_NO_CHECK}</p>
class zcx_no_check_aggr definition
                        public
                        inheriting from zcx_no_check
                        create public.

  public section.

    types:
           "! <p class="shorttext synchronized" lang="EN">Any errors</p>
           t_list type standard table of ref to cx_root with empty key.

    constants:
               "! <p class="shorttext synchronized" lang="EN">Default message</p>
               "! Reads as "Several errors occurred"
               begin of zcx_no_check_aggr,
                 msgid type symsgid value 'ZEXC',
                 msgno type symsgno value '002',
                 attr1 type scx_attrname value is initial,
                 attr2 type scx_attrname value is initial,
                 attr3 type scx_attrname value is initial,
                 attr4 type scx_attrname value is initial,
               end of zcx_no_check_aggr.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter i_t100_message | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_list | <p class="shorttext synchronized" lang="EN">Mandatory collection of errors</p>
    methods constructor
              importing
                i_t100_message type ref to if_t100_message optional
                i_previous like previous optional
                i_list type zcx_no_check_aggr=>t_list.

    "! <p class="shorttext synchronized" lang="EN">Returns all errors typed as CX_ROOT</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods untyped_list
              returning
                value(r_val) type zcx_no_check_aggr=>t_list.

    "! <p class="shorttext synchronized" lang="EN">Returns the number of errors contained in this object</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods size
              returning
                value(r_val) type i.

    "! <p class="shorttext synchronized" lang="EN">Returns true when the collection of errors is empty</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods is_empty
              returning
                value(r_val) type xsdboolean.

    methods default_message_vars redefinition.

  protected section.

    data _list type zcx_no_check_aggr=>t_list.

endclass.
class zcx_no_check_aggr implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( i_t100_message = i_t100_message
                        i_previous = i_previous ).

    _list = i_list.

  endmethod.
  method untyped_list.

    return _list.

  endmethod.
  method is_empty.

    return xsdbool( size( ) eq 0 ).

  endmethod.
  method size.

    return lines( untyped_list( ) ).

  endmethod.
  method default_message_vars.

    return value #( msgid = zcx_no_check_aggr-msgid
                    msgno = zcx_no_check_aggr-msgno ).

  endmethod.

endclass.
