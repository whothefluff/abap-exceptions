"! <p class="shorttext synchronized" lang="EN">Subclass with name in usual pattern</p>
class zcx_named_by_convention definition
                              public
                              inheriting from zcx_static_check
                              create public
                              for testing.

  public section.

    methods constructor.

  protected section.

endclass.
class zcx_named_by_convention implementation.

  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( i_t100_message = value #( ) ).

  endmethod.

endclass.
