#lang typed/racket/base

(provide (all-defined-out))

(require "ffi.rkt")

(define-type
  Z3-Parameter-Kind
  (U
   'parameter-int
   'parameter-double
   'parameter-rational
   'parameter-symbol
   'parameter-sort
   'parameter-ast
   'parameter-func-decl))
(define-type Z3-Ast-Kind (U 'numeral-ast 'app-ast 'var-ast 'quantifier-ast 'sort-ast 'func-decl-ast 'unknown-ast))
(define-type
  Z3-Decl-Kind
  (U
   'op-true
   'op-false
   'op-eq
   'op-distinct
   'op-ite
   'op-and
   'op-or
   'op-iff
   'op-xor
   'op-not
   'op-implies
   'op-oeq
   'op-interp
   'op-anum
   'op-agnum
   'op-le
   'op-ge
   'op-lt
   'op-gt
   'op-add
   'op-sub
   'op-uminus
   'op-mul
   'op-div
   'op-idiv
   'op-rem
   'op-mod
   'op-to-real
   'op-to-int
   'op-is-int
   'op-power
   'op-store
   'op-select
   'op-const-array
   'op-array-map
   'op-array-default
   'op-set-union
   'op-set-intersect
   'op-set-difference
   'op-set-complement
   'op-set-subset
   'op-as-array
   'op-bnum
   'op-bit1
   'op-bit0
   'op-bneg
   'op-badd
   'op-bsub
   'op-bmul
   'op-bsdiv
   'op-budiv
   'op-bsrem
   'op-burem
   'op-bsmod
   'op-bsdiv0
   'op-budiv0
   'op-bsrem0
   'op-burem0
   'op-bsmod0
   'op-uleq
   'op-sleq
   'op-ugeq
   'op-sgeq
   'op-ult
   'op-slt
   'op-ugt
   'op-sgt
   'op-band
   'op-bor
   'op-bnot
   'op-bxor
   'op-bnand
   'op-bnor
   'op-bxnor
   'op-concat
   'op-sign-ext
   'op-zero-ext
   'op-extract
   'op-repeat
   'op-bredor
   'op-bredand
   'op-bcomp
   'op-bshl
   'op-blshr
   'op-bashr
   'op-rotate-left
   'op-rotate-right
   'op-ext-rotate-left
   'op-ext-rotate-right
   'op-int2bv
   'op-bv2int
   'op-carry
   'op-xor3
   'op-pr-undef
   'op-pr-true
   'op-pr-asserted
   'op-pr-goal
   'op-pr-modus-ponens
   'op-pr-reflexivity
   'op-pr-symmetry
   'op-pr-transitivity
   'op-pr-transitivity-star
   'op-pr-monotonicity
   'op-pr-quant-intro
   'op-pr-distributivity
   'op-pr-and-elim
   'op-pr-not-or-elim
   'op-pr-rewrite
   'op-pr-rewrite-star
   'op-pr-pull-quant
   'op-pr-pull-quant-star
   'op-pr-push-quant
   'op-pr-elim-unused-vars
   'op-pr-der
   'op-pr-quant-inst
   'op-pr-hypothesis
   'op-pr-lemma
   'op-pr-unit-resolution
   'op-pr-iff-true
   'op-pr-iff-false
   'op-pr-commutativity
   'op-pr-def-axiom
   'op-pr-def-intro
   'op-pr-apply-def
   'op-pr-iff-oeq
   'op-pr-nnf-pos
   'op-pr-nnf-neg
   'op-pr-nnf-star
   'op-pr-cnf-star
   'op-pr-skolemize
   'op-pr-modus-ponens-oeq
   'op-pr-th-lemma
   'op-pr-hyper-resolve
   'op-ra-store
   'op-ra-empty
   'op-ra-is-empty
   'op-ra-join
   'op-ra-union
   'op-ra-widen
   'op-ra-project
   'op-ra-filter
   'op-ra-negation-filter
   'op-ra-rename
   'op-ra-complement
   'op-ra-select
   'op-ra-clone
   'op-fd-lt
   'op-label
   'op-label-lit
   'op-dt-constructor
   'op-dt-recogniser
   'op-dt-accessor
   'op-dt-update-field
   'op-pb-at-most
   'op-pb-le
   'op-pb-ge
   'op-fpa-rm-nearest-ties-to-even
   'op-fpa-rm-nearest-ties-to-away
   'op-fpa-rm-toward-positive
   'op-fpa-rm-toward-negative
   'op-fpa-rm-toward-zero
   'op-fpa-num
   'op-fpa-plus-inf
   'op-fpa-minus-inf
   'op-fpa-nan
   'op-fpa-plus-zero
   'op-fpa-minus-zero
   'op-fpa-add
   'op-fpa-sub
   'op-fpa-neg
   'op-fpa-mul
   'op-fpa-div
   'op-fpa-rem
   'op-fpa-abs
   'op-fpa-min
   'op-fpa-max
   'op-fpa-fma
   'op-fpa-sqrt
   'op-fpa-round-to-integral
   'op-fpa-eq
   'op-fpa-lt
   'op-fpa-gt
   'op-fpa-le
   'op-fpa-ge
   'op-fpa-is-nan
   'op-fpa-is-inf
   'op-fpa-is-zero
   'op-fpa-is-normal
   'op-fpa-is-subnormal
   'op-fpa-is-negative
   'op-fpa-is-positive
   'op-fpa-fp
   'op-fpa-to-fp
   'op-fpa-to-fp-unsigned
   'op-fpa-to-ubv
   'op-fpa-to-sbv
   'op-fpa-to-real
   'op-fpa-to-ieee-bv
   'op-uninterpreted))
(define-type
  Z3-Ast-Print-Mode
  (U 'print-smtlib-full 'print-low-level 'print-smtlib-compliant 'print-smtlib2-compliant))
(define-type Z3-Symbol-Kind (U 'int-symbol 'string-symbol))
(define-type
  Z3-Search-Failure
  (U 'no-failure 'unknown 'timeout 'memout-watermark 'canceled 'num-conflicts 'theory 'quantifiers))
(define-type Z3-Goal-Prec (U 'goal-precise 'goal-under 'goal-over 'goal-under-over))
(define-type Z3-Lbool (U 'l-false 'l-undef 'l-true))
(define-type Z3-Param-Kind (U 'pk-uint 'pk-bool 'pk-double 'pk-symbol 'pk-string 'pk-other 'pk-invalid))
(define-type
  Z3-Sort-Kind
  (U
   'uninterpreted-sort
   'bool-sort
   'int-sort
   'real-sort
   'bv-sort
   'array-sort
   'datatype-sort
   'relation-sort
   'finite-domain-sort
   'floating-point-sort
   'rounding-mode-sort
   'unknown-sort))
(define-type
  Z3-Error-Code
  (U
   'ok
   'sort-error
   'iob
   'invalid-arg
   'parser-error
   'no-parser
   'invalid-pattern
   'memout-fail
   'file-access-error
   'internal-fatal
   'invalid-usage
   'dec-ref-error
   'exception))

(require/typed/provide "ffi.rkt"
  [#:opaque Z3-Fixedpoint z3-fixedpoint?]
  [#:opaque Z3-Param-Descrs z3-param-descrs?]
  [#:opaque Z3-Solver z3-solver?]
  [#:opaque Z3-Constructor z3-constructor?]
  [#:opaque Z3-Ast-Map z3-ast-map?]
  [#:opaque Z3-Ast z3-ast?]
  [#:opaque Z3-Stats z3-stats?]
  [#:opaque Z3-Ast-Vector z3-ast-vector?]
  [#:opaque Z3-Probe z3-probe?]
  [#:opaque Z3-Theory z3-theory?]
  [#:opaque Z3-Func-Interp z3-func-interp?]
  [#:opaque Z3-Goal z3-goal?]
  [#:opaque Z3-Func-Entry z3-func-entry?]
  [#:opaque Z3-Sort z3-sort?]
  [#:opaque Z3-Symbol z3-symbol?]
  [#:opaque Z3-Bool z3-bool?]
  [#:opaque Z3-Func-Decl z3-func-decl?]
  [#:opaque Z3-Optimize z3-optimize?]
  [#:opaque Z3-Model z3-model?]
  [#:opaque Z3-Config z3-config?]
  [#:opaque Z3-Pattern z3-pattern?]
  [#:opaque Z3-Apply-Result z3-apply-result?]
  [#:opaque Z3-Theory-Data z3-theory-data?]
  [#:opaque Z3-App z3-app?]
  [#:opaque Z3-Constructor-List z3-constructor-list?]
  [#:opaque Z3-Params z3-params?]
  [#:opaque Z3-String z3-string?]
  [#:opaque Z3-Tactic z3-tactic?]
  [#:opaque Z3-Rcf-Num z3-rcf-num?]
  [#:opaque Z3-Context z3-context?]
  [#:opaque Z3-Null z3-null?]
  [z3-null Z3-Null])

(require/typed/provide "ffi.rkt"
  [mk-map (Z3-Context Z3-Func-Decl (Listof Z3-Ast) → Z3-Ast)]
  [fixedpoint-set-params! (Z3-Context Z3-Fixedpoint Z3-Params → Void)]
  [get-finite-domain-sort-size (Z3-Context Z3-Sort → (Option Nonnegative-Fixnum))]
  [mk-implies (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-quantifier-pattern-ast (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Pattern)]
  [get-sort-kind (Z3-Context Z3-Sort → Z3-Sort-Kind)]
  [mk-set-complement (Z3-Context Z3-Ast → Z3-Ast)]
  [algebraic-is-zero? (Z3-Context Z3-Ast → Boolean)]
  [solver-assert! (Z3-Context Z3-Solver Z3-Ast → Void)]
  [mk-set-union (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [stats-is-uint? (Z3-Context Z3-Stats Nonnegative-Fixnum → Boolean)]
  [ast->string (Z3-Context Z3-Ast → String)]
  [optimize-assert! (Z3-Context Z3-Optimize Z3-Ast → Void)]
  [algebraic-gt (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [mk-fpa-sort-32 (Z3-Context → Z3-Sort)]
  [get-ast-hash (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [mk-fpa-eq (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [model-get-func-interp (Z3-Context Z3-Model Z3-Func-Decl → Z3-Func-Interp)]
  [ast-map-find (Z3-Context Z3-Ast-Map Z3-Ast → Z3-Ast)]
  [mk-or (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [get-numeral-int (Z3-Context Z3-Ast → (Option Fixnum))]
  [goal->string (Z3-Context Z3-Goal → String)]
  [mk-set-member (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-pattern (Z3-Context Z3-Pattern Nonnegative-Fixnum → Z3-Ast)]
  [algebraic-eq (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [algebraic-lt (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [tactic-get-help (Z3-Context Z3-Tactic → String)]
  [global-param-set! (String String → Void)]
  [algebraic-div (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [del-config! (Z3-Config → Void)]
  [tactic-repeat (Z3-Context Z3-Tactic Nonnegative-Fixnum → Z3-Tactic)]
  [probe-or (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [mk-bvsub (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-le (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-bool-sort (Z3-Context → Z3-Sort)]
  [stats-get-key (Z3-Context Z3-Stats Nonnegative-Fixnum → String)]
  [func-decl->string (Z3-Context Z3-Func-Decl → String)]
  [algebraic-power (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [interrupt! (Z3-Context → Void)]
  [mk-bvredand (Z3-Context Z3-Ast → Z3-Ast)]
  [probe-eq (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [get-app-num-args (Z3-Context Z3-App → Nonnegative-Fixnum)]
  [mk-int-symbol (Z3-Context Fixnum → Z3-Symbol)]
  [fixedpoint-get-statistics (Z3-Context Z3-Fixedpoint → Z3-Stats)]
  [mk-bvmul-no-overflow (Z3-Context Z3-Ast Z3-Ast Boolean → Z3-Ast)]
  [param-descrs->string (Z3-Context Z3-Param-Descrs → String)]
  [algebraic-eval (Z3-Context Z3-Ast (Listof Z3-Ast) → Fixnum)]
  [mk-set-intersect (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [polynomial-subresultants (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast-Vector)]
  [solver-check (Z3-Context Z3-Solver → Z3-Lbool)]
  [tactic-try-for (Z3-Context Z3-Tactic Nonnegative-Fixnum → Z3-Tactic)]
  [stats-get-double-value (Z3-Context Z3-Stats Nonnegative-Fixnum → Flonum)]
  [ast-vector-inc-ref! (Z3-Context Z3-Ast-Vector → Void)]
  [simplify (Z3-Context Z3-Ast → Z3-Ast)]
  [quantifier-forall? (Z3-Context Z3-Ast → Boolean)]
  [func-entry-dec-ref! (Z3-Context Z3-Func-Entry → Void)]
  [mk-lt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [solver-get-param-descrs (Z3-Context Z3-Solver → Z3-Param-Descrs)]
  [mk-datatypes (Z3-Context (Listof (Pairof Z3-Symbol Z3-Constructor-List)) → (Listof Z3-Sort))]
  [param-descrs-inc-ref! (Z3-Context Z3-Param-Descrs → Void)]
  [get-numeral-uint64 (Z3-Context Z3-Ast → (Option Nonnegative-Fixnum))]
  [algebraic-ge (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [global-param-reset-all! (→ Void)]
  [params-set-double! (Z3-Context Z3-Params Z3-Symbol Flonum → Void)]
  [optimize-maximize (Z3-Context Z3-Optimize Z3-Ast → Nonnegative-Fixnum)]
  [tactic-using-params (Z3-Context Z3-Tactic Z3-Params → Z3-Tactic)]
  [tactic-skip (Z3-Context → Z3-Tactic)]
  [mk-fpa-geq (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-nan (Z3-Context Z3-Sort → Z3-Ast)]
  [mk-fpa-round-toward-zero (Z3-Context → Z3-Ast)]
  [get-decl-kind (Z3-Context Z3-Func-Decl → Z3-Decl-Kind)]
  [mk-app (Z3-Context Z3-Func-Decl (Listof Z3-Ast) → Z3-Ast)]
  [model->string (Z3-Context Z3-Model → String)]
  [probe-le (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [get-decl-sort-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Z3-Sort)]
  [solver-pop! (Z3-Context Z3-Solver Nonnegative-Fixnum → Void)]
  [ast-vector-push! (Z3-Context Z3-Ast-Vector Z3-Ast → Void)]
  [mk-ast-map (Z3-Context → Z3-Ast-Map)]
  [apply-result->string (Z3-Context Z3-Apply-Result → String)]
  [mk-bvsge (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [rcf-mk-infinitesimal (Z3-Context → Z3-Rcf-Num)]
  [mk-numeral (Z3-Context String Z3-Sort → Z3-Ast)]
  [pattern->ast (Z3-Context Z3-Pattern → Z3-Ast)]
  [mk-ext-rotate-left (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [tactic-dec-ref! (Z3-Context Z3-Tactic → Void)]
  [fixedpoint-add-rule! (Z3-Context Z3-Fixedpoint Z3-Ast Z3-Symbol → Void)]
  [solver-assert-and-track! (Z3-Context Z3-Solver Z3-Ast Z3-Ast → Void)]
  [algebraic-mul (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-is-infinite (Z3-Context Z3-Ast → Z3-Ast)]
  [tactic-apply (Z3-Context Z3-Tactic Z3-Goal → Z3-Apply-Result)]
  [mk-div (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-int2real (Z3-Context Z3-Ast → Z3-Ast)]
  [mk-finite-domain-sort (Z3-Context Z3-Symbol Nonnegative-Fixnum → Z3-Sort)]
  [ast-map-size (Z3-Context Z3-Ast-Map → Nonnegative-Fixnum)]
  [mk-fpa-inf (Z3-Context Z3-Sort Boolean → Z3-Ast)]
  [params-set-symbol! (Z3-Context Z3-Params Z3-Symbol Z3-Symbol → Void)]
  [apply-result-get-subgoal (Z3-Context Z3-Apply-Result Nonnegative-Fixnum → Z3-Goal)]
  [get-numeral-rational-int64 (Z3-Context Z3-Ast → (Values Boolean Fixnum Fixnum))]
  [fixedpoint-get-param-descrs (Z3-Context Z3-Fixedpoint → Z3-Param-Descrs)]
  [algebraic-roots (Z3-Context Z3-Ast (Listof Z3-Ast) → Z3-Ast-Vector)]
  [fixedpoint-update-rule! (Z3-Context Z3-Fixedpoint Z3-Ast Z3-Symbol → Void)]
  [fpa-get-numeral-exponent-string (Z3-Context Z3-Ast → String)]
  [fixedpoint-dec-ref! (Z3-Context Z3-Fixedpoint → Void)]
  [get-tactic-name (Z3-Context Nonnegative-Fixnum → String)]
  [tactic-when (Z3-Context Z3-Probe Z3-Tactic → Z3-Tactic)]
  [probe-dec-ref! (Z3-Context Z3-Probe → Void)]
  [mk-bvsmod (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [optimize-check (Z3-Context Z3-Optimize → Z3-Lbool)]
  [mk-zero-ext (Z3-Context Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [tactic-fail-if (Z3-Context Z3-Probe → Z3-Tactic)]
  [fixedpoint-from-string (Z3-Context Z3-Fixedpoint String → Z3-Ast-Vector)]
  [mk-unsigned-int (Z3-Context Nonnegative-Fixnum Z3-Sort → Z3-Ast)]
  [get-func-decl-id (Z3-Context Z3-Func-Decl → Nonnegative-Fixnum)]
  [mk-bvshl (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-bvsgt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-quantifier-num-no-patterns (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [get-numeral-int64 (Z3-Context Z3-Ast → (Option Fixnum))]
  [mk-fpa->fp-real (Z3-Context Z3-Ast Z3-Ast Z3-Sort → Z3-Ast)]
  [mk-bvslt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [to-app (Z3-Context Z3-Ast → Z3-App)]
  [probe-not (Z3-Context Z3-Probe → Z3-Probe)]
  [model-has-interp (Z3-Context Z3-Model Z3-Func-Decl → Boolean)]
  [func-entry-get-arg (Z3-Context Z3-Func-Entry Nonnegative-Fixnum → Z3-Ast)]
  [get-error-code (Z3-Context → Z3-Error-Code)]
  [mk-bvredor (Z3-Context Z3-Ast → Z3-Ast)]
  [mk-params (Z3-Context → Z3-Params)]
  [ast-map->string (Z3-Context Z3-Ast-Map → String)]
  [optimize-pop! (Z3-Context Z3-Optimize → Void)]
  [mk-set-sort (Z3-Context Z3-Sort → Z3-Sort)]
  [algebraic-neq (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [func-interp-get-arity (Z3-Context Z3-Func-Interp → Nonnegative-Fixnum)]
  [mk-bvadd (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-select (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [solver-check-assumptions (Z3-Context Z3-Solver (Listof Z3-Ast) → Z3-Lbool)]
  [get-decl-func-decl-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Z3-Func-Decl)]
  [rcf-ge (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Boolean)]
  [get-numeral-decimal-string (Z3-Context Z3-Ast Nonnegative-Fixnum → String)]
  [mk-power (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-repeat (Z3-Context Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [dec-ref! (Z3-Context Z3-Ast → Void)]
  [tactic-par-and-then (Z3-Context Z3-Tactic Z3-Tactic → Z3-Tactic)]
  [mk-bvand (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-set-subset (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [fixedpoint-get-help (Z3-Context Z3-Fixedpoint → String)]
  [tactic-fail (Z3-Context → Z3-Tactic)]
  [mk-unary-minus (Z3-Context Z3-Ast → Z3-Ast)]
  [tactic-or-else (Z3-Context Z3-Tactic Z3-Tactic → Z3-Tactic)]
  [rcf-gt (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Boolean)]
  [mk-add (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [mk-exists-const (Z3-Context Nonnegative-Fixnum (Listof Z3-App) (Listof Z3-Pattern) Z3-Ast → Z3-Ast)]
  [get-symbol-string (Z3-Context Z3-Symbol → String)]
  [stats-inc-ref! (Z3-Context Z3-Stats → Void)]
  [solver-get-model (Z3-Context Z3-Solver → Z3-Model)]
  [func-entry-get-value (Z3-Context Z3-Func-Entry → Z3-Ast)]
  [get-index-value (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [open-log (String → Boolean)]
  [func-entry-get-num-args (Z3-Context Z3-Func-Entry → Nonnegative-Fixnum)]
  [get-probe-name (Z3-Context Nonnegative-Fixnum → String)]
  [mk-quantifier
   (Z3-Context Boolean Nonnegative-Fixnum (Listof Z3-Pattern) (Listof (Pairof Z3-Sort Z3-Symbol)) Z3-Ast → Z3-Ast)]
  [mk-bvnot (Z3-Context Z3-Ast → Z3-Ast)]
  [global-param-get (String → (Option String))]
  [model-get-const-decl (Z3-Context Z3-Model Nonnegative-Fixnum → Z3-Func-Decl)]
  [del-context! (Z3-Context → Void)]
  [goal-translate (Z3-Context Z3-Goal Z3-Context → Z3-Goal)]
  [del-constructor-list! (Z3-Context Z3-Constructor-List → Void)]
  [get-sort (Z3-Context Z3-Ast → Z3-Sort)]
  [algebraic-sign (Z3-Context Z3-Ast → Fixnum)]
  [tactic-par-or (Z3-Context (Listof Z3-Tactic) → Z3-Tactic)]
  [mk-fpa-rne (Z3-Context → Z3-Ast)]
  [solver-inc-ref! (Z3-Context Z3-Solver → Void)]
  [get-error-msg (Z3-Error-Code → String)]
  [get-datatype-sort-recognizer (Z3-Context Z3-Sort Nonnegative-Fixnum → Z3-Func-Decl)]
  [mk-fpa-is-zero (Z3-Context Z3-Ast → Z3-Ast)]
  [substitute-vars (Z3-Context Z3-Ast (Listof Z3-Ast) → Z3-Ast)]
  [apply-result-inc-ref! (Z3-Context Z3-Apply-Result → Void)]
  [toggle-warning-messages! (Boolean → Void)]
  [simplify-get-help (Z3-Context → String)]
  [mk-bvadd-no-underflow (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-round-toward-positive (Z3-Context → Z3-Ast)]
  [mk-fpa-round-nearest-ties->away (Z3-Context → Z3-Ast)]
  [mk-array-sort (Z3-Context Z3-Sort Z3-Sort → Z3-Sort)]
  [model-inc-ref! (Z3-Context Z3-Model → Void)]
  [get-relation-arity (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [mk-forall (Z3-Context Nonnegative-Fixnum (Listof Z3-Pattern) (Listof (Pairof Z3-Sort Z3-Symbol)) Z3-Ast → Z3-Ast)]
  [mk-iff (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [fpa-get-numeral-significand-string (Z3-Context Z3-Ast → String)]
  [get-numeral-uint (Z3-Context Z3-Ast → (Option Nonnegative-Fixnum))]
  [ast-vector-translate (Z3-Context Z3-Ast-Vector Z3-Context → Z3-Ast-Vector)]
  [mk-constructor-list (Z3-Context (Listof Z3-Constructor) → Z3-Constructor-List)]
  [ast-vector-size (Z3-Context Z3-Ast-Vector → Nonnegative-Fixnum)]
  [mk-fpa-numeral-int-uint (Z3-Context Boolean Fixnum Nonnegative-Fixnum Z3-Sort → Z3-Ast)]
  [mk-fpa->fp-unsigned (Z3-Context Z3-Ast Z3-Ast Z3-Sort → Z3-Ast)]
  [mk-int2bv (Z3-Context Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [mk-fpa-round->integral (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [func-entry-inc-ref! (Z3-Context Z3-Func-Entry → Void)]
  [model-get-sort-universe (Z3-Context Z3-Model Z3-Sort → Z3-Ast-Vector)]
  [mk-string-symbol (Z3-Context String → Z3-Symbol)]
  [mk-concat (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [set-ast-print-mode! (Z3-Context Z3-Ast-Print-Mode → Void)]
  [tactic-apply-ex (Z3-Context Z3-Tactic Z3-Goal Z3-Params → Z3-Apply-Result)]
  [mk-sign-ext (Z3-Context Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [enable-trace! (String → Void)]
  [mk-store (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [get-decl-double-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Flonum)]
  [mk-func-decl (Z3-Context Z3-Symbol (Listof Z3-Sort) Z3-Sort → Z3-Func-Decl)]
  [mk-fpa-add (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [tactic-get-descr (Z3-Context String → String)]
  [pattern->string (Z3-Context Z3-Pattern → String)]
  [get-decl-ast-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Z3-Ast)]
  [param-descrs-size (Z3-Context Z3-Param-Descrs → Nonnegative-Fixnum)]
  [get-ast-kind (Z3-Context Z3-Ast → Z3-Ast-Kind)]
  [algebraic-number? (Z3-Context Z3-Ast → Boolean)]
  [mk-fixedpoint (Z3-Context → Z3-Fixedpoint)]
  [params-dec-ref! (Z3-Context Z3-Params → Void)]
  [mk-bvurem (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-int (Z3-Context Fixnum Z3-Sort → Z3-Ast)]
  [mk-int64 (Z3-Context Fixnum Z3-Sort → Z3-Ast)]
  [get-as-array-func-decl (Z3-Context Z3-Ast → Z3-Func-Decl)]
  [rcf-mk-small-int (Z3-Context Fixnum → Z3-Rcf-Num)]
  [mk-fpa-sort-half (Z3-Context → Z3-Sort)]
  [params-validate! (Z3-Context Z3-Params Z3-Param-Descrs → Void)]
  [probe-apply (Z3-Context Z3-Probe Z3-Goal → Flonum)]
  [goal-dec-ref! (Z3-Context Z3-Goal → Void)]
  [mk-eq (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [close-log! (→ Void)]
  [update-param-value! (Z3-Context String String → Void)]
  [mk-full-set (Z3-Context Z3-Sort → Z3-Ast)]
  [probe-gt (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [simplify-get-param-descrs (Z3-Context → Z3-Param-Descrs)]
  [mk-bvor (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [optimize-assert-soft (Z3-Context Z3-Optimize Z3-Ast String Z3-Symbol → Nonnegative-Fixnum)]
  [mk-const-array (Z3-Context Z3-Sort Z3-Ast → Z3-Ast)]
  [model-get-num-funcs (Z3-Context Z3-Model → Nonnegative-Fixnum)]
  [get-ast-id (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [get-numeral-string (Z3-Context Z3-Ast → String)]
  [params-set-uint! (Z3-Context Z3-Params Z3-Symbol Nonnegative-Fixnum → Void)]
  [fixedpoint-set-predicate-representation! (Z3-Context Z3-Fixedpoint Z3-Func-Decl (Listof Z3-Symbol) → Void)]
  [mk-fpa->fp-float (Z3-Context Z3-Ast Z3-Ast Z3-Sort → Z3-Ast)]
  [mk-enumeration-sort
   (Z3-Context Z3-Symbol (Listof Z3-Symbol) → (Values Z3-Sort (Listof Z3-Func-Decl) (Listof Z3-Func-Decl)))]
  [mk-fpa-numeral-int64-uint64 (Z3-Context Boolean Fixnum Nonnegative-Fixnum Z3-Sort → Z3-Ast)]
  [model-get-num-sorts (Z3-Context Z3-Model → Nonnegative-Fixnum)]
  [mk-bvxnor (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [simplify-ex (Z3-Context Z3-Ast Z3-Params → Z3-Ast)]
  [sort->ast (Z3-Context Z3-Sort → Z3-Ast)]
  [mk-bvsub-no-overflow (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [solver->string (Z3-Context Z3-Solver → String)]
  [optimize-get-upper (Z3-Context Z3-Optimize Nonnegative-Fixnum → Z3-Ast)]
  [benchmark->smtlib-string (Z3-Context String String String String (Listof Z3-Ast) Z3-Ast → String)]
  [get-quantifier-bound-name (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Symbol)]
  [mk-real (Z3-Context Fixnum Fixnum → Z3-Ast)]
  [mk-fpa-mul (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [ast-map-keys (Z3-Context Z3-Ast-Map → Z3-Ast-Vector)]
  [get-symbol-kind (Z3-Context Z3-Symbol → Z3-Symbol-Kind)]
  [fixedpoint-get-cover-delta (Z3-Context Z3-Fixedpoint Fixnum Z3-Func-Decl → Z3-Ast)]
  [update-term (Z3-Context Z3-Ast (Listof Z3-Ast) → Z3-Ast)]
  [rcf-sub (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Z3-Rcf-Num)]
  [mk-fpa-sub (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [solver-reset! (Z3-Context Z3-Solver → Void)]
  [mk-bvmul (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [probe-const (Z3-Context Flonum → Z3-Probe)]
  [append-log! (String → Void)]
  [mk-fpa-rtp (Z3-Context → Z3-Ast)]
  [func-interp-get-else (Z3-Context Z3-Func-Interp → Z3-Ast)]
  [optimize-set-params! (Z3-Context Z3-Optimize Z3-Params → Void)]
  [model-get-const-interp (Z3-Context Z3-Model Z3-Func-Decl → Z3-Ast)]
  [mk-forall-const (Z3-Context Nonnegative-Fixnum (Listof Z3-App) (Listof Z3-Pattern) Z3-Ast → Z3-Ast)]
  [mk-solver (Z3-Context → Z3-Solver)]
  [mk-bvudiv (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-exists (Z3-Context Nonnegative-Fixnum (Listof Z3-Pattern) (Listof (Pairof Z3-Sort Z3-Symbol)) Z3-Ast → Z3-Ast)]
  [mk-fpa-is-positive (Z3-Context Z3-Ast → Z3-Ast)]
  [mk-fpa->sbv (Z3-Context Z3-Ast Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [mk-fpa-is-normal (Z3-Context Z3-Ast → Z3-Ast)]
  [get-quantifier-bound-sort (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Sort)]
  [mk-fpa-numeral-float (Z3-Context Single-Flonum Z3-Sort → Z3-Ast)]
  [mk-bvashr (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-symbol-int (Z3-Context Z3-Symbol → Fixnum)]
  [get-arity (Z3-Context Z3-Func-Decl → Nonnegative-Fixnum)]
  [optimize-minimize (Z3-Context Z3-Optimize Z3-Ast → Nonnegative-Fixnum)]
  [mk-mod (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-lt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-uninterpreted-sort (Z3-Context Z3-Symbol → Z3-Sort)]
  [get-bv-sort-size (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [tactic-get-param-descrs (Z3-Context Z3-Tactic → Z3-Param-Descrs)]
  [mk-context-rc (Z3-Config → Z3-Context)]
  [model-dec-ref! (Z3-Context Z3-Model → Void)]
  [mk-fpa-sqrt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [parse-smtlib2-file
   (Z3-Context String (Listof (Pairof Z3-Symbol Z3-Sort)) (Listof (Pairof Z3-Symbol Z3-Func-Decl)) → Z3-Ast)]
  [mk-pble (Z3-Context (Listof (Pairof Z3-Ast Fixnum)) Fixnum → Z3-Ast)]
  [mk-real2int (Z3-Context Z3-Ast → Z3-Ast)]
  [algebraic-root (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [mk-list-sort
   (Z3-Context
    Z3-Symbol
    Z3-Sort
    →
    (Values Z3-Sort Z3-Func-Decl Z3-Func-Decl Z3-Func-Decl Z3-Func-Decl Z3-Func-Decl Z3-Func-Decl))]
  [apply-result-get-num-subgoals (Z3-Context Z3-Apply-Result → Nonnegative-Fixnum)]
  [rcf-get-numerator-denominator (Z3-Context Z3-Rcf-Num → (Values Z3-Rcf-Num Z3-Rcf-Num))]
  [get-relation-column (Z3-Context Z3-Sort Nonnegative-Fixnum → Z3-Sort)]
  [tactic-inc-ref! (Z3-Context Z3-Tactic → Void)]
  [optimize-get-model (Z3-Context Z3-Optimize → Z3-Model)]
  [get-version (→ (Values Nonnegative-Fixnum Nonnegative-Fixnum Nonnegative-Fixnum Nonnegative-Fixnum))]
  [mk-bvuge (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [eq-func-decl? (Z3-Context Z3-Func-Decl Z3-Func-Decl → Boolean)]
  [rcf-power (Z3-Context Z3-Rcf-Num Nonnegative-Fixnum → Z3-Rcf-Num)]
  [mk-sub (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [mk-array-default (Z3-Context Z3-Ast → Z3-Ast)]
  [fixedpoint-add-fact! (Z3-Context Z3-Fixedpoint Z3-Func-Decl (Listof Nonnegative-Fixnum) → Void)]
  [numeral-ast? (Z3-Context Z3-Ast → Boolean)]
  [solver-get-proof (Z3-Context Z3-Solver → Z3-Ast)]
  [mk-unsigned-int64 (Z3-Context Nonnegative-Fixnum Z3-Sort → Z3-Ast)]
  [mk-fpa-zero (Z3-Context Z3-Sort Boolean → Z3-Ast)]
  [mk-bvsub-no-underflow (Z3-Context Z3-Ast Z3-Ast Boolean → Z3-Ast)]
  [mk-fpa-neg (Z3-Context Z3-Ast → Z3-Ast)]
  [get-numerator (Z3-Context Z3-Ast → Z3-Ast)]
  [goal-size (Z3-Context Z3-Goal → Nonnegative-Fixnum)]
  [sort->string (Z3-Context Z3-Sort → String)]
  [fixedpoint-add-cover! (Z3-Context Z3-Fixedpoint Fixnum Z3-Func-Decl Z3-Ast → Void)]
  [get-decl-num-parameters (Z3-Context Z3-Func-Decl → Nonnegative-Fixnum)]
  [mk-fpa-sort-64 (Z3-Context → Z3-Sort)]
  [fixedpoint-inc-ref! (Z3-Context Z3-Fixedpoint → Void)]
  [mk-fpa-sort-128 (Z3-Context → Z3-Sort)]
  [fixedpoint-query (Z3-Context Z3-Fixedpoint Z3-Ast → Z3-Lbool)]
  [mk-int-sort (Z3-Context → Z3-Sort)]
  [ast-map-insert! (Z3-Context Z3-Ast-Map Z3-Ast Z3-Ast → Void)]
  [probe-inc-ref! (Z3-Context Z3-Probe → Void)]
  [goal-num-exprs (Z3-Context Z3-Goal → Nonnegative-Fixnum)]
  [mk-fpa-is-nan (Z3-Context Z3-Ast → Z3-Ast)]
  [get-datatype-sort-constructor-accessor (Z3-Context Z3-Sort Nonnegative-Fixnum Nonnegative-Fixnum → Z3-Func-Decl)]
  [mk-optimize (Z3-Context → Z3-Optimize)]
  [substitute (Z3-Context Z3-Ast (Listof (Pairof Z3-Ast Z3-Ast)) → Z3-Ast)]
  [mk-fresh-const (Z3-Context String Z3-Sort → Z3-Ast)]
  [probe-lt (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [fpa-get-sbits (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [solver-dec-ref! (Z3-Context Z3-Solver → Void)]
  [algebraic-le (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [mk-simple-solver (Z3-Context → Z3-Solver)]
  [rcf-num->decimal-string (Z3-Context Z3-Rcf-Num Nonnegative-Fixnum → String)]
  [mk-fpa->fp-bv (Z3-Context Z3-Ast Z3-Sort → Z3-Ast)]
  [model-get-sort (Z3-Context Z3-Model Nonnegative-Fixnum → Z3-Sort)]
  [get-domain (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Z3-Sort)]
  [mk-fpa-sort (Z3-Context Nonnegative-Fixnum Nonnegative-Fixnum → Z3-Sort)]
  [optimize-dec-ref! (Z3-Context Z3-Optimize → Void)]
  [mk-and (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [mk-bvugt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [probe-and (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [get-app-arg (Z3-Context Z3-App Nonnegative-Fixnum → Z3-Ast)]
  [get-bool-value (Z3-Context Z3-Ast → Z3-Lbool)]
  [mk-real-sort (Z3-Context → Z3-Sort)]
  [app->ast (Z3-Context Z3-App → Z3-Ast)]
  [mk-probe (Z3-Context String → Z3-Probe)]
  [get-algebraic-number-lower (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [optimize-inc-ref! (Z3-Context Z3-Optimize → Void)]
  [mk-true (Z3-Context → Z3-Ast)]
  [get-domain-size (Z3-Context Z3-Func-Decl → Nonnegative-Fixnum)]
  [mk-fpa-sort-16 (Z3-Context → Z3-Sort)]
  [fpa-get-ebits (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [finalize-memory! (→ Void)]
  [optimize-get-statistics (Z3-Context Z3-Optimize → Z3-Stats)]
  [fixedpoint->string (Z3-Context Z3-Fixedpoint (Listof Z3-Ast) → String)]
  [get-sort-name (Z3-Context Z3-Sort → Z3-Symbol)]
  [algebraic-is-pos? (Z3-Context Z3-Ast → Boolean)]
  [fixedpoint-get-num-levels (Z3-Context Z3-Fixedpoint Z3-Func-Decl → Nonnegative-Fixnum)]
  [model-eval (Z3-Context Z3-Model Z3-Ast Boolean → (Option Z3-Ast))]
  [mk-xor (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [query-constructor
   (Z3-Context Z3-Constructor Nonnegative-Fixnum → (Values Z3-Func-Decl Z3-Func-Decl (Listof Z3-Func-Decl)))]
  [fixedpoint-assert! (Z3-Context Z3-Fixedpoint Z3-Ast → Void)]
  [solver-get-assertions (Z3-Context Z3-Solver → Z3-Ast-Vector)]
  [mk-fpa-is-negative (Z3-Context Z3-Ast → Z3-Ast)]
  [func-interp-get-num-entries (Z3-Context Z3-Func-Interp → Nonnegative-Fixnum)]
  [algebraic-is-neg? (Z3-Context Z3-Ast → Boolean)]
  [ast-vector-set! (Z3-Context Z3-Ast-Vector Nonnegative-Fixnum Z3-Ast → Void)]
  [get-quantifier-no-pattern-ast (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [goal-assert! (Z3-Context Z3-Goal Z3-Ast → Void)]
  [mk-quantifier-ex
   (Z3-Context
    Boolean
    Nonnegative-Fixnum
    Z3-Symbol
    Z3-Symbol
    (Listof Z3-Pattern)
    (Listof Z3-Ast)
    (Listof (Pairof Z3-Sort Z3-Symbol))
    Z3-Ast
    →
    Z3-Ast)]
  [tactic-and-then (Z3-Context Z3-Tactic Z3-Tactic → Z3-Tactic)]
  [mk-atmost (Z3-Context (Listof Z3-Ast) Nonnegative-Fixnum → Z3-Ast)]
  [get-quantifier-num-bound (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [get-app-decl (Z3-Context Z3-App → Z3-Func-Decl)]
  [get-array-sort-domain (Z3-Context Z3-Sort → Z3-Sort)]
  [mk-fpa-round-toward-negative (Z3-Context → Z3-Ast)]
  [algebraic-is-value? (Z3-Context Z3-Ast → Boolean)]
  [rcf-lt (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Boolean)]
  [as-array? (Z3-Context Z3-Ast → Boolean)]
  [solver-get-help (Z3-Context Z3-Solver → String)]
  [mk-bvult (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-quantifier-body (Z3-Context Z3-Ast → Z3-Ast)]
  [rcf-num->string (Z3-Context Z3-Rcf-Num Boolean Boolean → String)]
  [mk-ext-rotate-right (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [translate (Z3-Context Z3-Ast Z3-Context → Z3-Ast)]
  [func-decl->ast (Z3-Context Z3-Func-Decl → Z3-Ast)]
  [mk-gt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [goal-inc-ref! (Z3-Context Z3-Goal → Void)]
  [mk-constructor
   (Z3-Context Z3-Symbol Z3-Symbol (Listof (List Z3-Symbol (U Z3-Null Z3-Sort) Nonnegative-Fixnum)) → Z3-Constructor)]
  [fixedpoint-get-assertions (Z3-Context Z3-Fixedpoint → Z3-Ast-Vector)]
  [get-range (Z3-Context Z3-Func-Decl → Z3-Sort)]
  [fixedpoint-get-answer (Z3-Context Z3-Fixedpoint → Z3-Ast)]
  [rcf-add (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Z3-Rcf-Num)]
  [probe-get-descr (Z3-Context String → String)]
  [rcf-mul (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Z3-Rcf-Num)]
  [mk-bvadd-no-overflow (Z3-Context Z3-Ast Z3-Ast Boolean → Z3-Ast)]
  [algebraic-add (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-algebraic-number-upper (Z3-Context Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [solver-get-unsat-core (Z3-Context Z3-Solver → Z3-Ast-Vector)]
  [eq-ast? (Z3-Context Z3-Ast Z3-Ast → Boolean)]
  [get-numeral-small (Z3-Context Z3-Ast → (Values Boolean Fixnum Fixnum))]
  [rcf-le (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Boolean)]
  [mk-fpa-is-subnormal (Z3-Context Z3-Ast → Z3-Ast)]
  [params-set-bool! (Z3-Context Z3-Params Z3-Symbol Boolean → Void)]
  [mk-fpa-fma (Z3-Context Z3-Ast Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [params->string (Z3-Context Z3-Params → String)]
  [mk-rotate-right (Z3-Context Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [mk-distinct (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [set-param-value! (Z3-Config String String → Void)]
  [get-datatype-sort-constructor (Z3-Context Z3-Sort Nonnegative-Fixnum → Z3-Func-Decl)]
  [mk-bvule (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [param-descrs-get-kind (Z3-Context Z3-Param-Descrs Z3-Symbol → Z3-Param-Kind)]
  [mk-bvsle (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-ge (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [goal-is-decided-sat? (Z3-Context Z3-Goal → Boolean)]
  [ast-map-inc-ref! (Z3-Context Z3-Ast-Map → Void)]
  [get-quantifier-num-patterns (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [mk-fpa-sort-single (Z3-Context → Z3-Sort)]
  [fpa-get-numeral-significand-uint64 (Z3-Context Z3-Ast → (Option Nonnegative-Fixnum))]
  [get-pattern-num-terms (Z3-Context Z3-Pattern → Nonnegative-Fixnum)]
  [mk-bvlshr (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-set-difference (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [inc-ref! (Z3-Context Z3-Ast → Void)]
  [stats->string (Z3-Context Z3-Stats → String)]
  [goal-formula (Z3-Context Z3-Goal Nonnegative-Fixnum → Z3-Ast)]
  [mk-empty-set (Z3-Context Z3-Sort → Z3-Ast)]
  [get-array-sort-range (Z3-Context Z3-Sort → Z3-Sort)]
  [app? (Z3-Context Z3-Ast → Boolean)]
  [rcf-eq (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Boolean)]
  [mk-extract (Z3-Context Nonnegative-Fixnum Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [get-tuple-sort-field-decl (Z3-Context Z3-Sort Nonnegative-Fixnum → Z3-Func-Decl)]
  [rcf-div (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Z3-Rcf-Num)]
  [optimize-get-reason-unknown (Z3-Context Z3-Optimize → String)]
  [mk-fpa->ubv (Z3-Context Z3-Ast Z3-Ast Nonnegative-Fixnum → Z3-Ast)]
  [mk-bvneg (Z3-Context Z3-Ast → Z3-Ast)]
  [rcf-mk-e (Z3-Context → Z3-Rcf-Num)]
  [tactic-cond (Z3-Context Z3-Probe Z3-Tactic Z3-Tactic → Z3-Tactic)]
  [mk-ite (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-ast-vector (Z3-Context → Z3-Ast-Vector)]
  [mk-fpa->real (Z3-Context Z3-Ast → Z3-Ast)]
  [goal-depth (Z3-Context Z3-Goal → Nonnegative-Fixnum)]
  [ast-vector-resize! (Z3-Context Z3-Ast-Vector Nonnegative-Fixnum → Void)]
  [goal-reset! (Z3-Context Z3-Goal → Void)]
  [mk-solver-for-logic (Z3-Context Z3-Symbol → Z3-Solver)]
  [stats-size (Z3-Context Z3-Stats → Nonnegative-Fixnum)]
  [mk-fpa-sort-double (Z3-Context → Z3-Sort)]
  [solver-set-params! (Z3-Context Z3-Solver Z3-Params → Void)]
  [disable-trace! (String → Void)]
  [mk-rem (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-quantifier-const-ex
   (Z3-Context
    Boolean
    Nonnegative-Fixnum
    Z3-Symbol
    Z3-Symbol
    (Listof Z3-App)
    (Listof Z3-Pattern)
    (Listof Z3-Ast)
    Z3-Ast
    →
    Z3-Ast)]
  [mk-fpa-rem (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [func-interp-dec-ref! (Z3-Context Z3-Func-Interp → Void)]
  [rcf-mk-pi (Z3-Context → Z3-Rcf-Num)]
  [mk-fpa-numeral-double (Z3-Context Flonum Z3-Sort → Z3-Ast)]
  [optimize-get-param-descrs (Z3-Context Z3-Optimize → Z3-Param-Descrs)]
  [param-descrs-get-name (Z3-Context Z3-Param-Descrs Nonnegative-Fixnum → Z3-Symbol)]
  [goal-precision (Z3-Context Z3-Goal → Z3-Goal-Prec)]
  [parse-smtlib2-string
   (Z3-Context String (Listof (Pairof Z3-Symbol Z3-Sort)) (Listof (Pairof Z3-Symbol Z3-Func-Decl)) → Z3-Ast)]
  [ast-vector-dec-ref! (Z3-Context Z3-Ast-Vector → Void)]
  [get-num-tactics (Z3-Context → Nonnegative-Fixnum)]
  [params-inc-ref! (Z3-Context Z3-Params → Void)]
  [param-descrs-dec-ref! (Z3-Context Z3-Param-Descrs → Void)]
  [tactic-fail-if-not-decided (Z3-Context → Z3-Tactic)]
  [ast-vector-get (Z3-Context Z3-Ast-Vector Nonnegative-Fixnum → Z3-Ast)]
  [eq-sort? (Z3-Context Z3-Sort Z3-Sort → Boolean)]
  [get-decl-name (Z3-Context Z3-Func-Decl → Z3-Symbol)]
  [mk-bvneg-no-overflow (Z3-Context Z3-Ast → Z3-Ast)]
  [mk-tuple-sort
   (Z3-Context Z3-Symbol (Listof (Pairof Z3-Symbol Z3-Sort)) → (Values Z3-Sort Z3-Func-Decl (Listof Z3-Func-Decl)))]
  [mk-bv2int (Z3-Context Z3-Ast Boolean → Z3-Ast)]
  [mk-fpa->fp-int-real (Z3-Context Z3-Ast Z3-Ast Z3-Ast Z3-Sort → Z3-Ast)]
  [solver-get-statistics (Z3-Context Z3-Solver → Z3-Stats)]
  [mk-fpa-abs (Z3-Context Z3-Ast → Z3-Ast)]
  [ast-map-reset! (Z3-Context Z3-Ast-Map → Void)]
  [mk-rotate-left (Z3-Context Nonnegative-Fixnum Z3-Ast → Z3-Ast)]
  [rcf-neq (Z3-Context Z3-Rcf-Num Z3-Rcf-Num → Boolean)]
  [mk-fpa->ieee-bv (Z3-Context Z3-Ast → Z3-Ast)]
  [optimize-get-lower (Z3-Context Z3-Optimize Nonnegative-Fixnum → Z3-Ast)]
  [func-interp-get-entry (Z3-Context Z3-Func-Interp Nonnegative-Fixnum → Z3-Func-Entry)]
  [mk-fpa-numeral-int (Z3-Context Fixnum Z3-Sort → Z3-Ast)]
  [mk-bvnor (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [optimize->string (Z3-Context Z3-Optimize → String)]
  [model-get-num-consts (Z3-Context Z3-Model → Nonnegative-Fixnum)]
  [stats-is-double? (Z3-Context Z3-Stats Nonnegative-Fixnum → Boolean)]
  [get-denominator (Z3-Context Z3-Ast → Z3-Ast)]
  [get-quantifier-weight (Z3-Context Z3-Ast → Nonnegative-Fixnum)]
  [fpa-get-numeral-exponent-int64 (Z3-Context Z3-Ast → (Option Fixnum))]
  [solver-push! (Z3-Context Z3-Solver → Void)]
  [well-sorted? (Z3-Context Z3-Ast → Boolean)]
  [del-constructor! (Z3-Context Z3-Constructor → Void)]
  [get-decl-int-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Fixnum)]
  [mk-set-del (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [stats-dec-ref! (Z3-Context Z3-Stats → Void)]
  [ast-vector->string (Z3-Context Z3-Ast-Vector → String)]
  [mk-pattern (Z3-Context (Listof Z3-Ast) → Z3-Pattern)]
  [fixedpoint-from-file (Z3-Context Z3-Fixedpoint String → Z3-Ast-Vector)]
  [get-sort-id (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [mk-fpa-rna (Z3-Context → Z3-Ast)]
  [mk-quantifier-const (Z3-Context Boolean Nonnegative-Fixnum (Listof Z3-App) (Listof Z3-Pattern) Z3-Ast → Z3-Ast)]
  [mk-is-int (Z3-Context Z3-Ast → Z3-Ast)]
  [optimize-push! (Z3-Context Z3-Optimize → Void)]
  [mk-mul (Z3-Context (Listof Z3-Ast) → Z3-Ast)]
  [mk-fpa-sort-quadruple (Z3-Context → Z3-Sort)]
  [mk-context (Z3-Config → Z3-Context)]
  [fpa-get-numeral-sign (Z3-Context Z3-Ast → (Option Fixnum))]
  [mk-fpa-rounding-mode-sort (Z3-Context → Z3-Sort)]
  [fixedpoint-register-relation! (Z3-Context Z3-Fixedpoint Z3-Func-Decl → Void)]
  [mk-bvxor (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [rcf-neg (Z3-Context Z3-Rcf-Num → Z3-Rcf-Num)]
  [mk-fpa->fp-signed (Z3-Context Z3-Ast Z3-Ast Z3-Sort → Z3-Ast)]
  [probe-ge (Z3-Context Z3-Probe Z3-Probe → Z3-Probe)]
  [rcf-del! (Z3-Context Z3-Rcf-Num → Void)]
  [optimize-get-help (Z3-Context Z3-Optimize → String)]
  [fixedpoint-get-reason-unknown (Z3-Context Z3-Fixedpoint → String)]
  [mk-not (Z3-Context Z3-Ast → Z3-Ast)]
  [stats-get-uint-value (Z3-Context Z3-Stats Nonnegative-Fixnum → Nonnegative-Fixnum)]
  [apply-result-dec-ref! (Z3-Context Z3-Apply-Result → Void)]
  [mk-fpa-round-nearest-ties->even (Z3-Context → Z3-Ast)]
  [mk-fpa-rtn (Z3-Context → Z3-Ast)]
  [mk-fresh-func-decl (Z3-Context String (Listof Z3-Sort) Z3-Sort → Z3-Func-Decl)]
  [ast-map-dec-ref! (Z3-Context Z3-Ast-Map → Void)]
  [get-decl-parameter-kind (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Z3-Parameter-Kind)]
  [get-tuple-sort-mk-decl (Z3-Context Z3-Sort → Z3-Func-Decl)]
  [model-get-func-decl (Z3-Context Z3-Model Nonnegative-Fixnum → Z3-Func-Decl)]
  [rcf-inv (Z3-Context Z3-Rcf-Num → Z3-Rcf-Num)]
  [fixedpoint-get-rules (Z3-Context Z3-Fixedpoint → Z3-Ast-Vector)]
  [get-datatype-sort-num-constructors (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [goal-is-decided-unsat? (Z3-Context Z3-Goal → Boolean)]
  [solver-get-reason-unknown (Z3-Context Z3-Solver → String)]
  [ast-map-contains (Z3-Context Z3-Ast-Map Z3-Ast → Boolean)]
  [get-num-probes (Z3-Context → Nonnegative-Fixnum)]
  [mk-datatype (Z3-Context Z3-Symbol (Listof Z3-Constructor) → Z3-Sort)]
  [rcf-mk-rational (Z3-Context String → Z3-Rcf-Num)]
  [mk-tactic (Z3-Context String → Z3-Tactic)]
  [mk-const (Z3-Context Z3-Symbol Z3-Sort → Z3-App)]
  [datatype-update-field (Z3-Context Z3-Func-Decl Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-max (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [ast-map-erase! (Z3-Context Z3-Ast-Map Z3-Ast → Void)]
  [mk-bvnand (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-bvsdiv (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-tuple-sort-num-fields (Z3-Context Z3-Sort → Nonnegative-Fixnum)]
  [mk-false (Z3-Context → Z3-Ast)]
  [func-interp-inc-ref! (Z3-Context Z3-Func-Interp → Void)]
  [mk-bound (Z3-Context Nonnegative-Fixnum Z3-Sort → Z3-Ast)]
  [rcf-mk-roots (Z3-Context (Listof Z3-Rcf-Num) → (Values Nonnegative-Fixnum (Listof Z3-Rcf-Num)))]
  [reset-memory! (→ Void)]
  [mk-fpa-leq (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-fp (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-rtz (Z3-Context → Z3-Ast)]
  [mk-bvsrem (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-decl-rational-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → String)]
  [to-func-decl (Z3-Context Z3-Ast → Z3-Func-Decl)]
  [mk-fpa-min (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-fpa-gt (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-solver-from-tactic (Z3-Context Z3-Tactic → Z3-Solver)]
  [goal-inconsistent (Z3-Context Z3-Goal → Boolean)]
  [algebraic-sub (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-bv-sort (Z3-Context Nonnegative-Fixnum → Z3-Sort)]
  [set-error! (Z3-Context Z3-Error-Code → Void)]
  [mk-bvmul-no-underflow (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [get-decl-symbol-parameter (Z3-Context Z3-Func-Decl Nonnegative-Fixnum → Z3-Symbol)]
  [mk-fpa-div (Z3-Context Z3-Ast Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-set-add (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [mk-goal (Z3-Context Boolean Boolean Boolean → Z3-Goal)]
  [solver-get-num-scopes (Z3-Context Z3-Solver → Nonnegative-Fixnum)]
  [mk-bvsdiv-no-overflow (Z3-Context Z3-Ast Z3-Ast → Z3-Ast)]
  [fixedpoint-query-relations (Z3-Context Z3-Fixedpoint (Listof Z3-Func-Decl) → Z3-Lbool)]
  [mk-config (→ Z3-Config)])
