(get-info :version)
; (:version "4.3.2")
; Input file is <unknown>
; Started: 2015-06-23 12:03:23
; Silicon.buildVersion: 0.1-SNAPSHOT 407b787e33ff+ default 2015/06/10 17:01:19
; ------------------------------------------------------------
; Preamble start
; 
; ; /z3config.smt2
(set-option :print-success true) ; Boogie: false
(set-option :global-decls true) ; Boogie: default
(set-option :auto_config false) ; Usually a good idea
(set-option :smt.mbqi false)
(set-option :model.v2 true)
(set-option :smt.phase_selection 0)
(set-option :smt.restart_strategy 0)
(set-option :smt.restart_factor |1.5|)
(set-option :smt.arith.random_initial_value true)
(set-option :smt.case_split 3)
(set-option :smt.delay_units true)
(set-option :smt.delay_units_threshold 16)
(set-option :nnf.sk_hack true)
(set-option :smt.qi.eager_threshold 100)
(set-option :smt.qi.cost "(+ weight generation)")
(set-option :type_check true)
(set-option :smt.bv.reflect true)
(set-option :smt.soft_timeout 30000)
; 
; ; /preamble.smt2
(declare-datatypes () ((
    $Snap $Snap.unit
    ($Snap.combine ($Snap.first $Snap) ($Snap.second $Snap)))))
(declare-sort $Ref)
(declare-const $Ref.null $Ref)
(define-sort $Perm () Real)
(define-const $Perm.Write $Perm 1.0)
(define-const $Perm.No $Perm 0.0)
(define-fun $Perm.isValidVar ((p $Perm)) Bool
	(<= $Perm.No p))
(define-fun $Perm.isReadVar ((p $Perm) (ub $Perm)) Bool
    (and ($Perm.isValidVar p)
         (not (= p $Perm.No))
         (< p $Perm.Write)))
(define-fun $Perm.min ((p1 $Perm) (p2 $Perm)) Real
    (ite (<= p1 p2) p1 p2))
(define-fun $Math.min ((a Int) (b Int)) Int
    (ite (<= a b) a b))
(define-fun $Math.clip ((a Int)) Int
    (ite (< a 0) 0 a))
(push) ; 1
(assert true)
; Declaring additional sort wrappers
(declare-fun $SortWrappers.$PermTo$Snap ($Perm) $Snap)
(declare-fun $SortWrappers.$SnapTo$Perm ($Snap) $Perm)
(assert (forall ((x $Perm)) (!
    (= x ($SortWrappers.$SnapTo$Perm($SortWrappers.$PermTo$Snap x)))
    :pattern (($SortWrappers.$PermTo$Snap x))
    )))
(declare-fun $SortWrappers.$RefTo$Snap ($Ref) $Snap)
(declare-fun $SortWrappers.$SnapTo$Ref ($Snap) $Ref)
(assert (forall ((x $Ref)) (!
    (= x ($SortWrappers.$SnapTo$Ref($SortWrappers.$RefTo$Snap x)))
    :pattern (($SortWrappers.$RefTo$Snap x))
    )))
(declare-fun $SortWrappers.BoolTo$Snap (Bool) $Snap)
(declare-fun $SortWrappers.$SnapToBool ($Snap) Bool)
(assert (forall ((x Bool)) (!
    (= x ($SortWrappers.$SnapToBool($SortWrappers.BoolTo$Snap x)))
    :pattern (($SortWrappers.BoolTo$Snap x))
    )))
(declare-fun $SortWrappers.IntTo$Snap (Int) $Snap)
(declare-fun $SortWrappers.$SnapToInt ($Snap) Int)
(assert (forall ((x Int)) (!
    (= x ($SortWrappers.$SnapToInt($SortWrappers.IntTo$Snap x)))
    :pattern (($SortWrappers.IntTo$Snap x))
    )))
; Preamble end
; ------------------------------------------------------------
; ------------------------------------------------------------
; Declaring program functions
(declare-const s@$ $Snap)
; ---------- LinkedList__LinkedList ----------
(declare-const sys__result@1 $Ref)
(declare-const diz@2 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@1 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LinkedList__first, LinkedList__last, LinkedList__Integer_value, LinkedList__Boolean_value)
(declare-const diz@3 $Ref)
(assert (not (= diz@3 $Ref.null)))
(declare-const LinkedList__first@4 $Ref)
(declare-const LinkedList__last@5 $Ref)
(declare-const LinkedList__Integer_value@6 Int)
(declare-const LinkedList__Boolean_value@7 Bool)
(assert (and
  (not (= sys__result@1 diz@3))
  (not (= LinkedList__first@4 diz@3))
  (not (= LinkedList__last@5 diz@3))))
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LinkedList__linkLast ----------
(declare-const diz@8 $Ref)
(declare-const val@9 Int)
(declare-const l@10 $Ref)
(declare-const newNode@11 $Ref)
(declare-const __flatten_1@12 $Ref)
(declare-const __flatten_2@13 $Ref)
(declare-const __flatten_3@14 $Ref)
(declare-const __flatten_4@15 $Ref)
(declare-const __flatten_18@16 $Ref)
(declare-const __flatten_19@17 $Ref)
(declare-const __flatten_20@18 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@8 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; l := diz.LinkedList__last
(check-sat)
; unknown
(push) ; 4
(pop) ; 4
(check-sat)
; unknown
(pop) ; 3
(pop) ; 2
; ---------- LinkedList__unlinkFirst ----------
(declare-const diz@19 $Ref)
(declare-const f@20 $Ref)
(declare-const sys__result@21 Int)
(declare-const element@22 Int)
(declare-const next@23 $Ref)
(declare-const __flatten_5@24 $Ref)
(declare-const __flatten_6@25 Int)
(declare-const __flatten_21@26 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@19 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; element := f.Node__item
(push) ; 4
(assert (not (not (= f@20 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LinkedList__peek ----------
(declare-const diz@27 $Ref)
(declare-const sys__result@28 Int)
(declare-const f@29 $Ref)
(declare-const __flatten_7@30 Int)
(declare-const __flatten_8@31 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@27 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; f := diz.LinkedList__first
(check-sat)
; unknown
(push) ; 4
(pop) ; 4
(check-sat)
; unknown
(pop) ; 3
(pop) ; 2
; ---------- LinkedList__poll ----------
(declare-const diz@32 $Ref)
(declare-const sys__result@33 Int)
(declare-const f@34 $Ref)
(declare-const __flatten_9@35 Int)
(declare-const __flatten_10@36 Int)
(declare-const __flatten_11@37 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@32 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; f := diz.LinkedList__first
(check-sat)
; unknown
(push) ; 4
(pop) ; 4
(check-sat)
; unknown
(pop) ; 3
(pop) ; 2
; ---------- LinkedList__offer ----------
(declare-const diz@38 $Ref)
(declare-const val@39 Int)
(declare-const sys__result@40 Bool)
(declare-const __flatten_13@41 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@38 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; LinkedList__linkLast(diz, val)
; [eval] diz != null
; [exec]
; __flatten_13 := true
; [exec]
; sys__result := __flatten_13
; [exec]
; assert true
(push) ; 4
(pop) ; 4
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- Node__Node ----------
(declare-const prev@42 $Ref)
(declare-const item@43 Int)
(declare-const next@44 $Ref)
(declare-const sys__result@45 $Ref)
(declare-const diz@46 $Ref)
(declare-const __flatten_14@47 Int)
(declare-const __flatten_15@48 $Ref)
(declare-const __flatten_16@49 $Ref)
(declare-const __flatten_24@50 Int)
(declare-const __flatten_25@51 $Ref)
(declare-const __flatten_26@52 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@45 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(Node__next, Node__prev, Node__item, Node__Integer_value, Node__Boolean_value)
(declare-const diz@53 $Ref)
(assert (not (= diz@53 $Ref.null)))
(declare-const Node__next@54 $Ref)
(declare-const Node__prev@55 $Ref)
(declare-const Node__item@56 Int)
(declare-const Node__Integer_value@57 Int)
(declare-const Node__Boolean_value@58 Bool)
(assert (and
  (not (= prev@42 diz@53))
  (not (= next@44 diz@53))
  (not (= sys__result@45 diz@53))
  (not (= __flatten_15@48 diz@53))
  (not (= __flatten_16@49 diz@53))
  (not (= __flatten_25@51 diz@53))
  (not (= __flatten_26@52 diz@53))
  (not (= Node__next@54 diz@53))
  (not (= Node__prev@55 diz@53))))
; [exec]
; __flatten_14 := item
; [exec]
; __flatten_24 := __flatten_14
; [exec]
; diz.Node__item := __flatten_24
; [exec]
; __flatten_15 := next
; [exec]
; __flatten_25 := __flatten_15
; [exec]
; diz.Node__next := __flatten_25
; [exec]
; __flatten_16 := prev
; [exec]
; __flatten_26 := __flatten_16
; [exec]
; diz.Node__prev := __flatten_26
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
