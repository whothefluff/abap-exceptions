"! <p class="shorttext synchronized" lang="EN">Excs. with No Check of RAISING Clause with t100 message</p>
class zcx_no_check definition
                   public
                   inheriting from cx_no_check
                   create public.

  public section.

    interfaces: if_t100_dyn_msg.

    "! <p class="shorttext synchronized" lang="EN">Creates an exception. Can use a t100 msg</p>
    "!
    "! @parameter i_t100_message | <p class="shorttext synchronized" lang="EN">t100 message</p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_t100_message type ref to if_t100_message optional
                i_previous like previous optional
                preferred parameter i_t100_message.

endclass.
class zcx_no_check implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    me->textid = value #( ).

    if i_t100_message is supplied.

      case type of i_t100_message.

        when type if_t100_dyn_msg into data(dyn).

          me->if_t100_dyn_msg~msgty = dyn->msgty.

          me->if_t100_dyn_msg~msgv1 = dyn->msgv1.

          me->if_t100_dyn_msg~msgv2 = dyn->msgv2.

          me->if_t100_dyn_msg~msgv3 = dyn->msgv3.

          me->if_t100_dyn_msg~msgv4 = dyn->msgv4.

        when others.

          cl_message_helper=>set_msg_vars_for_if_t100_msg( i_t100_message ).

          me->if_t100_dyn_msg~msgv1 = sy-msgv1.

          me->if_t100_dyn_msg~msgv2 = sy-msgv2.

          me->if_t100_dyn_msg~msgv3 = sy-msgv3.

          me->if_t100_dyn_msg~msgv4 = sy-msgv4.

          me->if_t100_dyn_msg~msgty = 'E'.

      endcase.

      me->if_t100_message~t100key = value #( msgid = i_t100_message->t100key-msgid
                                             msgno = i_t100_message->t100key-msgno
                                             attr1 = 'IF_T100_DYN_MSG~MSGV1'
                                             attr2 = 'IF_T100_DYN_MSG~MSGV2'
                                             attr3 = 'IF_T100_DYN_MSG~MSGV3'
                                             attr4 = 'IF_T100_DYN_MSG~MSGV4' ).

    else.

      me->if_t100_message~t100key = if_t100_message=>default_textid.

    endif.

  endmethod.

endclass.
