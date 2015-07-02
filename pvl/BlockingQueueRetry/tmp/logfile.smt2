(get-info :version)
; (:version "4.3.2")
; Input file is <unknown>
; Started: 2015-07-02 12:11:59
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
; ---------- AtomicInteger__lock_held ----------
(declare-const diz@1 $Ref)
; ---------- HeadLock__lock_held ----------
(declare-const diz@2 $Ref)
; ---------- LastLock__lock_held ----------
(declare-const diz@3 $Ref)
; ---------- Node__lock_held ----------
(declare-const diz@4 $Ref)
; ---------- LBQThread2a__joinToken ----------
(declare-const diz@5 $Ref)
; ---------- LBQThread3b__joinToken ----------
(declare-const diz@6 $Ref)
; ---------- AtomicInteger__AtomicInteger ----------
(declare-const val@7 Int)
(declare-const sys__result@8 $Ref)
(declare-const diz@9 $Ref)
(declare-const __flatten_1@10 Int)
(declare-const __flatten_67@11 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@8 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(AtomicInteger__val)
(declare-const diz@12 $Ref)
(assert (not (= diz@12 $Ref.null)))
(declare-const AtomicInteger__val@13 Int)
(assert (not (= sys__result@8 diz@12)))
; [exec]
; __flatten_1 := val
; [exec]
; __flatten_67 := __flatten_1
; [exec]
; diz.AtomicInteger__val := __flatten_67
; [exec]
; exhale acc(diz.AtomicInteger__val, write)
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- AtomicInteger__getAndIncrement ----------
(declare-const diz@14 $Ref)
(declare-const sys__result@15 Int)
(declare-const res@16 Int)
(declare-const __flatten_2@17 Int)
(declare-const __flatten_3@18 Int)
(declare-const __flatten_68@19 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@14 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write)
(declare-const $t@20 Int)
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@21 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; __flatten_2 := diz.AtomicInteger__val + 1
; [eval] diz.AtomicInteger__val + 1
; [exec]
; __flatten_68 := __flatten_2
; [exec]
; diz.AtomicInteger__val := __flatten_68
; [exec]
; exhale acc(AtomicInteger__lock_held(diz), write)
; [exec]
; exhale acc(diz.AtomicInteger__val, write)
; [exec]
; __flatten_3 := res
; [exec]
; sys__result := __flatten_3
; [exec]
; assert true
(push) ; 4
(pop) ; 4
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- AtomicInteger__getAndDecrement ----------
(declare-const diz@22 $Ref)
(declare-const sys__result@23 Int)
(declare-const res@24 Int)
(declare-const __flatten_4@25 Int)
(declare-const __flatten_5@26 Int)
(declare-const __flatten_69@27 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@22 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write)
(declare-const $t@28 Int)
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@29 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; __flatten_4 := diz.AtomicInteger__val - 1
; [eval] diz.AtomicInteger__val - 1
; [exec]
; __flatten_69 := __flatten_4
; [exec]
; diz.AtomicInteger__val := __flatten_69
; [exec]
; exhale acc(AtomicInteger__lock_held(diz), write)
; [exec]
; exhale acc(diz.AtomicInteger__val, write)
; [exec]
; __flatten_5 := res
; [exec]
; sys__result := __flatten_5
; [exec]
; assert true
(push) ; 4
(pop) ; 4
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- AtomicInteger__get ----------
(declare-const diz@30 $Ref)
(declare-const sys__result@31 Int)
(declare-const res@32 Int)
(declare-const __flatten_6@33 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@30 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write)
(declare-const $t@34 Int)
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@35 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; exhale acc(AtomicInteger__lock_held(diz), write)
; [exec]
; exhale acc(diz.AtomicInteger__val, write)
; [exec]
; __flatten_6 := res
; [exec]
; sys__result := __flatten_6
; [exec]
; assert true
(push) ; 4
(pop) ; 4
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- HeadLock__HeadLock ----------
(declare-const queue@36 $Ref)
(declare-const sys__result@37 $Ref)
(declare-const diz@38 $Ref)
(declare-const __flatten_7@39 $Ref)
(declare-const __flatten_70@40 $Ref)
(push) ; 2
(assert (not (= queue@36 $Ref.null)))
(declare-const $t@41 $Ref)
; [eval] queue.BlockingQueue__head != null
(assert (not (= $t@41 $Ref.null)))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@37 $Ref.null)))
(declare-const $k@42 $Perm)
(assert ($Perm.isValidVar $k@42))
(assert ($Perm.isReadVar $k@42 $Perm.Write))
(declare-const $t@43 $Ref)
; [eval] sys__result.HeadLock__queue == queue
(push) ; 4
(assert (not (not (= $k@42 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@42 $Perm.No)))
(assert (= $t@43 queue@36))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(HeadLock__queue)
(declare-const diz@44 $Ref)
(assert (not (= diz@44 $Ref.null)))
(declare-const HeadLock__queue@45 $Ref)
(assert (and
  (not (= queue@36 diz@44))
  (not (= sys__result@37 diz@44))
  (not (= __flatten_7@39 diz@44))
  (not (= __flatten_70@40 diz@44))
  (not (= HeadLock__queue@45 diz@44))
  (not (= $t@41 diz@44))))
; [exec]
; __flatten_7 := queue
; [exec]
; __flatten_70 := __flatten_7
; [exec]
; diz.HeadLock__queue := __flatten_70
; [exec]
; exhale acc(diz.HeadLock__queue, wildcard) && acc(diz.HeadLock__queue.BlockingQueue__head, write) && (diz.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@46 $Perm)
(assert ($Perm.isValidVar $k@46))
(assert ($Perm.isReadVar $k@46 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@46 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@46 $Perm.Write))
; [eval] diz.HeadLock__queue.BlockingQueue__head != null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.HeadLock__queue, wildcard) && (sys__result.HeadLock__queue == queue)
; [eval] sys__result != null
(declare-const $k@47 $Perm)
(assert ($Perm.isValidVar $k@47))
(assert ($Perm.isReadVar $k@47 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@47 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $Perm.Write $k@46) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $Perm.Write $k@46) $Perm.No)))
(assert (< $k@47 (- $Perm.Write $k@46)))
; [eval] sys__result.HeadLock__queue == queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LastLock__LastLock ----------
(declare-const queue@48 $Ref)
(declare-const sys__result@49 $Ref)
(declare-const diz@50 $Ref)
(declare-const __flatten_8@51 $Ref)
(declare-const __flatten_71@52 $Ref)
(push) ; 2
(assert (not (= queue@48 $Ref.null)))
(declare-const $t@53 $Ref)
; [eval] queue.BlockingQueue__last != null
(assert (not (= $t@53 $Ref.null)))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@49 $Ref.null)))
(declare-const $k@54 $Perm)
(assert ($Perm.isValidVar $k@54))
(assert ($Perm.isReadVar $k@54 $Perm.Write))
(declare-const $t@55 $Ref)
; [eval] sys__result.LastLock__queue == queue
(push) ; 4
(assert (not (not (= $k@54 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@54 $Perm.No)))
(assert (= $t@55 queue@48))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LastLock__queue)
(declare-const diz@56 $Ref)
(assert (not (= diz@56 $Ref.null)))
(declare-const LastLock__queue@57 $Ref)
(assert (and
  (not (= queue@48 diz@56))
  (not (= sys__result@49 diz@56))
  (not (= __flatten_8@51 diz@56))
  (not (= __flatten_71@52 diz@56))
  (not (= LastLock__queue@57 diz@56))
  (not (= $t@53 diz@56))))
; [exec]
; __flatten_8 := queue
; [exec]
; __flatten_71 := __flatten_8
; [exec]
; diz.LastLock__queue := __flatten_71
; [exec]
; exhale acc(diz.LastLock__queue, wildcard) && acc(diz.LastLock__queue.BlockingQueue__last, write) && (diz.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@58 $Perm)
(assert ($Perm.isValidVar $k@58))
(assert ($Perm.isReadVar $k@58 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@58 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@58 $Perm.Write))
; [eval] diz.LastLock__queue.BlockingQueue__last != null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LastLock__queue, wildcard) && (sys__result.LastLock__queue == queue)
; [eval] sys__result != null
(declare-const $k@59 $Perm)
(assert ($Perm.isValidVar $k@59))
(assert ($Perm.isReadVar $k@59 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@59 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $Perm.Write $k@58) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $Perm.Write $k@58) $Perm.No)))
(assert (< $k@59 (- $Perm.Write $k@58)))
; [eval] sys__result.LastLock__queue == queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__BlockingQueue ----------
(declare-const capacity@60 Int)
(declare-const sys__result@61 $Ref)
(declare-const diz@62 $Ref)
(declare-const __flatten_9@63 Int)
(declare-const __flatten_10@64 $Ref)
(declare-const __flatten_11@65 $Ref)
(declare-const __flatten_12@66 $Ref)
(declare-const __flatten_13@67 $Ref)
(declare-const __flatten_14@68 $Ref)
(declare-const __flatten_15@69 $Ref)
(declare-const __flatten_16@70 $Ref)
(declare-const __flatten_17@71 $Ref)
(declare-const __flatten_18@72 $Ref)
(declare-const __flatten_72@73 Int)
(declare-const __flatten_74@74 $Ref)
(declare-const __flatten_76@75 $Ref)
(declare-const __flatten_77@76 $Ref)
(declare-const __flatten_79@77 $Ref)
(declare-const __flatten_81@78 $Ref)
(push) ; 2
; [eval] capacity > 0
(assert (> capacity@60 0))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@61 $Ref.null)))
(declare-const $k@79 $Perm)
(assert ($Perm.isValidVar $k@79))
(assert ($Perm.isReadVar $k@79 $Perm.Write))
(declare-const $t@80 Int)
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@79 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@79 $Perm.No)))
(assert (> $t@80 0))
(declare-const $k@81 $Perm)
(assert ($Perm.isValidVar $k@81))
(assert ($Perm.isReadVar $k@81 $Perm.Write))
(declare-const $t@82 $Ref)
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@81 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@81 $Perm.No)))
(assert (not (= $t@82 $Ref.null)))
(declare-const $k@83 $Perm)
(assert ($Perm.isValidVar $k@83))
(assert ($Perm.isReadVar $k@83 $Perm.Write))
(declare-const $t@84 $Ref)
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@83 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@83 $Perm.No)))
(assert (not (= $t@84 $Ref.null)))
(declare-const $k@85 $Perm)
(assert ($Perm.isValidVar $k@85))
(assert ($Perm.isReadVar $k@85 $Perm.Write))
(declare-const $t@86 $Ref)
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@85 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@85 $Perm.No)))
(assert (= $t@86 sys__result@61))
(declare-const $k@87 $Perm)
(assert ($Perm.isValidVar $k@87))
(assert ($Perm.isReadVar $k@87 $Perm.Write))
(declare-const $t@88 $Ref)
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@87 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@87 $Perm.No)))
(assert (not (= $t@88 $Ref.null)))
(declare-const $k@89 $Perm)
(assert ($Perm.isValidVar $k@89))
(assert ($Perm.isReadVar $k@89 $Perm.Write))
(declare-const $t@90 $Ref)
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@89 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@89 $Perm.No)))
(assert (= $t@90 sys__result@61))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@80 capacity@60))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(BlockingQueue__capacity, BlockingQueue__count, BlockingQueue__head, BlockingQueue__last, BlockingQueue__headLock, BlockingQueue__lastLock)
(declare-const diz@91 $Ref)
(assert (not (= diz@91 $Ref.null)))
(declare-const BlockingQueue__capacity@92 Int)
(declare-const BlockingQueue__count@93 $Ref)
(declare-const BlockingQueue__head@94 $Ref)
(declare-const BlockingQueue__last@95 $Ref)
(declare-const BlockingQueue__headLock@96 $Ref)
(declare-const BlockingQueue__lastLock@97 $Ref)
(assert (and
  (not (= sys__result@61 diz@91))
  (not (= __flatten_10@64 diz@91))
  (not (= __flatten_11@65 diz@91))
  (not (= __flatten_12@66 diz@91))
  (not (= __flatten_13@67 diz@91))
  (not (= __flatten_14@68 diz@91))
  (not (= __flatten_15@69 diz@91))
  (not (= __flatten_16@70 diz@91))
  (not (= __flatten_17@71 diz@91))
  (not (= __flatten_18@72 diz@91))
  (not (= __flatten_74@74 diz@91))
  (not (= __flatten_76@75 diz@91))
  (not (= __flatten_77@76 diz@91))
  (not (= __flatten_79@77 diz@91))
  (not (= __flatten_81@78 diz@91))
  (not (= BlockingQueue__count@93 diz@91))
  (not (= BlockingQueue__head@94 diz@91))
  (not (= BlockingQueue__last@95 diz@91))
  (not (= BlockingQueue__headLock@96 diz@91))
  (not (= BlockingQueue__lastLock@97 diz@91))))
; [exec]
; __flatten_9 := capacity
; [exec]
; __flatten_72 := __flatten_9
; [exec]
; diz.BlockingQueue__capacity := __flatten_72
; [exec]
; __flatten_11 := AtomicInteger__AtomicInteger(0)
(declare-const sys__result@98 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@98 $Ref.null)))
; [exec]
; __flatten_10 := __flatten_11
; [exec]
; __flatten_74 := __flatten_10
; [exec]
; diz.BlockingQueue__count := __flatten_74
; [exec]
; __flatten_13 := Node__Node(null)
; [eval] val != null
(push) ; 4
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 1] False
(push) ; 4
; [else-branch 1] True
(declare-const sys__result@99 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@99 $Ref.null)))
; [exec]
; __flatten_12 := __flatten_13
; [exec]
; __flatten_76 := __flatten_12
; [exec]
; diz.BlockingQueue__head := __flatten_76
; [exec]
; __flatten_14 := diz.BlockingQueue__head
; [exec]
; __flatten_77 := __flatten_14
; [exec]
; diz.BlockingQueue__last := __flatten_77
; [exec]
; __flatten_16 := HeadLock__HeadLock(diz)
; [eval] queue.BlockingQueue__head != null
(declare-const sys__result@100 $Ref)
(declare-const $t@101 $Snap)
(declare-const $t@102 $Ref)
(assert (= $t@101 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@102) $Snap.unit)))
(declare-const $t@103 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@102)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@103))))
; [eval] sys__result != null
(assert (not (= sys__result@100 $Ref.null)))
(declare-const $k@104 $Perm)
(assert ($Perm.isValidVar $k@104))
(assert ($Perm.isReadVar $k@104 $Perm.Write))
; [eval] sys__result.HeadLock__queue == queue
(push) ; 5
(assert (not (not (= $k@104 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@104 $Perm.No)))
(assert (= $t@103 diz@91))
; [exec]
; __flatten_15 := __flatten_16
; [exec]
; __flatten_79 := __flatten_15
; [exec]
; diz.BlockingQueue__headLock := __flatten_79
; [exec]
; __flatten_18 := LastLock__LastLock(diz)
; [eval] queue.BlockingQueue__last != null
(declare-const sys__result@105 $Ref)
(declare-const $t@106 $Snap)
(declare-const $t@107 $Ref)
(assert (= $t@106 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@107) $Snap.unit)))
(declare-const $t@108 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@107)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@108))))
; [eval] sys__result != null
(assert (not (= sys__result@105 $Ref.null)))
(declare-const $k@109 $Perm)
(assert ($Perm.isValidVar $k@109))
(assert ($Perm.isReadVar $k@109 $Perm.Write))
; [eval] sys__result.LastLock__queue == queue
(push) ; 5
(assert (not (not (= $k@109 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@109 $Perm.No)))
(assert (= $t@108 diz@91))
; [exec]
; __flatten_17 := __flatten_18
; [exec]
; __flatten_81 := __flatten_17
; [exec]
; diz.BlockingQueue__lastLock := __flatten_81
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.BlockingQueue__capacity, wildcard) && (sys__result.BlockingQueue__capacity > 0) && acc(sys__result.BlockingQueue__count, wildcard) && (sys__result.BlockingQueue__count != null) && acc(sys__result.BlockingQueue__headLock, wildcard) && (sys__result.BlockingQueue__headLock != null) && acc(sys__result.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result) && acc(sys__result.BlockingQueue__lastLock, wildcard) && (sys__result.BlockingQueue__lastLock != null) && acc(sys__result.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result) && (sys__result.BlockingQueue__capacity == capacity)
; [eval] sys__result != null
(declare-const $k@110 $Perm)
(assert ($Perm.isValidVar $k@110))
(assert ($Perm.isReadVar $k@110 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@110 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@110 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(declare-const $k@111 $Perm)
(assert ($Perm.isValidVar $k@111))
(assert ($Perm.isReadVar $k@111 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@111 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@111 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(declare-const $k@112 $Perm)
(assert ($Perm.isValidVar $k@112))
(assert ($Perm.isReadVar $k@112 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@112 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@112 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(declare-const $k@113 $Perm)
(assert ($Perm.isValidVar $k@113))
(assert ($Perm.isReadVar $k@113 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@113 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@113 $k@104))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(declare-const $k@114 $Perm)
(assert ($Perm.isValidVar $k@114))
(assert ($Perm.isReadVar $k@114 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@114 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@114 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(declare-const $k@115 $Perm)
(assert ($Perm.isValidVar $k@115))
(assert ($Perm.isReadVar $k@115 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@115 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@115 $k@109))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
; [eval] sys__result.BlockingQueue__capacity == capacity
; [exec]
; inhale false
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__take ----------
(declare-const diz@116 $Ref)
(declare-const sys__result@117 Int)
(declare-const currentCount@118 Int)
(declare-const __flatten_19@119 Int)
(declare-const __flatten_20@120 Int)
(declare-const x@121 Int)
(declare-const __flatten_21@122 Int)
(declare-const c@123 Int)
(declare-const __flatten_22@124 Int)
(declare-const __flatten_23@125 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@116 $Ref.null)))
(declare-const $k@126 $Perm)
(assert ($Perm.isValidVar $k@126))
(assert ($Perm.isReadVar $k@126 $Perm.Write))
(declare-const $t@127 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@126 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@126 $Perm.No)))
(assert (> $t@127 0))
(declare-const $k@128 $Perm)
(assert ($Perm.isValidVar $k@128))
(assert ($Perm.isReadVar $k@128 $Perm.Write))
(declare-const $t@129 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@128 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@128 $Perm.No)))
(assert (not (= $t@129 $Ref.null)))
(declare-const $k@130 $Perm)
(assert ($Perm.isValidVar $k@130))
(assert ($Perm.isReadVar $k@130 $Perm.Write))
(declare-const $t@131 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@130 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@130 $Perm.No)))
(assert (not (= $t@131 $Ref.null)))
(declare-const $k@132 $Perm)
(assert ($Perm.isValidVar $k@132))
(assert ($Perm.isReadVar $k@132 $Perm.Write))
(declare-const $t@133 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@132 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@132 $Perm.No)))
(assert (= $t@133 diz@116))
(declare-const $k@134 $Perm)
(assert ($Perm.isValidVar $k@134))
(assert ($Perm.isReadVar $k@134 $Perm.Write))
(declare-const $t@135 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@134 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@134 $Perm.No)))
(assert (not (= $t@135 $Ref.null)))
(declare-const $k@136 $Perm)
(assert ($Perm.isValidVar $k@136))
(assert ($Perm.isReadVar $k@136 $Perm.Write))
(declare-const $t@137 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@136 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@136 $Perm.No)))
(assert (= $t@137 diz@116))
(push) ; 3
(declare-const $k@138 $Perm)
(assert ($Perm.isValidVar $k@138))
(assert ($Perm.isReadVar $k@138 $Perm.Write))
(declare-const $t@139 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@138 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@138 $Perm.No)))
(assert (> $t@139 0))
(declare-const $k@140 $Perm)
(assert ($Perm.isValidVar $k@140))
(assert ($Perm.isReadVar $k@140 $Perm.Write))
(declare-const $t@141 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@140 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@140 $Perm.No)))
(assert (not (= $t@141 $Ref.null)))
(declare-const $k@142 $Perm)
(assert ($Perm.isValidVar $k@142))
(assert ($Perm.isReadVar $k@142 $Perm.Write))
(declare-const $t@143 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@142 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@142 $Perm.No)))
(assert (not (= $t@143 $Ref.null)))
(declare-const $k@144 $Perm)
(assert ($Perm.isValidVar $k@144))
(assert ($Perm.isReadVar $k@144 $Perm.Write))
(declare-const $t@145 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@144 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@144 $Perm.No)))
(assert (= $t@145 diz@116))
(declare-const $k@146 $Perm)
(assert ($Perm.isValidVar $k@146))
(assert ($Perm.isReadVar $k@146 $Perm.Write))
(declare-const $t@147 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@146 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@146 $Perm.No)))
(assert (not (= $t@147 $Ref.null)))
(declare-const $k@148 $Perm)
(assert ($Perm.isValidVar $k@148))
(assert ($Perm.isReadVar $k@148 $Perm.Write))
(declare-const $t@149 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@148 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@148 $Perm.No)))
(assert (= $t@149 diz@116))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@150 $Snap)
(declare-const $t@151 $Snap)
(assert (= $t@150 ($Snap.combine $t@151 $Snap.unit)))
(declare-const $t@152 $Ref)
(declare-const $t@153 $Ref)
(assert (=
  $t@151
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@152)
    ($SortWrappers.$RefTo$Snap $t@153))))
(declare-const $k@154 $Perm)
(assert ($Perm.isValidVar $k@154))
(assert ($Perm.isReadVar $k@154 $Perm.Write))
(assert (= $t@133 $t@152))
(push) ; 4
(assert (not (not (= (+ $k@132 $k@154) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ $k@132 $k@154) $Perm.No)))
(assert (not (= $t@133 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@153 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@155 $Snap)
; [exec]
; __flatten_19 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@156 Int)
; [exec]
; currentCount := __flatten_19
; loop at <no position>
(declare-const currentCount@157 Int)
(declare-const __flatten_20@158 Int)
(push) ; 4
; Verify loop body
(declare-const $t@159 $Snap)
(declare-const $t@160 $Snap)
(assert (= $t@159 ($Snap.combine $t@160 $Snap.unit)))
(declare-const $t@161 $Snap)
(assert (= $t@160 ($Snap.combine $t@161 $Snap.unit)))
(declare-const $t@162 $Snap)
(assert (= $t@161 ($Snap.combine $t@162 $Snap.unit)))
(declare-const $t@163 $Snap)
(declare-const $t@164 $Ref)
(assert (= $t@162 ($Snap.combine $t@163 ($SortWrappers.$RefTo$Snap $t@164))))
(declare-const $t@165 $Snap)
(assert (= $t@163 ($Snap.combine $t@165 $Snap.unit)))
(declare-const $t@166 $Snap)
(declare-const $t@167 $Ref)
(assert (= $t@165 ($Snap.combine $t@166 ($SortWrappers.$RefTo$Snap $t@167))))
(declare-const $t@168 $Snap)
(assert (= $t@166 ($Snap.combine $t@168 $Snap.unit)))
(declare-const $t@169 $Snap)
(declare-const $t@170 $Ref)
(assert (= $t@168 ($Snap.combine $t@169 ($SortWrappers.$RefTo$Snap $t@170))))
(declare-const $t@171 $Ref)
(declare-const $t@172 $Snap)
(assert (= $t@169 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@171) $t@172)))
(declare-const $t@173 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@171)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@173) $Snap.unit)))
(declare-const $k@174 $Perm)
(assert ($Perm.isValidVar $k@174))
(assert ($Perm.isReadVar $k@174 $Perm.Write))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= $k@174 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@174 $Perm.No)))
(assert (not (= $t@173 $Ref.null)))
(declare-const $k@175 $Perm)
(assert ($Perm.isValidVar $k@175))
(assert ($Perm.isReadVar $k@175 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= $k@175 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@175 $Perm.No)))
(assert (not (= $t@170 $Ref.null)))
(declare-const $k@176 $Perm)
(assert ($Perm.isValidVar $k@176))
(assert ($Perm.isReadVar $k@176 $Perm.Write))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (not (= $k@176 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@176 $Perm.No)))
(assert (= $t@167 diz@116))
(assert (not (= $t@167 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@164 $Ref.null)))
; [eval] currentCount == 0
(assert (= currentCount@157 0))
(check-sat)
; unknown
; [exec]
; assert acc(diz.BlockingQueue__headLock, wildcard)
(declare-const $k@177 $Perm)
(assert ($Perm.isValidVar $k@177))
(assert ($Perm.isReadVar $k@177 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@177 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@177 $k@174))
; [exec]
; assert diz.BlockingQueue__headLock != null
; [eval] diz.BlockingQueue__headLock != null
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@178 $Perm)
(assert ($Perm.isValidVar $k@178))
(assert ($Perm.isReadVar $k@178 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@178 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@178 $k@176))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@179 $Snap)
(declare-const $t@180 $Snap)
(assert (= $t@179 ($Snap.combine $t@180 $Snap.unit)))
(declare-const $t@181 $Ref)
(declare-const $t@182 $Ref)
(assert (=
  $t@180
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@181)
    ($SortWrappers.$RefTo$Snap $t@182))))
(declare-const $k@183 $Perm)
(assert ($Perm.isValidVar $k@183))
(assert ($Perm.isReadVar $k@183 $Perm.Write))
(assert (implies (< $Perm.No (- $k@176 $k@178)) (= $t@181 $t@167)))
(push) ; 5
(assert (not (not (= (+ (- $k@176 $k@178) $k@183) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@176 $k@178) $k@183) $Perm.No)))
(assert (not (= $t@181 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@182 $Ref.null)))
; [exec]
; __flatten_20 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@184 Int)
; [exec]
; currentCount := __flatten_20
(declare-const $k@185 $Perm)
(assert ($Perm.isValidVar $k@185))
(assert ($Perm.isReadVar $k@185 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@185 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@185 $k@174))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@186 $Perm)
(assert ($Perm.isValidVar $k@186))
(assert ($Perm.isReadVar $k@186 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@186 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@186 $k@175))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@187 $Perm)
(assert ($Perm.isValidVar $k@187))
(assert ($Perm.isReadVar $k@187 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@187 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@187 (+ (- $k@176 $k@178) $k@183)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@181 diz@116)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (= $t@181 diz@116))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
; [eval] diz.BlockingQueue__head != null
(pop) ; 4
(push) ; 4
; Establish loop invariant
(declare-const $k@188 $Perm)
(assert ($Perm.isValidVar $k@188))
(assert ($Perm.isReadVar $k@188 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@188 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@188 $k@130))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@189 $Perm)
(assert ($Perm.isValidVar $k@189))
(assert ($Perm.isReadVar $k@189 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@189 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@189 $k@128))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@190 $Perm)
(assert ($Perm.isValidVar $k@190))
(assert ($Perm.isReadVar $k@190 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@190 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@190 (+ $k@132 $k@154)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
; [eval] diz.BlockingQueue__head != null
; Continue after loop
(declare-const $t@191 $Snap)
(declare-const $t@192 $Snap)
(assert (= $t@191 ($Snap.combine $t@192 $Snap.unit)))
(declare-const $t@193 $Snap)
(assert (= $t@192 ($Snap.combine $t@193 $Snap.unit)))
(declare-const $t@194 $Snap)
(assert (= $t@193 ($Snap.combine $t@194 $Snap.unit)))
(declare-const $t@195 $Snap)
(declare-const $t@196 $Ref)
(assert (= $t@194 ($Snap.combine $t@195 ($SortWrappers.$RefTo$Snap $t@196))))
(declare-const $t@197 $Snap)
(assert (= $t@195 ($Snap.combine $t@197 $Snap.unit)))
(declare-const $t@198 $Snap)
(declare-const $t@199 $Ref)
(assert (= $t@197 ($Snap.combine $t@198 ($SortWrappers.$RefTo$Snap $t@199))))
(declare-const $t@200 $Snap)
(assert (= $t@198 ($Snap.combine $t@200 $Snap.unit)))
(declare-const $t@201 $Snap)
(declare-const $t@202 $Ref)
(assert (= $t@200 ($Snap.combine $t@201 ($SortWrappers.$RefTo$Snap $t@202))))
(declare-const $t@203 $Ref)
(declare-const $t@204 $Snap)
(assert (= $t@201 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@203) $t@204)))
(declare-const $t@205 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@203)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@205) $Snap.unit)))
(declare-const $k@206 $Perm)
(assert ($Perm.isValidVar $k@206))
(assert ($Perm.isReadVar $k@206 $Perm.Write))
(assert (implies (< $Perm.No (- $k@130 $k@188)) (= $t@205 $t@131)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@130 $k@188) $k@206) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@130 $k@188) $k@206) $Perm.No)))
(assert (not (= $t@205 $Ref.null)))
(declare-const $k@207 $Perm)
(assert ($Perm.isValidVar $k@207))
(assert ($Perm.isReadVar $k@207 $Perm.Write))
(assert (implies (< $Perm.No (- $k@128 $k@189)) (= $t@202 $t@129)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- $k@128 $k@189) $k@207) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@128 $k@189) $k@207) $Perm.No)))
(assert (not (= $t@202 $Ref.null)))
(declare-const $k@208 $Perm)
(assert ($Perm.isValidVar $k@208))
(assert ($Perm.isReadVar $k@208 $Perm.Write))
(push) ; 5
(assert (not (= $t@131 $t@205)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- (+ $k@132 $k@154) $k@190)) (= $t@199 $t@133)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@131 $t@205)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- (+ $k@132 $k@154) $k@190) $k@208) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ $k@132 $k@154) $k@190) $k@208) $Perm.No)))
(assert (= $t@199 diz@116))
(push) ; 5
(assert (not (= $t@131 $t@205)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $t@199 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
(push) ; 5
(assert (not (= $t@131 $t@205)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@196 $Ref.null)))
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(assert (not (= currentCount@157 0)))
(check-sat)
; unknown
; [exec]
; inhale diz.BlockingQueue__head != null
; [eval] diz.BlockingQueue__head != null
; [exec]
; __flatten_21 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@209 $Perm)
(assert ($Perm.isValidVar $k@209))
(assert ($Perm.isReadVar $k@209 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@209 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@209 $k@126))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@210 $Perm)
(assert ($Perm.isValidVar $k@210))
(assert ($Perm.isReadVar $k@210 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@210 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@210 (+ (- $k@128 $k@189) $k@207)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@211 $Perm)
(assert ($Perm.isValidVar $k@211))
(assert ($Perm.isReadVar $k@211 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@211 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@211 (+ (- $k@130 $k@188) $k@206)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@212 $Perm)
(assert ($Perm.isValidVar $k@212))
(assert ($Perm.isReadVar $k@212 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@212 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= $t@131 $t@205)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@212 (+ (- (+ $k@132 $k@154) $k@190) $k@208)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@131 $t@205)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(declare-const $k@213 $Perm)
(assert ($Perm.isValidVar $k@213))
(assert ($Perm.isReadVar $k@213 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@213 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@213 $k@134))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@214 $Perm)
(assert ($Perm.isValidVar $k@214))
(assert ($Perm.isReadVar $k@214 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@214 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@214 $k@136))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@215 Int)
(declare-const $t@216 $Snap)
(declare-const $t@217 $Snap)
(assert (= $t@216 ($Snap.combine $t@217 $Snap.unit)))
(declare-const $t@218 $Snap)
(declare-const $t@219 $Ref)
(assert (= $t@217 ($Snap.combine $t@218 ($SortWrappers.$RefTo$Snap $t@219))))
(declare-const $t@220 $Snap)
(assert (= $t@218 ($Snap.combine $t@220 $Snap.unit)))
(declare-const $t@221 $Snap)
(declare-const $t@222 $Ref)
(assert (= $t@220 ($Snap.combine $t@221 ($SortWrappers.$RefTo$Snap $t@222))))
(declare-const $t@223 $Snap)
(assert (= $t@221 ($Snap.combine $t@223 $Snap.unit)))
(declare-const $t@224 $Snap)
(declare-const $t@225 $Ref)
(assert (= $t@223 ($Snap.combine $t@224 ($SortWrappers.$RefTo$Snap $t@225))))
(declare-const $t@226 $Snap)
(assert (= $t@224 ($Snap.combine $t@226 $Snap.unit)))
(declare-const $t@227 $Snap)
(declare-const $t@228 $Ref)
(assert (= $t@226 ($Snap.combine $t@227 ($SortWrappers.$RefTo$Snap $t@228))))
(declare-const $t@229 $Snap)
(assert (= $t@227 ($Snap.combine $t@229 $Snap.unit)))
(declare-const $t@230 $Snap)
(declare-const $t@231 $Ref)
(assert (= $t@229 ($Snap.combine $t@230 ($SortWrappers.$RefTo$Snap $t@231))))
(declare-const $t@232 $Snap)
(assert (= $t@230 ($Snap.combine $t@232 $Snap.unit)))
(declare-const $t@233 Int)
(declare-const $t@234 $Ref)
(assert (=
  $t@232
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@233)
    ($SortWrappers.$RefTo$Snap $t@234))))
(declare-const $t@235 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@233)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@235) $Snap.unit)))
(declare-const $k@236 $Perm)
(assert ($Perm.isValidVar $k@236))
(assert ($Perm.isReadVar $k@236 $Perm.Write))
(assert (implies (< $Perm.No (- $k@126 $k@209)) (= $t@235 $t@127)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= (+ (- $k@126 $k@209) $k@236) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@126 $k@209) $k@236) $Perm.No)))
(assert (> $t@235 0))
(declare-const $k@237 $Perm)
(assert ($Perm.isValidVar $k@237))
(assert ($Perm.isReadVar $k@237 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@128 $k@189) $k@207) $k@210)) (= $t@234 $t@202)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@128 $k@189) $k@207) $k@210) $k@237) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@128 $k@189) $k@207) $k@210) $k@237) $Perm.No)))
(assert (not (= $t@234 $Ref.null)))
(declare-const $k@238 $Perm)
(assert ($Perm.isValidVar $k@238))
(assert ($Perm.isReadVar $k@238 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@130 $k@188) $k@206) $k@211)) (= $t@231 $t@205)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@130 $k@188) $k@206) $k@211) $k@238) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@130 $k@188) $k@206) $k@211) $k@238) $Perm.No)))
(assert (not (= $t@231 $Ref.null)))
(declare-const $k@239 $Perm)
(assert ($Perm.isValidVar $k@239))
(assert ($Perm.isReadVar $k@239 $Perm.Write))
(push) ; 5
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies
  (< $Perm.No (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212))
  (= $t@228 $t@199)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $Perm.No)))
(assert (= $t@228 diz@116))
(declare-const $k@240 $Perm)
(assert ($Perm.isValidVar $k@240))
(assert ($Perm.isReadVar $k@240 $Perm.Write))
(assert (implies (< $Perm.No (- $k@134 $k@213)) (= $t@225 $t@135)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@134 $k@213) $k@240) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@134 $k@213) $k@240) $Perm.No)))
(assert (not (= $t@225 $Ref.null)))
(declare-const $k@241 $Perm)
(assert ($Perm.isValidVar $k@241))
(assert ($Perm.isReadVar $k@241 $Perm.Write))
(push) ; 5
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- $k@136 $k@214)) (= $t@222 $t@137)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- $k@136 $k@214) $k@241) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@136 $k@214) $k@241) $Perm.No)))
(assert (= $t@222 diz@116))
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@219 $Ref.null)))
; [exec]
; x := __flatten_21
; [exec]
; __flatten_22 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@242 Int)
; [exec]
; c := __flatten_22
; [eval] c > 1
(push) ; 5
(assert (not (not (> sys__result@242 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (> sys__result@242 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 2] sys__result@242 > 1
(assert (> sys__result@242 1))
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 6
(assert (not (= $t@205 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 6
(assert (not (= $t@205 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@243 $Perm)
(assert ($Perm.isValidVar $k@243))
(assert ($Perm.isReadVar $k@243 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@243 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@243 (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239)))
(push) ; 6
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@228 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@116 $t@228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 6
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@228 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@116 $t@228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= sys__result@242 $t@235))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@242 $t@235)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 3] sys__result@242 == $t@235
(assert (= sys__result@242 $t@235))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@244 $Snap)
(declare-const $t@245 $Snap)
(assert (= $t@244 ($Snap.combine $t@245 $Snap.unit)))
(declare-const $t@246 $Ref)
(declare-const $t@247 $Ref)
(assert (=
  $t@245
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@246)
    ($SortWrappers.$RefTo$Snap $t@247))))
(declare-const $k@248 $Perm)
(assert ($Perm.isValidVar $k@248))
(assert ($Perm.isReadVar $k@248 $Perm.Write))
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@136 $k@214) $k@241)) (= $t@246 $t@222)))
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@136 $k@214) $k@241) $k@248) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@136 $k@214) $k@241) $k@248) $Perm.No)))
(assert (not (= $t@246 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@247 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@249 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@250 $Perm)
(assert ($Perm.isValidVar $k@250))
(assert ($Perm.isReadVar $k@250 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@250 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@250 (+ (+ (- $k@136 $k@214) $k@241) $k@248)))
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; __flatten_23 := x
; [exec]
; sys__result := __flatten_23
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@251 $Perm)
(assert ($Perm.isValidVar $k@251))
(assert ($Perm.isReadVar $k@251 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@251 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@251 (+ (- $k@126 $k@209) $k@236)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@252 $Perm)
(assert ($Perm.isValidVar $k@252))
(assert ($Perm.isReadVar $k@252 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@252 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@252 (+ (- (+ (- $k@128 $k@189) $k@207) $k@210) $k@237)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@253 $Perm)
(assert ($Perm.isValidVar $k@253))
(assert ($Perm.isReadVar $k@253 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@253 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@253 (+ (- (+ (- $k@130 $k@188) $k@206) $k@211) $k@238)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@254 $Perm)
(assert ($Perm.isValidVar $k@254))
(assert ($Perm.isReadVar $k@254 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@254 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@243)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@243)
    $Perm.No)))
(assert (<
  $k@254
  (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@243)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@255 $Perm)
(assert ($Perm.isValidVar $k@255))
(assert ($Perm.isReadVar $k@255 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@255 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@255 (+ (- $k@134 $k@213) $k@240)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@256 $Perm)
(assert ($Perm.isValidVar $k@256))
(assert ($Perm.isReadVar $k@256 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@256 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@136 $k@214) $k@241) $k@248) $k@250) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@136 $k@214) $k@241) $k@248) $k@250) $Perm.No)))
(assert (< $k@256 (- (+ (+ (- $k@136 $k@214) $k@241) $k@248) $k@250)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@246 diz@116)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@246 diz@116))
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 3] sys__result@242 != $t@235
(assert (not (= sys__result@242 $t@235)))
(pop) ; 6
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (= sys__result@242 $t@235)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@242 $t@235))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 4] sys__result@242 != $t@235
(assert (not (= sys__result@242 $t@235)))
; [exec]
; __flatten_23 := x
; [exec]
; sys__result := __flatten_23
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@257 $Perm)
(assert ($Perm.isValidVar $k@257))
(assert ($Perm.isReadVar $k@257 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@257 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@257 (+ (- $k@126 $k@209) $k@236)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@258 $Perm)
(assert ($Perm.isValidVar $k@258))
(assert ($Perm.isReadVar $k@258 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@258 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@258 (+ (- (+ (- $k@128 $k@189) $k@207) $k@210) $k@237)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@259 $Perm)
(assert ($Perm.isValidVar $k@259))
(assert ($Perm.isReadVar $k@259 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@259 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@259 (+ (- (+ (- $k@130 $k@188) $k@206) $k@211) $k@238)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@260 $Perm)
(assert ($Perm.isValidVar $k@260))
(assert ($Perm.isReadVar $k@260 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@260 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@243)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@243)
    $Perm.No)))
(assert (<
  $k@260
  (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@243)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@261 $Perm)
(assert ($Perm.isValidVar $k@261))
(assert ($Perm.isReadVar $k@261 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@261 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@261 (+ (- $k@134 $k@213) $k@240)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@262 $Perm)
(assert ($Perm.isValidVar $k@262))
(assert ($Perm.isReadVar $k@262 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@262 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@262 (+ (- $k@136 $k@214) $k@241)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 4] sys__result@242 == $t@235
(assert (= sys__result@242 $t@235))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 2] !sys__result@242 > 1
(assert (not (> sys__result@242 1)))
(pop) ; 5
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 5
(assert (not (> sys__result@242 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (> sys__result@242 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 5] !sys__result@242 > 1
(assert (not (> sys__result@242 1)))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 6
(assert (not (= $t@205 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@263 $Perm)
(assert ($Perm.isValidVar $k@263))
(assert ($Perm.isReadVar $k@263 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@263 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@263 (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239)))
(push) ; 6
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@228 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@116 $t@228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 6
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@228 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@116 $t@228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= sys__result@242 $t@235))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@242 $t@235)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 6] sys__result@242 == $t@235
(assert (= sys__result@242 $t@235))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@264 $Snap)
(declare-const $t@265 $Snap)
(assert (= $t@264 ($Snap.combine $t@265 $Snap.unit)))
(declare-const $t@266 $Ref)
(declare-const $t@267 $Ref)
(assert (=
  $t@265
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@266)
    ($SortWrappers.$RefTo$Snap $t@267))))
(declare-const $k@268 $Perm)
(assert ($Perm.isValidVar $k@268))
(assert ($Perm.isReadVar $k@268 $Perm.Write))
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@136 $k@214) $k@241)) (= $t@266 $t@222)))
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@136 $k@214) $k@241) $k@268) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@136 $k@214) $k@241) $k@268) $Perm.No)))
(assert (not (= $t@266 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@267 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@269 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@270 $Perm)
(assert ($Perm.isValidVar $k@270))
(assert ($Perm.isReadVar $k@270 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@270 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@270 (+ (+ (- $k@136 $k@214) $k@241) $k@268)))
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; __flatten_23 := x
; [exec]
; sys__result := __flatten_23
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@271 $Perm)
(assert ($Perm.isValidVar $k@271))
(assert ($Perm.isReadVar $k@271 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@271 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@271 (+ (- $k@126 $k@209) $k@236)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@272 $Perm)
(assert ($Perm.isValidVar $k@272))
(assert ($Perm.isReadVar $k@272 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@272 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@272 (+ (- (+ (- $k@128 $k@189) $k@207) $k@210) $k@237)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@273 $Perm)
(assert ($Perm.isValidVar $k@273))
(assert ($Perm.isReadVar $k@273 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@273 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@273 (+ (- (+ (- $k@130 $k@188) $k@206) $k@211) $k@238)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@274 $Perm)
(assert ($Perm.isValidVar $k@274))
(assert ($Perm.isReadVar $k@274 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@274 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@263)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@263)
    $Perm.No)))
(assert (<
  $k@274
  (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@263)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@275 $Perm)
(assert ($Perm.isValidVar $k@275))
(assert ($Perm.isReadVar $k@275 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@275 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@275 (+ (- $k@134 $k@213) $k@240)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@276 $Perm)
(assert ($Perm.isValidVar $k@276))
(assert ($Perm.isReadVar $k@276 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@276 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@136 $k@214) $k@241) $k@268) $k@270) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@136 $k@214) $k@241) $k@268) $k@270) $Perm.No)))
(assert (< $k@276 (- (+ (+ (- $k@136 $k@214) $k@241) $k@268) $k@270)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@266 diz@116)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@266 diz@116))
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 6] sys__result@242 != $t@235
(assert (not (= sys__result@242 $t@235)))
(pop) ; 6
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (= sys__result@242 $t@235)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@242 $t@235))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 7] sys__result@242 != $t@235
(assert (not (= sys__result@242 $t@235)))
; [exec]
; __flatten_23 := x
; [exec]
; sys__result := __flatten_23
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@277 $Perm)
(assert ($Perm.isValidVar $k@277))
(assert ($Perm.isReadVar $k@277 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@277 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@277 (+ (- $k@126 $k@209) $k@236)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@278 $Perm)
(assert ($Perm.isValidVar $k@278))
(assert ($Perm.isReadVar $k@278 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@278 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@278 (+ (- (+ (- $k@128 $k@189) $k@207) $k@210) $k@237)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@279 $Perm)
(assert ($Perm.isValidVar $k@279))
(assert ($Perm.isReadVar $k@279 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@279 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@279 (+ (- (+ (- $k@130 $k@188) $k@206) $k@211) $k@238)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@280 $Perm)
(assert ($Perm.isValidVar $k@280))
(assert ($Perm.isReadVar $k@280 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@280 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@263)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@263)
    $Perm.No)))
(assert (<
  $k@280
  (- (+ (- (+ (- (+ $k@132 $k@154) $k@190) $k@208) $k@212) $k@239) $k@263)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@131 $t@231)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@281 $Perm)
(assert ($Perm.isValidVar $k@281))
(assert ($Perm.isReadVar $k@281 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@281 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@281 (+ (- $k@134 $k@213) $k@240)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@282 $Perm)
(assert ($Perm.isValidVar $k@282))
(assert ($Perm.isReadVar $k@282 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@282 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@282 (+ (- $k@136 $k@214) $k@241)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@135 $t@225)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 7] sys__result@242 == $t@235
(assert (= sys__result@242 $t@235))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 5] sys__result@242 > 1
(assert (> sys__result@242 1))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__put ----------
(declare-const diz@283 $Ref)
(declare-const val@284 Int)
(declare-const currentCount@285 Int)
(declare-const __flatten_24@286 Int)
(declare-const __flatten_25@287 Int)
(declare-const c@288 Int)
(declare-const __flatten_27@289 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@283 $Ref.null)))
(declare-const $k@290 $Perm)
(assert ($Perm.isValidVar $k@290))
(assert ($Perm.isReadVar $k@290 $Perm.Write))
(declare-const $t@291 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@290 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@290 $Perm.No)))
(assert (> $t@291 0))
(declare-const $k@292 $Perm)
(assert ($Perm.isValidVar $k@292))
(assert ($Perm.isReadVar $k@292 $Perm.Write))
(declare-const $t@293 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@292 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@292 $Perm.No)))
(assert (not (= $t@293 $Ref.null)))
(declare-const $k@294 $Perm)
(assert ($Perm.isValidVar $k@294))
(assert ($Perm.isReadVar $k@294 $Perm.Write))
(declare-const $t@295 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@294 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@294 $Perm.No)))
(assert (not (= $t@295 $Ref.null)))
(declare-const $k@296 $Perm)
(assert ($Perm.isValidVar $k@296))
(assert ($Perm.isReadVar $k@296 $Perm.Write))
(declare-const $t@297 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@296 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@296 $Perm.No)))
(assert (= $t@297 diz@283))
(declare-const $k@298 $Perm)
(assert ($Perm.isValidVar $k@298))
(assert ($Perm.isReadVar $k@298 $Perm.Write))
(declare-const $t@299 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@298 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@298 $Perm.No)))
(assert (not (= $t@299 $Ref.null)))
(declare-const $k@300 $Perm)
(assert ($Perm.isValidVar $k@300))
(assert ($Perm.isReadVar $k@300 $Perm.Write))
(declare-const $t@301 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@300 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@300 $Perm.No)))
(assert (= $t@301 diz@283))
(push) ; 3
(declare-const $k@302 $Perm)
(assert ($Perm.isValidVar $k@302))
(assert ($Perm.isReadVar $k@302 $Perm.Write))
(declare-const $t@303 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@302 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@302 $Perm.No)))
(assert (> $t@303 0))
(declare-const $k@304 $Perm)
(assert ($Perm.isValidVar $k@304))
(assert ($Perm.isReadVar $k@304 $Perm.Write))
(declare-const $t@305 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@304 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@304 $Perm.No)))
(assert (not (= $t@305 $Ref.null)))
(declare-const $k@306 $Perm)
(assert ($Perm.isValidVar $k@306))
(assert ($Perm.isReadVar $k@306 $Perm.Write))
(declare-const $t@307 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@306 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@306 $Perm.No)))
(assert (not (= $t@307 $Ref.null)))
(declare-const $k@308 $Perm)
(assert ($Perm.isValidVar $k@308))
(assert ($Perm.isReadVar $k@308 $Perm.Write))
(declare-const $t@309 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@308 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@308 $Perm.No)))
(assert (= $t@309 diz@283))
(declare-const $k@310 $Perm)
(assert ($Perm.isValidVar $k@310))
(assert ($Perm.isReadVar $k@310 $Perm.Write))
(declare-const $t@311 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@310 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@310 $Perm.No)))
(assert (not (= $t@311 $Ref.null)))
(declare-const $k@312 $Perm)
(assert ($Perm.isValidVar $k@312))
(assert ($Perm.isReadVar $k@312 $Perm.Write))
(declare-const $t@313 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@312 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@312 $Perm.No)))
(assert (= $t@313 diz@283))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@314 $Snap)
(declare-const $t@315 $Snap)
(assert (= $t@314 ($Snap.combine $t@315 $Snap.unit)))
(declare-const $t@316 $Ref)
(declare-const $t@317 $Ref)
(assert (=
  $t@315
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@316)
    ($SortWrappers.$RefTo$Snap $t@317))))
(declare-const $k@318 $Perm)
(assert ($Perm.isValidVar $k@318))
(assert ($Perm.isReadVar $k@318 $Perm.Write))
(assert (= $t@301 $t@316))
(push) ; 4
(assert (not (not (= (+ $k@300 $k@318) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ $k@300 $k@318) $Perm.No)))
(assert (not (= $t@301 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(assert (not (= $t@317 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@319 $Snap)
; [exec]
; __flatten_24 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@320 Int)
; [exec]
; currentCount := __flatten_24
; loop at <no position>
(declare-const currentCount@321 Int)
(declare-const __flatten_25@322 Int)
(push) ; 4
; Verify loop body
(declare-const $t@323 $Snap)
(declare-const $t@324 $Snap)
(assert (= $t@323 ($Snap.combine $t@324 $Snap.unit)))
(declare-const $t@325 $Snap)
(assert (= $t@324 ($Snap.combine $t@325 $Snap.unit)))
(declare-const $t@326 $Snap)
(assert (= $t@325 ($Snap.combine $t@326 $Snap.unit)))
(declare-const $t@327 $Snap)
(declare-const $t@328 $Ref)
(assert (= $t@326 ($Snap.combine $t@327 ($SortWrappers.$RefTo$Snap $t@328))))
(declare-const $t@329 $Snap)
(assert (= $t@327 ($Snap.combine $t@329 $Snap.unit)))
(declare-const $t@330 $Snap)
(declare-const $t@331 $Ref)
(assert (= $t@329 ($Snap.combine $t@330 ($SortWrappers.$RefTo$Snap $t@331))))
(declare-const $t@332 $Snap)
(assert (= $t@330 ($Snap.combine $t@332 $Snap.unit)))
(declare-const $t@333 $Snap)
(declare-const $t@334 $Ref)
(assert (= $t@332 ($Snap.combine $t@333 ($SortWrappers.$RefTo$Snap $t@334))))
(declare-const $t@335 $Snap)
(declare-const $t@336 Int)
(assert (= $t@333 ($Snap.combine $t@335 ($SortWrappers.IntTo$Snap $t@336))))
(declare-const $t@337 $Ref)
(declare-const $t@338 $Snap)
(assert (= $t@335 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@337) $t@338)))
(declare-const $t@339 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@337)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@339) $Snap.unit)))
(declare-const $k@340 $Perm)
(assert ($Perm.isValidVar $k@340))
(assert ($Perm.isReadVar $k@340 $Perm.Write))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= $k@340 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@340 $Perm.No)))
(assert (not (= $t@339 $Ref.null)))
(declare-const $k@341 $Perm)
(assert ($Perm.isValidVar $k@341))
(assert ($Perm.isReadVar $k@341 $Perm.Write))
(declare-const $k@342 $Perm)
(assert ($Perm.isValidVar $k@342))
(assert ($Perm.isReadVar $k@342 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= $k@342 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@342 $Perm.No)))
(assert (not (= $t@334 $Ref.null)))
(declare-const $k@343 $Perm)
(assert ($Perm.isValidVar $k@343))
(assert ($Perm.isReadVar $k@343 $Perm.Write))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (not (= $k@343 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@343 $Perm.No)))
(assert (= $t@331 diz@283))
(assert (not (= $t@331 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@328 $Ref.null)))
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (= $k@341 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@341 $Perm.No)))
(assert (= currentCount@321 $t@336))
(check-sat)
; unknown
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@344 $Perm)
(assert ($Perm.isValidVar $k@344))
(assert ($Perm.isReadVar $k@344 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@344 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@344 $k@343))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@345 $Snap)
(declare-const $t@346 $Snap)
(assert (= $t@345 ($Snap.combine $t@346 $Snap.unit)))
(declare-const $t@347 $Ref)
(declare-const $t@348 $Ref)
(assert (=
  $t@346
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@347)
    ($SortWrappers.$RefTo$Snap $t@348))))
(declare-const $k@349 $Perm)
(assert ($Perm.isValidVar $k@349))
(assert ($Perm.isReadVar $k@349 $Perm.Write))
(assert (implies (< $Perm.No (- $k@343 $k@344)) (= $t@347 $t@331)))
(push) ; 5
(assert (not (not (= (+ (- $k@343 $k@344) $k@349) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@343 $k@344) $k@349) $Perm.No)))
(assert (not (= $t@347 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(assert (not (= $t@348 $Ref.null)))
; [exec]
; __flatten_25 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@350 Int)
; [exec]
; currentCount := __flatten_25
(declare-const $k@351 $Perm)
(assert ($Perm.isValidVar $k@351))
(assert ($Perm.isReadVar $k@351 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@351 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@351 $k@340))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@352 $Perm)
(assert ($Perm.isValidVar $k@352))
(assert ($Perm.isReadVar $k@352 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@352 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@352 $k@341))
(declare-const $k@353 $Perm)
(assert ($Perm.isValidVar $k@353))
(assert ($Perm.isReadVar $k@353 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@353 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@353 $k@342))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@354 $Perm)
(assert ($Perm.isValidVar $k@354))
(assert ($Perm.isReadVar $k@354 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@354 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@354 (+ (- $k@343 $k@344) $k@349)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@347 diz@283)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (= $t@347 diz@283))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
; [eval] diz.BlockingQueue__last != null
(pop) ; 4
(push) ; 4
; Establish loop invariant
(declare-const $k@355 $Perm)
(assert ($Perm.isValidVar $k@355))
(assert ($Perm.isReadVar $k@355 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@355 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@355 $k@298))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@356 $Perm)
(assert ($Perm.isValidVar $k@356))
(assert ($Perm.isReadVar $k@356 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@356 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@356 $k@290))
(declare-const $k@357 $Perm)
(assert ($Perm.isValidVar $k@357))
(assert ($Perm.isReadVar $k@357 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@357 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@357 $k@292))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@358 $Perm)
(assert ($Perm.isValidVar $k@358))
(assert ($Perm.isReadVar $k@358 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@358 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@358 (+ $k@300 $k@318)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
; [eval] diz.BlockingQueue__last != null
; Continue after loop
(declare-const $t@359 $Snap)
(declare-const $t@360 $Snap)
(assert (= $t@359 ($Snap.combine $t@360 $Snap.unit)))
(declare-const $t@361 $Snap)
(assert (= $t@360 ($Snap.combine $t@361 $Snap.unit)))
(declare-const $t@362 $Snap)
(assert (= $t@361 ($Snap.combine $t@362 $Snap.unit)))
(declare-const $t@363 $Snap)
(declare-const $t@364 $Ref)
(assert (= $t@362 ($Snap.combine $t@363 ($SortWrappers.$RefTo$Snap $t@364))))
(declare-const $t@365 $Snap)
(assert (= $t@363 ($Snap.combine $t@365 $Snap.unit)))
(declare-const $t@366 $Snap)
(declare-const $t@367 $Ref)
(assert (= $t@365 ($Snap.combine $t@366 ($SortWrappers.$RefTo$Snap $t@367))))
(declare-const $t@368 $Snap)
(assert (= $t@366 ($Snap.combine $t@368 $Snap.unit)))
(declare-const $t@369 $Snap)
(declare-const $t@370 $Ref)
(assert (= $t@368 ($Snap.combine $t@369 ($SortWrappers.$RefTo$Snap $t@370))))
(declare-const $t@371 $Snap)
(declare-const $t@372 Int)
(assert (= $t@369 ($Snap.combine $t@371 ($SortWrappers.IntTo$Snap $t@372))))
(declare-const $t@373 $Ref)
(declare-const $t@374 $Snap)
(assert (= $t@371 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@373) $t@374)))
(declare-const $t@375 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@373)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@375) $Snap.unit)))
(declare-const $k@376 $Perm)
(assert ($Perm.isValidVar $k@376))
(assert ($Perm.isReadVar $k@376 $Perm.Write))
(assert (implies (< $Perm.No (- $k@298 $k@355)) (= $t@375 $t@299)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@298 $k@355) $k@376) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@298 $k@355) $k@376) $Perm.No)))
(assert (not (= $t@375 $Ref.null)))
(declare-const $k@377 $Perm)
(assert ($Perm.isValidVar $k@377))
(assert ($Perm.isReadVar $k@377 $Perm.Write))
(assert (implies (< $Perm.No (- $k@290 $k@356)) (= $t@372 $t@291)))
(declare-const $k@378 $Perm)
(assert ($Perm.isValidVar $k@378))
(assert ($Perm.isReadVar $k@378 $Perm.Write))
(assert (implies (< $Perm.No (- $k@292 $k@357)) (= $t@370 $t@293)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- $k@292 $k@357) $k@378) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@292 $k@357) $k@378) $Perm.No)))
(assert (not (= $t@370 $Ref.null)))
(declare-const $k@379 $Perm)
(assert ($Perm.isValidVar $k@379))
(assert ($Perm.isReadVar $k@379 $Perm.Write))
(push) ; 5
(assert (not (= $t@299 $t@375)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- (+ $k@300 $k@318) $k@358)) (= $t@367 $t@301)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@299 $t@375)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- (+ $k@300 $k@318) $k@358) $k@379) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ $k@300 $k@318) $k@358) $k@379) $Perm.No)))
(assert (= $t@367 diz@283))
(push) ; 5
(assert (not (= $t@299 $t@375)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $t@367 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
(push) ; 5
(assert (not (= $t@299 $t@375)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@364 $Ref.null)))
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (= (+ (- $k@290 $k@356) $k@377) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@290 $k@356) $k@377) $Perm.No)))
(assert (not (= currentCount@321 $t@372)))
(check-sat)
; unknown
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@380 $Perm)
(assert ($Perm.isValidVar $k@380))
(assert ($Perm.isReadVar $k@380 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@380 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@380 (+ (- $k@290 $k@356) $k@377)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (> $t@372 0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (> $t@372 0))
(declare-const $k@381 $Perm)
(assert ($Perm.isValidVar $k@381))
(assert ($Perm.isReadVar $k@381 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@381 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@381 (+ (- $k@292 $k@357) $k@378)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@382 $Perm)
(assert ($Perm.isValidVar $k@382))
(assert ($Perm.isReadVar $k@382 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@382 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@382 $k@294))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@383 $Perm)
(assert ($Perm.isValidVar $k@383))
(assert ($Perm.isReadVar $k@383 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@383 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@383 $k@296))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@384 $Perm)
(assert ($Perm.isValidVar $k@384))
(assert ($Perm.isReadVar $k@384 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@384 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@384 (+ (- $k@298 $k@355) $k@376)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@385 $Perm)
(assert ($Perm.isValidVar $k@385))
(assert ($Perm.isReadVar $k@385 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@385 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= $t@299 $t@375)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@385 (+ (- (+ $k@300 $k@318) $k@358) $k@379)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@299 $t@375)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(declare-const $t@386 $Snap)
(declare-const $t@387 $Snap)
(assert (= $t@386 ($Snap.combine $t@387 $Snap.unit)))
(declare-const $t@388 $Snap)
(declare-const $t@389 $Ref)
(assert (= $t@387 ($Snap.combine $t@388 ($SortWrappers.$RefTo$Snap $t@389))))
(declare-const $t@390 $Snap)
(assert (= $t@388 ($Snap.combine $t@390 $Snap.unit)))
(declare-const $t@391 $Snap)
(declare-const $t@392 $Ref)
(assert (= $t@390 ($Snap.combine $t@391 ($SortWrappers.$RefTo$Snap $t@392))))
(declare-const $t@393 $Snap)
(assert (= $t@391 ($Snap.combine $t@393 $Snap.unit)))
(declare-const $t@394 $Snap)
(declare-const $t@395 $Ref)
(assert (= $t@393 ($Snap.combine $t@394 ($SortWrappers.$RefTo$Snap $t@395))))
(declare-const $t@396 $Snap)
(assert (= $t@394 ($Snap.combine $t@396 $Snap.unit)))
(declare-const $t@397 $Snap)
(declare-const $t@398 $Ref)
(assert (= $t@396 ($Snap.combine $t@397 ($SortWrappers.$RefTo$Snap $t@398))))
(declare-const $t@399 $Snap)
(assert (= $t@397 ($Snap.combine $t@399 $Snap.unit)))
(declare-const $t@400 $Snap)
(declare-const $t@401 $Ref)
(assert (= $t@399 ($Snap.combine $t@400 ($SortWrappers.$RefTo$Snap $t@401))))
(declare-const $t@402 $Snap)
(assert (= $t@400 ($Snap.combine $t@402 $Snap.unit)))
(declare-const $t@403 Int)
(declare-const $t@404 $Ref)
(assert (=
  $t@402
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@403)
    ($SortWrappers.$RefTo$Snap $t@404))))
(declare-const $t@405 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@403)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@405) $Snap.unit)))
(declare-const $k@406 $Perm)
(assert ($Perm.isValidVar $k@406))
(assert ($Perm.isReadVar $k@406 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@290 $k@356) $k@377) $k@380)) (= $t@405 $t@372)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@290 $k@356) $k@377) $k@380) $k@406) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@290 $k@356) $k@377) $k@380) $k@406) $Perm.No)))
(assert (> $t@405 0))
(declare-const $k@407 $Perm)
(assert ($Perm.isValidVar $k@407))
(assert ($Perm.isReadVar $k@407 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@292 $k@357) $k@378) $k@381)) (= $t@404 $t@370)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@292 $k@357) $k@378) $k@381) $k@407) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@292 $k@357) $k@378) $k@381) $k@407) $Perm.No)))
(assert (not (= $t@404 $Ref.null)))
(declare-const $k@408 $Perm)
(assert ($Perm.isValidVar $k@408))
(assert ($Perm.isReadVar $k@408 $Perm.Write))
(assert (implies (< $Perm.No (- $k@294 $k@382)) (= $t@401 $t@295)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@294 $k@382) $k@408) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@294 $k@382) $k@408) $Perm.No)))
(assert (not (= $t@401 $Ref.null)))
(declare-const $k@409 $Perm)
(assert ($Perm.isValidVar $k@409))
(assert ($Perm.isReadVar $k@409 $Perm.Write))
(push) ; 5
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- $k@296 $k@383)) (= $t@398 $t@297)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- $k@296 $k@383) $k@409) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@296 $k@383) $k@409) $Perm.No)))
(assert (= $t@398 diz@283))
(declare-const $k@410 $Perm)
(assert ($Perm.isValidVar $k@410))
(assert ($Perm.isReadVar $k@410 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@298 $k@355) $k@376) $k@384)) (= $t@395 $t@375)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@298 $k@355) $k@376) $k@384) $k@410) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@298 $k@355) $k@376) $k@384) $k@410) $Perm.No)))
(assert (not (= $t@395 $Ref.null)))
(declare-const $k@411 $Perm)
(assert ($Perm.isValidVar $k@411))
(assert ($Perm.isReadVar $k@411 $Perm.Write))
(push) ; 5
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies
  (< $Perm.No (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385))
  (= $t@392 $t@367)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $Perm.No)))
(assert (= $t@392 diz@283))
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@389 $Ref.null)))
; [exec]
; __flatten_27 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@412 Int)
; [exec]
; c := __flatten_27
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 5
(assert (not (not (< (+ sys__result@412 1) $t@405))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (< (+ sys__result@412 1) $t@405)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 8] sys__result@412 + 1 < $t@405
(assert (< (+ sys__result@412 1) $t@405))
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 6
(assert (not (= $t@375 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 6
(assert (not (= $t@375 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@413 $Perm)
(assert ($Perm.isValidVar $k@413))
(assert ($Perm.isReadVar $k@413 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@413 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@413 (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411)))
(push) ; 6
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@392 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@283 $t@392)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 6
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@392 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@283 $t@392)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == 0
(push) ; 6
(assert (not (not (= sys__result@412 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@412 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 9] sys__result@412 == 0
(assert (= sys__result@412 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@414 $Snap)
(declare-const $t@415 $Snap)
(assert (= $t@414 ($Snap.combine $t@415 $Snap.unit)))
(declare-const $t@416 $Ref)
(declare-const $t@417 $Ref)
(assert (=
  $t@415
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@416)
    ($SortWrappers.$RefTo$Snap $t@417))))
(declare-const $k@418 $Perm)
(assert ($Perm.isValidVar $k@418))
(assert ($Perm.isReadVar $k@418 $Perm.Write))
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@296 $k@383) $k@409)) (= $t@416 $t@398)))
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@296 $k@383) $k@409) $k@418) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@296 $k@383) $k@409) $k@418) $Perm.No)))
(assert (not (= $t@416 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@417 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@419 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@420 $Perm)
(assert ($Perm.isValidVar $k@420))
(assert ($Perm.isReadVar $k@420 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@420 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@420 (+ (+ (- $k@296 $k@383) $k@409) $k@418)))
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@421 $Perm)
(assert ($Perm.isValidVar $k@421))
(assert ($Perm.isReadVar $k@421 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@421 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@421 (+ (- (+ (- $k@290 $k@356) $k@377) $k@380) $k@406)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@422 $Perm)
(assert ($Perm.isValidVar $k@422))
(assert ($Perm.isReadVar $k@422 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@422 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@422 (+ (- (+ (- $k@292 $k@357) $k@378) $k@381) $k@407)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@423 $Perm)
(assert ($Perm.isValidVar $k@423))
(assert ($Perm.isReadVar $k@423 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@423 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@423 (+ (- $k@294 $k@382) $k@408)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@424 $Perm)
(assert ($Perm.isValidVar $k@424))
(assert ($Perm.isReadVar $k@424 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@424 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@296 $k@383) $k@409) $k@418) $k@420) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@296 $k@383) $k@409) $k@418) $k@420) $Perm.No)))
(assert (< $k@424 (- (+ (+ (- $k@296 $k@383) $k@409) $k@418) $k@420)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@416 diz@283)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@416 diz@283))
(declare-const $k@425 $Perm)
(assert ($Perm.isValidVar $k@425))
(assert ($Perm.isReadVar $k@425 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@425 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@425 (+ (- (+ (- $k@298 $k@355) $k@376) $k@384) $k@410)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@426 $Perm)
(assert ($Perm.isValidVar $k@426))
(assert ($Perm.isReadVar $k@426 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@426 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@413)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@413)
    $Perm.No)))
(assert (<
  $k@426
  (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@413)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 9] sys__result@412 != 0
(assert (not (= sys__result@412 0)))
(pop) ; 6
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 6
(assert (not (= sys__result@412 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@412 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 10] sys__result@412 != 0
(assert (not (= sys__result@412 0)))
(declare-const $k@427 $Perm)
(assert ($Perm.isValidVar $k@427))
(assert ($Perm.isReadVar $k@427 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@427 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@427 (+ (- (+ (- $k@290 $k@356) $k@377) $k@380) $k@406)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@428 $Perm)
(assert ($Perm.isValidVar $k@428))
(assert ($Perm.isReadVar $k@428 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@428 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@428 (+ (- (+ (- $k@292 $k@357) $k@378) $k@381) $k@407)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@429 $Perm)
(assert ($Perm.isValidVar $k@429))
(assert ($Perm.isReadVar $k@429 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@429 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@429 (+ (- $k@294 $k@382) $k@408)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@430 $Perm)
(assert ($Perm.isValidVar $k@430))
(assert ($Perm.isReadVar $k@430 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@430 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@430 (+ (- $k@296 $k@383) $k@409)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@431 $Perm)
(assert ($Perm.isValidVar $k@431))
(assert ($Perm.isReadVar $k@431 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@431 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@431 (+ (- (+ (- $k@298 $k@355) $k@376) $k@384) $k@410)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@432 $Perm)
(assert ($Perm.isValidVar $k@432))
(assert ($Perm.isReadVar $k@432 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@432 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@413)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@413)
    $Perm.No)))
(assert (<
  $k@432
  (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@413)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 10] sys__result@412 == 0
(assert (= sys__result@412 0))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 8] !sys__result@412 + 1 < $t@405
(assert (not (< (+ sys__result@412 1) $t@405)))
(pop) ; 5
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 5
(assert (not (< (+ sys__result@412 1) $t@405)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (< (+ sys__result@412 1) $t@405))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 11] !sys__result@412 + 1 < $t@405
(assert (not (< (+ sys__result@412 1) $t@405)))
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 6
(assert (not (= $t@375 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@433 $Perm)
(assert ($Perm.isValidVar $k@433))
(assert ($Perm.isReadVar $k@433 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@433 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@433 (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411)))
(push) ; 6
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@392 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@283 $t@392)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 6
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@392 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@283 $t@392)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == 0
(push) ; 6
(assert (not (not (= sys__result@412 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@412 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 12] sys__result@412 == 0
(assert (= sys__result@412 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@434 $Snap)
(declare-const $t@435 $Snap)
(assert (= $t@434 ($Snap.combine $t@435 $Snap.unit)))
(declare-const $t@436 $Ref)
(declare-const $t@437 $Ref)
(assert (=
  $t@435
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@436)
    ($SortWrappers.$RefTo$Snap $t@437))))
(declare-const $k@438 $Perm)
(assert ($Perm.isValidVar $k@438))
(assert ($Perm.isReadVar $k@438 $Perm.Write))
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@296 $k@383) $k@409)) (= $t@436 $t@398)))
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@296 $k@383) $k@409) $k@438) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@296 $k@383) $k@409) $k@438) $Perm.No)))
(assert (not (= $t@436 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@437 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@439 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@440 $Perm)
(assert ($Perm.isValidVar $k@440))
(assert ($Perm.isReadVar $k@440 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@440 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@440 (+ (+ (- $k@296 $k@383) $k@409) $k@438)))
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@441 $Perm)
(assert ($Perm.isValidVar $k@441))
(assert ($Perm.isReadVar $k@441 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@441 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@441 (+ (- (+ (- $k@290 $k@356) $k@377) $k@380) $k@406)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@442 $Perm)
(assert ($Perm.isValidVar $k@442))
(assert ($Perm.isReadVar $k@442 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@442 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@442 (+ (- (+ (- $k@292 $k@357) $k@378) $k@381) $k@407)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@443 $Perm)
(assert ($Perm.isValidVar $k@443))
(assert ($Perm.isReadVar $k@443 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@443 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@443 (+ (- $k@294 $k@382) $k@408)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@444 $Perm)
(assert ($Perm.isValidVar $k@444))
(assert ($Perm.isReadVar $k@444 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@444 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@296 $k@383) $k@409) $k@438) $k@440) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@296 $k@383) $k@409) $k@438) $k@440) $Perm.No)))
(assert (< $k@444 (- (+ (+ (- $k@296 $k@383) $k@409) $k@438) $k@440)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@436 diz@283)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@436 diz@283))
(declare-const $k@445 $Perm)
(assert ($Perm.isValidVar $k@445))
(assert ($Perm.isReadVar $k@445 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@445 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@445 (+ (- (+ (- $k@298 $k@355) $k@376) $k@384) $k@410)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@446 $Perm)
(assert ($Perm.isValidVar $k@446))
(assert ($Perm.isReadVar $k@446 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@446 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@433)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@433)
    $Perm.No)))
(assert (<
  $k@446
  (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@433)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 12] sys__result@412 != 0
(assert (not (= sys__result@412 0)))
(pop) ; 6
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 6
(assert (not (= sys__result@412 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@412 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 13] sys__result@412 != 0
(assert (not (= sys__result@412 0)))
(declare-const $k@447 $Perm)
(assert ($Perm.isValidVar $k@447))
(assert ($Perm.isReadVar $k@447 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@447 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@447 (+ (- (+ (- $k@290 $k@356) $k@377) $k@380) $k@406)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@448 $Perm)
(assert ($Perm.isValidVar $k@448))
(assert ($Perm.isReadVar $k@448 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@448 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@448 (+ (- (+ (- $k@292 $k@357) $k@378) $k@381) $k@407)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@449 $Perm)
(assert ($Perm.isValidVar $k@449))
(assert ($Perm.isReadVar $k@449 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@449 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@449 (+ (- $k@294 $k@382) $k@408)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@450 $Perm)
(assert ($Perm.isValidVar $k@450))
(assert ($Perm.isReadVar $k@450 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@450 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@450 (+ (- $k@296 $k@383) $k@409)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@295 $t@401)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@451 $Perm)
(assert ($Perm.isValidVar $k@451))
(assert ($Perm.isReadVar $k@451 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@451 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@451 (+ (- (+ (- $k@298 $k@355) $k@376) $k@384) $k@410)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@452 $Perm)
(assert ($Perm.isValidVar $k@452))
(assert ($Perm.isReadVar $k@452 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@452 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@433)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@433)
    $Perm.No)))
(assert (<
  $k@452
  (- (+ (- (+ (- (+ $k@300 $k@318) $k@358) $k@379) $k@385) $k@411) $k@433)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@299 $t@395)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 13] sys__result@412 == 0
(assert (= sys__result@412 0))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 11] sys__result@412 + 1 < $t@405
(assert (< (+ sys__result@412 1) $t@405))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__offer ----------
(declare-const diz@453 $Ref)
(declare-const val@454 Int)
(declare-const sys__result@455 Bool)
(declare-const currentCount@456 Int)
(declare-const __flatten_28@457 Int)
(declare-const __flatten_29@458 Bool)
(declare-const c@459 Int)
(declare-const __flatten_30@460 Int)
(declare-const __flatten_32@461 Int)
(declare-const __flatten_33@462 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@453 $Ref.null)))
(declare-const $k@463 $Perm)
(assert ($Perm.isValidVar $k@463))
(assert ($Perm.isReadVar $k@463 $Perm.Write))
(declare-const $t@464 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@463 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@463 $Perm.No)))
(assert (> $t@464 0))
(declare-const $k@465 $Perm)
(assert ($Perm.isValidVar $k@465))
(assert ($Perm.isReadVar $k@465 $Perm.Write))
(declare-const $t@466 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@465 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@465 $Perm.No)))
(assert (not (= $t@466 $Ref.null)))
(declare-const $k@467 $Perm)
(assert ($Perm.isValidVar $k@467))
(assert ($Perm.isReadVar $k@467 $Perm.Write))
(declare-const $t@468 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@467 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@467 $Perm.No)))
(assert (not (= $t@468 $Ref.null)))
(declare-const $k@469 $Perm)
(assert ($Perm.isValidVar $k@469))
(assert ($Perm.isReadVar $k@469 $Perm.Write))
(declare-const $t@470 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@469 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@469 $Perm.No)))
(assert (= $t@470 diz@453))
(declare-const $k@471 $Perm)
(assert ($Perm.isValidVar $k@471))
(assert ($Perm.isReadVar $k@471 $Perm.Write))
(declare-const $t@472 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@471 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@471 $Perm.No)))
(assert (not (= $t@472 $Ref.null)))
(declare-const $k@473 $Perm)
(assert ($Perm.isValidVar $k@473))
(assert ($Perm.isReadVar $k@473 $Perm.Write))
(declare-const $t@474 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@473 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@473 $Perm.No)))
(assert (= $t@474 diz@453))
(push) ; 3
(declare-const $k@475 $Perm)
(assert ($Perm.isValidVar $k@475))
(assert ($Perm.isReadVar $k@475 $Perm.Write))
(declare-const $t@476 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@475 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@475 $Perm.No)))
(assert (> $t@476 0))
(declare-const $k@477 $Perm)
(assert ($Perm.isValidVar $k@477))
(assert ($Perm.isReadVar $k@477 $Perm.Write))
(declare-const $t@478 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@477 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@477 $Perm.No)))
(assert (not (= $t@478 $Ref.null)))
(declare-const $k@479 $Perm)
(assert ($Perm.isValidVar $k@479))
(assert ($Perm.isReadVar $k@479 $Perm.Write))
(declare-const $t@480 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@479 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@479 $Perm.No)))
(assert (not (= $t@480 $Ref.null)))
(declare-const $k@481 $Perm)
(assert ($Perm.isValidVar $k@481))
(assert ($Perm.isReadVar $k@481 $Perm.Write))
(declare-const $t@482 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@481 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@481 $Perm.No)))
(assert (= $t@482 diz@453))
(declare-const $k@483 $Perm)
(assert ($Perm.isValidVar $k@483))
(assert ($Perm.isReadVar $k@483 $Perm.Write))
(declare-const $t@484 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@483 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@483 $Perm.No)))
(assert (not (= $t@484 $Ref.null)))
(declare-const $k@485 $Perm)
(assert ($Perm.isValidVar $k@485))
(assert ($Perm.isReadVar $k@485 $Perm.Write))
(declare-const $t@486 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@485 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@485 $Perm.No)))
(assert (= $t@486 diz@453))
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_28 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@487 Int)
; [exec]
; currentCount := __flatten_28
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 4
(assert (not (not (= sys__result@487 $t@464))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@487 $t@464)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 14] sys__result@487 == $t@464
(assert (= sys__result@487 $t@464))
; [exec]
; __flatten_29 := false
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@488 $Perm)
(assert ($Perm.isValidVar $k@488))
(assert ($Perm.isReadVar $k@488 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@488 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@488 $k@463))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@489 $Perm)
(assert ($Perm.isValidVar $k@489))
(assert ($Perm.isReadVar $k@489 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@489 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@489 $k@465))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@490 $Perm)
(assert ($Perm.isValidVar $k@490))
(assert ($Perm.isReadVar $k@490 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@490 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@490 $k@467))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@491 $Perm)
(assert ($Perm.isValidVar $k@491))
(assert ($Perm.isReadVar $k@491 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@491 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@491 $k@469))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@492 $Perm)
(assert ($Perm.isValidVar $k@492))
(assert ($Perm.isReadVar $k@492 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@492 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@492 $k@471))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@493 $Perm)
(assert ($Perm.isValidVar $k@493))
(assert ($Perm.isReadVar $k@493 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@493 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@493 $k@473))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 4
(push) ; 4
; [else-branch 14] sys__result@487 != $t@464
(assert (not (= sys__result@487 $t@464)))
(pop) ; 4
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 4
(assert (not (= sys__result@487 $t@464)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= sys__result@487 $t@464))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 15] sys__result@487 != $t@464
(assert (not (= sys__result@487 $t@464)))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@494 $Snap)
(declare-const $t@495 $Snap)
(assert (= $t@494 ($Snap.combine $t@495 $Snap.unit)))
(declare-const $t@496 $Ref)
(declare-const $t@497 $Ref)
(assert (=
  $t@495
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@496)
    ($SortWrappers.$RefTo$Snap $t@497))))
(declare-const $k@498 $Perm)
(assert ($Perm.isValidVar $k@498))
(assert ($Perm.isReadVar $k@498 $Perm.Write))
(assert (= $t@474 $t@496))
(push) ; 5
(assert (not (not (= (+ $k@473 $k@498) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $k@473 $k@498) $Perm.No)))
(assert (not (= $t@474 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(assert (not (= $t@497 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@499 $Snap)
; [exec]
; c := -1
; [eval] -1
; [exec]
; __flatten_30 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@500 Int)
; [exec]
; currentCount := __flatten_30
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (< sys__result@500 $t@464))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (< sys__result@500 $t@464)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 16] sys__result@500 < $t@464
(assert (< sys__result@500 $t@464))
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@501 $Perm)
(assert ($Perm.isValidVar $k@501))
(assert ($Perm.isReadVar $k@501 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@501 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@501 $k@463))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@502 $Perm)
(assert ($Perm.isValidVar $k@502))
(assert ($Perm.isReadVar $k@502 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@502 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@502 $k@465))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@503 $Perm)
(assert ($Perm.isValidVar $k@503))
(assert ($Perm.isReadVar $k@503 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@503 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@503 $k@467))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@504 $Perm)
(assert ($Perm.isValidVar $k@504))
(assert ($Perm.isReadVar $k@504 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@504 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@504 $k@469))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@505 $Perm)
(assert ($Perm.isValidVar $k@505))
(assert ($Perm.isReadVar $k@505 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@505 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@505 $k@471))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@506 $Perm)
(assert ($Perm.isValidVar $k@506))
(assert ($Perm.isReadVar $k@506 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@506 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@506 (+ $k@473 $k@498)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const $t@507 $Snap)
(declare-const $t@508 $Snap)
(assert (= $t@507 ($Snap.combine $t@508 $Snap.unit)))
(declare-const $t@509 $Snap)
(declare-const $t@510 $Ref)
(assert (= $t@508 ($Snap.combine $t@509 ($SortWrappers.$RefTo$Snap $t@510))))
(declare-const $t@511 $Snap)
(assert (= $t@509 ($Snap.combine $t@511 $Snap.unit)))
(declare-const $t@512 $Snap)
(declare-const $t@513 $Ref)
(assert (= $t@511 ($Snap.combine $t@512 ($SortWrappers.$RefTo$Snap $t@513))))
(declare-const $t@514 $Snap)
(assert (= $t@512 ($Snap.combine $t@514 $Snap.unit)))
(declare-const $t@515 $Snap)
(declare-const $t@516 $Ref)
(assert (= $t@514 ($Snap.combine $t@515 ($SortWrappers.$RefTo$Snap $t@516))))
(declare-const $t@517 $Snap)
(assert (= $t@515 ($Snap.combine $t@517 $Snap.unit)))
(declare-const $t@518 $Snap)
(declare-const $t@519 $Ref)
(assert (= $t@517 ($Snap.combine $t@518 ($SortWrappers.$RefTo$Snap $t@519))))
(declare-const $t@520 $Snap)
(assert (= $t@518 ($Snap.combine $t@520 $Snap.unit)))
(declare-const $t@521 $Snap)
(declare-const $t@522 $Ref)
(assert (= $t@520 ($Snap.combine $t@521 ($SortWrappers.$RefTo$Snap $t@522))))
(declare-const $t@523 $Snap)
(assert (= $t@521 ($Snap.combine $t@523 $Snap.unit)))
(declare-const $t@524 Int)
(declare-const $t@525 $Ref)
(assert (=
  $t@523
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@524)
    ($SortWrappers.$RefTo$Snap $t@525))))
(declare-const $t@526 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@524)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@526) $Snap.unit)))
(declare-const $k@527 $Perm)
(assert ($Perm.isValidVar $k@527))
(assert ($Perm.isReadVar $k@527 $Perm.Write))
(assert (implies (< $Perm.No (- $k@463 $k@501)) (= $t@526 $t@464)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@463 $k@501) $k@527) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@463 $k@501) $k@527) $Perm.No)))
(assert (> $t@526 0))
(declare-const $k@528 $Perm)
(assert ($Perm.isValidVar $k@528))
(assert ($Perm.isReadVar $k@528 $Perm.Write))
(assert (implies (< $Perm.No (- $k@465 $k@502)) (= $t@525 $t@466)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@465 $k@502) $k@528) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@465 $k@502) $k@528) $Perm.No)))
(assert (not (= $t@525 $Ref.null)))
(declare-const $k@529 $Perm)
(assert ($Perm.isValidVar $k@529))
(assert ($Perm.isReadVar $k@529 $Perm.Write))
(assert (implies (< $Perm.No (- $k@467 $k@503)) (= $t@522 $t@468)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@467 $k@503) $k@529) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@467 $k@503) $k@529) $Perm.No)))
(assert (not (= $t@522 $Ref.null)))
(declare-const $k@530 $Perm)
(assert ($Perm.isValidVar $k@530))
(assert ($Perm.isReadVar $k@530 $Perm.Write))
(push) ; 6
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- $k@469 $k@504)) (= $t@519 $t@470)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 6
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- $k@469 $k@504) $k@530) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@469 $k@504) $k@530) $Perm.No)))
(assert (= $t@519 diz@453))
(declare-const $k@531 $Perm)
(assert ($Perm.isValidVar $k@531))
(assert ($Perm.isReadVar $k@531 $Perm.Write))
(assert (implies (< $Perm.No (- $k@471 $k@505)) (= $t@516 $t@472)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@471 $k@505) $k@531) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@471 $k@505) $k@531) $Perm.No)))
(assert (not (= $t@516 $Ref.null)))
(declare-const $k@532 $Perm)
(assert ($Perm.isValidVar $k@532))
(assert ($Perm.isReadVar $k@532 $Perm.Write))
(push) ; 6
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- (+ $k@473 $k@498) $k@506)) (= $t@513 $t@474)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 6
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- (+ $k@473 $k@498) $k@506) $k@532) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- (+ $k@473 $k@498) $k@506) $k@532) $Perm.No)))
(assert (= $t@513 diz@453))
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@510 $Ref.null)))
; [exec]
; __flatten_32 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@533 Int)
; [exec]
; c := __flatten_32
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 6
(assert (not (not (< (+ sys__result@533 1) $t@526))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (< (+ sys__result@533 1) $t@526)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 17] sys__result@533 + 1 < $t@526
(assert (< (+ sys__result@533 1) $t@526))
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@534 $Perm)
(assert ($Perm.isValidVar $k@534))
(assert ($Perm.isReadVar $k@534 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@534 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@534 (+ (- (+ $k@473 $k@498) $k@506) $k@532)))
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@513 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@453 $t@513)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@513 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@453 $t@513)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == 0
(push) ; 7
(assert (not (not (= sys__result@533 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@533 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 18] sys__result@533 == 0
(assert (= sys__result@533 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@535 $Snap)
(declare-const $t@536 $Snap)
(assert (= $t@535 ($Snap.combine $t@536 $Snap.unit)))
(declare-const $t@537 $Ref)
(declare-const $t@538 $Ref)
(assert (=
  $t@536
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@537)
    ($SortWrappers.$RefTo$Snap $t@538))))
(declare-const $k@539 $Perm)
(assert ($Perm.isValidVar $k@539))
(assert ($Perm.isReadVar $k@539 $Perm.Write))
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@469 $k@504) $k@530)) (= $t@537 $t@519)))
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@469 $k@504) $k@530) $k@539) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@469 $k@504) $k@530) $k@539) $Perm.No)))
(assert (not (= $t@537 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@538 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@540 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@541 $Perm)
(assert ($Perm.isValidVar $k@541))
(assert ($Perm.isReadVar $k@541 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@541 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@541 (+ (+ (- $k@469 $k@504) $k@530) $k@539)))
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_33 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_33
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@542 $Perm)
(assert ($Perm.isValidVar $k@542))
(assert ($Perm.isReadVar $k@542 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@542 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@542 (+ (- $k@463 $k@501) $k@527)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@543 $Perm)
(assert ($Perm.isValidVar $k@543))
(assert ($Perm.isReadVar $k@543 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@543 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@543 (+ (- $k@465 $k@502) $k@528)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@544 $Perm)
(assert ($Perm.isValidVar $k@544))
(assert ($Perm.isReadVar $k@544 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@544 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@544 (+ (- $k@467 $k@503) $k@529)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@545 $Perm)
(assert ($Perm.isValidVar $k@545))
(assert ($Perm.isReadVar $k@545 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@545 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@469 $k@504) $k@530) $k@539) $k@541) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@469 $k@504) $k@530) $k@539) $k@541) $Perm.No)))
(assert (< $k@545 (- (+ (+ (- $k@469 $k@504) $k@530) $k@539) $k@541)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@537 diz@453)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@537 diz@453))
(declare-const $k@546 $Perm)
(assert ($Perm.isValidVar $k@546))
(assert ($Perm.isReadVar $k@546 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@546 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@546 (+ (- $k@471 $k@505) $k@531)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@547 $Perm)
(assert ($Perm.isValidVar $k@547))
(assert ($Perm.isReadVar $k@547 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@547 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@534) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@534) $Perm.No)))
(assert (< $k@547 (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@534)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 18] sys__result@533 != 0
(assert (not (= sys__result@533 0)))
(pop) ; 7
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 7
(assert (not (= sys__result@533 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@533 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 19] sys__result@533 != 0
(assert (not (= sys__result@533 0)))
; [exec]
; __flatten_33 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_33
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@548 $Perm)
(assert ($Perm.isValidVar $k@548))
(assert ($Perm.isReadVar $k@548 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@548 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@548 (+ (- $k@463 $k@501) $k@527)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@549 $Perm)
(assert ($Perm.isValidVar $k@549))
(assert ($Perm.isReadVar $k@549 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@549 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@549 (+ (- $k@465 $k@502) $k@528)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@550 $Perm)
(assert ($Perm.isValidVar $k@550))
(assert ($Perm.isReadVar $k@550 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@550 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@550 (+ (- $k@467 $k@503) $k@529)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@551 $Perm)
(assert ($Perm.isValidVar $k@551))
(assert ($Perm.isReadVar $k@551 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@551 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@551 (+ (- $k@469 $k@504) $k@530)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@552 $Perm)
(assert ($Perm.isValidVar $k@552))
(assert ($Perm.isReadVar $k@552 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@552 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@552 (+ (- $k@471 $k@505) $k@531)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@553 $Perm)
(assert ($Perm.isValidVar $k@553))
(assert ($Perm.isReadVar $k@553 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@553 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@534) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@534) $Perm.No)))
(assert (< $k@553 (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@534)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 19] sys__result@533 == 0
(assert (= sys__result@533 0))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 17] !sys__result@533 + 1 < $t@526
(assert (not (< (+ sys__result@533 1) $t@526)))
(pop) ; 6
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 6
(assert (not (< (+ sys__result@533 1) $t@526)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (< (+ sys__result@533 1) $t@526))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 20] !sys__result@533 + 1 < $t@526
(assert (not (< (+ sys__result@533 1) $t@526)))
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@554 $Perm)
(assert ($Perm.isValidVar $k@554))
(assert ($Perm.isReadVar $k@554 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@554 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@554 (+ (- (+ $k@473 $k@498) $k@506) $k@532)))
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@513 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@453 $t@513)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@513 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@453 $t@513)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == 0
(push) ; 7
(assert (not (not (= sys__result@533 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@533 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 21] sys__result@533 == 0
(assert (= sys__result@533 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@555 $Snap)
(declare-const $t@556 $Snap)
(assert (= $t@555 ($Snap.combine $t@556 $Snap.unit)))
(declare-const $t@557 $Ref)
(declare-const $t@558 $Ref)
(assert (=
  $t@556
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@557)
    ($SortWrappers.$RefTo$Snap $t@558))))
(declare-const $k@559 $Perm)
(assert ($Perm.isValidVar $k@559))
(assert ($Perm.isReadVar $k@559 $Perm.Write))
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@469 $k@504) $k@530)) (= $t@557 $t@519)))
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@469 $k@504) $k@530) $k@559) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@469 $k@504) $k@530) $k@559) $Perm.No)))
(assert (not (= $t@557 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@558 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@560 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@561 $Perm)
(assert ($Perm.isValidVar $k@561))
(assert ($Perm.isReadVar $k@561 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@561 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@561 (+ (+ (- $k@469 $k@504) $k@530) $k@559)))
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_33 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_33
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@562 $Perm)
(assert ($Perm.isValidVar $k@562))
(assert ($Perm.isReadVar $k@562 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@562 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@562 (+ (- $k@463 $k@501) $k@527)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@563 $Perm)
(assert ($Perm.isValidVar $k@563))
(assert ($Perm.isReadVar $k@563 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@563 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@563 (+ (- $k@465 $k@502) $k@528)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@564 $Perm)
(assert ($Perm.isValidVar $k@564))
(assert ($Perm.isReadVar $k@564 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@564 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@564 (+ (- $k@467 $k@503) $k@529)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@565 $Perm)
(assert ($Perm.isValidVar $k@565))
(assert ($Perm.isReadVar $k@565 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@565 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@469 $k@504) $k@530) $k@559) $k@561) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@469 $k@504) $k@530) $k@559) $k@561) $Perm.No)))
(assert (< $k@565 (- (+ (+ (- $k@469 $k@504) $k@530) $k@559) $k@561)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@557 diz@453)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@557 diz@453))
(declare-const $k@566 $Perm)
(assert ($Perm.isValidVar $k@566))
(assert ($Perm.isReadVar $k@566 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@566 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@566 (+ (- $k@471 $k@505) $k@531)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@567 $Perm)
(assert ($Perm.isValidVar $k@567))
(assert ($Perm.isReadVar $k@567 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@567 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@554) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@554) $Perm.No)))
(assert (< $k@567 (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@554)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 21] sys__result@533 != 0
(assert (not (= sys__result@533 0)))
(pop) ; 7
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 7
(assert (not (= sys__result@533 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@533 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 22] sys__result@533 != 0
(assert (not (= sys__result@533 0)))
; [exec]
; __flatten_33 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_33
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@568 $Perm)
(assert ($Perm.isValidVar $k@568))
(assert ($Perm.isReadVar $k@568 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@568 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@568 (+ (- $k@463 $k@501) $k@527)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@569 $Perm)
(assert ($Perm.isValidVar $k@569))
(assert ($Perm.isReadVar $k@569 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@569 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@569 (+ (- $k@465 $k@502) $k@528)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@570 $Perm)
(assert ($Perm.isValidVar $k@570))
(assert ($Perm.isReadVar $k@570 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@570 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@570 (+ (- $k@467 $k@503) $k@529)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@571 $Perm)
(assert ($Perm.isValidVar $k@571))
(assert ($Perm.isReadVar $k@571 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@571 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@571 (+ (- $k@469 $k@504) $k@530)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@468 $t@522)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@572 $Perm)
(assert ($Perm.isValidVar $k@572))
(assert ($Perm.isReadVar $k@572 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@572 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@572 (+ (- $k@471 $k@505) $k@531)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@573 $Perm)
(assert ($Perm.isValidVar $k@573))
(assert ($Perm.isReadVar $k@573 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@573 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@554) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@554) $Perm.No)))
(assert (< $k@573 (- (+ (- (+ $k@473 $k@498) $k@506) $k@532) $k@554)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@472 $t@516)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 22] sys__result@533 == 0
(assert (= sys__result@533 0))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 20] sys__result@533 + 1 < $t@526
(assert (< (+ sys__result@533 1) $t@526))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 16] !sys__result@500 < $t@464
(assert (not (< sys__result@500 $t@464)))
(pop) ; 5
; [eval] !(currentCount < diz.BlockingQueue__capacity)
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 5
(assert (not (< sys__result@500 $t@464)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (< sys__result@500 $t@464))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 23] !sys__result@500 < $t@464
(assert (not (< sys__result@500 $t@464)))
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@574 $Perm)
(assert ($Perm.isValidVar $k@574))
(assert ($Perm.isReadVar $k@574 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@574 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@574 (+ $k@473 $k@498)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
; [eval] c == 0
(push) ; 6
(assert (not (not (= (- 0 1) 0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= (- 0 1) 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 24] -1 == 0
(push) ; 6
; [else-branch 24] -1 != 0
(assert (not (= (- 0 1) 0)))
(pop) ; 6
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 6
(assert (not (= (- 0 1) 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (- 0 1) 0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 25] -1 != 0
(assert (not (= (- 0 1) 0)))
; [exec]
; __flatten_33 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_33
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@575 $Perm)
(assert ($Perm.isValidVar $k@575))
(assert ($Perm.isReadVar $k@575 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@575 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@575 $k@463))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@576 $Perm)
(assert ($Perm.isValidVar $k@576))
(assert ($Perm.isReadVar $k@576 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@576 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@576 $k@465))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@577 $Perm)
(assert ($Perm.isValidVar $k@577))
(assert ($Perm.isReadVar $k@577 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@577 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@577 $k@467))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@578 $Perm)
(assert ($Perm.isValidVar $k@578))
(assert ($Perm.isReadVar $k@578 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@578 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@578 $k@469))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@579 $Perm)
(assert ($Perm.isValidVar $k@579))
(assert ($Perm.isReadVar $k@579 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@579 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@579 $k@471))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@580 $Perm)
(assert ($Perm.isValidVar $k@580))
(assert ($Perm.isReadVar $k@580 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@580 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ $k@473 $k@498) $k@574) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ $k@473 $k@498) $k@574) $Perm.No)))
(assert (< $k@580 (- (+ $k@473 $k@498) $k@574)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 25] -1 == 0
(pop) ; 5
(push) ; 5
; [else-branch 23] sys__result@500 < $t@464
(assert (< sys__result@500 $t@464))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 15] sys__result@487 == $t@464
(assert (= sys__result@487 $t@464))
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__poll ----------
(declare-const diz@581 $Ref)
(declare-const sys__result@582 $Ref)
(declare-const x@583 $Ref)
(declare-const currentCount@584 Int)
(declare-const __flatten_34@585 Int)
(declare-const __flatten_35@586 $Ref)
(declare-const c@587 Int)
(declare-const __flatten_36@588 Int)
(declare-const __flatten_37@589 Int)
(declare-const __flatten_38@590 $Ref)
(declare-const __flatten_39@591 Int)
(declare-const __flatten_40@592 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@581 $Ref.null)))
(declare-const $k@593 $Perm)
(assert ($Perm.isValidVar $k@593))
(assert ($Perm.isReadVar $k@593 $Perm.Write))
(declare-const $t@594 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@593 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@593 $Perm.No)))
(assert (> $t@594 0))
(declare-const $k@595 $Perm)
(assert ($Perm.isValidVar $k@595))
(assert ($Perm.isReadVar $k@595 $Perm.Write))
(declare-const $t@596 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@595 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@595 $Perm.No)))
(assert (not (= $t@596 $Ref.null)))
(declare-const $k@597 $Perm)
(assert ($Perm.isValidVar $k@597))
(assert ($Perm.isReadVar $k@597 $Perm.Write))
(declare-const $t@598 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@597 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@597 $Perm.No)))
(assert (not (= $t@598 $Ref.null)))
(declare-const $k@599 $Perm)
(assert ($Perm.isValidVar $k@599))
(assert ($Perm.isReadVar $k@599 $Perm.Write))
(declare-const $t@600 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@599 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@599 $Perm.No)))
(assert (= $t@600 diz@581))
(declare-const $k@601 $Perm)
(assert ($Perm.isValidVar $k@601))
(assert ($Perm.isReadVar $k@601 $Perm.Write))
(declare-const $t@602 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@601 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@601 $Perm.No)))
(assert (not (= $t@602 $Ref.null)))
(declare-const $k@603 $Perm)
(assert ($Perm.isValidVar $k@603))
(assert ($Perm.isReadVar $k@603 $Perm.Write))
(declare-const $t@604 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@603 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@603 $Perm.No)))
(assert (= $t@604 diz@581))
(push) ; 3
(declare-const $k@605 $Perm)
(assert ($Perm.isValidVar $k@605))
(assert ($Perm.isReadVar $k@605 $Perm.Write))
(declare-const $t@606 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@605 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@605 $Perm.No)))
(assert (> $t@606 0))
(declare-const $k@607 $Perm)
(assert ($Perm.isValidVar $k@607))
(assert ($Perm.isReadVar $k@607 $Perm.Write))
(declare-const $t@608 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@607 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@607 $Perm.No)))
(assert (not (= $t@608 $Ref.null)))
(declare-const $k@609 $Perm)
(assert ($Perm.isValidVar $k@609))
(assert ($Perm.isReadVar $k@609 $Perm.Write))
(declare-const $t@610 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@609 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@609 $Perm.No)))
(assert (not (= $t@610 $Ref.null)))
(declare-const $k@611 $Perm)
(assert ($Perm.isValidVar $k@611))
(assert ($Perm.isReadVar $k@611 $Perm.Write))
(declare-const $t@612 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@611 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@611 $Perm.No)))
(assert (= $t@612 diz@581))
(declare-const $k@613 $Perm)
(assert ($Perm.isValidVar $k@613))
(assert ($Perm.isReadVar $k@613 $Perm.Write))
(declare-const $t@614 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@613 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@613 $Perm.No)))
(assert (not (= $t@614 $Ref.null)))
(declare-const $k@615 $Perm)
(assert ($Perm.isValidVar $k@615))
(assert ($Perm.isReadVar $k@615 $Perm.Write))
(declare-const $t@616 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@615 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@615 $Perm.No)))
(assert (= $t@616 diz@581))
(pop) ; 3
(push) ; 3
; [exec]
; x := null
; [exec]
; __flatten_34 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@617 Int)
; [exec]
; currentCount := __flatten_34
; [eval] currentCount == 0
(push) ; 4
(assert (not (not (= sys__result@617 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@617 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 26] sys__result@617 == 0
(assert (= sys__result@617 0))
; [exec]
; __flatten_35 := x
; [exec]
; sys__result := __flatten_35
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@618 $Perm)
(assert ($Perm.isValidVar $k@618))
(assert ($Perm.isReadVar $k@618 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@618 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@618 $k@593))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@619 $Perm)
(assert ($Perm.isValidVar $k@619))
(assert ($Perm.isReadVar $k@619 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@619 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@619 $k@595))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@620 $Perm)
(assert ($Perm.isValidVar $k@620))
(assert ($Perm.isReadVar $k@620 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@620 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@620 $k@597))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@621 $Perm)
(assert ($Perm.isValidVar $k@621))
(assert ($Perm.isReadVar $k@621 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@621 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@621 $k@599))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@622 $Perm)
(assert ($Perm.isValidVar $k@622))
(assert ($Perm.isReadVar $k@622 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@622 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@622 $k@601))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@623 $Perm)
(assert ($Perm.isValidVar $k@623))
(assert ($Perm.isReadVar $k@623 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@623 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@623 $k@603))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 4
(push) ; 4
; [else-branch 26] sys__result@617 != 0
(assert (not (= sys__result@617 0)))
(pop) ; 4
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 4
(assert (not (= sys__result@617 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= sys__result@617 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 27] sys__result@617 != 0
(assert (not (= sys__result@617 0)))
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@624 $Snap)
(declare-const $t@625 $Snap)
(assert (= $t@624 ($Snap.combine $t@625 $Snap.unit)))
(declare-const $t@626 $Ref)
(declare-const $t@627 $Ref)
(assert (=
  $t@625
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@626)
    ($SortWrappers.$RefTo$Snap $t@627))))
(declare-const $k@628 $Perm)
(assert ($Perm.isValidVar $k@628))
(assert ($Perm.isReadVar $k@628 $Perm.Write))
(assert (= $t@600 $t@626))
(push) ; 5
(assert (not (not (= (+ $k@599 $k@628) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $k@599 $k@628) $Perm.No)))
(assert (not (= $t@600 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@627 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@629 $Snap)
; [exec]
; __flatten_36 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@630 Int)
; [exec]
; currentCount := __flatten_36
; [eval] currentCount > 0
(push) ; 5
(assert (not (not (> sys__result@630 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (> sys__result@630 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 28] sys__result@630 > 0
(assert (> sys__result@630 0))
; [exec]
; inhale diz.BlockingQueue__head != null
; [eval] diz.BlockingQueue__head != null
; [exec]
; __flatten_37 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@631 $Perm)
(assert ($Perm.isValidVar $k@631))
(assert ($Perm.isReadVar $k@631 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@631 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@631 $k@593))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@632 $Perm)
(assert ($Perm.isValidVar $k@632))
(assert ($Perm.isReadVar $k@632 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@632 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@632 $k@595))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@633 $Perm)
(assert ($Perm.isValidVar $k@633))
(assert ($Perm.isReadVar $k@633 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@633 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@633 $k@597))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@634 $Perm)
(assert ($Perm.isValidVar $k@634))
(assert ($Perm.isReadVar $k@634 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@634 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@634 (+ $k@599 $k@628)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@635 $Perm)
(assert ($Perm.isValidVar $k@635))
(assert ($Perm.isReadVar $k@635 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@635 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@635 $k@601))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@636 $Perm)
(assert ($Perm.isValidVar $k@636))
(assert ($Perm.isReadVar $k@636 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@636 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@636 $k@603))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@637 Int)
(declare-const $t@638 $Snap)
(declare-const $t@639 $Snap)
(assert (= $t@638 ($Snap.combine $t@639 $Snap.unit)))
(declare-const $t@640 $Snap)
(declare-const $t@641 $Ref)
(assert (= $t@639 ($Snap.combine $t@640 ($SortWrappers.$RefTo$Snap $t@641))))
(declare-const $t@642 $Snap)
(assert (= $t@640 ($Snap.combine $t@642 $Snap.unit)))
(declare-const $t@643 $Snap)
(declare-const $t@644 $Ref)
(assert (= $t@642 ($Snap.combine $t@643 ($SortWrappers.$RefTo$Snap $t@644))))
(declare-const $t@645 $Snap)
(assert (= $t@643 ($Snap.combine $t@645 $Snap.unit)))
(declare-const $t@646 $Snap)
(declare-const $t@647 $Ref)
(assert (= $t@645 ($Snap.combine $t@646 ($SortWrappers.$RefTo$Snap $t@647))))
(declare-const $t@648 $Snap)
(assert (= $t@646 ($Snap.combine $t@648 $Snap.unit)))
(declare-const $t@649 $Snap)
(declare-const $t@650 $Ref)
(assert (= $t@648 ($Snap.combine $t@649 ($SortWrappers.$RefTo$Snap $t@650))))
(declare-const $t@651 $Snap)
(assert (= $t@649 ($Snap.combine $t@651 $Snap.unit)))
(declare-const $t@652 $Snap)
(declare-const $t@653 $Ref)
(assert (= $t@651 ($Snap.combine $t@652 ($SortWrappers.$RefTo$Snap $t@653))))
(declare-const $t@654 $Snap)
(assert (= $t@652 ($Snap.combine $t@654 $Snap.unit)))
(declare-const $t@655 Int)
(declare-const $t@656 $Ref)
(assert (=
  $t@654
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@655)
    ($SortWrappers.$RefTo$Snap $t@656))))
(declare-const $t@657 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@655)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@657) $Snap.unit)))
(declare-const $k@658 $Perm)
(assert ($Perm.isValidVar $k@658))
(assert ($Perm.isReadVar $k@658 $Perm.Write))
(assert (implies (< $Perm.No (- $k@593 $k@631)) (= $t@657 $t@594)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@593 $k@631) $k@658) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@593 $k@631) $k@658) $Perm.No)))
(assert (> $t@657 0))
(declare-const $k@659 $Perm)
(assert ($Perm.isValidVar $k@659))
(assert ($Perm.isReadVar $k@659 $Perm.Write))
(assert (implies (< $Perm.No (- $k@595 $k@632)) (= $t@656 $t@596)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@595 $k@632) $k@659) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@595 $k@632) $k@659) $Perm.No)))
(assert (not (= $t@656 $Ref.null)))
(declare-const $k@660 $Perm)
(assert ($Perm.isValidVar $k@660))
(assert ($Perm.isReadVar $k@660 $Perm.Write))
(assert (implies (< $Perm.No (- $k@597 $k@633)) (= $t@653 $t@598)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@597 $k@633) $k@660) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@597 $k@633) $k@660) $Perm.No)))
(assert (not (= $t@653 $Ref.null)))
(declare-const $k@661 $Perm)
(assert ($Perm.isValidVar $k@661))
(assert ($Perm.isReadVar $k@661 $Perm.Write))
(push) ; 6
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- (+ $k@599 $k@628) $k@634)) (= $t@650 $t@600)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 6
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- (+ $k@599 $k@628) $k@634) $k@661) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- (+ $k@599 $k@628) $k@634) $k@661) $Perm.No)))
(assert (= $t@650 diz@581))
(declare-const $k@662 $Perm)
(assert ($Perm.isValidVar $k@662))
(assert ($Perm.isReadVar $k@662 $Perm.Write))
(assert (implies (< $Perm.No (- $k@601 $k@635)) (= $t@647 $t@602)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@601 $k@635) $k@662) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@601 $k@635) $k@662) $Perm.No)))
(assert (not (= $t@647 $Ref.null)))
(declare-const $k@663 $Perm)
(assert ($Perm.isValidVar $k@663))
(assert ($Perm.isReadVar $k@663 $Perm.Write))
(push) ; 6
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- $k@603 $k@636)) (= $t@644 $t@604)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 6
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- $k@603 $k@636) $k@663) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@603 $k@636) $k@663) $Perm.No)))
(assert (= $t@644 diz@581))
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@641 $Ref.null)))
; [exec]
; __flatten_38 := Integer__Integer(__flatten_37)
(declare-const sys__result@664 $Ref)
(declare-const $t@665 $Snap)
(declare-const $t@666 Int)
(assert (= $t@665 ($Snap.combine ($SortWrappers.IntTo$Snap $t@666) $Snap.unit)))
(declare-const $t@667 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@666)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@667))))
; [eval] sys__result != null
(assert (not (= sys__result@664 $Ref.null)))
(declare-const $k@668 $Perm)
(assert ($Perm.isValidVar $k@668))
(assert ($Perm.isReadVar $k@668 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 6
(assert (not (not (= $k@668 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@668 $Perm.No)))
(assert (= $t@667 sys__result@637))
; [exec]
; x := __flatten_38
; [exec]
; __flatten_39 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@669 Int)
; [exec]
; c := __flatten_39
; [eval] c > 1
(push) ; 6
(assert (not (not (> sys__result@669 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (> sys__result@669 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 29] sys__result@669 > 1
(assert (> sys__result@669 1))
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@670 $Perm)
(assert ($Perm.isValidVar $k@670))
(assert ($Perm.isReadVar $k@670 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@670 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@670 (+ (- (+ $k@599 $k@628) $k@634) $k@661)))
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@650 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@581 $t@650)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@650 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@581 $t@650)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (not (= sys__result@669 $t@657))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@669 $t@657)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 30] sys__result@669 == $t@657
(assert (= sys__result@669 $t@657))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@671 $Snap)
(declare-const $t@672 $Snap)
(assert (= $t@671 ($Snap.combine $t@672 $Snap.unit)))
(declare-const $t@673 $Ref)
(declare-const $t@674 $Ref)
(assert (=
  $t@672
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@673)
    ($SortWrappers.$RefTo$Snap $t@674))))
(declare-const $k@675 $Perm)
(assert ($Perm.isValidVar $k@675))
(assert ($Perm.isReadVar $k@675 $Perm.Write))
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@603 $k@636) $k@663)) (= $t@673 $t@644)))
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@603 $k@636) $k@663) $k@675) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@603 $k@636) $k@663) $k@675) $Perm.No)))
(assert (not (= $t@673 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@674 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@676 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@677 $Perm)
(assert ($Perm.isValidVar $k@677))
(assert ($Perm.isReadVar $k@677 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@677 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@677 (+ (+ (- $k@603 $k@636) $k@663) $k@675)))
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_40 := x
; [exec]
; sys__result := __flatten_40
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@678 $Perm)
(assert ($Perm.isValidVar $k@678))
(assert ($Perm.isReadVar $k@678 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@678 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@678 (+ (- $k@593 $k@631) $k@658)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@679 $Perm)
(assert ($Perm.isValidVar $k@679))
(assert ($Perm.isReadVar $k@679 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@679 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@679 (+ (- $k@595 $k@632) $k@659)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@680 $Perm)
(assert ($Perm.isValidVar $k@680))
(assert ($Perm.isReadVar $k@680 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@680 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@680 (+ (- $k@597 $k@633) $k@660)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@681 $Perm)
(assert ($Perm.isValidVar $k@681))
(assert ($Perm.isReadVar $k@681 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@681 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@670) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@670) $Perm.No)))
(assert (< $k@681 (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@670)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@682 $Perm)
(assert ($Perm.isValidVar $k@682))
(assert ($Perm.isReadVar $k@682 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@682 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@682 (+ (- $k@601 $k@635) $k@662)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@683 $Perm)
(assert ($Perm.isValidVar $k@683))
(assert ($Perm.isReadVar $k@683 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@683 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@603 $k@636) $k@663) $k@675) $k@677) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@603 $k@636) $k@663) $k@675) $k@677) $Perm.No)))
(assert (< $k@683 (- (+ (+ (- $k@603 $k@636) $k@663) $k@675) $k@677)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@673 diz@581)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@673 diz@581))
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 30] sys__result@669 != $t@657
(assert (not (= sys__result@669 $t@657)))
(pop) ; 7
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (= sys__result@669 $t@657)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@669 $t@657))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 31] sys__result@669 != $t@657
(assert (not (= sys__result@669 $t@657)))
; [exec]
; __flatten_40 := x
; [exec]
; sys__result := __flatten_40
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@684 $Perm)
(assert ($Perm.isValidVar $k@684))
(assert ($Perm.isReadVar $k@684 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@684 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@684 (+ (- $k@593 $k@631) $k@658)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@685 $Perm)
(assert ($Perm.isValidVar $k@685))
(assert ($Perm.isReadVar $k@685 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@685 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@685 (+ (- $k@595 $k@632) $k@659)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@686 $Perm)
(assert ($Perm.isValidVar $k@686))
(assert ($Perm.isReadVar $k@686 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@686 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@686 (+ (- $k@597 $k@633) $k@660)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@687 $Perm)
(assert ($Perm.isValidVar $k@687))
(assert ($Perm.isReadVar $k@687 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@687 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@670) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@670) $Perm.No)))
(assert (< $k@687 (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@670)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@688 $Perm)
(assert ($Perm.isValidVar $k@688))
(assert ($Perm.isReadVar $k@688 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@688 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@688 (+ (- $k@601 $k@635) $k@662)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@689 $Perm)
(assert ($Perm.isValidVar $k@689))
(assert ($Perm.isReadVar $k@689 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@689 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@689 (+ (- $k@603 $k@636) $k@663)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 31] sys__result@669 == $t@657
(assert (= sys__result@669 $t@657))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 29] !sys__result@669 > 1
(assert (not (> sys__result@669 1)))
(pop) ; 6
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 6
(assert (not (> sys__result@669 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (> sys__result@669 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 32] !sys__result@669 > 1
(assert (not (> sys__result@669 1)))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@690 $Perm)
(assert ($Perm.isValidVar $k@690))
(assert ($Perm.isReadVar $k@690 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@690 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@690 (+ (- (+ $k@599 $k@628) $k@634) $k@661)))
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@650 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@581 $t@650)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@650 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@581 $t@650)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (not (= sys__result@669 $t@657))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@669 $t@657)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 33] sys__result@669 == $t@657
(assert (= sys__result@669 $t@657))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@691 $Snap)
(declare-const $t@692 $Snap)
(assert (= $t@691 ($Snap.combine $t@692 $Snap.unit)))
(declare-const $t@693 $Ref)
(declare-const $t@694 $Ref)
(assert (=
  $t@692
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@693)
    ($SortWrappers.$RefTo$Snap $t@694))))
(declare-const $k@695 $Perm)
(assert ($Perm.isValidVar $k@695))
(assert ($Perm.isReadVar $k@695 $Perm.Write))
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@603 $k@636) $k@663)) (= $t@693 $t@644)))
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@603 $k@636) $k@663) $k@695) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@603 $k@636) $k@663) $k@695) $Perm.No)))
(assert (not (= $t@693 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@694 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@696 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@697 $Perm)
(assert ($Perm.isValidVar $k@697))
(assert ($Perm.isReadVar $k@697 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@697 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@697 (+ (+ (- $k@603 $k@636) $k@663) $k@695)))
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_40 := x
; [exec]
; sys__result := __flatten_40
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@698 $Perm)
(assert ($Perm.isValidVar $k@698))
(assert ($Perm.isReadVar $k@698 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@698 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@698 (+ (- $k@593 $k@631) $k@658)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@699 $Perm)
(assert ($Perm.isValidVar $k@699))
(assert ($Perm.isReadVar $k@699 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@699 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@699 (+ (- $k@595 $k@632) $k@659)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@700 $Perm)
(assert ($Perm.isValidVar $k@700))
(assert ($Perm.isReadVar $k@700 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@700 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@700 (+ (- $k@597 $k@633) $k@660)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@701 $Perm)
(assert ($Perm.isValidVar $k@701))
(assert ($Perm.isReadVar $k@701 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@701 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@690) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@690) $Perm.No)))
(assert (< $k@701 (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@690)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@702 $Perm)
(assert ($Perm.isValidVar $k@702))
(assert ($Perm.isReadVar $k@702 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@702 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@702 (+ (- $k@601 $k@635) $k@662)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@703 $Perm)
(assert ($Perm.isValidVar $k@703))
(assert ($Perm.isReadVar $k@703 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@703 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@603 $k@636) $k@663) $k@695) $k@697) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@603 $k@636) $k@663) $k@695) $k@697) $Perm.No)))
(assert (< $k@703 (- (+ (+ (- $k@603 $k@636) $k@663) $k@695) $k@697)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@693 diz@581)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@693 diz@581))
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 33] sys__result@669 != $t@657
(assert (not (= sys__result@669 $t@657)))
(pop) ; 7
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (= sys__result@669 $t@657)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@669 $t@657))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 34] sys__result@669 != $t@657
(assert (not (= sys__result@669 $t@657)))
; [exec]
; __flatten_40 := x
; [exec]
; sys__result := __flatten_40
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@704 $Perm)
(assert ($Perm.isValidVar $k@704))
(assert ($Perm.isReadVar $k@704 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@704 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@704 (+ (- $k@593 $k@631) $k@658)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@705 $Perm)
(assert ($Perm.isValidVar $k@705))
(assert ($Perm.isReadVar $k@705 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@705 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@705 (+ (- $k@595 $k@632) $k@659)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@706 $Perm)
(assert ($Perm.isValidVar $k@706))
(assert ($Perm.isReadVar $k@706 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@706 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@706 (+ (- $k@597 $k@633) $k@660)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@707 $Perm)
(assert ($Perm.isValidVar $k@707))
(assert ($Perm.isReadVar $k@707 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@707 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@690) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@690) $Perm.No)))
(assert (< $k@707 (- (+ (- (+ $k@599 $k@628) $k@634) $k@661) $k@690)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@598 $t@653)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@708 $Perm)
(assert ($Perm.isValidVar $k@708))
(assert ($Perm.isReadVar $k@708 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@708 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@708 (+ (- $k@601 $k@635) $k@662)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@709 $Perm)
(assert ($Perm.isValidVar $k@709))
(assert ($Perm.isReadVar $k@709 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@709 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@709 (+ (- $k@603 $k@636) $k@663)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@602 $t@647)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 34] sys__result@669 == $t@657
(assert (= sys__result@669 $t@657))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 32] sys__result@669 > 1
(assert (> sys__result@669 1))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 28] !sys__result@630 > 0
(assert (not (> sys__result@630 0)))
(pop) ; 5
; [eval] !(currentCount > 0)
; [eval] currentCount > 0
(push) ; 5
(assert (not (> sys__result@630 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (> sys__result@630 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 35] !sys__result@630 > 0
(assert (not (> sys__result@630 0)))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@710 $Perm)
(assert ($Perm.isValidVar $k@710))
(assert ($Perm.isReadVar $k@710 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@710 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@710 (+ $k@599 $k@628)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= (- 0 1) $t@594))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= (- 0 1) $t@594)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 36] -1 == $t@594
(push) ; 6
; [else-branch 36] -1 != $t@594
(assert (not (= (- 0 1) $t@594)))
(pop) ; 6
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (= (- 0 1) $t@594)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (- 0 1) $t@594))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 37] -1 != $t@594
(assert (not (= (- 0 1) $t@594)))
; [exec]
; __flatten_40 := x
; [exec]
; sys__result := __flatten_40
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@711 $Perm)
(assert ($Perm.isValidVar $k@711))
(assert ($Perm.isReadVar $k@711 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@711 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@711 $k@593))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@712 $Perm)
(assert ($Perm.isValidVar $k@712))
(assert ($Perm.isReadVar $k@712 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@712 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@712 $k@595))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@713 $Perm)
(assert ($Perm.isValidVar $k@713))
(assert ($Perm.isReadVar $k@713 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@713 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@713 $k@597))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@714 $Perm)
(assert ($Perm.isValidVar $k@714))
(assert ($Perm.isReadVar $k@714 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@714 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ $k@599 $k@628) $k@710) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ $k@599 $k@628) $k@710) $Perm.No)))
(assert (< $k@714 (- (+ $k@599 $k@628) $k@710)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@715 $Perm)
(assert ($Perm.isValidVar $k@715))
(assert ($Perm.isReadVar $k@715 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@715 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@715 $k@601))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@716 $Perm)
(assert ($Perm.isValidVar $k@716))
(assert ($Perm.isReadVar $k@716 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@716 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@716 $k@603))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 37] -1 == $t@594
(pop) ; 5
(push) ; 5
; [else-branch 35] sys__result@630 > 0
(assert (> sys__result@630 0))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 27] sys__result@617 == 0
(assert (= sys__result@617 0))
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__peek ----------
(declare-const diz@717 $Ref)
(declare-const sys__result@718 $Ref)
(declare-const x@719 $Ref)
(declare-const currentCount@720 Int)
(declare-const __flatten_41@721 Int)
(declare-const __flatten_42@722 $Ref)
(declare-const __flatten_43@723 $Ref)
(declare-const __flatten_44@724 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@717 $Ref.null)))
(declare-const $k@725 $Perm)
(assert ($Perm.isValidVar $k@725))
(assert ($Perm.isReadVar $k@725 $Perm.Write))
(declare-const $t@726 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@725 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@725 $Perm.No)))
(assert (> $t@726 0))
(declare-const $k@727 $Perm)
(assert ($Perm.isValidVar $k@727))
(assert ($Perm.isReadVar $k@727 $Perm.Write))
(declare-const $t@728 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@727 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@727 $Perm.No)))
(assert (not (= $t@728 $Ref.null)))
(declare-const $k@729 $Perm)
(assert ($Perm.isValidVar $k@729))
(assert ($Perm.isReadVar $k@729 $Perm.Write))
(declare-const $t@730 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@729 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@729 $Perm.No)))
(assert (not (= $t@730 $Ref.null)))
(declare-const $k@731 $Perm)
(assert ($Perm.isValidVar $k@731))
(assert ($Perm.isReadVar $k@731 $Perm.Write))
(declare-const $t@732 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@731 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@731 $Perm.No)))
(assert (= $t@732 diz@717))
(declare-const $k@733 $Perm)
(assert ($Perm.isValidVar $k@733))
(assert ($Perm.isReadVar $k@733 $Perm.Write))
(declare-const $t@734 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@733 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@733 $Perm.No)))
(assert (not (= $t@734 $Ref.null)))
(declare-const $k@735 $Perm)
(assert ($Perm.isValidVar $k@735))
(assert ($Perm.isReadVar $k@735 $Perm.Write))
(declare-const $t@736 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@735 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@735 $Perm.No)))
(assert (= $t@736 diz@717))
(push) ; 3
(declare-const $k@737 $Perm)
(assert ($Perm.isValidVar $k@737))
(assert ($Perm.isReadVar $k@737 $Perm.Write))
(declare-const $t@738 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@737 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@737 $Perm.No)))
(assert (> $t@738 0))
(declare-const $k@739 $Perm)
(assert ($Perm.isValidVar $k@739))
(assert ($Perm.isReadVar $k@739 $Perm.Write))
(declare-const $t@740 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@739 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@739 $Perm.No)))
(assert (not (= $t@740 $Ref.null)))
(declare-const $k@741 $Perm)
(assert ($Perm.isValidVar $k@741))
(assert ($Perm.isReadVar $k@741 $Perm.Write))
(declare-const $t@742 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@741 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@741 $Perm.No)))
(assert (not (= $t@742 $Ref.null)))
(declare-const $k@743 $Perm)
(assert ($Perm.isValidVar $k@743))
(assert ($Perm.isReadVar $k@743 $Perm.Write))
(declare-const $t@744 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@743 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@743 $Perm.No)))
(assert (= $t@744 diz@717))
(declare-const $k@745 $Perm)
(assert ($Perm.isValidVar $k@745))
(assert ($Perm.isReadVar $k@745 $Perm.Write))
(declare-const $t@746 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@745 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@745 $Perm.No)))
(assert (not (= $t@746 $Ref.null)))
(declare-const $k@747 $Perm)
(assert ($Perm.isValidVar $k@747))
(assert ($Perm.isReadVar $k@747 $Perm.Write))
(declare-const $t@748 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@747 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@747 $Perm.No)))
(assert (= $t@748 diz@717))
(pop) ; 3
(push) ; 3
; [exec]
; x := null
; [exec]
; __flatten_41 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@749 Int)
; [exec]
; currentCount := __flatten_41
; [eval] currentCount == 0
(push) ; 4
(assert (not (not (= sys__result@749 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@749 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 38] sys__result@749 == 0
(assert (= sys__result@749 0))
; [exec]
; __flatten_42 := x
; [exec]
; sys__result := __flatten_42
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@750 $Perm)
(assert ($Perm.isValidVar $k@750))
(assert ($Perm.isReadVar $k@750 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@750 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@750 $k@725))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@751 $Perm)
(assert ($Perm.isValidVar $k@751))
(assert ($Perm.isReadVar $k@751 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@751 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@751 $k@727))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@752 $Perm)
(assert ($Perm.isValidVar $k@752))
(assert ($Perm.isReadVar $k@752 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@752 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@752 $k@729))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@753 $Perm)
(assert ($Perm.isValidVar $k@753))
(assert ($Perm.isReadVar $k@753 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@753 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@753 $k@731))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@754 $Perm)
(assert ($Perm.isValidVar $k@754))
(assert ($Perm.isReadVar $k@754 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@754 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@754 $k@733))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@755 $Perm)
(assert ($Perm.isValidVar $k@755))
(assert ($Perm.isReadVar $k@755 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@755 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@755 $k@735))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 4
(push) ; 4
; [else-branch 38] sys__result@749 != 0
(assert (not (= sys__result@749 0)))
(pop) ; 4
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 4
(assert (not (= sys__result@749 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= sys__result@749 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 39] sys__result@749 != 0
(assert (not (= sys__result@749 0)))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@756 $Snap)
(declare-const $t@757 $Snap)
(assert (= $t@756 ($Snap.combine $t@757 $Snap.unit)))
(declare-const $t@758 $Ref)
(declare-const $t@759 $Ref)
(assert (=
  $t@757
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@758)
    ($SortWrappers.$RefTo$Snap $t@759))))
(declare-const $k@760 $Perm)
(assert ($Perm.isValidVar $k@760))
(assert ($Perm.isReadVar $k@760 $Perm.Write))
(assert (= $t@732 $t@758))
(push) ; 5
(assert (not (not (= (+ $k@731 $k@760) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $k@731 $k@760) $Perm.No)))
(assert (not (= $t@732 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@759 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@761 $Snap)
; [eval] diz.BlockingQueue__head != null
(push) ; 5
(assert (not (= $t@759 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 40] $t@759 != Null
; [exec]
; inhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
(declare-const $t@762 $Snap)
(declare-const $t@763 $Snap)
(declare-const $t@764 $Ref)
(assert (= $t@762 ($Snap.combine $t@763 ($SortWrappers.$RefTo$Snap $t@764))))
(declare-const $t@765 $Ref)
(declare-const $t@766 Int)
(assert (=
  $t@763
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@765)
    ($SortWrappers.IntTo$Snap $t@766))))
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 6
(assert (not (= $t@765 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@765 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 41] $t@765 != Null
(assert (not (= $t@765 $Ref.null)))
(declare-const $k@767 $Perm)
(assert ($Perm.isValidVar $k@767))
(assert ($Perm.isReadVar $k@767 $Perm.Write))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@768 $Snap)
; [exec]
; __flatten_43 := diz.BlockingQueue__head
; [exec]
; x := __flatten_43.Node__val
; [exec]
; exhale acc(Node__lock_held(diz.BlockingQueue__head), write)
; [exec]
; exhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 7
(assert (not (= $t@765 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 42] $t@765 != Null
(declare-const $k@769 $Perm)
(assert ($Perm.isValidVar $k@769))
(assert ($Perm.isReadVar $k@769 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@769 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@767 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@767 $Perm.No)))
(assert (< $k@769 $k@767))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@770 $Perm)
(assert ($Perm.isValidVar $k@770))
(assert ($Perm.isReadVar $k@770 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@770 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@770 (+ $k@731 $k@760)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [exec]
; __flatten_44 := x
; [exec]
; sys__result := __flatten_44
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@771 $Perm)
(assert ($Perm.isValidVar $k@771))
(assert ($Perm.isReadVar $k@771 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@771 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@771 $k@725))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@772 $Perm)
(assert ($Perm.isValidVar $k@772))
(assert ($Perm.isReadVar $k@772 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@772 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@772 $k@727))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@773 $Perm)
(assert ($Perm.isValidVar $k@773))
(assert ($Perm.isReadVar $k@773 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@773 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@773 $k@729))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@774 $Perm)
(assert ($Perm.isValidVar $k@774))
(assert ($Perm.isReadVar $k@774 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@774 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ $k@731 $k@760) $k@770) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ $k@731 $k@760) $k@770) $Perm.No)))
(assert (< $k@774 (- (+ $k@731 $k@760) $k@770)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@775 $Perm)
(assert ($Perm.isValidVar $k@775))
(assert ($Perm.isReadVar $k@775 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@775 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@775 $k@733))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@776 $Perm)
(assert ($Perm.isValidVar $k@776))
(assert ($Perm.isReadVar $k@776 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@776 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@776 $k@735))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 7
; [dead else-branch 42] $t@765 == Null
(pop) ; 6
(push) ; 6
; [else-branch 41] $t@765 == Null
(assert (= $t@765 $Ref.null))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@777 $Snap)
; [exec]
; __flatten_43 := diz.BlockingQueue__head
; [exec]
; x := __flatten_43.Node__val
; [exec]
; exhale acc(Node__lock_held(diz.BlockingQueue__head), write)
; [exec]
; exhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 7
(assert (not (not (= $t@765 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 43] $t@765 != Null
(push) ; 7
; [else-branch 43] $t@765 == Null
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@778 $Perm)
(assert ($Perm.isValidVar $k@778))
(assert ($Perm.isReadVar $k@778 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@778 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@778 (+ $k@731 $k@760)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [exec]
; __flatten_44 := x
; [exec]
; sys__result := __flatten_44
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@779 $Perm)
(assert ($Perm.isValidVar $k@779))
(assert ($Perm.isReadVar $k@779 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@779 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@779 $k@725))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@780 $Perm)
(assert ($Perm.isValidVar $k@780))
(assert ($Perm.isReadVar $k@780 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@780 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@780 $k@727))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@781 $Perm)
(assert ($Perm.isValidVar $k@781))
(assert ($Perm.isReadVar $k@781 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@781 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@781 $k@729))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@782 $Perm)
(assert ($Perm.isValidVar $k@782))
(assert ($Perm.isReadVar $k@782 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@782 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ $k@731 $k@760) $k@778) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ $k@731 $k@760) $k@778) $Perm.No)))
(assert (< $k@782 (- (+ $k@731 $k@760) $k@778)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@783 $Perm)
(assert ($Perm.isValidVar $k@783))
(assert ($Perm.isReadVar $k@783 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@783 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@783 $k@733))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@784 $Perm)
(assert ($Perm.isValidVar $k@784))
(assert ($Perm.isReadVar $k@784 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@784 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@784 $k@735))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 40] $t@759 == Null
; [eval] !(diz.BlockingQueue__head != null)
; [eval] diz.BlockingQueue__head != null
(push) ; 5
(assert (not (= $t@759 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 44] $t@759 == Null
(push) ; 5
; [else-branch 44] $t@759 != Null
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 39] sys__result@749 == 0
(assert (= sys__result@749 0))
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__linkLast ----------
(declare-const diz@785 $Ref)
(declare-const val@786 Int)
(declare-const oldLast@787 $Ref)
(declare-const __flatten_45@788 $Ref)
(declare-const __flatten_46@789 $Ref)
(declare-const __flatten_47@790 $Ref)
(declare-const __flatten_48@791 $Ref)
(declare-const __flatten_49@792 $Ref)
(declare-const __flatten_50@793 $Ref)
(declare-const __flatten_102@794 $Ref)
(declare-const __flatten_103@795 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@785 $Ref.null)))
(declare-const $k@796 $Perm)
(assert ($Perm.isValidVar $k@796))
(assert ($Perm.isReadVar $k@796 $Perm.Write))
(declare-const $t@797 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@796 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@796 $Perm.No)))
(assert (> $t@797 0))
(declare-const $k@798 $Perm)
(assert ($Perm.isValidVar $k@798))
(assert ($Perm.isReadVar $k@798 $Perm.Write))
(declare-const $t@799 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@798 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@798 $Perm.No)))
(assert (not (= $t@799 $Ref.null)))
(declare-const $k@800 $Perm)
(assert ($Perm.isValidVar $k@800))
(assert ($Perm.isReadVar $k@800 $Perm.Write))
(declare-const $t@801 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@800 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@800 $Perm.No)))
(assert (not (= $t@801 $Ref.null)))
(declare-const $k@802 $Perm)
(assert ($Perm.isValidVar $k@802))
(assert ($Perm.isReadVar $k@802 $Perm.Write))
(declare-const $t@803 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@802 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@802 $Perm.No)))
(assert (= $t@803 diz@785))
(declare-const $k@804 $Perm)
(assert ($Perm.isValidVar $k@804))
(assert ($Perm.isReadVar $k@804 $Perm.Write))
(declare-const $t@805 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@804 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@804 $Perm.No)))
(assert (not (= $t@805 $Ref.null)))
(declare-const $k@806 $Perm)
(assert ($Perm.isValidVar $k@806))
(assert ($Perm.isReadVar $k@806 $Perm.Write))
(declare-const $t@807 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@806 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@806 $Perm.No)))
(assert (= $t@807 diz@785))
(declare-const $t@808 $Ref)
(push) ; 3
(declare-const $k@809 $Perm)
(assert ($Perm.isValidVar $k@809))
(assert ($Perm.isReadVar $k@809 $Perm.Write))
(declare-const $t@810 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@809 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@809 $Perm.No)))
(assert (> $t@810 0))
(declare-const $k@811 $Perm)
(assert ($Perm.isValidVar $k@811))
(assert ($Perm.isReadVar $k@811 $Perm.Write))
(declare-const $t@812 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@811 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@811 $Perm.No)))
(assert (not (= $t@812 $Ref.null)))
(declare-const $k@813 $Perm)
(assert ($Perm.isValidVar $k@813))
(assert ($Perm.isReadVar $k@813 $Perm.Write))
(declare-const $t@814 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@813 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@813 $Perm.No)))
(assert (not (= $t@814 $Ref.null)))
(declare-const $k@815 $Perm)
(assert ($Perm.isValidVar $k@815))
(assert ($Perm.isReadVar $k@815 $Perm.Write))
(declare-const $t@816 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@815 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@815 $Perm.No)))
(assert (= $t@816 diz@785))
(declare-const $k@817 $Perm)
(assert ($Perm.isValidVar $k@817))
(assert ($Perm.isReadVar $k@817 $Perm.Write))
(declare-const $t@818 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@817 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@817 $Perm.No)))
(assert (not (= $t@818 $Ref.null)))
(declare-const $k@819 $Perm)
(assert ($Perm.isValidVar $k@819))
(assert ($Perm.isReadVar $k@819 $Perm.Write))
(declare-const $t@820 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@819 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@819 $Perm.No)))
(assert (= $t@820 diz@785))
(declare-const $t@821 $Ref)
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@821 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__last.Node__val, write) && ((diz.BlockingQueue__last.Node__val != null) ==> acc(diz.BlockingQueue__last.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__last.Node__next, write)
(declare-const $t@822 $Snap)
(declare-const $t@823 $Snap)
(declare-const $t@824 $Ref)
(assert (= $t@822 ($Snap.combine $t@823 ($SortWrappers.$RefTo$Snap $t@824))))
(declare-const $t@825 $Ref)
(declare-const $t@826 Int)
(assert (=
  $t@823
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@825)
    ($SortWrappers.IntTo$Snap $t@826))))
(assert (not (= $t@808 $Ref.null)))
; [eval] diz.BlockingQueue__last.Node__val != null
(push) ; 4
(assert (not (= $t@825 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@825 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 45] $t@825 != Null
(assert (not (= $t@825 $Ref.null)))
(declare-const $k@827 $Perm)
(assert ($Perm.isValidVar $k@827))
(assert ($Perm.isReadVar $k@827 $Perm.Write))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__last), write)
(declare-const $t@828 $Snap)
; [exec]
; oldLast := diz.BlockingQueue__last
; [exec]
; __flatten_45 := diz.BlockingQueue__last
; [exec]
; __flatten_47 := Integer__Integer(val)
(declare-const sys__result@829 $Ref)
(declare-const $t@830 $Snap)
(declare-const $t@831 Int)
(assert (= $t@830 ($Snap.combine ($SortWrappers.IntTo$Snap $t@831) $Snap.unit)))
(declare-const $t@832 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@831)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@832))))
; [eval] sys__result != null
(assert (not (= sys__result@829 $Ref.null)))
(declare-const $k@833 $Perm)
(assert ($Perm.isValidVar $k@833))
(assert ($Perm.isReadVar $k@833 $Perm.Write))
(push) ; 5
(assert (not (= $t@825 sys__result@829)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] sys__result.Integer__val == val
(push) ; 5
(assert (not (not (= $k@833 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@833 $Perm.No)))
(assert (= $t@832 val@786))
; [exec]
; __flatten_48 := Node__Node(__flatten_47)
; [eval] val != null
(push) ; 5
(assert (not (= sys__result@829 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 46] sys__result@829 != Null
(declare-const $k@834 $Perm)
(assert ($Perm.isValidVar $k@834))
(assert ($Perm.isReadVar $k@834 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@834 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@834 $k@833))
(declare-const sys__result@835 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@835 $Ref.null)))
; [exec]
; __flatten_46 := __flatten_48
; [exec]
; __flatten_102 := __flatten_46
; [exec]
; __flatten_45.Node__next := __flatten_102
; [exec]
; __flatten_50 := diz.BlockingQueue__last
; [exec]
; __flatten_49 := __flatten_50.Node__next
; [exec]
; __flatten_103 := __flatten_49
; [exec]
; diz.BlockingQueue__last := __flatten_103
; [exec]
; exhale acc(Node__lock_held(oldLast), write)
; [exec]
; exhale acc(oldLast.Node__val, write) && ((oldLast.Node__val != null) ==> acc(oldLast.Node__val.Integer__val, wildcard)) && acc(oldLast.Node__next, write)
; [eval] oldLast.Node__val != null
(push) ; 6
(assert (not (= $t@825 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 47] $t@825 != Null
(declare-const $k@836 $Perm)
(assert ($Perm.isValidVar $k@836))
(assert ($Perm.isReadVar $k@836 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@836 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@827 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@827 $Perm.No)))
(assert (< $k@836 $k@827))
(declare-const $k@837 $Perm)
(assert ($Perm.isValidVar $k@837))
(assert ($Perm.isReadVar $k@837 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@837 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@837 $k@796))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@838 $Perm)
(assert ($Perm.isValidVar $k@838))
(assert ($Perm.isReadVar $k@838 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@838 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@838 $k@798))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@839 $Perm)
(assert ($Perm.isValidVar $k@839))
(assert ($Perm.isReadVar $k@839 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@839 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@839 $k@800))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@840 $Perm)
(assert ($Perm.isValidVar $k@840))
(assert ($Perm.isReadVar $k@840 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@840 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@840 $k@802))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@841 $Perm)
(assert ($Perm.isValidVar $k@841))
(assert ($Perm.isReadVar $k@841 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@841 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@841 $k@804))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@842 $Perm)
(assert ($Perm.isValidVar $k@842))
(assert ($Perm.isReadVar $k@842 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@842 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@842 $k@806))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__last != null
(pop) ; 6
; [dead else-branch 47] $t@825 == Null
(pop) ; 5
; [dead else-branch 46] sys__result@829 == Null
(pop) ; 4
(push) ; 4
; [else-branch 45] $t@825 == Null
(assert (= $t@825 $Ref.null))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__last), write)
(declare-const $t@843 $Snap)
; [exec]
; oldLast := diz.BlockingQueue__last
; [exec]
; __flatten_45 := diz.BlockingQueue__last
; [exec]
; __flatten_47 := Integer__Integer(val)
(declare-const sys__result@844 $Ref)
(declare-const $t@845 $Snap)
(declare-const $t@846 Int)
(assert (= $t@845 ($Snap.combine ($SortWrappers.IntTo$Snap $t@846) $Snap.unit)))
(declare-const $t@847 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@846)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@847))))
; [eval] sys__result != null
(assert (not (= sys__result@844 $Ref.null)))
(declare-const $k@848 $Perm)
(assert ($Perm.isValidVar $k@848))
(assert ($Perm.isReadVar $k@848 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 5
(assert (not (not (= $k@848 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@848 $Perm.No)))
(assert (= $t@847 val@786))
; [exec]
; __flatten_48 := Node__Node(__flatten_47)
; [eval] val != null
(push) ; 5
(assert (not (= sys__result@844 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 48] sys__result@844 != Null
(declare-const $k@849 $Perm)
(assert ($Perm.isValidVar $k@849))
(assert ($Perm.isReadVar $k@849 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@849 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@849 $k@848))
(declare-const sys__result@850 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@850 $Ref.null)))
; [exec]
; __flatten_46 := __flatten_48
; [exec]
; __flatten_102 := __flatten_46
; [exec]
; __flatten_45.Node__next := __flatten_102
; [exec]
; __flatten_50 := diz.BlockingQueue__last
; [exec]
; __flatten_49 := __flatten_50.Node__next
; [exec]
; __flatten_103 := __flatten_49
; [exec]
; diz.BlockingQueue__last := __flatten_103
; [exec]
; exhale acc(Node__lock_held(oldLast), write)
; [exec]
; exhale acc(oldLast.Node__val, write) && ((oldLast.Node__val != null) ==> acc(oldLast.Node__val.Integer__val, wildcard)) && acc(oldLast.Node__next, write)
; [eval] oldLast.Node__val != null
(push) ; 6
(assert (not (not (= $t@825 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 49] $t@825 != Null
(push) ; 6
; [else-branch 49] $t@825 == Null
(declare-const $k@851 $Perm)
(assert ($Perm.isValidVar $k@851))
(assert ($Perm.isReadVar $k@851 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@851 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@851 $k@796))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@852 $Perm)
(assert ($Perm.isValidVar $k@852))
(assert ($Perm.isReadVar $k@852 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@852 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@852 $k@798))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@853 $Perm)
(assert ($Perm.isValidVar $k@853))
(assert ($Perm.isReadVar $k@853 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@853 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@853 $k@800))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@854 $Perm)
(assert ($Perm.isValidVar $k@854))
(assert ($Perm.isReadVar $k@854 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@854 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@854 $k@802))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@855 $Perm)
(assert ($Perm.isValidVar $k@855))
(assert ($Perm.isReadVar $k@855 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@855 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@855 $k@804))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@856 $Perm)
(assert ($Perm.isValidVar $k@856))
(assert ($Perm.isReadVar $k@856 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@856 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@856 $k@806))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__last != null
(pop) ; 6
(pop) ; 5
; [dead else-branch 48] sys__result@844 == Null
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__unlinkFirst ----------
(declare-const diz@857 $Ref)
(declare-const sys__result@858 Int)
(declare-const oldHead@859 $Ref)
(declare-const first@860 $Ref)
(declare-const __flatten_51@861 $Ref)
(declare-const __flatten_52@862 $Ref)
(declare-const value@863 $Ref)
(declare-const __flatten_53@864 Int)
(declare-const __flatten_104@865 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@857 $Ref.null)))
(declare-const $k@866 $Perm)
(assert ($Perm.isValidVar $k@866))
(assert ($Perm.isReadVar $k@866 $Perm.Write))
(declare-const $t@867 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@866 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@866 $Perm.No)))
(assert (> $t@867 0))
(declare-const $k@868 $Perm)
(assert ($Perm.isValidVar $k@868))
(assert ($Perm.isReadVar $k@868 $Perm.Write))
(declare-const $t@869 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@868 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@868 $Perm.No)))
(assert (not (= $t@869 $Ref.null)))
(declare-const $k@870 $Perm)
(assert ($Perm.isValidVar $k@870))
(assert ($Perm.isReadVar $k@870 $Perm.Write))
(declare-const $t@871 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@870 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@870 $Perm.No)))
(assert (not (= $t@871 $Ref.null)))
(declare-const $k@872 $Perm)
(assert ($Perm.isValidVar $k@872))
(assert ($Perm.isReadVar $k@872 $Perm.Write))
(declare-const $t@873 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@872 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@872 $Perm.No)))
(assert (= $t@873 diz@857))
(declare-const $k@874 $Perm)
(assert ($Perm.isValidVar $k@874))
(assert ($Perm.isReadVar $k@874 $Perm.Write))
(declare-const $t@875 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@874 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@874 $Perm.No)))
(assert (not (= $t@875 $Ref.null)))
(declare-const $k@876 $Perm)
(assert ($Perm.isValidVar $k@876))
(assert ($Perm.isReadVar $k@876 $Perm.Write))
(declare-const $t@877 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@876 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@876 $Perm.No)))
(assert (= $t@877 diz@857))
(declare-const $t@878 $Ref)
(push) ; 3
(declare-const $k@879 $Perm)
(assert ($Perm.isValidVar $k@879))
(assert ($Perm.isReadVar $k@879 $Perm.Write))
(declare-const $t@880 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@879 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@879 $Perm.No)))
(assert (> $t@880 0))
(declare-const $k@881 $Perm)
(assert ($Perm.isValidVar $k@881))
(assert ($Perm.isReadVar $k@881 $Perm.Write))
(declare-const $t@882 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@881 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@881 $Perm.No)))
(assert (not (= $t@882 $Ref.null)))
(declare-const $k@883 $Perm)
(assert ($Perm.isValidVar $k@883))
(assert ($Perm.isReadVar $k@883 $Perm.Write))
(declare-const $t@884 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@883 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@883 $Perm.No)))
(assert (not (= $t@884 $Ref.null)))
(declare-const $k@885 $Perm)
(assert ($Perm.isValidVar $k@885))
(assert ($Perm.isReadVar $k@885 $Perm.Write))
(declare-const $t@886 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@885 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@885 $Perm.No)))
(assert (= $t@886 diz@857))
(declare-const $k@887 $Perm)
(assert ($Perm.isValidVar $k@887))
(assert ($Perm.isReadVar $k@887 $Perm.Write))
(declare-const $t@888 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@887 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@887 $Perm.No)))
(assert (not (= $t@888 $Ref.null)))
(declare-const $k@889 $Perm)
(assert ($Perm.isValidVar $k@889))
(assert ($Perm.isReadVar $k@889 $Perm.Write))
(declare-const $t@890 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@889 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@889 $Perm.No)))
(assert (= $t@890 diz@857))
(declare-const $t@891 $Ref)
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@891 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
(declare-const $t@892 $Snap)
(declare-const $t@893 $Snap)
(declare-const $t@894 $Ref)
(assert (= $t@892 ($Snap.combine $t@893 ($SortWrappers.$RefTo$Snap $t@894))))
(declare-const $t@895 $Ref)
(declare-const $t@896 Int)
(assert (=
  $t@893
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@895)
    ($SortWrappers.IntTo$Snap $t@896))))
(assert (not (= $t@878 $Ref.null)))
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 4
(assert (not (= $t@895 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@895 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 50] $t@895 != Null
(assert (not (= $t@895 $Ref.null)))
(declare-const $k@897 $Perm)
(assert ($Perm.isValidVar $k@897))
(assert ($Perm.isReadVar $k@897 $Perm.Write))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@898 $Snap)
; [exec]
; oldHead := diz.BlockingQueue__head
; [exec]
; __flatten_51 := diz.BlockingQueue__head
; [exec]
; first := __flatten_51.Node__next
; [exec]
; inhale first != null
; [eval] first != null
(assert (not (= $t@894 $Ref.null)))
; [exec]
; __flatten_52 := first
; [exec]
; __flatten_104 := __flatten_52
; [exec]
; diz.BlockingQueue__head := __flatten_104
; [exec]
; inhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
(declare-const $t@899 $Snap)
(declare-const $t@900 $Snap)
(declare-const $t@901 $Ref)
(assert (= $t@899 ($Snap.combine $t@900 ($SortWrappers.$RefTo$Snap $t@901))))
(declare-const $t@902 $Ref)
(declare-const $t@903 Int)
(assert (=
  $t@900
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@902)
    ($SortWrappers.IntTo$Snap $t@903))))
(push) ; 5
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] first.Node__val != null
(push) ; 5
(assert (not (= $t@902 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@902 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 51] $t@902 != Null
(assert (not (= $t@902 $Ref.null)))
(declare-const $k@904 $Perm)
(assert ($Perm.isValidVar $k@904))
(assert ($Perm.isReadVar $k@904 $Perm.Write))
(push) ; 6
(assert (not (= $t@895 $t@902)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@905 $Snap)
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; value := first.Node__val
; [exec]
; inhale value != null
; [eval] value != null
; [exec]
; first.Node__val := null
; [exec]
; exhale acc(Node__lock_held(first), write)
; [exec]
; exhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
; [eval] first.Node__val != null
(push) ; 6
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 52] False
(push) ; 6
; [else-branch 52] True
; [exec]
; exhale acc(Node__lock_held(oldHead), write)
; [exec]
; exhale acc(oldHead.Node__val, write) && ((oldHead.Node__val != null) ==> acc(oldHead.Node__val.Integer__val, wildcard)) && acc(oldHead.Node__next, write)
; [eval] oldHead.Node__val != null
(push) ; 7
(assert (not (= $t@895 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 53] $t@895 != Null
(declare-const $k@906 $Perm)
(assert ($Perm.isValidVar $k@906))
(assert ($Perm.isReadVar $k@906 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@906 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@897 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@897 $Perm.No)))
(assert (< $k@906 $k@897))
; [exec]
; __flatten_53 := value.Integer__val
(push) ; 8
(assert (not (not (= $k@904 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@904 $Perm.No)))
; [exec]
; sys__result := __flatten_53
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz) && acc(diz.BlockingQueue__head, write) && (diz.BlockingQueue__head != null)
(declare-const $k@907 $Perm)
(assert ($Perm.isValidVar $k@907))
(assert ($Perm.isReadVar $k@907 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@907 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@907 $k@866))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@908 $Perm)
(assert ($Perm.isValidVar $k@908))
(assert ($Perm.isReadVar $k@908 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@908 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@908 $k@868))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@909 $Perm)
(assert ($Perm.isValidVar $k@909))
(assert ($Perm.isReadVar $k@909 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@909 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@909 $k@870))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@910 $Perm)
(assert ($Perm.isValidVar $k@910))
(assert ($Perm.isReadVar $k@910 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@910 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@910 $k@872))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@911 $Perm)
(assert ($Perm.isValidVar $k@911))
(assert ($Perm.isReadVar $k@911 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@911 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@911 $k@874))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@912 $Perm)
(assert ($Perm.isValidVar $k@912))
(assert ($Perm.isReadVar $k@912 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@912 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@912 $k@876))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__head != null
; [exec]
; inhale false
(pop) ; 7
; [dead else-branch 53] $t@895 == Null
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 51] $t@902 == Null
(assert (= $t@902 $Ref.null))
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@913 $Snap)
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; value := first.Node__val
; [exec]
; inhale value != null
; [eval] value != null
(assert (not (= $t@902 $Ref.null)))
; [exec]
; first.Node__val := null
; [exec]
; exhale acc(Node__lock_held(first), write)
; [exec]
; exhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
; [eval] first.Node__val != null
(push) ; 6
(assert (not false))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [dead then-branch 54] False
; [dead else-branch 54] True
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 50] $t@895 == Null
(assert (= $t@895 $Ref.null))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@914 $Snap)
; [exec]
; oldHead := diz.BlockingQueue__head
; [exec]
; __flatten_51 := diz.BlockingQueue__head
; [exec]
; first := __flatten_51.Node__next
; [exec]
; inhale first != null
; [eval] first != null
(assert (not (= $t@894 $Ref.null)))
; [exec]
; __flatten_52 := first
; [exec]
; __flatten_104 := __flatten_52
; [exec]
; diz.BlockingQueue__head := __flatten_104
; [exec]
; inhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
(declare-const $t@915 $Snap)
(declare-const $t@916 $Snap)
(declare-const $t@917 $Ref)
(assert (= $t@915 ($Snap.combine $t@916 ($SortWrappers.$RefTo$Snap $t@917))))
(declare-const $t@918 $Ref)
(declare-const $t@919 Int)
(assert (=
  $t@916
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@918)
    ($SortWrappers.IntTo$Snap $t@919))))
(push) ; 5
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] first.Node__val != null
(push) ; 5
(assert (not (= $t@918 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@918 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 55] $t@918 != Null
(assert (not (= $t@918 $Ref.null)))
(declare-const $k@920 $Perm)
(assert ($Perm.isValidVar $k@920))
(assert ($Perm.isReadVar $k@920 $Perm.Write))
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@921 $Snap)
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; value := first.Node__val
; [exec]
; inhale value != null
; [eval] value != null
; [exec]
; first.Node__val := null
; [exec]
; exhale acc(Node__lock_held(first), write)
; [exec]
; exhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
; [eval] first.Node__val != null
(push) ; 6
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 56] False
(push) ; 6
; [else-branch 56] True
; [exec]
; exhale acc(Node__lock_held(oldHead), write)
; [exec]
; exhale acc(oldHead.Node__val, write) && ((oldHead.Node__val != null) ==> acc(oldHead.Node__val.Integer__val, wildcard)) && acc(oldHead.Node__next, write)
; [eval] oldHead.Node__val != null
(push) ; 7
(assert (not (not (= $t@895 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 57] $t@895 != Null
(push) ; 7
; [else-branch 57] $t@895 == Null
; [exec]
; __flatten_53 := value.Integer__val
(push) ; 8
(assert (not (not (= $k@920 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@920 $Perm.No)))
; [exec]
; sys__result := __flatten_53
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz) && acc(diz.BlockingQueue__head, write) && (diz.BlockingQueue__head != null)
(declare-const $k@922 $Perm)
(assert ($Perm.isValidVar $k@922))
(assert ($Perm.isReadVar $k@922 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@922 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@922 $k@866))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@923 $Perm)
(assert ($Perm.isValidVar $k@923))
(assert ($Perm.isReadVar $k@923 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@923 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@923 $k@868))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@924 $Perm)
(assert ($Perm.isValidVar $k@924))
(assert ($Perm.isReadVar $k@924 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@924 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@924 $k@870))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@925 $Perm)
(assert ($Perm.isValidVar $k@925))
(assert ($Perm.isReadVar $k@925 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@925 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@925 $k@872))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@926 $Perm)
(assert ($Perm.isValidVar $k@926))
(assert ($Perm.isReadVar $k@926 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@926 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@926 $k@874))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@927 $Perm)
(assert ($Perm.isValidVar $k@927))
(assert ($Perm.isReadVar $k@927 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@927 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@927 $k@876))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__head != null
; [exec]
; inhale false
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 55] $t@918 == Null
(assert (= $t@918 $Ref.null))
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@928 $Snap)
(push) ; 6
(assert (not (= $t@878 $t@894)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; value := first.Node__val
; [exec]
; inhale value != null
; [eval] value != null
(assert (not (= $t@918 $Ref.null)))
; [exec]
; first.Node__val := null
; [exec]
; exhale acc(Node__lock_held(first), write)
; [exec]
; exhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
; [eval] first.Node__val != null
(push) ; 6
(assert (not false))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [dead then-branch 58] False
; [dead else-branch 58] True
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Integer__Integer ----------
(declare-const val@929 Int)
(declare-const sys__result@930 $Ref)
(declare-const diz@931 $Ref)
(declare-const __flatten_54@932 Int)
(declare-const __flatten_105@933 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@930 $Ref.null)))
(declare-const $k@934 $Perm)
(assert ($Perm.isValidVar $k@934))
(assert ($Perm.isReadVar $k@934 $Perm.Write))
(declare-const $t@935 Int)
; [eval] sys__result.Integer__val == val
(push) ; 4
(assert (not (not (= $k@934 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@934 $Perm.No)))
(assert (= $t@935 val@929))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(Integer__val)
(declare-const diz@936 $Ref)
(assert (not (= diz@936 $Ref.null)))
(declare-const Integer__val@937 Int)
(assert (not (= sys__result@930 diz@936)))
; [exec]
; __flatten_54 := val
; [exec]
; __flatten_105 := __flatten_54
; [exec]
; diz.Integer__val := __flatten_105
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.Integer__val, wildcard) && (sys__result.Integer__val == val)
; [eval] sys__result != null
(declare-const $k@938 $Perm)
(assert ($Perm.isValidVar $k@938))
(assert ($Perm.isReadVar $k@938 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@938 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@938 $Perm.Write))
; [eval] sys__result.Integer__val == val
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- Node__Node ----------
(declare-const val@939 $Ref)
(declare-const sys__result@940 $Ref)
(declare-const diz@941 $Ref)
(declare-const __flatten_55@942 $Ref)
(declare-const __flatten_106@943 $Ref)
(push) ; 2
; [eval] val != null
(push) ; 3
(assert (not (= val@939 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= val@939 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 59] val@939 != Null
(assert (not (= val@939 $Ref.null)))
(declare-const $k@944 $Perm)
(assert ($Perm.isValidVar $k@944))
(assert ($Perm.isReadVar $k@944 $Perm.Write))
(declare-const $t@945 Int)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@940 $Ref.null)))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@946 $Ref)
(assert (not (= diz@946 $Ref.null)))
(declare-const Node__next@947 $Ref)
(declare-const Node__val@948 $Ref)
(assert (and
  (not (= val@939 diz@946))
  (not (= sys__result@940 diz@946))
  (not (= __flatten_55@942 diz@946))
  (not (= __flatten_106@943 diz@946))
  (not (= Node__next@947 diz@946))
  (not (= Node__val@948 diz@946))))
; [exec]
; __flatten_55 := val
; [exec]
; __flatten_106 := __flatten_55
; [exec]
; diz.Node__val := __flatten_106
; [exec]
; diz.Node__next := null
; [exec]
; exhale acc(diz.Node__val, write) && ((diz.Node__val != null) ==> acc(diz.Node__val.Integer__val, wildcard)) && acc(diz.Node__next, write)
; [eval] diz.Node__val != null
(push) ; 5
(assert (not (= val@939 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 60] val@939 != Null
(declare-const $k@949 $Perm)
(assert ($Perm.isValidVar $k@949))
(assert ($Perm.isReadVar $k@949 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@949 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@944 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@944 $Perm.No)))
(assert (< $k@949 $k@944))
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 60] val@939 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 59] val@939 == Null
(assert (= val@939 $Ref.null))
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@940 $Ref.null)))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@950 $Ref)
(assert (not (= diz@950 $Ref.null)))
(declare-const Node__next@951 $Ref)
(declare-const Node__val@952 $Ref)
(assert (and
  (not (= val@939 diz@950))
  (not (= sys__result@940 diz@950))
  (not (= __flatten_55@942 diz@950))
  (not (= __flatten_106@943 diz@950))
  (not (= Node__next@951 diz@950))
  (not (= Node__val@952 diz@950))))
; [exec]
; __flatten_55 := val
; [exec]
; __flatten_106 := __flatten_55
; [exec]
; diz.Node__val := __flatten_106
; [exec]
; diz.Node__next := null
; [exec]
; exhale acc(diz.Node__val, write) && ((diz.Node__val != null) ==> acc(diz.Node__val.Integer__val, wildcard)) && acc(diz.Node__next, write)
; [eval] diz.Node__val != null
(push) ; 5
(assert (not (not (= val@939 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 61] val@939 != Null
(push) ; 5
; [else-branch 61] val@939 == Null
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2a__LBQThread2a ----------
(declare-const queue@953 $Ref)
(declare-const sys__result@954 $Ref)
(declare-const diz@955 $Ref)
(declare-const __flatten_56@956 $Ref)
(declare-const __flatten_107@957 $Ref)
(push) ; 2
(assert (not (= queue@953 $Ref.null)))
(declare-const $k@958 $Perm)
(assert ($Perm.isValidVar $k@958))
(assert ($Perm.isReadVar $k@958 $Perm.Write))
(declare-const $t@959 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@958 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@958 $Perm.No)))
(assert (> $t@959 0))
(declare-const $k@960 $Perm)
(assert ($Perm.isValidVar $k@960))
(assert ($Perm.isReadVar $k@960 $Perm.Write))
(declare-const $t@961 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@960 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@960 $Perm.No)))
(assert (not (= $t@961 $Ref.null)))
(declare-const $k@962 $Perm)
(assert ($Perm.isValidVar $k@962))
(assert ($Perm.isReadVar $k@962 $Perm.Write))
(declare-const $t@963 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@962 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@962 $Perm.No)))
(assert (not (= $t@963 $Ref.null)))
(declare-const $k@964 $Perm)
(assert ($Perm.isValidVar $k@964))
(assert ($Perm.isReadVar $k@964 $Perm.Write))
(declare-const $t@965 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@964 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@964 $Perm.No)))
(assert (= $t@965 queue@953))
(declare-const $k@966 $Perm)
(assert ($Perm.isValidVar $k@966))
(assert ($Perm.isReadVar $k@966 $Perm.Write))
(declare-const $t@967 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@966 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@966 $Perm.No)))
(assert (not (= $t@967 $Ref.null)))
(declare-const $k@968 $Perm)
(assert ($Perm.isValidVar $k@968))
(assert ($Perm.isReadVar $k@968 $Perm.Write))
(declare-const $t@969 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@968 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@968 $Perm.No)))
(assert (= $t@969 queue@953))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@954 $Ref.null)))
(declare-const $k@970 $Perm)
(assert ($Perm.isValidVar $k@970))
(assert ($Perm.isReadVar $k@970 $Perm.Write))
(declare-const $t@971 $Ref)
(push) ; 4
(assert (not (not (= $k@970 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@970 $Perm.No)))
(assert (not (= $t@971 $Ref.null)))
(declare-const $k@972 $Perm)
(assert ($Perm.isValidVar $k@972))
(assert ($Perm.isReadVar $k@972 $Perm.Write))
(declare-const $t@973 Int)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@972 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@972 $Perm.No)))
(assert (> $t@973 0))
(declare-const $k@974 $Perm)
(assert ($Perm.isValidVar $k@974))
(assert ($Perm.isReadVar $k@974 $Perm.Write))
(declare-const $t@975 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@974 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@974 $Perm.No)))
(assert (not (= $t@975 $Ref.null)))
(declare-const $k@976 $Perm)
(assert ($Perm.isValidVar $k@976))
(assert ($Perm.isReadVar $k@976 $Perm.Write))
(declare-const $t@977 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@976 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@976 $Perm.No)))
(assert (not (= $t@977 $Ref.null)))
(declare-const $k@978 $Perm)
(assert ($Perm.isValidVar $k@978))
(assert ($Perm.isReadVar $k@978 $Perm.Write))
(declare-const $t@979 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@978 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@978 $Perm.No)))
(assert (= $t@979 $t@971))
(declare-const $k@980 $Perm)
(assert ($Perm.isValidVar $k@980))
(assert ($Perm.isReadVar $k@980 $Perm.Write))
(declare-const $t@981 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@980 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@980 $Perm.No)))
(assert (not (= $t@981 $Ref.null)))
(declare-const $k@982 $Perm)
(assert ($Perm.isValidVar $k@982))
(assert ($Perm.isReadVar $k@982 $Perm.Write))
(declare-const $t@983 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@982 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@982 $Perm.No)))
(assert (= $t@983 $t@971))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LBQThread2a__queue)
(declare-const diz@984 $Ref)
(assert (not (= diz@984 $Ref.null)))
(declare-const LBQThread2a__queue@985 $Ref)
(assert (and
  (not (= queue@953 diz@984))
  (not (= sys__result@954 diz@984))
  (not (= __flatten_56@956 diz@984))
  (not (= __flatten_107@957 diz@984))
  (not (= $t@963 diz@984))
  (not (= $t@967 diz@984))
  (not (= LBQThread2a__queue@985 diz@984))
  (not (= $t@961 diz@984))
  (not (= $t@965 diz@984))
  (not (= $t@969 diz@984))))
; [exec]
; __flatten_56 := queue
; [exec]
; __flatten_107 := __flatten_56
; [exec]
; diz.LBQThread2a__queue := __flatten_107
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread2a__queue, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread2a__queue.BlockingQueue__count, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__count != null) && acc(sys__result.LBQThread2a__queue.BlockingQueue__headLock, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__headLock != null) && acc(sys__result.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread2a__queue) && acc(sys__result.LBQThread2a__queue.BlockingQueue__lastLock, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__lastLock != null) && acc(sys__result.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread2a__queue)
; [eval] sys__result != null
(declare-const $k@986 $Perm)
(assert ($Perm.isValidVar $k@986))
(assert ($Perm.isReadVar $k@986 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@986 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@986 $Perm.Write))
(declare-const $k@987 $Perm)
(assert ($Perm.isValidVar $k@987))
(assert ($Perm.isReadVar $k@987 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@987 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@987 $k@958))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@988 $Perm)
(assert ($Perm.isValidVar $k@988))
(assert ($Perm.isReadVar $k@988 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@988 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@988 $k@960))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__count != null
(declare-const $k@989 $Perm)
(assert ($Perm.isValidVar $k@989))
(assert ($Perm.isReadVar $k@989 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@989 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@989 $k@962))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__headLock != null
(declare-const $k@990 $Perm)
(assert ($Perm.isValidVar $k@990))
(assert ($Perm.isReadVar $k@990 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@990 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@990 $k@964))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread2a__queue
(declare-const $k@991 $Perm)
(assert ($Perm.isValidVar $k@991))
(assert ($Perm.isReadVar $k@991 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@991 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@991 $k@966))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__lastLock != null
(declare-const $k@992 $Perm)
(assert ($Perm.isValidVar $k@992))
(assert ($Perm.isReadVar $k@992 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@992 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@992 $k@968))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread2a__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2a__forkOperator ----------
(declare-const diz@993 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@993 $Ref.null)))
(declare-const $k@994 $Perm)
(assert ($Perm.isValidVar $k@994))
(assert ($Perm.isReadVar $k@994 $Perm.Write))
(declare-const $t@995 $Ref)
(push) ; 3
(assert (not (not (= $k@994 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@994 $Perm.No)))
(assert (not (= $t@995 $Ref.null)))
(declare-const $k@996 $Perm)
(assert ($Perm.isValidVar $k@996))
(assert ($Perm.isReadVar $k@996 $Perm.Write))
(declare-const $t@997 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@996 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@996 $Perm.No)))
(assert (> $t@997 0))
(declare-const $k@998 $Perm)
(assert ($Perm.isValidVar $k@998))
(assert ($Perm.isReadVar $k@998 $Perm.Write))
(declare-const $t@999 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@998 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@998 $Perm.No)))
(assert (not (= $t@999 $Ref.null)))
(declare-const $k@1000 $Perm)
(assert ($Perm.isValidVar $k@1000))
(assert ($Perm.isReadVar $k@1000 $Perm.Write))
(declare-const $t@1001 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@1000 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1000 $Perm.No)))
(assert (not (= $t@1001 $Ref.null)))
(declare-const $k@1002 $Perm)
(assert ($Perm.isValidVar $k@1002))
(assert ($Perm.isReadVar $k@1002 $Perm.Write))
(declare-const $t@1003 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(push) ; 3
(assert (not (not (= $k@1002 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1002 $Perm.No)))
(assert (= $t@1003 $t@995))
(declare-const $k@1004 $Perm)
(assert ($Perm.isValidVar $k@1004))
(assert ($Perm.isReadVar $k@1004 $Perm.Write))
(declare-const $t@1005 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@1004 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1004 $Perm.No)))
(assert (not (= $t@1005 $Ref.null)))
(declare-const $k@1006 $Perm)
(assert ($Perm.isValidVar $k@1006))
(assert ($Perm.isReadVar $k@1006 $Perm.Write))
(declare-const $t@1007 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(push) ; 3
(assert (not (not (= $k@1006 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1006 $Perm.No)))
(assert (= $t@1007 $t@995))
(push) ; 3
(declare-const $t@1008 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2a__joinOperator ----------
(declare-const diz@1009 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1009 $Ref.null)))
(declare-const $t@1010 $Snap)
(push) ; 3
(declare-const $k@1011 $Perm)
(assert ($Perm.isValidVar $k@1011))
(assert ($Perm.isReadVar $k@1011 $Perm.Write))
(declare-const $t@1012 $Ref)
(push) ; 4
(assert (not (not (= $k@1011 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1011 $Perm.No)))
(assert (not (= $t@1012 $Ref.null)))
(declare-const $k@1013 $Perm)
(assert ($Perm.isValidVar $k@1013))
(assert ($Perm.isReadVar $k@1013 $Perm.Write))
(declare-const $t@1014 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1013 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1013 $Perm.No)))
(assert (> $t@1014 0))
(declare-const $k@1015 $Perm)
(assert ($Perm.isValidVar $k@1015))
(assert ($Perm.isReadVar $k@1015 $Perm.Write))
(declare-const $t@1016 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1015 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1015 $Perm.No)))
(assert (not (= $t@1016 $Ref.null)))
(declare-const $k@1017 $Perm)
(assert ($Perm.isValidVar $k@1017))
(assert ($Perm.isReadVar $k@1017 $Perm.Write))
(declare-const $t@1018 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1017 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1017 $Perm.No)))
(assert (not (= $t@1018 $Ref.null)))
(declare-const $k@1019 $Perm)
(assert ($Perm.isValidVar $k@1019))
(assert ($Perm.isReadVar $k@1019 $Perm.Write))
(declare-const $t@1020 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@1019 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1019 $Perm.No)))
(assert (= $t@1020 $t@1012))
(declare-const $k@1021 $Perm)
(assert ($Perm.isValidVar $k@1021))
(assert ($Perm.isReadVar $k@1021 $Perm.Write))
(declare-const $t@1022 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1021 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1021 $Perm.No)))
(assert (not (= $t@1022 $Ref.null)))
(declare-const $k@1023 $Perm)
(assert ($Perm.isValidVar $k@1023))
(assert ($Perm.isReadVar $k@1023 $Perm.Write))
(declare-const $t@1024 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@1023 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1023 $Perm.No)))
(assert (= $t@1024 $t@1012))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2a__run ----------
(declare-const diz@1025 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1025 $Ref.null)))
(declare-const $k@1026 $Perm)
(assert ($Perm.isValidVar $k@1026))
(assert ($Perm.isReadVar $k@1026 $Perm.Write))
(declare-const $t@1027 $Ref)
(push) ; 3
(assert (not (not (= $k@1026 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1026 $Perm.No)))
(assert (not (= $t@1027 $Ref.null)))
(declare-const $k@1028 $Perm)
(assert ($Perm.isValidVar $k@1028))
(assert ($Perm.isReadVar $k@1028 $Perm.Write))
(declare-const $t@1029 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1028 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1028 $Perm.No)))
(assert (> $t@1029 0))
(declare-const $k@1030 $Perm)
(assert ($Perm.isValidVar $k@1030))
(assert ($Perm.isReadVar $k@1030 $Perm.Write))
(declare-const $t@1031 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@1030 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1030 $Perm.No)))
(assert (not (= $t@1031 $Ref.null)))
(declare-const $k@1032 $Perm)
(assert ($Perm.isValidVar $k@1032))
(assert ($Perm.isReadVar $k@1032 $Perm.Write))
(declare-const $t@1033 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@1032 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1032 $Perm.No)))
(assert (not (= $t@1033 $Ref.null)))
(declare-const $k@1034 $Perm)
(assert ($Perm.isValidVar $k@1034))
(assert ($Perm.isReadVar $k@1034 $Perm.Write))
(declare-const $t@1035 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(push) ; 3
(assert (not (not (= $k@1034 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1034 $Perm.No)))
(assert (= $t@1035 $t@1027))
(declare-const $k@1036 $Perm)
(assert ($Perm.isValidVar $k@1036))
(assert ($Perm.isReadVar $k@1036 $Perm.Write))
(declare-const $t@1037 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@1036 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1036 $Perm.No)))
(assert (not (= $t@1037 $Ref.null)))
(declare-const $k@1038 $Perm)
(assert ($Perm.isValidVar $k@1038))
(assert ($Perm.isReadVar $k@1038 $Perm.Write))
(declare-const $t@1039 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(push) ; 3
(assert (not (not (= $k@1038 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1038 $Perm.No)))
(assert (= $t@1039 $t@1027))
(push) ; 3
(declare-const $k@1040 $Perm)
(assert ($Perm.isValidVar $k@1040))
(assert ($Perm.isReadVar $k@1040 $Perm.Write))
(declare-const $t@1041 $Ref)
(push) ; 4
(assert (not (not (= $k@1040 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1040 $Perm.No)))
(assert (not (= $t@1041 $Ref.null)))
(declare-const $k@1042 $Perm)
(assert ($Perm.isValidVar $k@1042))
(assert ($Perm.isReadVar $k@1042 $Perm.Write))
(declare-const $t@1043 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1042 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1042 $Perm.No)))
(assert (> $t@1043 0))
(declare-const $k@1044 $Perm)
(assert ($Perm.isValidVar $k@1044))
(assert ($Perm.isReadVar $k@1044 $Perm.Write))
(declare-const $t@1045 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1044 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1044 $Perm.No)))
(assert (not (= $t@1045 $Ref.null)))
(declare-const $k@1046 $Perm)
(assert ($Perm.isValidVar $k@1046))
(assert ($Perm.isReadVar $k@1046 $Perm.Write))
(declare-const $t@1047 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1046 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1046 $Perm.No)))
(assert (not (= $t@1047 $Ref.null)))
(declare-const $k@1048 $Perm)
(assert ($Perm.isValidVar $k@1048))
(assert ($Perm.isReadVar $k@1048 $Perm.Write))
(declare-const $t@1049 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@1048 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1048 $Perm.No)))
(assert (= $t@1049 $t@1041))
(declare-const $k@1050 $Perm)
(assert ($Perm.isValidVar $k@1050))
(assert ($Perm.isReadVar $k@1050 $Perm.Write))
(declare-const $t@1051 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1050 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1050 $Perm.No)))
(assert (not (= $t@1051 $Ref.null)))
(declare-const $k@1052 $Perm)
(assert ($Perm.isValidVar $k@1052))
(assert ($Perm.isReadVar $k@1052 $Perm.Write))
(declare-const $t@1053 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@1052 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1052 $Perm.No)))
(assert (= $t@1053 $t@1041))
(pop) ; 3
(push) ; 3
; [exec]
; BlockingQueue__put(diz.LBQThread2a__queue, 1)
; [eval] diz != null
(declare-const $k@1054 $Perm)
(assert ($Perm.isValidVar $k@1054))
(assert ($Perm.isReadVar $k@1054 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1054 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1054 $k@1028))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1055 $Perm)
(assert ($Perm.isValidVar $k@1055))
(assert ($Perm.isReadVar $k@1055 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1055 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1055 $k@1030))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1056 $Perm)
(assert ($Perm.isValidVar $k@1056))
(assert ($Perm.isReadVar $k@1056 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1056 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1056 $k@1032))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1057 $Perm)
(assert ($Perm.isValidVar $k@1057))
(assert ($Perm.isReadVar $k@1057 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1057 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1057 $k@1034))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@1058 $Perm)
(assert ($Perm.isValidVar $k@1058))
(assert ($Perm.isReadVar $k@1058 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1058 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1058 $k@1036))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1059 $Perm)
(assert ($Perm.isValidVar $k@1059))
(assert ($Perm.isReadVar $k@1059 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1059 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1059 $k@1038))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const $t@1060 $Snap)
(declare-const $t@1061 $Snap)
(assert (= $t@1060 ($Snap.combine $t@1061 $Snap.unit)))
(declare-const $t@1062 $Snap)
(declare-const $t@1063 $Ref)
(assert (= $t@1061 ($Snap.combine $t@1062 ($SortWrappers.$RefTo$Snap $t@1063))))
(declare-const $t@1064 $Snap)
(assert (= $t@1062 ($Snap.combine $t@1064 $Snap.unit)))
(declare-const $t@1065 $Snap)
(declare-const $t@1066 $Ref)
(assert (= $t@1064 ($Snap.combine $t@1065 ($SortWrappers.$RefTo$Snap $t@1066))))
(declare-const $t@1067 $Snap)
(assert (= $t@1065 ($Snap.combine $t@1067 $Snap.unit)))
(declare-const $t@1068 $Snap)
(declare-const $t@1069 $Ref)
(assert (= $t@1067 ($Snap.combine $t@1068 ($SortWrappers.$RefTo$Snap $t@1069))))
(declare-const $t@1070 $Snap)
(assert (= $t@1068 ($Snap.combine $t@1070 $Snap.unit)))
(declare-const $t@1071 $Snap)
(declare-const $t@1072 $Ref)
(assert (= $t@1070 ($Snap.combine $t@1071 ($SortWrappers.$RefTo$Snap $t@1072))))
(declare-const $t@1073 $Snap)
(assert (= $t@1071 ($Snap.combine $t@1073 $Snap.unit)))
(declare-const $t@1074 Int)
(declare-const $t@1075 $Ref)
(assert (=
  $t@1073
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1074)
    ($SortWrappers.$RefTo$Snap $t@1075))))
(declare-const $t@1076 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1074)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1076) $Snap.unit)))
(declare-const $k@1077 $Perm)
(assert ($Perm.isValidVar $k@1077))
(assert ($Perm.isReadVar $k@1077 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1028 $k@1054)) (= $t@1076 $t@1029)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@1028 $k@1054) $k@1077) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1028 $k@1054) $k@1077) $Perm.No)))
(assert (> $t@1076 0))
(declare-const $k@1078 $Perm)
(assert ($Perm.isValidVar $k@1078))
(assert ($Perm.isReadVar $k@1078 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1030 $k@1055)) (= $t@1075 $t@1031)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@1030 $k@1055) $k@1078) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1030 $k@1055) $k@1078) $Perm.No)))
(assert (not (= $t@1075 $Ref.null)))
(declare-const $k@1079 $Perm)
(assert ($Perm.isValidVar $k@1079))
(assert ($Perm.isReadVar $k@1079 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1032 $k@1056)) (= $t@1072 $t@1033)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1032 $k@1056) $k@1079) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1032 $k@1056) $k@1079) $Perm.No)))
(assert (not (= $t@1072 $Ref.null)))
(declare-const $k@1080 $Perm)
(assert ($Perm.isValidVar $k@1080))
(assert ($Perm.isReadVar $k@1080 $Perm.Write))
(push) ; 4
(assert (not (= $t@1033 $t@1072)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1034 $k@1057)) (= $t@1069 $t@1035)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1033 $t@1072)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1034 $k@1057) $k@1080) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1034 $k@1057) $k@1080) $Perm.No)))
(assert (= $t@1069 $t@1027))
(declare-const $k@1081 $Perm)
(assert ($Perm.isValidVar $k@1081))
(assert ($Perm.isReadVar $k@1081 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1036 $k@1058)) (= $t@1066 $t@1037)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1036 $k@1058) $k@1081) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1036 $k@1058) $k@1081) $Perm.No)))
(assert (not (= $t@1066 $Ref.null)))
(declare-const $k@1082 $Perm)
(assert ($Perm.isValidVar $k@1082))
(assert ($Perm.isReadVar $k@1082 $Perm.Write))
(push) ; 4
(assert (not (= $t@1037 $t@1066)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1038 $k@1059)) (= $t@1063 $t@1039)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1037 $t@1066)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1038 $k@1059) $k@1082) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1038 $k@1059) $k@1082) $Perm.No)))
(assert (= $t@1063 $t@1027))
(declare-const $k@1083 $Perm)
(assert ($Perm.isValidVar $k@1083))
(assert ($Perm.isReadVar $k@1083 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1083 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1083 $k@1026))
(declare-const $k@1084 $Perm)
(assert ($Perm.isValidVar $k@1084))
(assert ($Perm.isReadVar $k@1084 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1084 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1084 (+ (- $k@1028 $k@1054) $k@1077)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@1085 $Perm)
(assert ($Perm.isValidVar $k@1085))
(assert ($Perm.isReadVar $k@1085 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1085 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1085 (+ (- $k@1030 $k@1055) $k@1078)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(declare-const $k@1086 $Perm)
(assert ($Perm.isValidVar $k@1086))
(assert ($Perm.isReadVar $k@1086 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1086 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1086 (+ (- $k@1032 $k@1056) $k@1079)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(declare-const $k@1087 $Perm)
(assert ($Perm.isValidVar $k@1087))
(assert ($Perm.isReadVar $k@1087 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1087 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1033 $t@1072)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1087 (+ (- $k@1034 $k@1057) $k@1080)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (= $t@1033 $t@1072)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1088 $Perm)
(assert ($Perm.isValidVar $k@1088))
(assert ($Perm.isReadVar $k@1088 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1088 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1088 (+ (- $k@1036 $k@1058) $k@1081)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(declare-const $k@1089 $Perm)
(assert ($Perm.isValidVar $k@1089))
(assert ($Perm.isReadVar $k@1089 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1089 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1037 $t@1066)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1089 (+ (- $k@1038 $k@1059) $k@1082)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (= $t@1037 $t@1066)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3b__LBQThread3b ----------
(declare-const queue@1090 $Ref)
(declare-const sys__result@1091 $Ref)
(declare-const diz@1092 $Ref)
(declare-const __flatten_58@1093 $Ref)
(declare-const __flatten_109@1094 $Ref)
(push) ; 2
(assert (not (= queue@1090 $Ref.null)))
(declare-const $k@1095 $Perm)
(assert ($Perm.isValidVar $k@1095))
(assert ($Perm.isReadVar $k@1095 $Perm.Write))
(declare-const $t@1096 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1095 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1095 $Perm.No)))
(assert (> $t@1096 0))
(declare-const $k@1097 $Perm)
(assert ($Perm.isValidVar $k@1097))
(assert ($Perm.isReadVar $k@1097 $Perm.Write))
(declare-const $t@1098 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@1097 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1097 $Perm.No)))
(assert (not (= $t@1098 $Ref.null)))
(declare-const $k@1099 $Perm)
(assert ($Perm.isValidVar $k@1099))
(assert ($Perm.isReadVar $k@1099 $Perm.Write))
(declare-const $t@1100 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@1099 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1099 $Perm.No)))
(assert (not (= $t@1100 $Ref.null)))
(declare-const $k@1101 $Perm)
(assert ($Perm.isValidVar $k@1101))
(assert ($Perm.isReadVar $k@1101 $Perm.Write))
(declare-const $t@1102 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@1101 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1101 $Perm.No)))
(assert (= $t@1102 queue@1090))
(declare-const $k@1103 $Perm)
(assert ($Perm.isValidVar $k@1103))
(assert ($Perm.isReadVar $k@1103 $Perm.Write))
(declare-const $t@1104 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@1103 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1103 $Perm.No)))
(assert (not (= $t@1104 $Ref.null)))
(declare-const $k@1105 $Perm)
(assert ($Perm.isValidVar $k@1105))
(assert ($Perm.isReadVar $k@1105 $Perm.Write))
(declare-const $t@1106 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@1105 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1105 $Perm.No)))
(assert (= $t@1106 queue@1090))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@1091 $Ref.null)))
(declare-const $k@1107 $Perm)
(assert ($Perm.isValidVar $k@1107))
(assert ($Perm.isReadVar $k@1107 $Perm.Write))
(declare-const $t@1108 $Ref)
(push) ; 4
(assert (not (not (= $k@1107 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1107 $Perm.No)))
(assert (not (= $t@1108 $Ref.null)))
(declare-const $k@1109 $Perm)
(assert ($Perm.isValidVar $k@1109))
(assert ($Perm.isReadVar $k@1109 $Perm.Write))
(declare-const $t@1110 Int)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1109 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1109 $Perm.No)))
(assert (> $t@1110 0))
(declare-const $k@1111 $Perm)
(assert ($Perm.isValidVar $k@1111))
(assert ($Perm.isReadVar $k@1111 $Perm.Write))
(declare-const $t@1112 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1111 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1111 $Perm.No)))
(assert (not (= $t@1112 $Ref.null)))
(declare-const $k@1113 $Perm)
(assert ($Perm.isValidVar $k@1113))
(assert ($Perm.isReadVar $k@1113 $Perm.Write))
(declare-const $t@1114 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1113 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1113 $Perm.No)))
(assert (not (= $t@1114 $Ref.null)))
(declare-const $k@1115 $Perm)
(assert ($Perm.isValidVar $k@1115))
(assert ($Perm.isReadVar $k@1115 $Perm.Write))
(declare-const $t@1116 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1115 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1115 $Perm.No)))
(assert (= $t@1116 $t@1108))
(declare-const $k@1117 $Perm)
(assert ($Perm.isValidVar $k@1117))
(assert ($Perm.isReadVar $k@1117 $Perm.Write))
(declare-const $t@1118 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1117 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1117 $Perm.No)))
(assert (not (= $t@1118 $Ref.null)))
(declare-const $k@1119 $Perm)
(assert ($Perm.isValidVar $k@1119))
(assert ($Perm.isReadVar $k@1119 $Perm.Write))
(declare-const $t@1120 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1119 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1119 $Perm.No)))
(assert (= $t@1120 $t@1108))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LBQThread3b__queue)
(declare-const diz@1121 $Ref)
(assert (not (= diz@1121 $Ref.null)))
(declare-const LBQThread3b__queue@1122 $Ref)
(assert (and
  (not (= queue@1090 diz@1121))
  (not (= sys__result@1091 diz@1121))
  (not (= __flatten_58@1093 diz@1121))
  (not (= __flatten_109@1094 diz@1121))
  (not (= $t@1100 diz@1121))
  (not (= $t@1104 diz@1121))
  (not (= LBQThread3b__queue@1122 diz@1121))
  (not (= $t@1098 diz@1121))
  (not (= $t@1102 diz@1121))
  (not (= $t@1106 diz@1121))))
; [exec]
; __flatten_58 := queue
; [exec]
; __flatten_109 := __flatten_58
; [exec]
; diz.LBQThread3b__queue := __flatten_109
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread3b__queue, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread3b__queue.BlockingQueue__count, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__count != null) && acc(sys__result.LBQThread3b__queue.BlockingQueue__headLock, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__headLock != null) && acc(sys__result.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread3b__queue) && acc(sys__result.LBQThread3b__queue.BlockingQueue__lastLock, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__lastLock != null) && acc(sys__result.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread3b__queue)
; [eval] sys__result != null
(declare-const $k@1123 $Perm)
(assert ($Perm.isValidVar $k@1123))
(assert ($Perm.isReadVar $k@1123 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1123 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1123 $Perm.Write))
(declare-const $k@1124 $Perm)
(assert ($Perm.isValidVar $k@1124))
(assert ($Perm.isReadVar $k@1124 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1124 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1124 $k@1095))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@1125 $Perm)
(assert ($Perm.isValidVar $k@1125))
(assert ($Perm.isReadVar $k@1125 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1125 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1125 $k@1097))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__count != null
(declare-const $k@1126 $Perm)
(assert ($Perm.isValidVar $k@1126))
(assert ($Perm.isReadVar $k@1126 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1126 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1126 $k@1099))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__headLock != null
(declare-const $k@1127 $Perm)
(assert ($Perm.isValidVar $k@1127))
(assert ($Perm.isReadVar $k@1127 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1127 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1127 $k@1101))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread3b__queue
(declare-const $k@1128 $Perm)
(assert ($Perm.isValidVar $k@1128))
(assert ($Perm.isReadVar $k@1128 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1128 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1128 $k@1103))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__lastLock != null
(declare-const $k@1129 $Perm)
(assert ($Perm.isValidVar $k@1129))
(assert ($Perm.isReadVar $k@1129 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1129 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1129 $k@1105))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread3b__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3b__forkOperator ----------
(declare-const diz@1130 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1130 $Ref.null)))
(declare-const $k@1131 $Perm)
(assert ($Perm.isValidVar $k@1131))
(assert ($Perm.isReadVar $k@1131 $Perm.Write))
(declare-const $t@1132 $Ref)
(push) ; 3
(assert (not (not (= $k@1131 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1131 $Perm.No)))
(assert (not (= $t@1132 $Ref.null)))
(declare-const $k@1133 $Perm)
(assert ($Perm.isValidVar $k@1133))
(assert ($Perm.isReadVar $k@1133 $Perm.Write))
(declare-const $t@1134 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1133 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1133 $Perm.No)))
(assert (> $t@1134 0))
(declare-const $k@1135 $Perm)
(assert ($Perm.isValidVar $k@1135))
(assert ($Perm.isReadVar $k@1135 $Perm.Write))
(declare-const $t@1136 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@1135 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1135 $Perm.No)))
(assert (not (= $t@1136 $Ref.null)))
(declare-const $k@1137 $Perm)
(assert ($Perm.isValidVar $k@1137))
(assert ($Perm.isReadVar $k@1137 $Perm.Write))
(declare-const $t@1138 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@1137 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1137 $Perm.No)))
(assert (not (= $t@1138 $Ref.null)))
(declare-const $k@1139 $Perm)
(assert ($Perm.isValidVar $k@1139))
(assert ($Perm.isReadVar $k@1139 $Perm.Write))
(declare-const $t@1140 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(push) ; 3
(assert (not (not (= $k@1139 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1139 $Perm.No)))
(assert (= $t@1140 $t@1132))
(declare-const $k@1141 $Perm)
(assert ($Perm.isValidVar $k@1141))
(assert ($Perm.isReadVar $k@1141 $Perm.Write))
(declare-const $t@1142 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@1141 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1141 $Perm.No)))
(assert (not (= $t@1142 $Ref.null)))
(declare-const $k@1143 $Perm)
(assert ($Perm.isValidVar $k@1143))
(assert ($Perm.isReadVar $k@1143 $Perm.Write))
(declare-const $t@1144 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(push) ; 3
(assert (not (not (= $k@1143 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1143 $Perm.No)))
(assert (= $t@1144 $t@1132))
(push) ; 3
(declare-const $t@1145 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3b__joinOperator ----------
(declare-const diz@1146 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1146 $Ref.null)))
(declare-const $t@1147 $Snap)
(push) ; 3
(declare-const $k@1148 $Perm)
(assert ($Perm.isValidVar $k@1148))
(assert ($Perm.isReadVar $k@1148 $Perm.Write))
(declare-const $t@1149 $Ref)
(push) ; 4
(assert (not (not (= $k@1148 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1148 $Perm.No)))
(assert (not (= $t@1149 $Ref.null)))
(declare-const $k@1150 $Perm)
(assert ($Perm.isValidVar $k@1150))
(assert ($Perm.isReadVar $k@1150 $Perm.Write))
(declare-const $t@1151 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1150 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1150 $Perm.No)))
(assert (> $t@1151 0))
(declare-const $k@1152 $Perm)
(assert ($Perm.isValidVar $k@1152))
(assert ($Perm.isReadVar $k@1152 $Perm.Write))
(declare-const $t@1153 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1152 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1152 $Perm.No)))
(assert (not (= $t@1153 $Ref.null)))
(declare-const $k@1154 $Perm)
(assert ($Perm.isValidVar $k@1154))
(assert ($Perm.isReadVar $k@1154 $Perm.Write))
(declare-const $t@1155 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1154 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1154 $Perm.No)))
(assert (not (= $t@1155 $Ref.null)))
(declare-const $k@1156 $Perm)
(assert ($Perm.isValidVar $k@1156))
(assert ($Perm.isReadVar $k@1156 $Perm.Write))
(declare-const $t@1157 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1156 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1156 $Perm.No)))
(assert (= $t@1157 $t@1149))
(declare-const $k@1158 $Perm)
(assert ($Perm.isValidVar $k@1158))
(assert ($Perm.isReadVar $k@1158 $Perm.Write))
(declare-const $t@1159 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1158 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1158 $Perm.No)))
(assert (not (= $t@1159 $Ref.null)))
(declare-const $k@1160 $Perm)
(assert ($Perm.isValidVar $k@1160))
(assert ($Perm.isReadVar $k@1160 $Perm.Write))
(declare-const $t@1161 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1160 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1160 $Perm.No)))
(assert (= $t@1161 $t@1149))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3b__run ----------
(declare-const diz@1162 $Ref)
(declare-const i@1163 Int)
(declare-const __flatten_59@1164 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1162 $Ref.null)))
(declare-const $k@1165 $Perm)
(assert ($Perm.isValidVar $k@1165))
(assert ($Perm.isReadVar $k@1165 $Perm.Write))
(declare-const $t@1166 $Ref)
(push) ; 3
(assert (not (not (= $k@1165 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1165 $Perm.No)))
(assert (not (= $t@1166 $Ref.null)))
(declare-const $k@1167 $Perm)
(assert ($Perm.isValidVar $k@1167))
(assert ($Perm.isReadVar $k@1167 $Perm.Write))
(declare-const $t@1168 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1167 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1167 $Perm.No)))
(assert (> $t@1168 0))
(declare-const $k@1169 $Perm)
(assert ($Perm.isValidVar $k@1169))
(assert ($Perm.isReadVar $k@1169 $Perm.Write))
(declare-const $t@1170 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@1169 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1169 $Perm.No)))
(assert (not (= $t@1170 $Ref.null)))
(declare-const $k@1171 $Perm)
(assert ($Perm.isValidVar $k@1171))
(assert ($Perm.isReadVar $k@1171 $Perm.Write))
(declare-const $t@1172 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@1171 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1171 $Perm.No)))
(assert (not (= $t@1172 $Ref.null)))
(declare-const $k@1173 $Perm)
(assert ($Perm.isValidVar $k@1173))
(assert ($Perm.isReadVar $k@1173 $Perm.Write))
(declare-const $t@1174 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(push) ; 3
(assert (not (not (= $k@1173 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1173 $Perm.No)))
(assert (= $t@1174 $t@1166))
(declare-const $k@1175 $Perm)
(assert ($Perm.isValidVar $k@1175))
(assert ($Perm.isReadVar $k@1175 $Perm.Write))
(declare-const $t@1176 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@1175 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1175 $Perm.No)))
(assert (not (= $t@1176 $Ref.null)))
(declare-const $k@1177 $Perm)
(assert ($Perm.isValidVar $k@1177))
(assert ($Perm.isReadVar $k@1177 $Perm.Write))
(declare-const $t@1178 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(push) ; 3
(assert (not (not (= $k@1177 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1177 $Perm.No)))
(assert (= $t@1178 $t@1166))
(push) ; 3
(declare-const $k@1179 $Perm)
(assert ($Perm.isValidVar $k@1179))
(assert ($Perm.isReadVar $k@1179 $Perm.Write))
(declare-const $t@1180 $Ref)
(push) ; 4
(assert (not (not (= $k@1179 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1179 $Perm.No)))
(assert (not (= $t@1180 $Ref.null)))
(declare-const $k@1181 $Perm)
(assert ($Perm.isValidVar $k@1181))
(assert ($Perm.isReadVar $k@1181 $Perm.Write))
(declare-const $t@1182 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1181 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1181 $Perm.No)))
(assert (> $t@1182 0))
(declare-const $k@1183 $Perm)
(assert ($Perm.isValidVar $k@1183))
(assert ($Perm.isReadVar $k@1183 $Perm.Write))
(declare-const $t@1184 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1183 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1183 $Perm.No)))
(assert (not (= $t@1184 $Ref.null)))
(declare-const $k@1185 $Perm)
(assert ($Perm.isValidVar $k@1185))
(assert ($Perm.isReadVar $k@1185 $Perm.Write))
(declare-const $t@1186 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1185 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1185 $Perm.No)))
(assert (not (= $t@1186 $Ref.null)))
(declare-const $k@1187 $Perm)
(assert ($Perm.isValidVar $k@1187))
(assert ($Perm.isReadVar $k@1187 $Perm.Write))
(declare-const $t@1188 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1187 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1187 $Perm.No)))
(assert (= $t@1188 $t@1180))
(declare-const $k@1189 $Perm)
(assert ($Perm.isValidVar $k@1189))
(assert ($Perm.isReadVar $k@1189 $Perm.Write))
(declare-const $t@1190 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1189 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1189 $Perm.No)))
(assert (not (= $t@1190 $Ref.null)))
(declare-const $k@1191 $Perm)
(assert ($Perm.isValidVar $k@1191))
(assert ($Perm.isReadVar $k@1191 $Perm.Write))
(declare-const $t@1192 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1191 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1191 $Perm.No)))
(assert (= $t@1192 $t@1180))
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_59 := BlockingQueue__take(diz.LBQThread3b__queue)
; [eval] diz != null
(declare-const $k@1193 $Perm)
(assert ($Perm.isValidVar $k@1193))
(assert ($Perm.isReadVar $k@1193 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1193 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1193 $k@1167))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1194 $Perm)
(assert ($Perm.isValidVar $k@1194))
(assert ($Perm.isReadVar $k@1194 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1194 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1194 $k@1169))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1195 $Perm)
(assert ($Perm.isValidVar $k@1195))
(assert ($Perm.isReadVar $k@1195 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1195 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1195 $k@1171))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1196 $Perm)
(assert ($Perm.isValidVar $k@1196))
(assert ($Perm.isReadVar $k@1196 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1196 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1196 $k@1173))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@1197 $Perm)
(assert ($Perm.isValidVar $k@1197))
(assert ($Perm.isReadVar $k@1197 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1197 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1197 $k@1175))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1198 $Perm)
(assert ($Perm.isValidVar $k@1198))
(assert ($Perm.isReadVar $k@1198 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1198 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1198 $k@1177))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@1199 Int)
(declare-const $t@1200 $Snap)
(declare-const $t@1201 $Snap)
(assert (= $t@1200 ($Snap.combine $t@1201 $Snap.unit)))
(declare-const $t@1202 $Snap)
(declare-const $t@1203 $Ref)
(assert (= $t@1201 ($Snap.combine $t@1202 ($SortWrappers.$RefTo$Snap $t@1203))))
(declare-const $t@1204 $Snap)
(assert (= $t@1202 ($Snap.combine $t@1204 $Snap.unit)))
(declare-const $t@1205 $Snap)
(declare-const $t@1206 $Ref)
(assert (= $t@1204 ($Snap.combine $t@1205 ($SortWrappers.$RefTo$Snap $t@1206))))
(declare-const $t@1207 $Snap)
(assert (= $t@1205 ($Snap.combine $t@1207 $Snap.unit)))
(declare-const $t@1208 $Snap)
(declare-const $t@1209 $Ref)
(assert (= $t@1207 ($Snap.combine $t@1208 ($SortWrappers.$RefTo$Snap $t@1209))))
(declare-const $t@1210 $Snap)
(assert (= $t@1208 ($Snap.combine $t@1210 $Snap.unit)))
(declare-const $t@1211 $Snap)
(declare-const $t@1212 $Ref)
(assert (= $t@1210 ($Snap.combine $t@1211 ($SortWrappers.$RefTo$Snap $t@1212))))
(declare-const $t@1213 $Snap)
(assert (= $t@1211 ($Snap.combine $t@1213 $Snap.unit)))
(declare-const $t@1214 Int)
(declare-const $t@1215 $Ref)
(assert (=
  $t@1213
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1214)
    ($SortWrappers.$RefTo$Snap $t@1215))))
(declare-const $t@1216 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1214)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1216) $Snap.unit)))
(declare-const $k@1217 $Perm)
(assert ($Perm.isValidVar $k@1217))
(assert ($Perm.isReadVar $k@1217 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1167 $k@1193)) (= $t@1216 $t@1168)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@1167 $k@1193) $k@1217) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1167 $k@1193) $k@1217) $Perm.No)))
(assert (> $t@1216 0))
(declare-const $k@1218 $Perm)
(assert ($Perm.isValidVar $k@1218))
(assert ($Perm.isReadVar $k@1218 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1169 $k@1194)) (= $t@1215 $t@1170)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@1169 $k@1194) $k@1218) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1169 $k@1194) $k@1218) $Perm.No)))
(assert (not (= $t@1215 $Ref.null)))
(declare-const $k@1219 $Perm)
(assert ($Perm.isValidVar $k@1219))
(assert ($Perm.isReadVar $k@1219 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1171 $k@1195)) (= $t@1212 $t@1172)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1171 $k@1195) $k@1219) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1171 $k@1195) $k@1219) $Perm.No)))
(assert (not (= $t@1212 $Ref.null)))
(declare-const $k@1220 $Perm)
(assert ($Perm.isValidVar $k@1220))
(assert ($Perm.isReadVar $k@1220 $Perm.Write))
(push) ; 4
(assert (not (= $t@1172 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1173 $k@1196)) (= $t@1209 $t@1174)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1172 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1173 $k@1196) $k@1220) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1173 $k@1196) $k@1220) $Perm.No)))
(assert (= $t@1209 $t@1166))
(declare-const $k@1221 $Perm)
(assert ($Perm.isValidVar $k@1221))
(assert ($Perm.isReadVar $k@1221 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1175 $k@1197)) (= $t@1206 $t@1176)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1175 $k@1197) $k@1221) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1175 $k@1197) $k@1221) $Perm.No)))
(assert (not (= $t@1206 $Ref.null)))
(declare-const $k@1222 $Perm)
(assert ($Perm.isValidVar $k@1222))
(assert ($Perm.isReadVar $k@1222 $Perm.Write))
(push) ; 4
(assert (not (= $t@1176 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1177 $k@1198)) (= $t@1203 $t@1178)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1176 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1177 $k@1198) $k@1222) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1177 $k@1198) $k@1222) $Perm.No)))
(assert (= $t@1203 $t@1166))
; [exec]
; i := __flatten_59
(declare-const $k@1223 $Perm)
(assert ($Perm.isValidVar $k@1223))
(assert ($Perm.isReadVar $k@1223 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1223 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1223 $k@1165))
(declare-const $k@1224 $Perm)
(assert ($Perm.isValidVar $k@1224))
(assert ($Perm.isReadVar $k@1224 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1224 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1224 (+ (- $k@1167 $k@1193) $k@1217)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@1225 $Perm)
(assert ($Perm.isValidVar $k@1225))
(assert ($Perm.isReadVar $k@1225 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1225 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1225 (+ (- $k@1169 $k@1194) $k@1218)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(declare-const $k@1226 $Perm)
(assert ($Perm.isValidVar $k@1226))
(assert ($Perm.isReadVar $k@1226 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1226 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1226 (+ (- $k@1171 $k@1195) $k@1219)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(declare-const $k@1227 $Perm)
(assert ($Perm.isValidVar $k@1227))
(assert ($Perm.isReadVar $k@1227 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1227 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1172 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1227 (+ (- $k@1173 $k@1196) $k@1220)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (= $t@1172 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1228 $Perm)
(assert ($Perm.isValidVar $k@1228))
(assert ($Perm.isReadVar $k@1228 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1228 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1228 (+ (- $k@1175 $k@1197) $k@1221)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(declare-const $k@1229 $Perm)
(assert ($Perm.isValidVar $k@1229))
(assert ($Perm.isReadVar $k@1229 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1229 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1176 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1229 (+ (- $k@1177 $k@1198) $k@1222)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (= $t@1176 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Test__testEmpty ----------
(declare-const diz@1230 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1230 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
(pop) ; 3
(pop) ; 2
; ---------- Test__testFillAndEmpty ----------
(declare-const diz@1231 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1231 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
(pop) ; 3
(pop) ; 2
; ---------- Test__testFillAndPeek ----------
(declare-const diz@1232 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1232 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
(pop) ; 3
(pop) ; 2
; ---------- Test__testFullAndFill ----------
(declare-const diz@1233 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1233 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
(pop) ; 3
(pop) ; 2
; ---------- Test__test1 ----------
(declare-const diz@1234 $Ref)
(declare-const queue@1235 $Ref)
(declare-const __flatten_60@1236 $Ref)
(declare-const t1@1237 $Ref)
(declare-const __flatten_61@1238 $Ref)
(declare-const t2@1239 $Ref)
(declare-const __flatten_62@1240 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1234 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_60 := BlockingQueue__BlockingQueue(2)
; [eval] capacity > 0
(declare-const sys__result@1241 $Ref)
(declare-const $t@1242 $Snap)
(declare-const $t@1243 $Snap)
(assert (= $t@1242 ($Snap.combine $t@1243 $Snap.unit)))
(declare-const $t@1244 $Snap)
(assert (= $t@1243 ($Snap.combine $t@1244 $Snap.unit)))
(declare-const $t@1245 $Snap)
(declare-const $t@1246 $Ref)
(assert (= $t@1244 ($Snap.combine $t@1245 ($SortWrappers.$RefTo$Snap $t@1246))))
(declare-const $t@1247 $Snap)
(assert (= $t@1245 ($Snap.combine $t@1247 $Snap.unit)))
(declare-const $t@1248 $Snap)
(declare-const $t@1249 $Ref)
(assert (= $t@1247 ($Snap.combine $t@1248 ($SortWrappers.$RefTo$Snap $t@1249))))
(declare-const $t@1250 $Snap)
(assert (= $t@1248 ($Snap.combine $t@1250 $Snap.unit)))
(declare-const $t@1251 $Snap)
(declare-const $t@1252 $Ref)
(assert (= $t@1250 ($Snap.combine $t@1251 ($SortWrappers.$RefTo$Snap $t@1252))))
(declare-const $t@1253 $Snap)
(assert (= $t@1251 ($Snap.combine $t@1253 $Snap.unit)))
(declare-const $t@1254 $Snap)
(declare-const $t@1255 $Ref)
(assert (= $t@1253 ($Snap.combine $t@1254 ($SortWrappers.$RefTo$Snap $t@1255))))
(declare-const $t@1256 $Snap)
(assert (= $t@1254 ($Snap.combine $t@1256 $Snap.unit)))
(declare-const $t@1257 Int)
(declare-const $t@1258 $Ref)
(assert (=
  $t@1256
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1257)
    ($SortWrappers.$RefTo$Snap $t@1258))))
(declare-const $t@1259 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1257)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1259) $Snap.unit)))
(declare-const $t@1260 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1259)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1260))))
; [eval] sys__result != null
(assert (not (= sys__result@1241 $Ref.null)))
(declare-const $k@1261 $Perm)
(assert ($Perm.isValidVar $k@1261))
(assert ($Perm.isReadVar $k@1261 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1261 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1261 $Perm.No)))
(assert (> $t@1260 0))
(declare-const $k@1262 $Perm)
(assert ($Perm.isValidVar $k@1262))
(assert ($Perm.isReadVar $k@1262 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1262 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1262 $Perm.No)))
(assert (not (= $t@1258 $Ref.null)))
(declare-const $k@1263 $Perm)
(assert ($Perm.isValidVar $k@1263))
(assert ($Perm.isReadVar $k@1263 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1263 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1263 $Perm.No)))
(assert (not (= $t@1255 $Ref.null)))
(declare-const $k@1264 $Perm)
(assert ($Perm.isValidVar $k@1264))
(assert ($Perm.isReadVar $k@1264 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1264 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1264 $Perm.No)))
(assert (= $t@1252 sys__result@1241))
(declare-const $k@1265 $Perm)
(assert ($Perm.isValidVar $k@1265))
(assert ($Perm.isReadVar $k@1265 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1265 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1265 $Perm.No)))
(assert (not (= $t@1249 $Ref.null)))
(declare-const $k@1266 $Perm)
(assert ($Perm.isValidVar $k@1266))
(assert ($Perm.isReadVar $k@1266 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1266 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1266 $Perm.No)))
(assert (= $t@1246 sys__result@1241))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1260 2))
; [exec]
; queue := __flatten_60
; [exec]
; __flatten_61 := LBQThread2a__LBQThread2a(queue)
(declare-const $k@1267 $Perm)
(assert ($Perm.isValidVar $k@1267))
(assert ($Perm.isReadVar $k@1267 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1267 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1267 $k@1261))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1268 $Perm)
(assert ($Perm.isValidVar $k@1268))
(assert ($Perm.isReadVar $k@1268 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1268 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1268 $k@1262))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1269 $Perm)
(assert ($Perm.isValidVar $k@1269))
(assert ($Perm.isReadVar $k@1269 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1269 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1269 $k@1263))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1270 $Perm)
(assert ($Perm.isValidVar $k@1270))
(assert ($Perm.isReadVar $k@1270 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1270 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1270 $k@1264))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1271 $Perm)
(assert ($Perm.isValidVar $k@1271))
(assert ($Perm.isReadVar $k@1271 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1271 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1271 $k@1265))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1272 $Perm)
(assert ($Perm.isValidVar $k@1272))
(assert ($Perm.isReadVar $k@1272 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1272 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1272 $k@1266))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1273 $Ref)
(declare-const $t@1274 $Snap)
(declare-const $t@1275 $Snap)
(assert (= $t@1274 ($Snap.combine $t@1275 $Snap.unit)))
(declare-const $t@1276 $Snap)
(declare-const $t@1277 $Ref)
(assert (= $t@1275 ($Snap.combine $t@1276 ($SortWrappers.$RefTo$Snap $t@1277))))
(declare-const $t@1278 $Snap)
(assert (= $t@1276 ($Snap.combine $t@1278 $Snap.unit)))
(declare-const $t@1279 $Snap)
(declare-const $t@1280 $Ref)
(assert (= $t@1278 ($Snap.combine $t@1279 ($SortWrappers.$RefTo$Snap $t@1280))))
(declare-const $t@1281 $Snap)
(assert (= $t@1279 ($Snap.combine $t@1281 $Snap.unit)))
(declare-const $t@1282 $Snap)
(declare-const $t@1283 $Ref)
(assert (= $t@1281 ($Snap.combine $t@1282 ($SortWrappers.$RefTo$Snap $t@1283))))
(declare-const $t@1284 $Snap)
(assert (= $t@1282 ($Snap.combine $t@1284 $Snap.unit)))
(declare-const $t@1285 $Snap)
(declare-const $t@1286 $Ref)
(assert (= $t@1284 ($Snap.combine $t@1285 ($SortWrappers.$RefTo$Snap $t@1286))))
(declare-const $t@1287 $Snap)
(assert (= $t@1285 ($Snap.combine $t@1287 $Snap.unit)))
(declare-const $t@1288 $Snap)
(declare-const $t@1289 $Ref)
(assert (= $t@1287 ($Snap.combine $t@1288 ($SortWrappers.$RefTo$Snap $t@1289))))
(declare-const $t@1290 $Snap)
(assert (= $t@1288 ($Snap.combine $t@1290 $Snap.unit)))
(declare-const $t@1291 $Ref)
(declare-const $t@1292 Int)
(assert (=
  $t@1290
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1291)
    ($SortWrappers.IntTo$Snap $t@1292))))
(declare-const $t@1293 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1291)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1293))))
; [eval] sys__result != null
(assert (not (= sys__result@1273 $Ref.null)))
(declare-const $k@1294 $Perm)
(assert ($Perm.isValidVar $k@1294))
(assert ($Perm.isReadVar $k@1294 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1294 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1294 $Perm.No)))
(assert (not (= $t@1293 $Ref.null)))
(declare-const $k@1295 $Perm)
(assert ($Perm.isValidVar $k@1295))
(assert ($Perm.isReadVar $k@1295 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1293)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1295 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1295 $Perm.No)))
(assert (> $t@1292 0))
(declare-const $k@1296 $Perm)
(assert ($Perm.isValidVar $k@1296))
(assert ($Perm.isReadVar $k@1296 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1293)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1296 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1296 $Perm.No)))
(assert (not (= $t@1289 $Ref.null)))
(declare-const $k@1297 $Perm)
(assert ($Perm.isValidVar $k@1297))
(assert ($Perm.isReadVar $k@1297 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1293)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1297 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1297 $Perm.No)))
(assert (not (= $t@1286 $Ref.null)))
(declare-const $k@1298 $Perm)
(assert ($Perm.isValidVar $k@1298))
(assert ($Perm.isReadVar $k@1298 $Perm.Write))
(push) ; 4
(assert (not (= $t@1255 $t@1286)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@1298 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1298 $Perm.No)))
(assert (= $t@1283 $t@1293))
(declare-const $k@1299 $Perm)
(assert ($Perm.isValidVar $k@1299))
(assert ($Perm.isReadVar $k@1299 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1293)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1299 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1299 $Perm.No)))
(assert (not (= $t@1280 $Ref.null)))
(declare-const $k@1300 $Perm)
(assert ($Perm.isValidVar $k@1300))
(assert ($Perm.isReadVar $k@1300 $Perm.Write))
(push) ; 4
(assert (not (= $t@1249 $t@1280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread2a__queue
(push) ; 4
(assert (not (not (= $k@1300 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1300 $Perm.No)))
(assert (= $t@1277 $t@1293))
; [exec]
; t1 := __flatten_61
; [exec]
; __flatten_62 := LBQThread3b__LBQThread3b(queue)
(declare-const $k@1301 $Perm)
(assert ($Perm.isValidVar $k@1301))
(assert ($Perm.isReadVar $k@1301 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1301 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1261 $k@1267) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1261 $k@1267) $Perm.No)))
(assert (< $k@1301 (- $k@1261 $k@1267)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1302 $Perm)
(assert ($Perm.isValidVar $k@1302))
(assert ($Perm.isReadVar $k@1302 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1302 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1262 $k@1268) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1262 $k@1268) $Perm.No)))
(assert (< $k@1302 (- $k@1262 $k@1268)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1303 $Perm)
(assert ($Perm.isValidVar $k@1303))
(assert ($Perm.isReadVar $k@1303 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1303 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1263 $k@1269) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1263 $k@1269) $Perm.No)))
(assert (< $k@1303 (- $k@1263 $k@1269)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1304 $Perm)
(assert ($Perm.isValidVar $k@1304))
(assert ($Perm.isReadVar $k@1304 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1304 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1264 $k@1270) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1264 $k@1270) $Perm.No)))
(assert (< $k@1304 (- $k@1264 $k@1270)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1305 $Perm)
(assert ($Perm.isValidVar $k@1305))
(assert ($Perm.isReadVar $k@1305 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1305 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1265 $k@1271) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1265 $k@1271) $Perm.No)))
(assert (< $k@1305 (- $k@1265 $k@1271)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1306 $Perm)
(assert ($Perm.isValidVar $k@1306))
(assert ($Perm.isReadVar $k@1306 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1306 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1266 $k@1272) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1266 $k@1272) $Perm.No)))
(assert (< $k@1306 (- $k@1266 $k@1272)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1307 $Ref)
(declare-const $t@1308 $Snap)
(declare-const $t@1309 $Snap)
(assert (= $t@1308 ($Snap.combine $t@1309 $Snap.unit)))
(declare-const $t@1310 $Snap)
(declare-const $t@1311 $Ref)
(assert (= $t@1309 ($Snap.combine $t@1310 ($SortWrappers.$RefTo$Snap $t@1311))))
(declare-const $t@1312 $Snap)
(assert (= $t@1310 ($Snap.combine $t@1312 $Snap.unit)))
(declare-const $t@1313 $Snap)
(declare-const $t@1314 $Ref)
(assert (= $t@1312 ($Snap.combine $t@1313 ($SortWrappers.$RefTo$Snap $t@1314))))
(declare-const $t@1315 $Snap)
(assert (= $t@1313 ($Snap.combine $t@1315 $Snap.unit)))
(declare-const $t@1316 $Snap)
(declare-const $t@1317 $Ref)
(assert (= $t@1315 ($Snap.combine $t@1316 ($SortWrappers.$RefTo$Snap $t@1317))))
(declare-const $t@1318 $Snap)
(assert (= $t@1316 ($Snap.combine $t@1318 $Snap.unit)))
(declare-const $t@1319 $Snap)
(declare-const $t@1320 $Ref)
(assert (= $t@1318 ($Snap.combine $t@1319 ($SortWrappers.$RefTo$Snap $t@1320))))
(declare-const $t@1321 $Snap)
(assert (= $t@1319 ($Snap.combine $t@1321 $Snap.unit)))
(declare-const $t@1322 $Snap)
(declare-const $t@1323 $Ref)
(assert (= $t@1321 ($Snap.combine $t@1322 ($SortWrappers.$RefTo$Snap $t@1323))))
(declare-const $t@1324 $Snap)
(assert (= $t@1322 ($Snap.combine $t@1324 $Snap.unit)))
(declare-const $t@1325 $Ref)
(declare-const $t@1326 Int)
(assert (=
  $t@1324
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1325)
    ($SortWrappers.IntTo$Snap $t@1326))))
(declare-const $t@1327 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1325)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1327))))
; [eval] sys__result != null
(assert (not (= sys__result@1307 $Ref.null)))
(declare-const $k@1328 $Perm)
(assert ($Perm.isValidVar $k@1328))
(assert ($Perm.isReadVar $k@1328 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1328 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1328 $Perm.No)))
(assert (not (= $t@1327 $Ref.null)))
(declare-const $k@1329 $Perm)
(assert ($Perm.isValidVar $k@1329))
(assert ($Perm.isReadVar $k@1329 $Perm.Write))
(push) ; 4
(assert (not (= $t@1293 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1241 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1329 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1329 $Perm.No)))
(assert (> $t@1326 0))
(declare-const $k@1330 $Perm)
(assert ($Perm.isValidVar $k@1330))
(assert ($Perm.isReadVar $k@1330 $Perm.Write))
(push) ; 4
(assert (not (= $t@1293 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1241 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1330 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1330 $Perm.No)))
(assert (not (= $t@1323 $Ref.null)))
(declare-const $k@1331 $Perm)
(assert ($Perm.isValidVar $k@1331))
(assert ($Perm.isReadVar $k@1331 $Perm.Write))
(push) ; 4
(assert (not (= $t@1293 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1241 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1331 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1331 $Perm.No)))
(assert (not (= $t@1320 $Ref.null)))
(declare-const $k@1332 $Perm)
(assert ($Perm.isValidVar $k@1332))
(assert ($Perm.isReadVar $k@1332 $Perm.Write))
(push) ; 4
(assert (not (= $t@1286 $t@1320)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1255 $t@1320)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1332 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1332 $Perm.No)))
(assert (= $t@1317 $t@1327))
(declare-const $k@1333 $Perm)
(assert ($Perm.isValidVar $k@1333))
(assert ($Perm.isReadVar $k@1333 $Perm.Write))
(push) ; 4
(assert (not (= $t@1293 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1241 $t@1327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1333 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1333 $Perm.No)))
(assert (not (= $t@1314 $Ref.null)))
(declare-const $k@1334 $Perm)
(assert ($Perm.isValidVar $k@1334))
(assert ($Perm.isReadVar $k@1334 $Perm.Write))
(push) ; 4
(assert (not (= $t@1280 $t@1314)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1249 $t@1314)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.LBQThread3b__queue
(push) ; 4
(assert (not (not (= $k@1334 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1334 $Perm.No)))
(assert (= $t@1311 $t@1327))
; [exec]
; t2 := __flatten_62
; [exec]
; LBQThread2a__forkOperator(t1)
; [eval] diz != null
(declare-const $k@1335 $Perm)
(assert ($Perm.isValidVar $k@1335))
(assert ($Perm.isReadVar $k@1335 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1335 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1335 $k@1294))
(declare-const $k@1336 $Perm)
(assert ($Perm.isValidVar $k@1336))
(assert ($Perm.isReadVar $k@1336 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1336 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1336 $k@1295))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@1337 $Perm)
(assert ($Perm.isValidVar $k@1337))
(assert ($Perm.isReadVar $k@1337 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1337 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1337 $k@1296))
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(declare-const $k@1338 $Perm)
(assert ($Perm.isValidVar $k@1338))
(assert ($Perm.isReadVar $k@1338 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1338 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1338 $k@1297))
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(declare-const $k@1339 $Perm)
(assert ($Perm.isValidVar $k@1339))
(assert ($Perm.isReadVar $k@1339 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1339 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1339 $k@1298))
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(declare-const $k@1340 $Perm)
(assert ($Perm.isValidVar $k@1340))
(assert ($Perm.isReadVar $k@1340 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1340 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1340 $k@1299))
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(declare-const $k@1341 $Perm)
(assert ($Perm.isValidVar $k@1341))
(assert ($Perm.isReadVar $k@1341 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1341 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1341 $k@1300))
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(declare-const $t@1342 $Snap)
; [exec]
; LBQThread3b__forkOperator(t2)
; [eval] diz != null
(declare-const $k@1343 $Perm)
(assert ($Perm.isValidVar $k@1343))
(assert ($Perm.isReadVar $k@1343 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1343 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1343 $k@1328))
(declare-const $k@1344 $Perm)
(assert ($Perm.isValidVar $k@1344))
(assert ($Perm.isReadVar $k@1344 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1344 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1344 $k@1329))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@1345 $Perm)
(assert ($Perm.isValidVar $k@1345))
(assert ($Perm.isReadVar $k@1345 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1345 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1345 $k@1330))
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(declare-const $k@1346 $Perm)
(assert ($Perm.isValidVar $k@1346))
(assert ($Perm.isReadVar $k@1346 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1346 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1346 $k@1331))
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(declare-const $k@1347 $Perm)
(assert ($Perm.isValidVar $k@1347))
(assert ($Perm.isReadVar $k@1347 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1347 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1347 $k@1332))
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(declare-const $k@1348 $Perm)
(assert ($Perm.isValidVar $k@1348))
(assert ($Perm.isReadVar $k@1348 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1348 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1348 $k@1333))
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(declare-const $k@1349 $Perm)
(assert ($Perm.isValidVar $k@1349))
(assert ($Perm.isReadVar $k@1349 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1349 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1349 $k@1334))
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(declare-const $t@1350 $Snap)
; [exec]
; LBQThread2a__joinOperator(t1)
; [eval] diz != null
(declare-const $t@1351 $Snap)
(declare-const $t@1352 $Snap)
(assert (= $t@1351 ($Snap.combine $t@1352 $Snap.unit)))
(declare-const $t@1353 $Snap)
(declare-const $t@1354 $Ref)
(assert (= $t@1352 ($Snap.combine $t@1353 ($SortWrappers.$RefTo$Snap $t@1354))))
(declare-const $t@1355 $Snap)
(assert (= $t@1353 ($Snap.combine $t@1355 $Snap.unit)))
(declare-const $t@1356 $Snap)
(declare-const $t@1357 $Ref)
(assert (= $t@1355 ($Snap.combine $t@1356 ($SortWrappers.$RefTo$Snap $t@1357))))
(declare-const $t@1358 $Snap)
(assert (= $t@1356 ($Snap.combine $t@1358 $Snap.unit)))
(declare-const $t@1359 $Snap)
(declare-const $t@1360 $Ref)
(assert (= $t@1358 ($Snap.combine $t@1359 ($SortWrappers.$RefTo$Snap $t@1360))))
(declare-const $t@1361 $Snap)
(assert (= $t@1359 ($Snap.combine $t@1361 $Snap.unit)))
(declare-const $t@1362 $Snap)
(declare-const $t@1363 $Ref)
(assert (= $t@1361 ($Snap.combine $t@1362 ($SortWrappers.$RefTo$Snap $t@1363))))
(declare-const $t@1364 $Snap)
(assert (= $t@1362 ($Snap.combine $t@1364 $Snap.unit)))
(declare-const $t@1365 $Snap)
(declare-const $t@1366 $Ref)
(assert (= $t@1364 ($Snap.combine $t@1365 ($SortWrappers.$RefTo$Snap $t@1366))))
(declare-const $t@1367 $Snap)
(assert (= $t@1365 ($Snap.combine $t@1367 $Snap.unit)))
(declare-const $t@1368 $Ref)
(declare-const $t@1369 Int)
(assert (=
  $t@1367
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1368)
    ($SortWrappers.IntTo$Snap $t@1369))))
(declare-const $k@1370 $Perm)
(assert ($Perm.isValidVar $k@1370))
(assert ($Perm.isReadVar $k@1370 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1294 $k@1335)) (= $t@1368 $t@1293)))
(push) ; 4
(assert (not (not (= (+ (- $k@1294 $k@1335) $k@1370) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1294 $k@1335) $k@1370) $Perm.No)))
(assert (not (= $t@1368 $Ref.null)))
(declare-const $k@1371 $Perm)
(assert ($Perm.isValidVar $k@1371))
(assert ($Perm.isReadVar $k@1371 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1295 $k@1336)) (= $t@1369 $t@1292)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1295 $k@1336) $k@1371) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1295 $k@1336) $k@1371) $Perm.No)))
(assert (> $t@1369 0))
(declare-const $k@1372 $Perm)
(assert ($Perm.isValidVar $k@1372))
(assert ($Perm.isReadVar $k@1372 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1296 $k@1337)) (= $t@1366 $t@1289)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1296 $k@1337) $k@1372) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1296 $k@1337) $k@1372) $Perm.No)))
(assert (not (= $t@1366 $Ref.null)))
(declare-const $k@1373 $Perm)
(assert ($Perm.isValidVar $k@1373))
(assert ($Perm.isReadVar $k@1373 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1297 $k@1338)) (= $t@1363 $t@1286)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1297 $k@1338) $k@1373) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1297 $k@1338) $k@1373) $Perm.No)))
(assert (not (= $t@1363 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1374 $Perm)
(assert ($Perm.isValidVar $k@1374))
(assert ($Perm.isReadVar $k@1374 $Perm.Write))
(push) ; 4
(assert (not (= $t@1255 $t@1363)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1286 $t@1363)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1298 $k@1339)) (= $t@1360 $t@1283)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1255 $t@1363)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1320 $t@1363)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1286 $t@1363)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1298 $k@1339) $k@1374) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1298 $k@1339) $k@1374) $Perm.No)))
(assert (= $t@1360 $t@1368))
(declare-const $k@1375 $Perm)
(assert ($Perm.isValidVar $k@1375))
(assert ($Perm.isReadVar $k@1375 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1299 $k@1340)) (= $t@1357 $t@1280)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1299 $k@1340) $k@1375) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1299 $k@1340) $k@1375) $Perm.No)))
(assert (not (= $t@1357 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1376 $Perm)
(assert ($Perm.isValidVar $k@1376))
(assert ($Perm.isReadVar $k@1376 $Perm.Write))
(push) ; 4
(assert (not (= $t@1249 $t@1357)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1280 $t@1357)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1300 $k@1341)) (= $t@1354 $t@1277)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread2a__queue
(push) ; 4
(assert (not (= sys__result@1241 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1368)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1368)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1249 $t@1357)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1314 $t@1357)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1280 $t@1357)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1300 $k@1341) $k@1376) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1300 $k@1341) $k@1376) $Perm.No)))
(assert (= $t@1354 $t@1368))
; [exec]
; LBQThread3b__joinOperator(t2)
; [eval] diz != null
(declare-const $t@1377 $Snap)
(declare-const $t@1378 $Snap)
(assert (= $t@1377 ($Snap.combine $t@1378 $Snap.unit)))
(declare-const $t@1379 $Snap)
(declare-const $t@1380 $Ref)
(assert (= $t@1378 ($Snap.combine $t@1379 ($SortWrappers.$RefTo$Snap $t@1380))))
(declare-const $t@1381 $Snap)
(assert (= $t@1379 ($Snap.combine $t@1381 $Snap.unit)))
(declare-const $t@1382 $Snap)
(declare-const $t@1383 $Ref)
(assert (= $t@1381 ($Snap.combine $t@1382 ($SortWrappers.$RefTo$Snap $t@1383))))
(declare-const $t@1384 $Snap)
(assert (= $t@1382 ($Snap.combine $t@1384 $Snap.unit)))
(declare-const $t@1385 $Snap)
(declare-const $t@1386 $Ref)
(assert (= $t@1384 ($Snap.combine $t@1385 ($SortWrappers.$RefTo$Snap $t@1386))))
(declare-const $t@1387 $Snap)
(assert (= $t@1385 ($Snap.combine $t@1387 $Snap.unit)))
(declare-const $t@1388 $Snap)
(declare-const $t@1389 $Ref)
(assert (= $t@1387 ($Snap.combine $t@1388 ($SortWrappers.$RefTo$Snap $t@1389))))
(declare-const $t@1390 $Snap)
(assert (= $t@1388 ($Snap.combine $t@1390 $Snap.unit)))
(declare-const $t@1391 $Snap)
(declare-const $t@1392 $Ref)
(assert (= $t@1390 ($Snap.combine $t@1391 ($SortWrappers.$RefTo$Snap $t@1392))))
(declare-const $t@1393 $Snap)
(assert (= $t@1391 ($Snap.combine $t@1393 $Snap.unit)))
(declare-const $t@1394 $Ref)
(declare-const $t@1395 Int)
(assert (=
  $t@1393
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1394)
    ($SortWrappers.IntTo$Snap $t@1395))))
(declare-const $k@1396 $Perm)
(assert ($Perm.isValidVar $k@1396))
(assert ($Perm.isReadVar $k@1396 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1328 $k@1343)) (= $t@1394 $t@1327)))
(push) ; 4
(assert (not (not (= (+ (- $k@1328 $k@1343) $k@1396) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1328 $k@1343) $k@1396) $Perm.No)))
(assert (not (= $t@1394 $Ref.null)))
(declare-const $k@1397 $Perm)
(assert ($Perm.isValidVar $k@1397))
(assert ($Perm.isReadVar $k@1397 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1329 $k@1344)) (= $t@1395 $t@1326)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1329 $k@1344) $k@1397) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1329 $k@1344) $k@1397) $Perm.No)))
(assert (> $t@1395 0))
(declare-const $k@1398 $Perm)
(assert ($Perm.isValidVar $k@1398))
(assert ($Perm.isReadVar $k@1398 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1330 $k@1345)) (= $t@1392 $t@1323)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1330 $k@1345) $k@1398) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1330 $k@1345) $k@1398) $Perm.No)))
(assert (not (= $t@1392 $Ref.null)))
(declare-const $k@1399 $Perm)
(assert ($Perm.isValidVar $k@1399))
(assert ($Perm.isReadVar $k@1399 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1331 $k@1346)) (= $t@1389 $t@1320)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1331 $k@1346) $k@1399) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1331 $k@1346) $k@1399) $Perm.No)))
(assert (not (= $t@1389 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1400 $Perm)
(assert ($Perm.isValidVar $k@1400))
(assert ($Perm.isReadVar $k@1400 $Perm.Write))
(push) ; 4
(assert (not (= $t@1255 $t@1389)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1320 $t@1389)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1332 $k@1347)) (= $t@1386 $t@1317)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__headLock.HeadLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1255 $t@1389)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1286 $t@1389)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1320 $t@1389)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1332 $k@1347) $k@1400) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1332 $k@1347) $k@1400) $Perm.No)))
(assert (= $t@1386 $t@1394))
(declare-const $k@1401 $Perm)
(assert ($Perm.isValidVar $k@1401))
(assert ($Perm.isReadVar $k@1401 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1333 $k@1348)) (= $t@1383 $t@1314)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1333 $k@1348) $k@1401) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1333 $k@1348) $k@1401) $Perm.No)))
(assert (not (= $t@1383 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1402 $Perm)
(assert ($Perm.isValidVar $k@1402))
(assert ($Perm.isReadVar $k@1402 $Perm.Write))
(push) ; 4
(assert (not (= $t@1249 $t@1383)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1314 $t@1383)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1334 $k@1349)) (= $t@1380 $t@1311)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__lastLock.LastLock__queue == diz.LBQThread3b__queue
(push) ; 4
(assert (not (= sys__result@1241 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1293 $t@1394)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1327 $t@1394)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1249 $t@1383)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1280 $t@1383)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1314 $t@1383)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1334 $k@1349) $k@1402) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1334 $k@1349) $k@1402) $Perm.No)))
(assert (= $t@1380 $t@1394))
(pop) ; 3
(pop) ; 2
; ---------- Test__Test ----------
(declare-const sys__result@1403 $Ref)
(declare-const diz@1404 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@1403 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new()
(declare-const diz@1405 $Ref)
(assert (not (= diz@1405 $Ref.null)))
(assert (not (= sys__result@1403 diz@1405)))
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
