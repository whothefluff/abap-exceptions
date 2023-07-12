"! <p class="shorttext synchronized" lang="EN">Excs. with No Check of RAISING Clause with t100 message</p>
class zcx_no_check definition
                   public
                   inheriting from cx_no_check
                   create public.

  public section.

    interfaces: if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Create an exception. Can use either a t100 msg or a text ID</p>
    "! Providing <strong>both</strong> text parameters will result in a <strong>short dump</strong>
    "!
    "! @parameter i_t100_message | <p class="shorttext synchronized" lang="EN">t100 message</p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_t100_message type ref to if_t100_message optional
                i_previous like previous optional
                preferred parameter i_t100_message.

    data var1 type sy-msgv1 read-only.

    data var2 type sy-msgv2 read-only.

    data var3 type sy-msgv4 read-only.

    data var4 type sy-msgv4 read-only.

  protected section.

    methods load_message_in_sy_structure
              importing
                i_t100_message type ref to if_t100_message
              returning
                value(r_self) type ref to zcx_no_check.

endclass.
class zcx_no_check implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    me->textid = value #( ).

    if i_t100_message is supplied.

      me->load_message_in_sy_structure( i_t100_message ).

      me->var1 = sy-msgv1.

      me->var2 = sy-msgv2.

      me->var3 = sy-msgv3.

      me->var4 = sy-msgv4.

      me->if_t100_message~t100key = cond #( when i_t100_message is not initial
                                            then value #( msgid = sy-msgid
                                                          msgno = sy-msgno
                                                          attr1 = 'VAR1'
                                                          attr2 = 'VAR2'
                                                          attr3 = 'VAR3'
                                                          attr4 = 'VAR4' )
                                            else if_t100_message=>default_textid ).

    else.

      me->if_t100_message~t100key = if_t100_message=>default_textid.

    endif.

  endmethod.
  method load_message_in_sy_structure.

    cl_message_helper=>get_text_for_message( i_t100_message ).

    r_self = me.

  endmethod.

endclass.
