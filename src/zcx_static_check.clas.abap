"! <p class="shorttext synchronized" lang="EN">Excs. with Static Check of RAISING Clause with t100 message</p>
class zcx_static_check definition
                       public
                       inheriting from cx_static_check
                       create public.

  public section.

    interfaces: if_t100_message.

    "! <p class="shorttext synchronized" lang="EN">Creates an exception. Can use a t100 msg</p>
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

endclass.
class zcx_static_check implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    me->textid = value #( ).

    if i_t100_message is supplied.

      cl_message_helper=>set_msg_vars_for_if_t100_msg( i_t100_message ).

      me->var1 = sy-msgv1.

      me->var2 = sy-msgv2.

      me->var3 = sy-msgv3.

      me->var4 = sy-msgv4.

      me->if_t100_message~t100key = value #( msgid = sy-msgid
                                             msgno = sy-msgno
                                             attr1 = 'VAR1'
                                             attr2 = 'VAR2'
                                             attr3 = 'VAR3'
                                             attr4 = 'VAR4' ).

    else.

      me->if_t100_message~t100key = if_t100_message=>default_textid.

    endif.

  endmethod.

endclass.
