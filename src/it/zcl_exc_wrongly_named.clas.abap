"! <p class="shorttext synchronized" lang="EN">Subclass with name in innovative pattern</p>
class zcl_exc_wrongly_named definition
                            public
                            inheriting from zcx_static_check
                            create public
                            for testing.

  public section.

    methods constructor.

  protected section.

endclass.
class zcl_exc_wrongly_named implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( i_t100_message = value #( ) ).

  endmethod.

endclass.
