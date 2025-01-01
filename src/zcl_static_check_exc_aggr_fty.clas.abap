"! <p class="shorttext synchronized" lang="EN">Static-Check Aggregate Error Factory</p>
class zcl_static_check_exc_aggr_fty definition
                                    public
                                    create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Returns a new exception aggregate</p>
    "!
    "! <p>Returns null for empty lists</p>
    "!
    "! Wraps un-mockable behavior
    "!
    "! @parameter i_list | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods from
              importing
                i_list type zcx_static_check_aggr=>t_list
              returning
                value(r_val) type ref to zcx_static_check_aggr.

    "! <p class="shorttext synchronized" lang="EN">Returns a new exception aggregate by adding errors together</p>
    "!
    "! It only makes sense to use this method if you can guaranty that
    "! {@link .meth:APPEND.data:I_EXCEPTIONS} and
    "! {@link .meth:APPEND.data:I_TO_PREVIOUS} are valid references,
    "! otherwise it will just work as a duplicate of the one that is a
    "! valid instance.
    "!
    "! @parameter i_to_previous | <p class="shorttext synchronized" lang="EN">Some errors</p>
    "! @parameter i_exceptions | <p class="shorttext synchronized" lang="EN">New errors to add</p>
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN"></p>
    methods append
              importing
                i_to_previous type ref to zcx_static_check_aggr
                i_exceptions type ref to zcx_static_check_aggr
              returning
                value(r_val) type ref to zcx_static_check_aggr.

  protected section.

endclass.
class zcl_static_check_exc_aggr_fty implementation.

  method from.

    return cond #( when i_list is not initial
                   then new zcx_static_check_aggr( i_list ) ).

  endmethod.
  method append.

    return from( value #( let previous_list = cond #( when i_to_previous is bound
                                                      then i_to_previous->untyped_list( ) )
                              list_to_append = cond #( when i_exceptions is bound
                                                       then i_exceptions->untyped_list( ) ) in
                          ( lines of previous_list )
                          ( lines of list_to_append ) ) ).

  endmethod.

endclass.
