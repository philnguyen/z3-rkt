#lang racket/base

(provide (all-defined-out))

(require ffi/unsafe
         racket/list
         "define-ffi.rkt")

(define _z3-ast-kind
  (_enum '(numeral-ast app-ast var-ast quantifier-ast sort-ast func-decl-ast unknown-ast = 1000) _int32))
(define _z3-param-kind (_enum '(pk-uint pk-bool pk-double pk-symbol pk-string pk-other pk-invalid) _int32))
(define _z3-symbol-kind (_enum '(int-symbol string-symbol) _int32))
(define _z3-search-failure
  (_enum '(no-failure unknown timeout memout-watermark canceled num-conflicts theory quantifiers) _int32))
(define _z3-goal-prec (_enum '(goal-precise goal-under goal-over goal-under-over) _int32))
(define _z3-parameter-kind
  (_enum
   '(parameter-int
     parameter-double
     parameter-rational
     parameter-symbol
     parameter-sort
     parameter-ast
     parameter-func-decl)
   _int32))
(define _z3-error-code
  (_enum
   '(ok
     sort-error
     iob
     invalid-arg
     parser-error
     no-parser
     invalid-pattern
     memout-fail
     file-access-error
     internal-fatal
     invalid-usage
     dec-ref-error
     exception)
   _int32))
(define _z3-ast-print-mode
  (_enum '(print-smtlib-full print-low-level print-smtlib-compliant print-smtlib2-compliant) _int32))
(define _z3-sort-kind
  (_enum
   '(uninterpreted-sort
     bool-sort
     int-sort
     real-sort
     bv-sort
     array-sort
     datatype-sort
     relation-sort
     finite-domain-sort
     floating-point-sort
     rounding-mode-sort
     unknown-sort
     =
     1000)
   _int32))
(define _z3-lbool (_enum '(l-false = -1 l-undef l-true) _int32))
(define _z3-decl-kind
  (_enum
   '(op-true
     =
     256
     op-false
     op-eq
     op-distinct
     op-ite
     op-and
     op-or
     op-iff
     op-xor
     op-not
     op-implies
     op-oeq
     op-interp
     op-anum
     =
     512
     op-agnum
     op-le
     op-ge
     op-lt
     op-gt
     op-add
     op-sub
     op-uminus
     op-mul
     op-div
     op-idiv
     op-rem
     op-mod
     op-to-real
     op-to-int
     op-is-int
     op-power
     op-store
     =
     768
     op-select
     op-const-array
     op-array-map
     op-array-default
     op-set-union
     op-set-intersect
     op-set-difference
     op-set-complement
     op-set-subset
     op-as-array
     op-bnum
     =
     1024
     op-bit1
     op-bit0
     op-bneg
     op-badd
     op-bsub
     op-bmul
     op-bsdiv
     op-budiv
     op-bsrem
     op-burem
     op-bsmod
     op-bsdiv0
     op-budiv0
     op-bsrem0
     op-burem0
     op-bsmod0
     op-uleq
     op-sleq
     op-ugeq
     op-sgeq
     op-ult
     op-slt
     op-ugt
     op-sgt
     op-band
     op-bor
     op-bnot
     op-bxor
     op-bnand
     op-bnor
     op-bxnor
     op-concat
     op-sign-ext
     op-zero-ext
     op-extract
     op-repeat
     op-bredor
     op-bredand
     op-bcomp
     op-bshl
     op-blshr
     op-bashr
     op-rotate-left
     op-rotate-right
     op-ext-rotate-left
     op-ext-rotate-right
     op-int2bv
     op-bv2int
     op-carry
     op-xor3
     op-pr-undef
     =
     1280
     op-pr-true
     op-pr-asserted
     op-pr-goal
     op-pr-modus-ponens
     op-pr-reflexivity
     op-pr-symmetry
     op-pr-transitivity
     op-pr-transitivity-star
     op-pr-monotonicity
     op-pr-quant-intro
     op-pr-distributivity
     op-pr-and-elim
     op-pr-not-or-elim
     op-pr-rewrite
     op-pr-rewrite-star
     op-pr-pull-quant
     op-pr-pull-quant-star
     op-pr-push-quant
     op-pr-elim-unused-vars
     op-pr-der
     op-pr-quant-inst
     op-pr-hypothesis
     op-pr-lemma
     op-pr-unit-resolution
     op-pr-iff-true
     op-pr-iff-false
     op-pr-commutativity
     op-pr-def-axiom
     op-pr-def-intro
     op-pr-apply-def
     op-pr-iff-oeq
     op-pr-nnf-pos
     op-pr-nnf-neg
     op-pr-nnf-star
     op-pr-cnf-star
     op-pr-skolemize
     op-pr-modus-ponens-oeq
     op-pr-th-lemma
     op-pr-hyper-resolve
     op-ra-store
     =
     1536
     op-ra-empty
     op-ra-is-empty
     op-ra-join
     op-ra-union
     op-ra-widen
     op-ra-project
     op-ra-filter
     op-ra-negation-filter
     op-ra-rename
     op-ra-complement
     op-ra-select
     op-ra-clone
     op-fd-lt
     op-label
     =
     1792
     op-label-lit
     op-dt-constructor
     =
     2048
     op-dt-recogniser
     op-dt-accessor
     op-dt-update-field
     op-pb-at-most
     =
     2304
     op-pb-le
     op-pb-ge
     op-fpa-rm-nearest-ties-to-even
     op-fpa-rm-nearest-ties-to-away
     op-fpa-rm-toward-positive
     op-fpa-rm-toward-negative
     op-fpa-rm-toward-zero
     op-fpa-num
     op-fpa-plus-inf
     op-fpa-minus-inf
     op-fpa-nan
     op-fpa-plus-zero
     op-fpa-minus-zero
     op-fpa-add
     op-fpa-sub
     op-fpa-neg
     op-fpa-mul
     op-fpa-div
     op-fpa-rem
     op-fpa-abs
     op-fpa-min
     op-fpa-max
     op-fpa-fma
     op-fpa-sqrt
     op-fpa-round-to-integral
     op-fpa-eq
     op-fpa-lt
     op-fpa-gt
     op-fpa-le
     op-fpa-ge
     op-fpa-is-nan
     op-fpa-is-inf
     op-fpa-is-zero
     op-fpa-is-normal
     op-fpa-is-subnormal
     op-fpa-is-negative
     op-fpa-is-positive
     op-fpa-fp
     op-fpa-to-fp
     op-fpa-to-fp-unsigned
     op-fpa-to-ubv
     op-fpa-to-sbv
     op-fpa-to-real
     op-fpa-to-ieee-bv
     op-uninterpreted)
   _int32))

(define-cpointer-type _z3-rcf-num)
(define-cpointer-type _z3-ast-map)
(define-cpointer-type _z3-func-entry)
(define-cpointer-type _z3-solver)
(define-cpointer-type _z3-probe)
(define-cpointer-type _z3-config)
(define-cpointer-type _z3-ast)
(define-cpointer-type _z3-stats)
(define-cpointer-type _z3-theory)
(define-cpointer-type _z3-constructor-list)
(define-cpointer-type _z3-symbol)
(define-cpointer-type _z3-constructor)
(define-cpointer-type _z3-bool)
(define-cpointer-type _z3-context)
(define-cpointer-type _z3-apply-result)
(define-cpointer-type _z3-model)
(define-cpointer-type _z3-goal)
(define-cpointer-type _z3-func-interp)
(define-cpointer-type _z3-fixedpoint)
(define-cpointer-type _z3-app)
(define-cpointer-type _z3-param-descrs)
(define-cpointer-type _z3-string)
(define-cpointer-type _z3-pattern)
(define-cpointer-type _z3-theory-data)
(define-cpointer-type _z3-sort)
(define-cpointer-type _z3-tactic)
(define-cpointer-type _z3-ast-vector)
(define-cpointer-type _z3-params)
(define-cpointer-type _z3-optimize)
(define-cpointer-type _z3-func-decl)

(define-z3 params-dec-ref! "Z3_params_dec_ref" (_fun _z3-context _z3-params -> _void))
(define-z3 get-decl-symbol-parameter "Z3_get_decl_symbol_parameter" (_fun _z3-context _z3-func-decl _uint -> _z3-symbol))
(define-z3 ast-vector-push! "Z3_ast_vector_push" (_fun _z3-context _z3-ast-vector _z3-ast -> _void))
(define-z3 apply-result-get-num-subgoals "Z3_apply_result_get_num_subgoals" (_fun _z3-context _z3-apply-result -> _uint))
(define-z3 global-param-set! "Z3_global_param_set" (_fun _string _string -> _void))
(define-z3 mk-real-sort "Z3_mk_real_sort" (_fun _z3-context -> _z3-sort))
(define-z3 rcf-mk-infinitesimal "Z3_rcf_mk_infinitesimal" (_fun _z3-context -> _z3-rcf-num))
(define-z3 eq-func-decl? "Z3_is_eq_func_decl" (_fun _z3-context _z3-func-decl _z3-func-decl -> _bool))
(define-z3 tactic-get-param-descrs "Z3_tactic_get_param_descrs" (_fun _z3-context _z3-tactic -> _z3-param-descrs))
(define-z3 set-param-value! "Z3_set_param_value" (_fun _z3-config _string _string -> _void))
(define-z3 goal-inc-ref! "Z3_goal_inc_ref" (_fun _z3-context _z3-goal -> _void))
(define-z3 optimize-dec-ref! "Z3_optimize_dec_ref" (_fun _z3-context _z3-optimize -> _void))
(define-z3 rcf-inv "Z3_rcf_inv" (_fun _z3-context _z3-rcf-num -> _z3-rcf-num))
(define-z3 polynomial-subresultants "Z3_polynomial_subresultants" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast-vector))
(define-z3 mk-add "Z3_mk_add"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 mk-atmost "Z3_mk_atmost"
  (_fun (c args k) ::
   (c : _z3-context)
   (num-args : _uint = (length args))
   (args : (_list i _z3-ast))
   (k : _uint)
   -> _z3-ast))
(define-z3 mk-finite-domain-sort "Z3_mk_finite_domain_sort" (_fun _z3-context _z3-symbol _uint64 -> _z3-sort))
(define-z3 mk-forall-const "Z3_mk_forall_const"
  (_fun (c weight bound patterns body) ::
   (c : _z3-context)
   (weight : _uint)
   (num-bound : _uint = (length bound))
   (bound : (_list i _z3-app))
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 mk-app "Z3_mk_app"
  (_fun (c d args) ::
   (c : _z3-context)
   (d : _z3-func-decl)
   (num-args : _uint = (length args))
   (args : (_list i _z3-ast))
   -> _z3-ast))
(define-z3 get-bool-value "Z3_get_bool_value" (_fun _z3-context _z3-ast -> _z3-lbool))
(define-z3 probe-le "Z3_probe_le" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 mk-quantifier-const "Z3_mk_quantifier_const"
  (_fun (c is-forall weight bound patterns body) ::
   (c : _z3-context)
   (is-forall : _bool)
   (weight : _uint)
   (num-bound : _uint = (length bound))
   (bound : (_list i _z3-app))
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 algebraic-add "Z3_algebraic_add" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 ast-map-keys "Z3_ast_map_keys" (_fun _z3-context _z3-ast-map -> _z3-ast-vector))
(define-z3 del-context! "Z3_del_context" (_fun _z3-context -> _void))
(define-z3 fixedpoint-assert! "Z3_fixedpoint_assert" (_fun _z3-context _z3-fixedpoint _z3-ast -> _void))
(define-z3 fixedpoint-get-help "Z3_fixedpoint_get_help" (_fun _z3-context _z3-fixedpoint -> _string))
(define-z3 algebraic-le "Z3_algebraic_le" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 mk-fpa-round-toward-zero "Z3_mk_fpa_round_toward_zero" (_fun _z3-context -> _z3-ast))
(define-z3 stats-get-uint-value "Z3_stats_get_uint_value" (_fun _z3-context _z3-stats _uint -> _uint))
(define-z3 mk-empty-set "Z3_mk_empty_set" (_fun _z3-context _z3-sort -> _z3-ast))
(define-z3 mk-quantifier-ex "Z3_mk_quantifier_ex"
  (_fun
   (c is-forall weight quantifier-id skolem-id patterns no-patterns sorts+decl-names body) ::
   (c : _z3-context)
   (is-forall : _bool)
   (weight : _uint)
   (quantifier-id : _z3-symbol)
   (skolem-id : _z3-symbol)
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (num-no-patterns : _uint = (length no-patterns))
   (no-patterns : (_list i _z3-ast))
   (num-decls : _uint = (length sorts+decl-names))
   (sorts : (_list i _z3-sort) = (map car sorts+decl-names))
   (decl-names : (_list i _z3-symbol) = (map cdr sorts+decl-names))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 tactic-fail-if-not-decided "Z3_tactic_fail_if_not_decided" (_fun _z3-context -> _z3-tactic))
(define-z3 benchmark->smtlib-string "Z3_benchmark_to_smtlib_string"
  (_fun (c name logic status attributes assumptions formula) ::
   (c : _z3-context)
   (name : _string)
   (logic : _string)
   (status : _string)
   (attributes : _string)
   (num-assumptions : _uint = (length assumptions))
   (assumptions : (_list i _z3-ast))
   (formula : _z3-ast)
   -> _string))
(define-z3 func-entry-get-value "Z3_func_entry_get_value" (_fun _z3-context _z3-func-entry -> _z3-ast))
(define-z3 ast->string "Z3_ast_to_string" (_fun _z3-context _z3-ast -> _string))
(define-z3 app? "Z3_is_app" (_fun _z3-context _z3-ast -> _bool))
(define-z3 ast-map-dec-ref! "Z3_ast_map_dec_ref" (_fun _z3-context _z3-ast-map -> _void))
(define-z3 mk-extract "Z3_mk_extract" (_fun _z3-context _uint _uint _z3-ast -> _z3-ast))
(define-z3 inc-ref! "Z3_inc_ref" (_fun _z3-context _z3-ast -> _void))
(define-z3 rcf-div "Z3_rcf_div" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _z3-rcf-num))
(define-z3 parse-smtlib2-file "Z3_parse_smtlib2_file"
  (_fun
   (c file-name sort-names+sorts decl-names+decls)
   ::
   (c : _z3-context)
   (file-name : _string)
   (num-sorts : _uint = (length sort-names+sorts))
   (sort-names : (_list i _z3-symbol) = (map car sort-names+sorts))
   (sorts : (_list i _z3-sort) = (map cdr sort-names+sorts))
   (num-decls : _uint = (length decl-names+decls))
   (decl-names : (_list i _z3-symbol) = (map car decl-names+decls))
   (decls : (_list i _z3-func-decl) = (map cdr decl-names+decls))
   -> _z3-ast))
(define-z3 mk-bvult "Z3_mk_bvult" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 rcf-add "Z3_rcf_add" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _z3-rcf-num))
(define-z3 mk-ext-rotate-left "Z3_mk_ext_rotate_left" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 rcf-neg "Z3_rcf_neg" (_fun _z3-context _z3-rcf-num -> _z3-rcf-num))
(define-z3 get-quantifier-num-patterns "Z3_get_quantifier_num_patterns" (_fun _z3-context _z3-ast -> _uint))
(define-z3 update-term "Z3_update_term"
  (_fun (c a args) ::
   (c : _z3-context)
   (a : _z3-ast)
   (num-args : _uint = (length args))
   (args : (_list i _z3-ast))
   -> _z3-ast))
(define-z3 apply-result->string "Z3_apply_result_to_string" (_fun _z3-context _z3-apply-result -> _string))
(define-z3 optimize-assert-soft "Z3_optimize_assert_soft" (_fun _z3-context _z3-optimize _z3-ast _string _z3-symbol -> _uint))
(define-z3 disable-trace! "Z3_disable_trace" (_fun _string -> _void))
(define-z3 mk-string-symbol "Z3_mk_string_symbol" (_fun _z3-context _string -> _z3-symbol))
(define-z3 algebraic-mul "Z3_algebraic_mul" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 solver-dec-ref! "Z3_solver_dec_ref" (_fun _z3-context _z3-solver -> _void))
(define-z3 mk-numeral "Z3_mk_numeral" (_fun _z3-context _string _z3-sort -> _z3-ast))
(define-z3 mk-true "Z3_mk_true" (_fun _z3-context -> _z3-ast))
(define-z3 get-quantifier-bound-name "Z3_get_quantifier_bound_name" (_fun _z3-context _z3-ast _uint -> _z3-symbol))
(define-z3 get-relation-arity "Z3_get_relation_arity" (_fun _z3-context _z3-sort -> _uint))
(define-z3 mk-bvsub "Z3_mk_bvsub" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 optimize-maximize "Z3_optimize_maximize" (_fun _z3-context _z3-optimize _z3-ast -> _uint))
(define-z3 mk-bvugt "Z3_mk_bvugt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-select "Z3_mk_select" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 global-param-reset-all! "Z3_global_param_reset_all" (_fun -> _void))
(define-z3 algebraic-power "Z3_algebraic_power" (_fun _z3-context _z3-ast _uint -> _z3-ast))
(define-z3 mk-full-set "Z3_mk_full_set" (_fun _z3-context _z3-sort -> _z3-ast))
(define-z3 update-param-value! "Z3_update_param_value" (_fun _z3-context _string _string -> _void))
(define-z3 fpa-get-sbits "Z3_fpa_get_sbits" (_fun _z3-context _z3-sort -> _uint))
(define-z3 tactic-cond "Z3_tactic_cond" (_fun _z3-context _z3-probe _z3-tactic _z3-tactic -> _z3-tactic))
(define-z3 mk-bvsub-no-underflow "Z3_mk_bvsub_no_underflow" (_fun _z3-context _z3-ast _z3-ast _bool -> _z3-ast))
(define-z3 param-descrs-inc-ref! "Z3_param_descrs_inc_ref" (_fun _z3-context _z3-param-descrs -> _void))
(define-z3 rcf-num->string "Z3_rcf_num_to_string" (_fun _z3-context _z3-rcf-num _bool _bool -> _string))
(define-z3 get-pattern "Z3_get_pattern" (_fun _z3-context _z3-pattern _uint -> _z3-ast))
(define-z3 params-validate! "Z3_params_validate" (_fun _z3-context _z3-params _z3-param-descrs -> _void))
(define-z3 mk-lt "Z3_mk_lt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 probe-dec-ref! "Z3_probe_dec_ref" (_fun _z3-context _z3-probe -> _void))
(define-z3 mk-fpa-is-positive "Z3_mk_fpa_is_positive" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 algebraic-gt "Z3_algebraic_gt" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 get-bv-sort-size "Z3_get_bv_sort_size" (_fun _z3-context _z3-sort -> _uint))
(define-z3 model-get-num-consts "Z3_model_get_num_consts" (_fun _z3-context _z3-model -> _uint))
(define-z3 fpa-get-numeral-sign "Z3_fpa_get_numeral_sign"
  (_fun (c : _z3-context) (t : _z3-ast) (sgn : (_ptr o _int)) -> (res : _bool) -> (and res sgn)))
(define-z3 mk-bvlshr "Z3_mk_bvlshr" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-tactic "Z3_mk_tactic" (_fun _z3-context _string -> _z3-tactic))
(define-z3 open-log "Z3_open_log" (_fun _string -> _bool))
(define-z3 mk-set-union "Z3_mk_set_union"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 tactic-apply-ex "Z3_tactic_apply_ex" (_fun _z3-context _z3-tactic _z3-goal _z3-params -> _z3-apply-result))
(define-z3 optimize->string "Z3_optimize_to_string" (_fun _z3-context _z3-optimize -> _string))
(define-z3 mk-quantifier "Z3_mk_quantifier"
  (_fun (c is-forall weight patterns sorts+decl-names body) ::
   (c : _z3-context)
   (is-forall : _bool)
   (weight : _uint)
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (num-decls : _uint = (length sorts+decl-names))
   (sorts : (_list i _z3-sort) = (map car sorts+decl-names))
   (decl-names : (_list i _z3-symbol) = (map cdr sorts+decl-names))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 get-quantifier-weight "Z3_get_quantifier_weight" (_fun _z3-context _z3-ast -> _uint))
(define-z3 mk-fpa-rtn "Z3_mk_fpa_rtn" (_fun _z3-context -> _z3-ast))
(define-z3 mk-probe "Z3_mk_probe" (_fun _z3-context _string -> _z3-probe))
(define-z3 param-descrs-dec-ref! "Z3_param_descrs_dec_ref" (_fun _z3-context _z3-param-descrs -> _void))
(define-z3 get-domain-size "Z3_get_domain_size" (_fun _z3-context _z3-func-decl -> _uint))
(define-z3 mk-fpa->real "Z3_mk_fpa_to_real" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 fixedpoint-add-rule! "Z3_fixedpoint_add_rule"
  (_fun _z3-context _z3-fixedpoint _z3-ast _z3-symbol -> _void))
(define-z3 rcf-mk-pi "Z3_rcf_mk_pi" (_fun _z3-context -> _z3-rcf-num))
(define-z3 mk-eq "Z3_mk_eq" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-numeral-int "Z3_get_numeral_int"
  (_fun (c : _z3-context) (v : _z3-ast) (i : (_ptr o _int)) -> (res : _bool) -> (and res i)))
(define-z3 mk-fpa-mul "Z3_mk_fpa_mul" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-numeral-float "Z3_mk_fpa_numeral_float" (_fun _z3-context _float _z3-sort -> _z3-ast))
(define-z3 func-interp-inc-ref! "Z3_func_interp_inc_ref" (_fun _z3-context _z3-func-interp -> _void))
(define-z3 mk-fpa-rna "Z3_mk_fpa_rna" (_fun _z3-context -> _z3-ast))
(define-z3 get-sort "Z3_get_sort" (_fun _z3-context _z3-ast -> _z3-sort))
(define-z3 goal-translate "Z3_goal_translate" (_fun _z3-context _z3-goal _z3-context -> _z3-goal))
(define-z3 mk-fpa-is-nan "Z3_mk_fpa_is_nan" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 get-numeral-uint64 "Z3_get_numeral_uint64"
  (_fun (c : _z3-context) (v : _z3-ast) (u : (_ptr o _uint64)) -> (res : _bool) -> (and res u)))
(define-z3 del-config! "Z3_del_config" (_fun _z3-config -> _void))
(define-z3 ast-vector-inc-ref! "Z3_ast_vector_inc_ref" (_fun _z3-context _z3-ast-vector -> _void))
(define-z3 mk-config "Z3_mk_config" (_fun -> _z3-config))
(define-z3 get-decl-num-parameters "Z3_get_decl_num_parameters" (_fun _z3-context _z3-func-decl -> _uint))
(define-z3 optimize-pop! "Z3_optimize_pop" (_fun _z3-context _z3-optimize -> _void))
(define-z3 mk-solver "Z3_mk_solver" (_fun _z3-context -> _z3-solver))
(define-z3 get-sort-id "Z3_get_sort_id" (_fun _z3-context _z3-sort -> _uint))
(define-z3 mk-gt "Z3_mk_gt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 tactic-dec-ref! "Z3_tactic_dec_ref" (_fun _z3-context _z3-tactic -> _void))
(define-z3 mk-bvredor "Z3_mk_bvredor" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 solver-reset! "Z3_solver_reset" (_fun _z3-context _z3-solver -> _void))
(define-z3 ast-map-size "Z3_ast_map_size" (_fun _z3-context _z3-ast-map -> _uint))
(define-z3 get-quantifier-body "Z3_get_quantifier_body" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 ast-vector-get "Z3_ast_vector_get" (_fun _z3-context _z3-ast-vector _uint -> _z3-ast))
(define-z3 mk-fpa-gt "Z3_mk_fpa_gt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-context "Z3_mk_context" (_fun _z3-config -> _z3-context))
(define-z3 func-entry-inc-ref! "Z3_func_entry_inc_ref" (_fun _z3-context _z3-func-entry -> _void))
(define-z3 mk-bvslt "Z3_mk_bvslt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-sub "Z3_mk_sub"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 mk-solver-from-tactic "Z3_mk_solver_from_tactic" (_fun _z3-context _z3-tactic -> _z3-solver))
(define-z3 stats-is-double? "Z3_stats_is_double" (_fun _z3-context _z3-stats _uint -> _bool))
(define-z3 mk-set-member "Z3_mk_set_member" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 params-set-symbol! "Z3_params_set_symbol" (_fun _z3-context _z3-params _z3-symbol _z3-symbol -> _void))
(define-z3 mk-fpa-is-subnormal "Z3_mk_fpa_is_subnormal" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 mk-fpa-nan "Z3_mk_fpa_nan" (_fun _z3-context _z3-sort -> _z3-ast))
(define-z3 mk-bvmul-no-underflow "Z3_mk_bvmul_no_underflow" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-datatype-sort-constructor "Z3_get_datatype_sort_constructor"
  (_fun _z3-context _z3-sort _uint -> _z3-func-decl))
(define-z3 rcf-mul "Z3_rcf_mul" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _z3-rcf-num))
(define-z3 fixedpoint-update-rule! "Z3_fixedpoint_update_rule"
  (_fun _z3-context _z3-fixedpoint _z3-ast _z3-symbol -> _void))
(define-z3 get-as-array-func-decl "Z3_get_as_array_func_decl" (_fun _z3-context _z3-ast -> _z3-func-decl))
(define-z3 mk-fresh-const "Z3_mk_fresh_const" (_fun _z3-context _string _z3-sort -> _z3-ast))
(define-z3 tactic-or-else "Z3_tactic_or_else" (_fun _z3-context _z3-tactic _z3-tactic -> _z3-tactic))
(define-z3 mk-list-sort "Z3_mk_list_sort"
  (_fun
   (c : _z3-context)
   (name : _z3-symbol)
   (elem-sort : _z3-sort)
   (nil-decl : (_ptr o _z3-func-decl))
   (is-nil-decl : (_ptr o _z3-func-decl))
   (cons-decl : (_ptr o _z3-func-decl))
   (is-cons-decl : (_ptr o _z3-func-decl))
   (head-decl : (_ptr o _z3-func-decl))
   (tail-decl : (_ptr o _z3-func-decl))
   -> (res : _z3-sort)
   -> (values res nil-decl is-nil-decl cons-decl is-cons-decl head-decl tail-decl)))
(define-z3 mk-constructor "Z3_mk_constructor"
  (_fun (c name recognizer field-names+sorts+sort-refs) ::
   (c : _z3-context)
   (name : _z3-symbol)
   (recognizer : _z3-symbol)
   (num-fields : _uint = (length field-names+sorts+sort-refs))
   (field-names : (_list i _z3-symbol) = (map first field-names+sorts+sort-refs))
   (sorts : (_list i _z3-sort/null) = (map second field-names+sorts+sort-refs))
   (sort-refs : (_list i _uint) = (map third field-names+sorts+sort-refs))
   -> _z3-constructor))
(define-z3 model-has-interp "Z3_model_has_interp" (_fun _z3-context _z3-model _z3-func-decl -> _bool))
(define-z3 optimize-get-param-descrs "Z3_optimize_get_param_descrs" (_fun _z3-context _z3-optimize -> _z3-param-descrs))
(define-z3 fixedpoint-add-fact! "Z3_fixedpoint_add_fact"
  (_fun (c d r args) ::
   (c : _z3-context)
   (d : _z3-fixedpoint)
   (r : _z3-func-decl)
   (num-args : _uint = (length args))
   (args : (_list i _uint))
   -> _void))
(define-z3 set-error! "Z3_set_error" (_fun _z3-context _z3-error-code -> _void))
(define-z3 model-get-num-sorts "Z3_model_get_num_sorts" (_fun _z3-context _z3-model -> _uint))
(define-z3 model-dec-ref! "Z3_model_dec_ref" (_fun _z3-context _z3-model -> _void))
(define-z3 get-index-value "Z3_get_index_value" (_fun _z3-context _z3-ast -> _uint))
(define-z3 get-domain "Z3_get_domain" (_fun _z3-context _z3-func-decl _uint -> _z3-sort))
(define-z3 mk-fpa-numeral-int "Z3_mk_fpa_numeral_int" (_fun _z3-context _int _z3-sort -> _z3-ast))
(define-z3 get-range "Z3_get_range" (_fun _z3-context _z3-func-decl -> _z3-sort))
(define-z3 solver-assert-and-track! "Z3_solver_assert_and_track" (_fun _z3-context _z3-solver _z3-ast _z3-ast -> _void))
(define-z3 mk-enumeration-sort "Z3_mk_enumeration_sort"
  (_fun (c name enum-names) ::
   (c : _z3-context)
   (name : _z3-symbol)
   (n : _uint = (length enum-names))
   (enum-names : (_list i _z3-symbol))
   (enum-consts : (_list o _z3-func-decl n))
   (enum-testers : (_list o _z3-func-decl n))
   -> (res : _z3-sort)
   -> (values res enum-consts enum-testers)))
(define-z3 mk-fpa-eq "Z3_mk_fpa_eq" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-or "Z3_mk_or"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 mk-uninterpreted-sort "Z3_mk_uninterpreted_sort" (_fun _z3-context _z3-symbol -> _z3-sort))
(define-z3 goal-num-exprs "Z3_goal_num_exprs" (_fun _z3-context _z3-goal -> _uint))
(define-z3 mk-fpa-is-zero "Z3_mk_fpa_is_zero" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 solver-get-unsat-core "Z3_solver_get_unsat_core" (_fun _z3-context _z3-solver -> _z3-ast-vector))
(define-z3 mk-bvand "Z3_mk_bvand" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-rotate-right "Z3_mk_rotate_right" (_fun _z3-context _uint _z3-ast -> _z3-ast))
(define-z3 rcf-mk-roots "Z3_rcf_mk_roots"
  (_fun (c a) ::
   (c : _z3-context)
   (n : _uint = (length a))
   (a : (_list i _z3-rcf-num))
   (roots : (_list o _z3-rcf-num n))
   -> (res : _uint)
   -> (values res roots)))
(define-z3 mk-fpa-sqrt "Z3_mk_fpa_sqrt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-datatype-sort-constructor-accessor "Z3_get_datatype_sort_constructor_accessor"
  (_fun _z3-context _z3-sort _uint _uint -> _z3-func-decl))
(define-z3 mk-datatype "Z3_mk_datatype"
  (_fun (c name constructors) ::
   (c : _z3-context)
   (name : _z3-symbol)
   (num-constructors : _uint = (length constructors))
   (constructors : (_list i _z3-constructor))
   -> _z3-sort))
(define-z3 mk-fpa-div "Z3_mk_fpa_div" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 func-interp-get-num-entries "Z3_func_interp_get_num_entries" (_fun _z3-context _z3-func-interp -> _uint))
(define-z3 get-ast-id "Z3_get_ast_id" (_fun _z3-context _z3-ast -> _uint))
(define-z3 dec-ref! "Z3_dec_ref" (_fun _z3-context _z3-ast -> _void))
(define-z3 fixedpoint-get-param-descrs "Z3_fixedpoint_get_param_descrs" (_fun _z3-context _z3-fixedpoint -> _z3-param-descrs))
(define-z3 optimize-inc-ref! "Z3_optimize_inc_ref" (_fun _z3-context _z3-optimize -> _void))
(define-z3 mk-fpa-abs "Z3_mk_fpa_abs" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 fpa-get-numeral-significand-uint64 "Z3_fpa_get_numeral_significand_uint64"
  (_fun (c : _z3-context) (t : _z3-ast) (n : (_ptr o _uint64)) -> (res : _bool) -> (and res n)))
(define-z3 algebraic-is-neg? "Z3_algebraic_is_neg" (_fun _z3-context _z3-ast -> _bool))
(define-z3 tactic-using-params "Z3_tactic_using_params" (_fun _z3-context _z3-tactic _z3-params -> _z3-tactic))
(define-z3 fixedpoint-inc-ref! "Z3_fixedpoint_inc_ref" (_fun _z3-context _z3-fixedpoint -> _void))
(define-z3 get-decl-name "Z3_get_decl_name" (_fun _z3-context _z3-func-decl -> _z3-symbol))
(define-z3 stats-inc-ref! "Z3_stats_inc_ref" (_fun _z3-context _z3-stats -> _void))
(define-z3 probe-gt "Z3_probe_gt" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 mk-fpa->sbv "Z3_mk_fpa_to_sbv" (_fun _z3-context _z3-ast _z3-ast _uint -> _z3-ast))
(define-z3 mk-fpa-sort-single "Z3_mk_fpa_sort_single" (_fun _z3-context -> _z3-sort))
(define-z3 mk-zero-ext "Z3_mk_zero_ext" (_fun _z3-context _uint _z3-ast -> _z3-ast))
(define-z3 mk-fpa-sort-16 "Z3_mk_fpa_sort_16" (_fun _z3-context -> _z3-sort))
(define-z3 get-version "Z3_get_version"
  (_fun
   (major : (_ptr o _uint))
   (minor : (_ptr o _uint))
   (build-number : (_ptr o _uint))
   (revision-number : (_ptr o _uint))
   -> _void
   -> (values major minor build-number revision-number)))
(define-z3 get-algebraic-number-upper "Z3_get_algebraic_number_upper" (_fun _z3-context _z3-ast _uint -> _z3-ast))
(define-z3 mk-int-sort "Z3_mk_int_sort" (_fun _z3-context -> _z3-sort))
(define-z3 get-tuple-sort-mk-decl "Z3_get_tuple_sort_mk_decl" (_fun _z3-context _z3-sort -> _z3-func-decl))
(define-z3 tactic-repeat "Z3_tactic_repeat" (_fun _z3-context _z3-tactic _uint -> _z3-tactic))
(define-z3 get-func-decl-id "Z3_get_func_decl_id" (_fun _z3-context _z3-func-decl -> _uint))
(define-z3 algebraic-neq "Z3_algebraic_neq" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 tactic-inc-ref! "Z3_tactic_inc_ref" (_fun _z3-context _z3-tactic -> _void))
(define-z3 rcf-le "Z3_rcf_le" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _bool))
(define-z3 mk-fpa->fp-int-real "Z3_mk_fpa_to_fp_int_real"
  (_fun _z3-context _z3-ast _z3-ast _z3-ast _z3-sort -> _z3-ast))
(define-z3 get-num-probes "Z3_get_num_probes" (_fun _z3-context -> _uint))
(define-z3 mk-fpa-rtp "Z3_mk_fpa_rtp" (_fun _z3-context -> _z3-ast))
(define-z3 mk-sign-ext "Z3_mk_sign_ext" (_fun _z3-context _uint _z3-ast -> _z3-ast))
(define-z3 mk-ite "Z3_mk_ite" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 simplify-get-help "Z3_simplify_get_help" (_fun _z3-context -> _string))
(define-z3 simplify-ex "Z3_simplify_ex" (_fun _z3-context _z3-ast _z3-params -> _z3-ast))
(define-z3 mk-fpa-numeral-int-uint "Z3_mk_fpa_numeral_int_uint"
  (_fun _z3-context _bool _int _uint _z3-sort -> _z3-ast))
(define-z3 func-interp-get-else "Z3_func_interp_get_else" (_fun _z3-context _z3-func-interp -> _z3-ast))
(define-z3 model-get-sort "Z3_model_get_sort" (_fun _z3-context _z3-model _uint -> _z3-sort))
(define-z3 mk-fpa-leq "Z3_mk_fpa_leq" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-sort-double "Z3_mk_fpa_sort_double" (_fun _z3-context -> _z3-sort))
(define-z3 mk-bvxnor "Z3_mk_bvxnor" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 optimize-push! "Z3_optimize_push" (_fun _z3-context _z3-optimize -> _void))
(define-z3 mk-datatypes "Z3_mk_datatypes"
  (_fun (c sort-names+constructor-lists) ::
   (c : _z3-context)
   (num-sorts : _uint = (length sort-names+constructor-lists))
   (sort-names : (_list i _z3-symbol) = (map car sort-names+constructor-lists))
   (sorts : (_list o _z3-sort num-sorts))
   (constructor-lists : (_list i _z3-constructor-list) = (map cdr sort-names+constructor-lists))
   -> _void
   -> sorts))
(define-z3 rcf-mk-small-int "Z3_rcf_mk_small_int" (_fun _z3-context _int -> _z3-rcf-num))
(define-z3 mk-set-subset "Z3_mk_set_subset" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-symbol-kind "Z3_get_symbol_kind" (_fun _z3-context _z3-symbol -> _z3-symbol-kind))
(define-z3 goal-is-decided-unsat? "Z3_goal_is_decided_unsat" (_fun _z3-context _z3-goal -> _bool))
(define-z3 get-quantifier-no-pattern-ast "Z3_get_quantifier_no_pattern_ast"
  (_fun _z3-context _z3-ast _uint -> _z3-ast))
(define-z3 mk-fpa-round-nearest-ties->away "Z3_mk_fpa_round_nearest_ties_to_away" (_fun _z3-context -> _z3-ast))
(define-z3 stats-size "Z3_stats_size" (_fun _z3-context _z3-stats -> _uint))
(define-z3 goal-dec-ref! "Z3_goal_dec_ref" (_fun _z3-context _z3-goal -> _void))
(define-z3 mk-bvuge "Z3_mk_bvuge" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-bv-sort "Z3_mk_bv_sort" (_fun _z3-context _uint -> _z3-sort))
(define-z3 optimize-check "Z3_optimize_check" (_fun _z3-context _z3-optimize -> _z3-lbool))
(define-z3 rcf-num->decimal-string "Z3_rcf_num_to_decimal_string" (_fun _z3-context _z3-rcf-num _uint -> _string))
(define-z3 mk-fpa->fp-signed "Z3_mk_fpa_to_fp_signed" (_fun _z3-context _z3-ast _z3-ast _z3-sort -> _z3-ast))
(define-z3 goal->string "Z3_goal_to_string" (_fun _z3-context _z3-goal -> _string))
(define-z3 get-decl-double-parameter "Z3_get_decl_double_parameter" (_fun _z3-context _z3-func-decl _uint -> _double))
(define-z3 get-array-sort-range "Z3_get_array_sort_range" (_fun _z3-context _z3-sort -> _z3-sort))
(define-z3 rcf-del! "Z3_rcf_del" (_fun _z3-context _z3-rcf-num -> _void))
(define-z3 get-array-sort-domain "Z3_get_array_sort_domain" (_fun _z3-context _z3-sort -> _z3-sort))
(define-z3 mk-store "Z3_mk_store" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-round-toward-positive "Z3_mk_fpa_round_toward_positive" (_fun _z3-context -> _z3-ast))
(define-z3 mk-forall "Z3_mk_forall"
  (_fun (c weight patterns sorts+decl-names body) ::
   (c : _z3-context)
   (weight : _uint)
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (num-decls : _uint = (length sorts+decl-names))
   (sorts : (_list i _z3-sort) = (map car sorts+decl-names))
   (decl-names : (_list i _z3-symbol) = (map cdr sorts+decl-names))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 mk-fpa-sort-32 "Z3_mk_fpa_sort_32" (_fun _z3-context -> _z3-sort))
(define-z3 mk-fpa-sort-quadruple "Z3_mk_fpa_sort_quadruple" (_fun _z3-context -> _z3-sort))
(define-z3 mk-set-del "Z3_mk_set_del" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-num-tactics "Z3_get_num_tactics" (_fun _z3-context -> _uint))
(define-z3 mk-fpa-inf "Z3_mk_fpa_inf" (_fun _z3-context _z3-sort _bool -> _z3-ast))
(define-z3 mk-int2real "Z3_mk_int2real" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 probe-const "Z3_probe_const" (_fun _z3-context _double -> _z3-probe))
(define-z3 mk-fresh-func-decl "Z3_mk_fresh_func_decl"
  (_fun (c prefix domain range) ::
   (c : _z3-context)
   (prefix : _string)
   (domain-size : _uint = (length domain))
   (domain : (_list i _z3-sort))
   (range : _z3-sort)
   -> _z3-func-decl))
(define-z3 algebraic-is-pos? "Z3_algebraic_is_pos" (_fun _z3-context _z3-ast -> _bool))
(define-z3 eq-ast? "Z3_is_eq_ast" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 solver-check-assumptions "Z3_solver_check_assumptions"
  (_fun (c s assumptions) ::
   (c : _z3-context)
   (s : _z3-solver)
   (num-assumptions : _uint = (length assumptions))
   (assumptions : (_list i _z3-ast))
   -> _z3-lbool))
(define-z3 stats-dec-ref! "Z3_stats_dec_ref" (_fun _z3-context _z3-stats -> _void))
(define-z3 ast-map-reset! "Z3_ast_map_reset" (_fun _z3-context _z3-ast-map -> _void))
(define-z3 tactic-apply "Z3_tactic_apply" (_fun _z3-context _z3-tactic _z3-goal -> _z3-apply-result))
(define-z3 mk-fpa->fp-unsigned "Z3_mk_fpa_to_fp_unsigned" (_fun _z3-context _z3-ast _z3-ast _z3-sort -> _z3-ast))
(define-z3 param-descrs-get-name "Z3_param_descrs_get_name" (_fun _z3-context _z3-param-descrs _uint -> _z3-symbol))
(define-z3 mk-ast-map "Z3_mk_ast_map" (_fun _z3-context -> _z3-ast-map))
(define-z3 mk-set-complement "Z3_mk_set_complement" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 rcf-gt "Z3_rcf_gt" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _bool))
(define-z3 mk-ast-vector "Z3_mk_ast_vector" (_fun _z3-context -> _z3-ast-vector))
(define-z3 sort->ast "Z3_sort_to_ast" (_fun _z3-context _z3-sort -> _z3-ast))
(define-z3 probe-lt "Z3_probe_lt" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 algebraic-eq "Z3_algebraic_eq" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 tactic-get-descr "Z3_tactic_get_descr" (_fun _z3-context _string -> _string))
(define-z3 model-get-sort-universe "Z3_model_get_sort_universe" (_fun _z3-context _z3-model _z3-sort -> _z3-ast-vector))
(define-z3 fixedpoint-query "Z3_fixedpoint_query" (_fun _z3-context _z3-fixedpoint _z3-ast -> _z3-lbool))
(define-z3 optimize-assert! "Z3_optimize_assert" (_fun _z3-context _z3-optimize _z3-ast -> _void))
(define-z3 optimize-minimize "Z3_optimize_minimize" (_fun _z3-context _z3-optimize _z3-ast -> _uint))
(define-z3 probe-not "Z3_probe_not" (_fun _z3-context _z3-probe -> _z3-probe))
(define-z3 optimize-get-statistics "Z3_optimize_get_statistics" (_fun _z3-context _z3-optimize -> _z3-stats))
(define-z3 tactic-and-then "Z3_tactic_and_then" (_fun _z3-context _z3-tactic _z3-tactic -> _z3-tactic))
(define-z3 pattern->ast "Z3_pattern_to_ast" (_fun _z3-context _z3-pattern -> _z3-ast))
(define-z3 get-symbol-string "Z3_get_symbol_string" (_fun _z3-context _z3-symbol -> _string))
(define-z3 mk-fpa-numeral-int64-uint64 "Z3_mk_fpa_numeral_int64_uint64" (_fun _z3-context _bool _int64 _uint64 _z3-sort -> _z3-ast))
(define-z3 mk-fpa-is-normal "Z3_mk_fpa_is_normal" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 get-relation-column "Z3_get_relation_column" (_fun _z3-context _z3-sort _uint -> _z3-sort))
(define-z3 fixedpoint-dec-ref! "Z3_fixedpoint_dec_ref" (_fun _z3-context _z3-fixedpoint -> _void))
(define-z3 mk-params "Z3_mk_params" (_fun _z3-context -> _z3-params))
(define-z3 goal-is-decided-sat? "Z3_goal_is_decided_sat" (_fun _z3-context _z3-goal -> _bool))
(define-z3 solver-get-model "Z3_solver_get_model" (_fun _z3-context _z3-solver -> _z3-model))
(define-z3 probe-ge "Z3_probe_ge" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 algebraic-is-value? "Z3_algebraic_is_value" (_fun _z3-context _z3-ast -> _bool))
(define-z3 rcf-mk-e "Z3_rcf_mk_e" (_fun _z3-context -> _z3-rcf-num))
(define-z3 fpa-get-ebits "Z3_fpa_get_ebits" (_fun _z3-context _z3-sort -> _uint))
(define-z3 solver-get-proof "Z3_solver_get_proof" (_fun _z3-context _z3-solver -> _z3-ast))
(define-z3 mk-fpa-zero "Z3_mk_fpa_zero" (_fun _z3-context _z3-sort _bool -> _z3-ast))
(define-z3 goal-depth "Z3_goal_depth" (_fun _z3-context _z3-goal -> _uint))
(define-z3 global-param-get "Z3_global_param_get" (_fun (param-id : _string) (param-value : (_ptr o _string)) -> (res : _bool) -> (and res param-value)))
(define-z3 solver-get-num-scopes "Z3_solver_get_num_scopes" (_fun _z3-context _z3-solver -> _uint))
(define-z3 mk-int-symbol "Z3_mk_int_symbol" (_fun _z3-context _int -> _z3-symbol))
(define-z3 optimize-get-upper "Z3_optimize_get_upper" (_fun _z3-context _z3-optimize _uint -> _z3-ast))
(define-z3 mk-bvadd-no-underflow "Z3_mk_bvadd_no_underflow" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-ast-kind "Z3_get_ast_kind" (_fun _z3-context _z3-ast -> _z3-ast-kind))
(define-z3 mk-fpa-sort-64 "Z3_mk_fpa_sort_64" (_fun _z3-context -> _z3-sort))
(define-z3 func-interp-get-entry "Z3_func_interp_get_entry" (_fun _z3-context _z3-func-interp _uint -> _z3-func-entry))
(define-z3 solver-check "Z3_solver_check" (_fun _z3-context _z3-solver -> _z3-lbool))
(define-z3 optimize-get-model "Z3_optimize_get_model" (_fun _z3-context _z3-optimize -> _z3-model))
(define-z3 mk-fpa-sort "Z3_mk_fpa_sort" (_fun _z3-context _uint _uint -> _z3-sort))
(define-z3 model-get-const-interp "Z3_model_get_const_interp" (_fun _z3-context _z3-model _z3-func-decl -> _z3-ast))
(define-z3 rcf-mk-rational "Z3_rcf_mk_rational" (_fun _z3-context _string -> _z3-rcf-num))
(define-z3 tactic-when "Z3_tactic_when" (_fun _z3-context _z3-probe _z3-tactic -> _z3-tactic))
(define-z3 get-app-decl "Z3_get_app_decl" (_fun _z3-context _z3-app -> _z3-func-decl))
(define-z3 tactic-try-for "Z3_tactic_try_for" (_fun _z3-context _z3-tactic _uint -> _z3-tactic))
(define-z3 get-decl-rational-parameter "Z3_get_decl_rational_parameter" (_fun _z3-context _z3-func-decl _uint -> _string))
(define-z3 apply-result-get-subgoal "Z3_apply_result_get_subgoal" (_fun _z3-context _z3-apply-result _uint -> _z3-goal))
(define-z3 fixedpoint-set-params! "Z3_fixedpoint_set_params" (_fun _z3-context _z3-fixedpoint _z3-params -> _void))
(define-z3 get-arity "Z3_get_arity" (_fun _z3-context _z3-func-decl -> _uint))
(define-z3 quantifier-forall? "Z3_is_quantifier_forall" (_fun _z3-context _z3-ast -> _bool))
(define-z3 fixedpoint-get-answer "Z3_fixedpoint_get_answer" (_fun _z3-context _z3-fixedpoint -> _z3-ast))
(define-z3 toggle-warning-messages! "Z3_toggle_warning_messages" (_fun _bool -> _void))
(define-z3 set-ast-print-mode! "Z3_set_ast_print_mode" (_fun _z3-context _z3-ast-print-mode -> _void))
(define-z3 get-app-arg "Z3_get_app_arg" (_fun _z3-context _z3-app _uint -> _z3-ast))
(define-z3 mk-false "Z3_mk_false" (_fun _z3-context -> _z3-ast))
(define-z3 mk-le "Z3_mk_le" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 solver-get-param-descrs "Z3_solver_get_param_descrs" (_fun _z3-context _z3-solver -> _z3-param-descrs))
(define-z3 rcf-lt "Z3_rcf_lt" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _bool))
(define-z3 mk-func-decl "Z3_mk_func_decl"
  (_fun (c s domain range) ::
   (c : _z3-context)
   (s : _z3-symbol)
   (domain-size : _uint = (length domain))
   (domain : (_list i _z3-sort))
   (range : _z3-sort)
   -> _z3-func-decl))
(define-z3 fixedpoint-get-statistics "Z3_fixedpoint_get_statistics" (_fun _z3-context _z3-fixedpoint -> _z3-stats))
(define-z3 pattern->string "Z3_pattern_to_string" (_fun _z3-context _z3-pattern -> _string))
(define-z3 eq-sort? "Z3_is_eq_sort" (_fun _z3-context _z3-sort _z3-sort -> _bool))
(define-z3 solver-inc-ref! "Z3_solver_inc_ref" (_fun _z3-context _z3-solver -> _void))
(define-z3 fixedpoint-query-relations "Z3_fixedpoint_query_relations"
  (_fun (c d relations) ::
   (c : _z3-context)
   (d : _z3-fixedpoint)
   (num-relations : _uint = (length relations))
   (relations : (_list i _z3-func-decl))
   -> _z3-lbool))
(define-z3 optimize-get-help "Z3_optimize_get_help" (_fun _z3-context _z3-optimize -> _string))
(define-z3 mk-pattern "Z3_mk_pattern"
  (_fun (c terms) ::
   (c : _z3-context)
   (num-patterns : _uint = (length terms))
   (terms : (_list i _z3-ast))
   -> _z3-pattern))
(define-z3 as-array? "Z3_is_as_array" (_fun _z3-context _z3-ast -> _bool))
(define-z3 mk-ge "Z3_mk_ge" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 ast-vector-translate "Z3_ast_vector_translate" (_fun _z3-context _z3-ast-vector _z3-context -> _z3-ast-vector))
(define-z3 ast-map->string "Z3_ast_map_to_string" (_fun _z3-context _z3-ast-map -> _string))
(define-z3 solver-get-help "Z3_solver_get_help" (_fun _z3-context _z3-solver -> _string))
(define-z3 query-constructor "Z3_query_constructor"
  (_fun (c constr num-fields) ::
   (c : _z3-context)
   (constr : _z3-constructor)
   (num-fields : _uint)
   (constructor : (_ptr o _z3-func-decl))
   (tester : (_ptr o _z3-func-decl))
   (accessors : (_list o _z3-func-decl num-fields))
   -> _void
   -> (values constructor tester accessors)))
(define-z3 fpa-get-numeral-exponent-int64 "Z3_fpa_get_numeral_exponent_int64"
  (_fun (c : _z3-context) (t : _z3-ast) (n : (_ptr o _int64)) -> (res : _bool) -> (and res n)))
(define-z3 mk-rem "Z3_mk_rem" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 ast-vector-resize! "Z3_ast_vector_resize" (_fun _z3-context _z3-ast-vector _uint -> _void))
(define-z3 simplify-get-param-descrs "Z3_simplify_get_param_descrs" (_fun _z3-context -> _z3-param-descrs))
(define-z3 mk-distinct "Z3_mk_distinct"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 mk-bvsdiv "Z3_mk_bvsdiv" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 model-inc-ref! "Z3_model_inc_ref" (_fun _z3-context _z3-model -> _void))
(define-z3 mk-bvsrem "Z3_mk_bvsrem" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-set-sort "Z3_mk_set_sort" (_fun _z3-context _z3-sort -> _z3-sort))
(define-z3 ast-vector-set! "Z3_ast_vector_set" (_fun _z3-context _z3-ast-vector _uint _z3-ast -> _void))
(define-z3 get-sort-name "Z3_get_sort_name" (_fun _z3-context _z3-sort -> _z3-symbol))
(define-z3 tactic-skip "Z3_tactic_skip" (_fun _z3-context -> _z3-tactic))
(define-z3 mk-repeat "Z3_mk_repeat" (_fun _z3-context _uint _z3-ast -> _z3-ast))
(define-z3 get-decl-func-decl-parameter "Z3_get_decl_func_decl_parameter" (_fun _z3-context _z3-func-decl _uint -> _z3-func-decl))
(define-z3 mk-bvule "Z3_mk_bvule" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-exists "Z3_mk_exists"
  (_fun (c weight patterns sorts+decl-names body) ::
   (c : _z3-context)
   (weight : _uint)
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (num-decls : _uint = (length sorts+decl-names))
   (sorts : (_list i _z3-sort) = (map car sorts+decl-names))
   (decl-names : (_list i _z3-symbol) = (map cdr sorts+decl-names))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 rcf-eq "Z3_rcf_eq" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _bool))
(define-z3 datatype-update-field "Z3_datatype_update_field" (_fun _z3-context _z3-func-decl _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-rounding-mode-sort "Z3_mk_fpa_rounding_mode_sort" (_fun _z3-context -> _z3-sort))
(define-z3 apply-result-inc-ref! "Z3_apply_result_inc_ref" (_fun _z3-context _z3-apply-result -> _void))
(define-z3 goal-inconsistent "Z3_goal_inconsistent" (_fun _z3-context _z3-goal -> _bool))
(define-z3 get-decl-kind "Z3_get_decl_kind" (_fun _z3-context _z3-func-decl -> _z3-decl-kind))
(define-z3 optimize-get-lower "Z3_optimize_get_lower" (_fun _z3-context _z3-optimize _uint -> _z3-ast))
(define-z3 get-quantifier-bound-sort "Z3_get_quantifier_bound_sort" (_fun _z3-context _z3-ast _uint -> _z3-sort))
(define-z3 solver-get-assertions "Z3_solver_get_assertions" (_fun _z3-context _z3-solver -> _z3-ast-vector))
(define-z3 mk-fpa-round-toward-negative "Z3_mk_fpa_round_toward_negative" (_fun _z3-context -> _z3-ast))
(define-z3 get-error-code "Z3_get_error_code" (_fun _z3-context -> _z3-error-code))
(define-z3 mk-bvsge "Z3_mk_bvsge" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-bvredand "Z3_mk_bvredand" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 translate "Z3_translate" (_fun _z3-context _z3-ast _z3-context -> _z3-ast))
(define-z3 mk-map "Z3_mk_map"
  (_fun (c f args) ::
   (c : _z3-context)
   (f : _z3-func-decl)
   (n : _uint = (length args))
   (args : (_list i _z3-ast))
   -> _z3-ast))
(define-z3 mk-solver-for-logic "Z3_mk_solver_for_logic" (_fun _z3-context _z3-symbol -> _z3-solver))
(define-z3 get-sort-kind "Z3_get_sort_kind" (_fun _z3-context _z3-sort -> _z3-sort-kind))
(define-z3 get-finite-domain-sort-size "Z3_get_finite_domain_sort_size"
  (_fun (c : _z3-context) (s : _z3-sort) (r : (_ptr o _uint64)) -> (res : _bool) -> (and res r)))
(define-z3 well-sorted? "Z3_is_well_sorted" (_fun _z3-context _z3-ast -> _bool))
(define-z3 func-entry-get-num-args "Z3_func_entry_get_num_args" (_fun _z3-context _z3-func-entry -> _uint))
(define-z3 mk-rotate-left "Z3_mk_rotate_left" (_fun _z3-context _uint _z3-ast -> _z3-ast))
(define-z3 model-get-func-interp "Z3_model_get_func_interp" (_fun _z3-context _z3-model _z3-func-decl -> _z3-func-interp))
(define-z3 substitute "Z3_substitute"
  (_fun (c a from+to) ::
   (c : _z3-context)
   (a : _z3-ast)
   (num-exprs : _uint = (length from+to))
   (from : (_list i _z3-ast) = (map car from+to))
   (to : (_list i _z3-ast) = (map cdr from+to))
   -> _z3-ast))
(define-z3 fixedpoint-get-num-levels "Z3_fixedpoint_get_num_levels" (_fun _z3-context _z3-fixedpoint _z3-func-decl -> _uint))
(define-z3 mk-fpa->ieee-bv "Z3_mk_fpa_to_ieee_bv" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 mk-unsigned-int "Z3_mk_unsigned_int" (_fun _z3-context _uint _z3-sort -> _z3-ast))
(define-z3 get-datatype-sort-recognizer "Z3_get_datatype_sort_recognizer" (_fun _z3-context _z3-sort _uint -> _z3-func-decl))
(define-z3 sort->string "Z3_sort_to_string" (_fun _z3-context _z3-sort -> _string))
(define-z3 solver-set-params! "Z3_solver_set_params" (_fun _z3-context _z3-solver _z3-params -> _void))
(define-z3 ast-map-inc-ref! "Z3_ast_map_inc_ref" (_fun _z3-context _z3-ast-map -> _void))
(define-z3 params->string "Z3_params_to_string" (_fun _z3-context _z3-params -> _string))
(define-z3 mk-bound "Z3_mk_bound" (_fun _z3-context _uint _z3-sort -> _z3-ast))
(define-z3 fixedpoint-get-rules "Z3_fixedpoint_get_rules" (_fun _z3-context _z3-fixedpoint -> _z3-ast-vector))
(define-z3 model->string "Z3_model_to_string" (_fun _z3-context _z3-model -> _string))
(define-z3 mk-fpa-is-negative "Z3_mk_fpa_is_negative" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 rcf-sub "Z3_rcf_sub" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _z3-rcf-num))
(define-z3 get-numeral-int64 "Z3_get_numeral_int64"
  (_fun (c : _z3-context) (v : _z3-ast) (i : (_ptr o _int64)) -> (res : _bool) -> (and res i)))
(define-z3 stats->string "Z3_stats_to_string" (_fun _z3-context _z3-stats -> _string))
(define-z3 mk-is-int "Z3_mk_is_int" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 mk-fpa->ubv "Z3_mk_fpa_to_ubv" (_fun _z3-context _z3-ast _z3-ast _uint -> _z3-ast))
(define-z3 mk-bvshl "Z3_mk_bvshl" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 fpa-get-numeral-significand-string "Z3_fpa_get_numeral_significand_string"
  (_fun _z3-context _z3-ast -> _string))
(define-z3 get-algebraic-number-lower "Z3_get_algebraic_number_lower" (_fun _z3-context _z3-ast _uint -> _z3-ast))
(define-z3 model-get-func-decl "Z3_model_get_func_decl" (_fun _z3-context _z3-model _uint -> _z3-func-decl))
(define-z3 del-constructor-list! "Z3_del_constructor_list" (_fun _z3-context _z3-constructor-list -> _void))
(define-z3 optimize-set-params! "Z3_optimize_set_params" (_fun _z3-context _z3-optimize _z3-params -> _void))
(define-z3 model-eval "Z3_model_eval"
  (_fun
   (c : _z3-context)
   (m : _z3-model)
   (t : _z3-ast)
   (model-completion : _bool)
   (v : (_ptr o _z3-ast))
   -> (res : _bool)
   -> (and res v)))
(define-z3 mk-fpa->fp-real "Z3_mk_fpa_to_fp_real" (_fun _z3-context _z3-ast _z3-ast _z3-sort -> _z3-ast))
(define-z3 stats-is-uint? "Z3_stats_is_uint" (_fun _z3-context _z3-stats _uint -> _bool))
(define-z3 mk-pble "Z3_mk_pble"
  (_fun (c args+coeffs k) ::
   (c : _z3-context)
   (num-args : _uint = (length args+coeffs))
   (args : (_list i _z3-ast) = (map car args+coeffs))
   (coeffs : (_list i _int) = (map cdr args+coeffs))
   (k : _int)
   -> _z3-ast))
(define-z3 param-descrs->string "Z3_param_descrs_to_string" (_fun _z3-context _z3-param-descrs -> _string))
(define-z3 mk-array-default "Z3_mk_array_default" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 ast-vector->string "Z3_ast_vector_to_string" (_fun _z3-context _z3-ast-vector -> _string))
(define-z3 mk-bvneg-no-overflow "Z3_mk_bvneg_no_overflow" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 func-interp-dec-ref! "Z3_func_interp_dec_ref" (_fun _z3-context _z3-func-interp -> _void))
(define-z3 mk-fpa-fp "Z3_mk_fpa_fp" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 apply-result-dec-ref! "Z3_apply_result_dec_ref" (_fun _z3-context _z3-apply-result -> _void))
(define-z3 solver-assert! "Z3_solver_assert" (_fun _z3-context _z3-solver _z3-ast -> _void))
(define-z3 mk-fpa-round-nearest-ties->even "Z3_mk_fpa_round_nearest_ties_to_even" (_fun _z3-context -> _z3-ast))
(define-z3 mk-int64 "Z3_mk_int64" (_fun _z3-context _int64 _z3-sort -> _z3-ast))
(define-z3 mk-bv2int "Z3_mk_bv2int" (_fun _z3-context _z3-ast _bool -> _z3-ast))
(define-z3 mk-bvsle "Z3_mk_bvsle" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-is-infinite "Z3_mk_fpa_is_infinite" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 mk-bvnand "Z3_mk_bvnand" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 algebraic-lt "Z3_algebraic_lt" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 mk-set-difference "Z3_mk_set_difference" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-decl-sort-parameter "Z3_get_decl_sort_parameter" (_fun _z3-context _z3-func-decl _uint -> _z3-sort))
(define-z3 algebraic-sub "Z3_algebraic_sub" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-datatype-sort-num-constructors "Z3_get_datatype_sort_num_constructors" (_fun _z3-context _z3-sort -> _uint))
(define-z3 enable-trace! "Z3_enable_trace" (_fun _string -> _void))
(define-z3 ast-map-erase! "Z3_ast_map_erase" (_fun _z3-context _z3-ast-map _z3-ast -> _void))
(define-z3 mk-int2bv "Z3_mk_int2bv" (_fun _z3-context _uint _z3-ast -> _z3-ast))
(define-z3 probe-inc-ref! "Z3_probe_inc_ref" (_fun _z3-context _z3-probe -> _void))
(define-z3 get-tuple-sort-num-fields "Z3_get_tuple_sort_num_fields" (_fun _z3-context _z3-sort -> _uint))
(define-z3 mk-bvadd-no-overflow "Z3_mk_bvadd_no_overflow" (_fun _z3-context _z3-ast _z3-ast _bool -> _z3-ast))
(define-z3 ast-map-insert! "Z3_ast_map_insert" (_fun _z3-context _z3-ast-map _z3-ast _z3-ast -> _void))
(define-z3 tactic-fail "Z3_tactic_fail" (_fun _z3-context -> _z3-tactic))
(define-z3 algebraic-sign "Z3_algebraic_sign" (_fun _z3-context _z3-ast -> _int))
(define-z3 mk-bvsgt "Z3_mk_bvsgt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-power "Z3_mk_power" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa->fp-bv "Z3_mk_fpa_to_fp_bv" (_fun _z3-context _z3-ast _z3-sort -> _z3-ast))
(define-z3 probe-apply "Z3_probe_apply" (_fun _z3-context _z3-probe _z3-goal -> _double))
(define-z3 mk-fpa-max "Z3_mk_fpa_max" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-decl-parameter-kind "Z3_get_decl_parameter_kind"
  (_fun _z3-context _z3-func-decl _uint -> _z3-parameter-kind))
(define-z3 algebraic-is-zero? "Z3_algebraic_is_zero" (_fun _z3-context _z3-ast -> _bool))
(define-z3 get-symbol-int "Z3_get_symbol_int" (_fun _z3-context _z3-symbol -> _int))
(define-z3 mk-fpa-rtz "Z3_mk_fpa_rtz" (_fun _z3-context -> _z3-ast))
(define-z3 mk-optimize "Z3_mk_optimize" (_fun _z3-context -> _z3-optimize))
(define-z3 fixedpoint-add-cover! "Z3_fixedpoint_add_cover"
  (_fun _z3-context _z3-fixedpoint _int _z3-func-decl _z3-ast -> _void))
(define-z3 mk-unsigned-int64 "Z3_mk_unsigned_int64" (_fun _z3-context _uint64 _z3-sort -> _z3-ast))
(define-z3 mk-fpa-sort-half "Z3_mk_fpa_sort_half" (_fun _z3-context -> _z3-sort))
(define-z3 fixedpoint-get-cover-delta "Z3_fixedpoint_get_cover_delta"
  (_fun _z3-context _z3-fixedpoint _int _z3-func-decl -> _z3-ast))
(define-z3 to-func-decl "Z3_to_func_decl" (_fun _z3-context _z3-ast -> _z3-func-decl))
(define-z3 mk-bvor "Z3_mk_bvor" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 model-get-num-funcs "Z3_model_get_num_funcs" (_fun _z3-context _z3-model -> _uint))
(define-z3 mk-context-rc "Z3_mk_context_rc" (_fun _z3-config -> _z3-context))
(define-z3 get-numeral-uint "Z3_get_numeral_uint"
  (_fun (c : _z3-context) (v : _z3-ast) (u : (_ptr o _uint)) -> (res : _bool) -> (and res u)))
(define-z3 fixedpoint-get-reason-unknown "Z3_fixedpoint_get_reason_unknown" (_fun _z3-context _z3-fixedpoint -> _string))
(define-z3 mk-bvnor "Z3_mk_bvnor" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 tactic-par-or "Z3_tactic_par_or"
  (_fun (c ts) ::
        (c : _z3-context)
        (num : _uint = (length ts))
        (ts : (_list i _z3-tactic))
        -> _z3-tactic))
(define-z3 mk-fpa-sub "Z3_mk_fpa_sub" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 fixedpoint->string "Z3_fixedpoint_to_string"
  (_fun (c f queries) ::
   (c : _z3-context)
   (f : _z3-fixedpoint)
   (num-queries : _uint = (length queries))
   (queries : (_list i _z3-ast))
   -> _string))
(define-z3 mk-fpa-round->integral "Z3_mk_fpa_round_to_integral" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-fma "Z3_mk_fpa_fma" (_fun _z3-context _z3-ast _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 probe-eq "Z3_probe_eq" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 mk-const-array "Z3_mk_const_array" (_fun _z3-context _z3-sort _z3-ast -> _z3-ast))
(define-z3 mk-bvadd "Z3_mk_bvadd" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 reset-memory! "Z3_reset_memory" (_fun -> _void))
(define-z3 goal-precision "Z3_goal_precision" (_fun _z3-context _z3-goal -> _z3-goal-prec))
(define-z3 mk-bvurem "Z3_mk_bvurem" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-probe-name "Z3_get_probe_name" (_fun _z3-context _uint -> _string))
(define-z3 mk-fpa-min "Z3_mk_fpa_min" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fixedpoint "Z3_mk_fixedpoint" (_fun _z3-context -> _z3-fixedpoint))
(define-z3 goal-reset! "Z3_goal_reset" (_fun _z3-context _z3-goal -> _void))
(define-z3 param-descrs-size "Z3_param_descrs_size" (_fun _z3-context _z3-param-descrs -> _uint))
(define-z3 mk-fpa-numeral-double "Z3_mk_fpa_numeral_double" (_fun _z3-context _double _z3-sort -> _z3-ast))
(define-z3 mk-constructor-list "Z3_mk_constructor_list"
  (_fun (c constructors) ::
   (c : _z3-context)
   (num-constructors : _uint = (length constructors))
   (constructors : (_list i _z3-constructor))
   -> _z3-constructor-list))
(define-z3 close-log! "Z3_close_log" (_fun -> _void))
(define-z3 ast-vector-dec-ref! "Z3_ast_vector_dec_ref" (_fun _z3-context _z3-ast-vector -> _void))
(define-z3 get-tactic-name "Z3_get_tactic_name" (_fun _z3-context _uint -> _string))
(define-z3 fpa-get-numeral-exponent-string "Z3_fpa_get_numeral_exponent_string" (_fun _z3-context _z3-ast -> _string))
(define-z3 ast-vector-size "Z3_ast_vector_size" (_fun _z3-context _z3-ast-vector -> _uint))
(define-z3 mk-fpa-geq "Z3_mk_fpa_geq" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 algebraic-roots "Z3_algebraic_roots"
  (_fun (c p a) ::
        (c : _z3-context)
        (p : _z3-ast)
        (n : _uint = (length a))
        (a : (_list i _z3-ast))
        -> _z3-ast-vector))
(define-z3 algebraic-div "Z3_algebraic_div" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 simplify "Z3_simplify" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 fixedpoint-get-assertions "Z3_fixedpoint_get_assertions" (_fun _z3-context _z3-fixedpoint -> _z3-ast-vector))
(define-z3 mk-and "Z3_mk_and"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 probe-or "Z3_probe_or" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 params-set-uint! "Z3_params_set_uint" (_fun _z3-context _z3-params _z3-symbol _uint -> _void))
(define-z3 goal-assert! "Z3_goal_assert" (_fun _z3-context _z3-goal _z3-ast -> _void))
(define-z3 get-numeral-small "Z3_get_numeral_small"
  (_fun
   (c : _z3-context)
   (a : _z3-ast)
   (num : (_ptr o _int64))
   (den : (_ptr o _int64))
   -> (res : _bool)
   -> (values res num den)))
(define-z3 finalize-memory! "Z3_finalize_memory" (_fun -> _void))
(define-z3 mk-bvmul-no-overflow "Z3_mk_bvmul_no_overflow" (_fun _z3-context _z3-ast _z3-ast _bool -> _z3-ast))
(define-z3 algebraic-root "Z3_algebraic_root" (_fun _z3-context _z3-ast _uint -> _z3-ast))
(define-z3 del-constructor! "Z3_del_constructor" (_fun _z3-context _z3-constructor -> _void))
(define-z3 solver->string "Z3_solver_to_string" (_fun _z3-context _z3-solver -> _string))
(define-z3 mk-tuple-sort "Z3_mk_tuple_sort"
  (_fun (c mk-tuple-name field-names+field-sorts) ::
   (c : _z3-context)
   (mk-tuple-name : _z3-symbol)
   (num-fields : _uint = (length field-names+field-sorts))
   (field-names : (_list i _z3-symbol) = (map car field-names+field-sorts))
   (field-sorts : (_list i _z3-sort) = (map cdr field-names+field-sorts))
   (mk-tuple-decl : (_ptr o _z3-func-decl))
   (proj-decl : (_list o _z3-func-decl num-fields))
   -> (res : _z3-sort)
   -> (values res mk-tuple-decl proj-decl)))
(define-z3 append-log! "Z3_append_log" (_fun _string -> _void))
(define-z3 algebraic-number? "Z3_is_algebraic_number" (_fun _z3-context _z3-ast -> _bool))
(define-z3 mk-not "Z3_mk_not" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 rcf-get-numerator-denominator "Z3_rcf_get_numerator_denominator"
  (_fun
   (c : _z3-context)
   (a : _z3-rcf-num)
   (n : (_ptr o _z3-rcf-num))
   (d : (_ptr o _z3-rcf-num))
   -> _void
   -> (values n d)))
(define-z3 mk-bvneg "Z3_mk_bvneg" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 goal-formula "Z3_goal_formula" (_fun _z3-context _z3-goal _uint -> _z3-ast))
(define-z3 mk-bvsub-no-overflow "Z3_mk_bvsub_no_overflow" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-real "Z3_mk_real" (_fun _z3-context _int _int -> _z3-ast))
(define-z3 rcf-neq "Z3_rcf_neq" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _bool))
(define-z3 get-numeral-decimal-string "Z3_get_numeral_decimal_string" (_fun _z3-context _z3-ast _uint -> _string))
(define-z3 parse-smtlib2-string "Z3_parse_smtlib2_string"
  (_fun (c str sort-names+sorts decl-names+decls) ::
   (c : _z3-context)
   (str : _string)
   (num-sorts : _uint = (length sort-names+sorts))
   (sort-names : (_list i _z3-symbol) = (map car sort-names+sorts))
   (sorts : (_list i _z3-sort) = (map cdr sort-names+sorts))
   (num-decls : _uint = (length decl-names+decls))
   (decl-names : (_list i _z3-symbol) = (map car decl-names+decls))
   (decls : (_list i _z3-func-decl) = (map cdr decl-names+decls))
   -> _z3-ast))
(define-z3 solver-push! "Z3_solver_push" (_fun _z3-context _z3-solver -> _void))
(define-z3 fixedpoint-set-predicate-representation! "Z3_fixedpoint_set_predicate_representation"
  (_fun (c d f relation-kinds) ::
   (c : _z3-context)
   (d : _z3-fixedpoint)
   (f : _z3-func-decl)
   (num-relations : _uint = (length relation-kinds))
   (relation-kinds : (_list i _z3-symbol))
   -> _void))
(define-z3 mk-bvashr "Z3_mk_bvashr" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-bvsmod "Z3_mk_bvsmod" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 tactic-par-and-then "Z3_tactic_par_and_then" (_fun _z3-context _z3-tactic _z3-tactic -> _z3-tactic))
(define-z3 mk-div "Z3_mk_div" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 func-entry-dec-ref! "Z3_func_entry_dec_ref" (_fun _z3-context _z3-func-entry -> _void))
(define-z3 rcf-power "Z3_rcf_power" (_fun _z3-context _z3-rcf-num _uint -> _z3-rcf-num))
(define-z3 func-entry-get-arg "Z3_func_entry_get_arg" (_fun _z3-context _z3-func-entry _uint -> _z3-ast))
(define-z3 mk-bvxor "Z3_mk_bvxor" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 func-decl->ast "Z3_func_decl_to_ast" (_fun _z3-context _z3-func-decl -> _z3-ast))
(define-z3 fixedpoint-from-string "Z3_fixedpoint_from_string" (_fun _z3-context _z3-fixedpoint _string -> _z3-ast-vector))
(define-z3 interrupt! "Z3_interrupt" (_fun _z3-context -> _void))
(define-z3 get-ast-hash "Z3_get_ast_hash" (_fun _z3-context _z3-ast -> _uint))
(define-z3 tactic-fail-if "Z3_tactic_fail_if" (_fun _z3-context _z3-probe -> _z3-tactic))
(define-z3 rcf-ge "Z3_rcf_ge" (_fun _z3-context _z3-rcf-num _z3-rcf-num -> _bool))
(define-z3 to-app "Z3_to_app" (_fun _z3-context _z3-ast -> _z3-app))
(define-z3 fixedpoint-register-relation! "Z3_fixedpoint_register_relation" (_fun _z3-context _z3-fixedpoint _z3-func-decl -> _void))
(define-z3 tactic-get-help "Z3_tactic_get_help" (_fun _z3-context _z3-tactic -> _string))
(define-z3 numeral-ast? "Z3_is_numeral_ast" (_fun _z3-context _z3-ast -> _bool))
(define-z3 func-decl->string "Z3_func_decl_to_string" (_fun _z3-context _z3-func-decl -> _string))
(define-z3 mk-bool-sort "Z3_mk_bool_sort" (_fun _z3-context -> _z3-sort))
(define-z3 mk-fpa->fp-float "Z3_mk_fpa_to_fp_float" (_fun _z3-context _z3-ast _z3-ast _z3-sort -> _z3-ast))
(define-z3 get-quantifier-num-bound "Z3_get_quantifier_num_bound" (_fun _z3-context _z3-ast -> _uint))
(define-z3 solver-pop! "Z3_solver_pop" (_fun _z3-context _z3-solver _uint -> _void))
(define-z3 mk-real2int "Z3_mk_real2int" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 get-decl-int-parameter "Z3_get_decl_int_parameter" (_fun _z3-context _z3-func-decl _uint -> _int))
(define-z3 app->ast "Z3_app_to_ast" (_fun _z3-context _z3-app -> _z3-ast))
(define-z3 mk-set-add "Z3_mk_set_add" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-quantifier-pattern-ast "Z3_get_quantifier_pattern_ast" (_fun _z3-context _z3-ast _uint -> _z3-pattern))
(define-z3 ast-map-find "Z3_ast_map_find" (_fun _z3-context _z3-ast-map _z3-ast -> _z3-ast))
(define-z3 mk-goal "Z3_mk_goal" (_fun _z3-context _bool _bool _bool -> _z3-goal))
(define-z3 mk-int "Z3_mk_int" (_fun _z3-context _int _z3-sort -> _z3-ast))
(define-z3 solver-get-reason-unknown "Z3_solver_get_reason_unknown" (_fun _z3-context _z3-solver -> _string))
(define-z3 mk-ext-rotate-right "Z3_mk_ext_rotate_right" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-set-intersect "Z3_mk_set_intersect"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 get-numeral-string "Z3_get_numeral_string" (_fun _z3-context _z3-ast -> _string))
(define-z3 mk-bvmul "Z3_mk_bvmul" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-mod "Z3_mk_mod" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-app-num-args "Z3_get_app_num_args" (_fun _z3-context _z3-app -> _uint))
(define-z3 params-set-double! "Z3_params_set_double" (_fun _z3-context _z3-params _z3-symbol _double -> _void))
(define-z3 get-pattern-num-terms "Z3_get_pattern_num_terms" (_fun _z3-context _z3-pattern -> _uint))
(define-z3 params-set-bool! "Z3_params_set_bool" (_fun _z3-context _z3-params _z3-symbol _bool -> _void))
(define-z3 probe-and "Z3_probe_and" (_fun _z3-context _z3-probe _z3-probe -> _z3-probe))
(define-z3 mk-concat "Z3_mk_concat" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-sort-128 "Z3_mk_fpa_sort_128" (_fun _z3-context -> _z3-sort))
(define-z3 solver-get-statistics "Z3_solver_get_statistics" (_fun _z3-context _z3-solver -> _z3-stats))
(define-z3 mk-xor "Z3_mk_xor" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-error-msg "Z3_get_error_msg" (_fun _z3-error-code -> _string))
(define-z3 mk-fpa-lt "Z3_mk_fpa_lt" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-numeral-rational-int64 "Z3_get_numeral_rational_int64"
  (_fun
   (c : _z3-context)
   (v : _z3-ast)
   (num : (_ptr o _int64))
   (den : (_ptr o _int64))
   -> (res : _bool)
   -> (values res num den)))
(define-z3 substitute-vars "Z3_substitute_vars"
  (_fun (c a to) ::
   (c : _z3-context)
   (a : _z3-ast)
   (num-exprs : _uint = (length to))
   (to : (_list i _z3-ast))
   -> _z3-ast))
(define-z3 param-descrs-get-kind "Z3_param_descrs_get_kind" (_fun _z3-context _z3-param-descrs _z3-symbol -> _z3-param-kind))
(define-z3 probe-get-descr "Z3_probe_get_descr" (_fun _z3-context _string -> _string))
(define-z3 mk-implies "Z3_mk_implies" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-fpa-add "Z3_mk_fpa_add" (_fun _z3-context _z3-ast _z3-ast _z3-ast -> _z3-ast))
(define-z3 model-get-const-decl "Z3_model_get_const_decl" (_fun _z3-context _z3-model _uint -> _z3-func-decl))
(define-z3 mk-bvnot "Z3_mk_bvnot" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 params-inc-ref! "Z3_params_inc_ref" (_fun _z3-context _z3-params -> _void))
(define-z3 algebraic-eval "Z3_algebraic_eval"
  (_fun (c p a) ::
        (c : _z3-context)
        (p : _z3-ast)
        (n : _uint = (length a))
        (a : (_list i _z3-ast))
        -> _int))
(define-z3 get-tuple-sort-field-decl "Z3_get_tuple_sort_field_decl" (_fun _z3-context _z3-sort _uint -> _z3-func-decl))
(define-z3 get-denominator "Z3_get_denominator" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 mk-unary-minus "Z3_mk_unary_minus" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 fixedpoint-from-file "Z3_fixedpoint_from_file" (_fun _z3-context _z3-fixedpoint _string -> _z3-ast-vector))
(define-z3 get-quantifier-num-no-patterns "Z3_get_quantifier_num_no_patterns" (_fun _z3-context _z3-ast -> _uint))
(define-z3 mk-mul "Z3_mk_mul"
  (_fun (c args) ::
        (c : _z3-context)
        (num-args : _uint = (length args))
        (args : (_list i _z3-ast))
        -> _z3-ast))
(define-z3 mk-exists-const "Z3_mk_exists_const"
  (_fun (c weight bound patterns body) ::
   (c : _z3-context)
   (weight : _uint)
   (num-bound : _uint = (length bound))
   (bound : (_list i _z3-app))
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 mk-quantifier-const-ex "Z3_mk_quantifier_const_ex"
  (_fun (c is-forall weight quantifier-id skolem-id bound patterns no-patterns body) ::
   (c : _z3-context)
   (is-forall : _bool)
   (weight : _uint)
   (quantifier-id : _z3-symbol)
   (skolem-id : _z3-symbol)
   (num-bound : _uint = (length bound))
   (bound : (_list i _z3-app))
   (num-patterns : _uint = (length patterns))
   (patterns : (_list i _z3-pattern))
   (num-no-patterns : _uint = (length no-patterns))
   (no-patterns : (_list i _z3-ast))
   (body : _z3-ast)
   -> _z3-ast))
(define-z3 goal-size "Z3_goal_size" (_fun _z3-context _z3-goal -> _uint))
(define-z3 mk-fpa-rne "Z3_mk_fpa_rne" (_fun _z3-context -> _z3-ast))
(define-z3 optimize-get-reason-unknown "Z3_optimize_get_reason_unknown" (_fun _z3-context _z3-optimize -> _string))
(define-z3 mk-iff "Z3_mk_iff" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 stats-get-key "Z3_stats_get_key" (_fun _z3-context _z3-stats _uint -> _string))
(define-z3 get-numerator "Z3_get_numerator" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 mk-bvudiv "Z3_mk_bvudiv" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 mk-simple-solver "Z3_mk_simple_solver" (_fun _z3-context -> _z3-solver))
(define-z3 mk-array-sort "Z3_mk_array_sort" (_fun _z3-context _z3-sort _z3-sort -> _z3-sort))
(define-z3 mk-const "Z3_mk_const" (_fun _z3-context _z3-symbol _z3-sort -> _z3-app))
(define-z3 func-interp-get-arity "Z3_func_interp_get_arity" (_fun _z3-context _z3-func-interp -> _uint))
(define-z3 mk-bvsdiv-no-overflow "Z3_mk_bvsdiv_no_overflow" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 stats-get-double-value "Z3_stats_get_double_value" (_fun _z3-context _z3-stats _uint -> _double))
(define-z3 mk-fpa-neg "Z3_mk_fpa_neg" (_fun _z3-context _z3-ast -> _z3-ast))
(define-z3 algebraic-ge "Z3_algebraic_ge" (_fun _z3-context _z3-ast _z3-ast -> _bool))
(define-z3 mk-fpa-rem "Z3_mk_fpa_rem" (_fun _z3-context _z3-ast _z3-ast -> _z3-ast))
(define-z3 get-decl-ast-parameter "Z3_get_decl_ast_parameter" (_fun _z3-context _z3-func-decl _uint -> _z3-ast))
(define-z3 ast-map-contains "Z3_ast_map_contains" (_fun _z3-context _z3-ast-map _z3-ast -> _bool))

(define z3-null #f)
(define z3-null? not)
(provide z3-null z3-null?)
