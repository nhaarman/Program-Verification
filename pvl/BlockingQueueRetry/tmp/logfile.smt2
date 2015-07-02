(get-info :version)
; (:version "4.3.2")
; Input file is <unknown>
; Started: 2015-07-02 12:25:22
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
; ---------- OfferPeekWorker__joinToken ----------
(declare-const diz@2 $Ref)
; ---------- PutWorker__joinToken ----------
(declare-const diz@3 $Ref)
; ---------- PutPollWorker__joinToken ----------
(declare-const diz@4 $Ref)
; ---------- TakeWorker__joinToken ----------
(declare-const diz@5 $Ref)
; ---------- OfferWorker__joinToken ----------
(declare-const diz@6 $Ref)
; ---------- Node__lock_held ----------
(declare-const diz@7 $Ref)
; ---------- HeadLock__lock_held ----------
(declare-const diz@8 $Ref)
; ---------- LastLock__lock_held ----------
(declare-const diz@9 $Ref)
; ---------- AtomicInteger__AtomicInteger ----------
(declare-const val@10 Int)
(declare-const sys__result@11 $Ref)
(declare-const diz@12 $Ref)
(declare-const __flatten_1@13 Int)
(declare-const __flatten_126@14 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@11 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(AtomicInteger__val)
(declare-const diz@15 $Ref)
(assert (not (= diz@15 $Ref.null)))
(declare-const AtomicInteger__val@16 Int)
(assert (not (= sys__result@11 diz@15)))
; [exec]
; __flatten_1 := val
; [exec]
; __flatten_126 := __flatten_1
; [exec]
; diz.AtomicInteger__val := __flatten_126
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
(declare-const diz@17 $Ref)
(declare-const sys__result@18 Int)
(declare-const res@19 Int)
(declare-const __flatten_2@20 Int)
(declare-const __flatten_3@21 Int)
(declare-const __flatten_127@22 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@17 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write)
(declare-const $t@23 Int)
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@24 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; __flatten_2 := diz.AtomicInteger__val + 1
; [eval] diz.AtomicInteger__val + 1
; [exec]
; __flatten_127 := __flatten_2
; [exec]
; diz.AtomicInteger__val := __flatten_127
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
(declare-const diz@25 $Ref)
(declare-const sys__result@26 Int)
(declare-const res@27 Int)
(declare-const __flatten_4@28 Int)
(declare-const __flatten_5@29 Int)
(declare-const __flatten_128@30 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@25 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write)
(declare-const $t@31 Int)
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@32 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; __flatten_4 := diz.AtomicInteger__val - 1
; [eval] diz.AtomicInteger__val - 1
; [exec]
; __flatten_128 := __flatten_4
; [exec]
; diz.AtomicInteger__val := __flatten_128
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
(declare-const diz@33 $Ref)
(declare-const sys__result@34 Int)
(declare-const res@35 Int)
(declare-const __flatten_6@36 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@33 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write)
(declare-const $t@37 Int)
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@38 $Snap)
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
; ---------- Integer__Integer ----------
(declare-const val@39 Int)
(declare-const sys__result@40 $Ref)
(declare-const diz@41 $Ref)
(declare-const __flatten_7@42 Int)
(declare-const __flatten_129@43 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@40 $Ref.null)))
(declare-const $k@44 $Perm)
(assert ($Perm.isValidVar $k@44))
(assert ($Perm.isReadVar $k@44 $Perm.Write))
(declare-const $t@45 Int)
; [eval] sys__result.Integer__val == val
(push) ; 4
(assert (not (not (= $k@44 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@44 $Perm.No)))
(assert (= $t@45 val@39))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(Integer__val)
(declare-const diz@46 $Ref)
(assert (not (= diz@46 $Ref.null)))
(declare-const Integer__val@47 Int)
(assert (not (= sys__result@40 diz@46)))
; [exec]
; __flatten_7 := val
; [exec]
; __flatten_129 := __flatten_7
; [exec]
; diz.Integer__val := __flatten_129
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.Integer__val, wildcard) && (sys__result.Integer__val == val)
; [eval] sys__result != null
(declare-const $k@48 $Perm)
(assert ($Perm.isValidVar $k@48))
(assert ($Perm.isReadVar $k@48 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@48 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@48 $Perm.Write))
; [eval] sys__result.Integer__val == val
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferPeekWorker__OfferPeekWorker ----------
(declare-const queue@49 $Ref)
(declare-const sys__result@50 $Ref)
(declare-const diz@51 $Ref)
(declare-const __flatten_8@52 $Ref)
(declare-const __flatten_130@53 $Ref)
(push) ; 2
(assert (not (= queue@49 $Ref.null)))
(declare-const $k@54 $Perm)
(assert ($Perm.isValidVar $k@54))
(assert ($Perm.isReadVar $k@54 $Perm.Write))
(declare-const $t@55 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@54 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@54 $Perm.No)))
(assert (> $t@55 0))
(declare-const $k@56 $Perm)
(assert ($Perm.isValidVar $k@56))
(assert ($Perm.isReadVar $k@56 $Perm.Write))
(declare-const $t@57 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@56 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@56 $Perm.No)))
(assert (not (= $t@57 $Ref.null)))
(declare-const $k@58 $Perm)
(assert ($Perm.isValidVar $k@58))
(assert ($Perm.isReadVar $k@58 $Perm.Write))
(declare-const $t@59 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@58 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@58 $Perm.No)))
(assert (not (= $t@59 $Ref.null)))
(declare-const $k@60 $Perm)
(assert ($Perm.isValidVar $k@60))
(assert ($Perm.isReadVar $k@60 $Perm.Write))
(declare-const $t@61 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@60 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@60 $Perm.No)))
(assert (= $t@61 queue@49))
(declare-const $k@62 $Perm)
(assert ($Perm.isValidVar $k@62))
(assert ($Perm.isReadVar $k@62 $Perm.Write))
(declare-const $t@63 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@62 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@62 $Perm.No)))
(assert (not (= $t@63 $Ref.null)))
(declare-const $k@64 $Perm)
(assert ($Perm.isValidVar $k@64))
(assert ($Perm.isReadVar $k@64 $Perm.Write))
(declare-const $t@65 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@64 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@64 $Perm.No)))
(assert (= $t@65 queue@49))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@50 $Ref.null)))
(declare-const $k@66 $Perm)
(assert ($Perm.isValidVar $k@66))
(assert ($Perm.isReadVar $k@66 $Perm.Write))
(declare-const $t@67 $Ref)
(push) ; 4
(assert (not (not (= $k@66 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@66 $Perm.No)))
(assert (not (= $t@67 $Ref.null)))
(declare-const $k@68 $Perm)
(assert ($Perm.isValidVar $k@68))
(assert ($Perm.isReadVar $k@68 $Perm.Write))
(declare-const $t@69 Int)
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@68 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@68 $Perm.No)))
(assert (> $t@69 0))
(declare-const $k@70 $Perm)
(assert ($Perm.isValidVar $k@70))
(assert ($Perm.isReadVar $k@70 $Perm.Write))
(declare-const $t@71 $Ref)
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@70 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@70 $Perm.No)))
(assert (not (= $t@71 $Ref.null)))
(declare-const $k@72 $Perm)
(assert ($Perm.isValidVar $k@72))
(assert ($Perm.isReadVar $k@72 $Perm.Write))
(declare-const $t@73 $Ref)
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@72 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@72 $Perm.No)))
(assert (not (= $t@73 $Ref.null)))
(declare-const $k@74 $Perm)
(assert ($Perm.isValidVar $k@74))
(assert ($Perm.isReadVar $k@74 $Perm.Write))
(declare-const $t@75 $Ref)
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@74 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@74 $Perm.No)))
(assert (= $t@75 $t@67))
(declare-const $k@76 $Perm)
(assert ($Perm.isValidVar $k@76))
(assert ($Perm.isReadVar $k@76 $Perm.Write))
(declare-const $t@77 $Ref)
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@76 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@76 $Perm.No)))
(assert (not (= $t@77 $Ref.null)))
(declare-const $k@78 $Perm)
(assert ($Perm.isValidVar $k@78))
(assert ($Perm.isReadVar $k@78 $Perm.Write))
(declare-const $t@79 $Ref)
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@78 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@78 $Perm.No)))
(assert (= $t@79 $t@67))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(OfferPeekWorker__queue)
(declare-const diz@80 $Ref)
(assert (not (= diz@80 $Ref.null)))
(declare-const OfferPeekWorker__queue@81 $Ref)
(assert (and
  (not (= queue@49 diz@80))
  (not (= sys__result@50 diz@80))
  (not (= __flatten_8@52 diz@80))
  (not (= __flatten_130@53 diz@80))
  (not (= $t@59 diz@80))
  (not (= $t@63 diz@80))
  (not (= OfferPeekWorker__queue@81 diz@80))
  (not (= $t@57 diz@80))
  (not (= $t@61 diz@80))
  (not (= $t@65 diz@80))))
; [exec]
; __flatten_8 := queue
; [exec]
; __flatten_130 := __flatten_8
; [exec]
; diz.OfferPeekWorker__queue := __flatten_130
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.OfferPeekWorker__queue, wildcard) && acc(sys__result.OfferPeekWorker__queue.BlockingQueue__capacity, wildcard) && (sys__result.OfferPeekWorker__queue.BlockingQueue__capacity > 0) && acc(sys__result.OfferPeekWorker__queue.BlockingQueue__count, wildcard) && (sys__result.OfferPeekWorker__queue.BlockingQueue__count != null) && acc(sys__result.OfferPeekWorker__queue.BlockingQueue__headLock, wildcard) && (sys__result.OfferPeekWorker__queue.BlockingQueue__headLock != null) && acc(sys__result.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferPeekWorker__queue) && acc(sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock, wildcard) && (sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock != null) && acc(sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferPeekWorker__queue)
; [eval] sys__result != null
(declare-const $k@82 $Perm)
(assert ($Perm.isValidVar $k@82))
(assert ($Perm.isReadVar $k@82 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@82 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@82 $Perm.Write))
(declare-const $k@83 $Perm)
(assert ($Perm.isValidVar $k@83))
(assert ($Perm.isReadVar $k@83 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@83 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@83 $k@54))
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@84 $Perm)
(assert ($Perm.isValidVar $k@84))
(assert ($Perm.isReadVar $k@84 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@84 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@84 $k@56))
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__count != null
(declare-const $k@85 $Perm)
(assert ($Perm.isValidVar $k@85))
(assert ($Perm.isReadVar $k@85 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@85 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@85 $k@58))
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock != null
(declare-const $k@86 $Perm)
(assert ($Perm.isValidVar $k@86))
(assert ($Perm.isReadVar $k@86 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@86 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@86 $k@60))
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferPeekWorker__queue
(declare-const $k@87 $Perm)
(assert ($Perm.isValidVar $k@87))
(assert ($Perm.isReadVar $k@87 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@87 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@87 $k@62))
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@88 $Perm)
(assert ($Perm.isValidVar $k@88))
(assert ($Perm.isReadVar $k@88 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@88 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@88 $k@64))
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferPeekWorker__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferPeekWorker__forkOperator ----------
(declare-const diz@89 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@89 $Ref.null)))
(declare-const $k@90 $Perm)
(assert ($Perm.isValidVar $k@90))
(assert ($Perm.isReadVar $k@90 $Perm.Write))
(declare-const $t@91 $Ref)
(push) ; 3
(assert (not (not (= $k@90 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@90 $Perm.No)))
(assert (not (= $t@91 $Ref.null)))
(declare-const $k@92 $Perm)
(assert ($Perm.isValidVar $k@92))
(assert ($Perm.isReadVar $k@92 $Perm.Write))
(declare-const $t@93 Int)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@92 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@92 $Perm.No)))
(assert (> $t@93 0))
(declare-const $k@94 $Perm)
(assert ($Perm.isValidVar $k@94))
(assert ($Perm.isReadVar $k@94 $Perm.Write))
(declare-const $t@95 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@94 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@94 $Perm.No)))
(assert (not (= $t@95 $Ref.null)))
(declare-const $k@96 $Perm)
(assert ($Perm.isValidVar $k@96))
(assert ($Perm.isReadVar $k@96 $Perm.Write))
(declare-const $t@97 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@96 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@96 $Perm.No)))
(assert (not (= $t@97 $Ref.null)))
(declare-const $k@98 $Perm)
(assert ($Perm.isValidVar $k@98))
(assert ($Perm.isReadVar $k@98 $Perm.Write))
(declare-const $t@99 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 3
(assert (not (not (= $k@98 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@98 $Perm.No)))
(assert (= $t@99 $t@91))
(declare-const $k@100 $Perm)
(assert ($Perm.isValidVar $k@100))
(assert ($Perm.isReadVar $k@100 $Perm.Write))
(declare-const $t@101 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@100 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@100 $Perm.No)))
(assert (not (= $t@101 $Ref.null)))
(declare-const $k@102 $Perm)
(assert ($Perm.isValidVar $k@102))
(assert ($Perm.isReadVar $k@102 $Perm.Write))
(declare-const $t@103 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 3
(assert (not (not (= $k@102 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@102 $Perm.No)))
(assert (= $t@103 $t@91))
(push) ; 3
(declare-const $t@104 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferPeekWorker__joinOperator ----------
(declare-const diz@105 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@105 $Ref.null)))
(declare-const $t@106 $Snap)
(push) ; 3
(declare-const $k@107 $Perm)
(assert ($Perm.isValidVar $k@107))
(assert ($Perm.isReadVar $k@107 $Perm.Write))
(declare-const $t@108 $Ref)
(push) ; 4
(assert (not (not (= $k@107 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@107 $Perm.No)))
(assert (not (= $t@108 $Ref.null)))
(declare-const $k@109 $Perm)
(assert ($Perm.isValidVar $k@109))
(assert ($Perm.isReadVar $k@109 $Perm.Write))
(declare-const $t@110 Int)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@109 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@109 $Perm.No)))
(assert (> $t@110 0))
(declare-const $k@111 $Perm)
(assert ($Perm.isValidVar $k@111))
(assert ($Perm.isReadVar $k@111 $Perm.Write))
(declare-const $t@112 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@111 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@111 $Perm.No)))
(assert (not (= $t@112 $Ref.null)))
(declare-const $k@113 $Perm)
(assert ($Perm.isValidVar $k@113))
(assert ($Perm.isReadVar $k@113 $Perm.Write))
(declare-const $t@114 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@113 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@113 $Perm.No)))
(assert (not (= $t@114 $Ref.null)))
(declare-const $k@115 $Perm)
(assert ($Perm.isValidVar $k@115))
(assert ($Perm.isReadVar $k@115 $Perm.Write))
(declare-const $t@116 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@115 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@115 $Perm.No)))
(assert (= $t@116 $t@108))
(declare-const $k@117 $Perm)
(assert ($Perm.isValidVar $k@117))
(assert ($Perm.isReadVar $k@117 $Perm.Write))
(declare-const $t@118 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@117 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@117 $Perm.No)))
(assert (not (= $t@118 $Ref.null)))
(declare-const $k@119 $Perm)
(assert ($Perm.isValidVar $k@119))
(assert ($Perm.isReadVar $k@119 $Perm.Write))
(declare-const $t@120 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@119 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@119 $Perm.No)))
(assert (= $t@120 $t@108))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferPeekWorker__run ----------
(declare-const diz@121 $Ref)
(declare-const b@122 Bool)
(declare-const __flatten_9@123 Bool)
(declare-const i@124 $Ref)
(declare-const __flatten_10@125 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@121 $Ref.null)))
(declare-const $k@126 $Perm)
(assert ($Perm.isValidVar $k@126))
(assert ($Perm.isReadVar $k@126 $Perm.Write))
(declare-const $t@127 $Ref)
(push) ; 3
(assert (not (not (= $k@126 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@126 $Perm.No)))
(assert (not (= $t@127 $Ref.null)))
(declare-const $k@128 $Perm)
(assert ($Perm.isValidVar $k@128))
(assert ($Perm.isReadVar $k@128 $Perm.Write))
(declare-const $t@129 Int)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@128 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@128 $Perm.No)))
(assert (> $t@129 0))
(declare-const $k@130 $Perm)
(assert ($Perm.isValidVar $k@130))
(assert ($Perm.isReadVar $k@130 $Perm.Write))
(declare-const $t@131 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
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
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@132 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@132 $Perm.No)))
(assert (not (= $t@133 $Ref.null)))
(declare-const $k@134 $Perm)
(assert ($Perm.isValidVar $k@134))
(assert ($Perm.isReadVar $k@134 $Perm.Write))
(declare-const $t@135 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 3
(assert (not (not (= $k@134 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@134 $Perm.No)))
(assert (= $t@135 $t@127))
(declare-const $k@136 $Perm)
(assert ($Perm.isValidVar $k@136))
(assert ($Perm.isReadVar $k@136 $Perm.Write))
(declare-const $t@137 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@136 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@136 $Perm.No)))
(assert (not (= $t@137 $Ref.null)))
(declare-const $k@138 $Perm)
(assert ($Perm.isValidVar $k@138))
(assert ($Perm.isReadVar $k@138 $Perm.Write))
(declare-const $t@139 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 3
(assert (not (not (= $k@138 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@138 $Perm.No)))
(assert (= $t@139 $t@127))
(push) ; 3
(declare-const $k@140 $Perm)
(assert ($Perm.isValidVar $k@140))
(assert ($Perm.isReadVar $k@140 $Perm.Write))
(declare-const $t@141 $Ref)
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
(declare-const $t@143 Int)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@142 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@142 $Perm.No)))
(assert (> $t@143 0))
(declare-const $k@144 $Perm)
(assert ($Perm.isValidVar $k@144))
(assert ($Perm.isReadVar $k@144 $Perm.Write))
(declare-const $t@145 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@144 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@144 $Perm.No)))
(assert (not (= $t@145 $Ref.null)))
(declare-const $k@146 $Perm)
(assert ($Perm.isValidVar $k@146))
(assert ($Perm.isReadVar $k@146 $Perm.Write))
(declare-const $t@147 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
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
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@148 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@148 $Perm.No)))
(assert (= $t@149 $t@141))
(declare-const $k@150 $Perm)
(assert ($Perm.isValidVar $k@150))
(assert ($Perm.isReadVar $k@150 $Perm.Write))
(declare-const $t@151 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@150 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@150 $Perm.No)))
(assert (not (= $t@151 $Ref.null)))
(declare-const $k@152 $Perm)
(assert ($Perm.isValidVar $k@152))
(assert ($Perm.isReadVar $k@152 $Perm.Write))
(declare-const $t@153 $Ref)
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@152 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@152 $Perm.No)))
(assert (= $t@153 $t@141))
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_9 := BlockingQueue__offer(diz.OfferPeekWorker__queue, 1)
; [eval] diz != null
(declare-const $k@154 $Perm)
(assert ($Perm.isValidVar $k@154))
(assert ($Perm.isReadVar $k@154 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@154 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@154 $k@128))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@155 $Perm)
(assert ($Perm.isValidVar $k@155))
(assert ($Perm.isReadVar $k@155 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@155 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@155 $k@130))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@156 $Perm)
(assert ($Perm.isValidVar $k@156))
(assert ($Perm.isReadVar $k@156 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@156 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@156 $k@132))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@157 $Perm)
(assert ($Perm.isValidVar $k@157))
(assert ($Perm.isReadVar $k@157 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@157 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@157 $k@134))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@158 $Perm)
(assert ($Perm.isValidVar $k@158))
(assert ($Perm.isReadVar $k@158 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@158 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@158 $k@136))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@159 $Perm)
(assert ($Perm.isValidVar $k@159))
(assert ($Perm.isReadVar $k@159 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@159 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@159 $k@138))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@160 Bool)
(declare-const $t@161 $Snap)
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
(declare-const $t@171 $Snap)
(assert (= $t@169 ($Snap.combine $t@171 $Snap.unit)))
(declare-const $t@172 $Snap)
(declare-const $t@173 $Ref)
(assert (= $t@171 ($Snap.combine $t@172 ($SortWrappers.$RefTo$Snap $t@173))))
(declare-const $t@174 $Snap)
(assert (= $t@172 ($Snap.combine $t@174 $Snap.unit)))
(declare-const $t@175 Int)
(declare-const $t@176 $Ref)
(assert (=
  $t@174
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@175)
    ($SortWrappers.$RefTo$Snap $t@176))))
(declare-const $t@177 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@175)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@177) $Snap.unit)))
(declare-const $k@178 $Perm)
(assert ($Perm.isValidVar $k@178))
(assert ($Perm.isReadVar $k@178 $Perm.Write))
(assert (implies (< $Perm.No (- $k@128 $k@154)) (= $t@177 $t@129)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@128 $k@154) $k@178) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@128 $k@154) $k@178) $Perm.No)))
(assert (> $t@177 0))
(declare-const $k@179 $Perm)
(assert ($Perm.isValidVar $k@179))
(assert ($Perm.isReadVar $k@179 $Perm.Write))
(assert (implies (< $Perm.No (- $k@130 $k@155)) (= $t@176 $t@131)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@130 $k@155) $k@179) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@130 $k@155) $k@179) $Perm.No)))
(assert (not (= $t@176 $Ref.null)))
(declare-const $k@180 $Perm)
(assert ($Perm.isValidVar $k@180))
(assert ($Perm.isReadVar $k@180 $Perm.Write))
(assert (implies (< $Perm.No (- $k@132 $k@156)) (= $t@173 $t@133)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@132 $k@156) $k@180) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@132 $k@156) $k@180) $Perm.No)))
(assert (not (= $t@173 $Ref.null)))
(declare-const $k@181 $Perm)
(assert ($Perm.isValidVar $k@181))
(assert ($Perm.isReadVar $k@181 $Perm.Write))
(push) ; 4
(assert (not (= $t@133 $t@173)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@134 $k@157)) (= $t@170 $t@135)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@133 $t@173)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@134 $k@157) $k@181) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@134 $k@157) $k@181) $Perm.No)))
(assert (= $t@170 $t@127))
(declare-const $k@182 $Perm)
(assert ($Perm.isValidVar $k@182))
(assert ($Perm.isReadVar $k@182 $Perm.Write))
(assert (implies (< $Perm.No (- $k@136 $k@158)) (= $t@167 $t@137)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@136 $k@158) $k@182) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@136 $k@158) $k@182) $Perm.No)))
(assert (not (= $t@167 $Ref.null)))
(declare-const $k@183 $Perm)
(assert ($Perm.isValidVar $k@183))
(assert ($Perm.isReadVar $k@183 $Perm.Write))
(push) ; 4
(assert (not (= $t@137 $t@167)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@138 $k@159)) (= $t@164 $t@139)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@137 $t@167)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@138 $k@159) $k@183) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@138 $k@159) $k@183) $Perm.No)))
(assert (= $t@164 $t@127))
; [exec]
; b := __flatten_9
; [exec]
; __flatten_10 := BlockingQueue__peek(diz.OfferPeekWorker__queue)
; [eval] diz != null
(declare-const $k@184 $Perm)
(assert ($Perm.isValidVar $k@184))
(assert ($Perm.isReadVar $k@184 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@184 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@184 (+ (- $k@128 $k@154) $k@178)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@185 $Perm)
(assert ($Perm.isValidVar $k@185))
(assert ($Perm.isReadVar $k@185 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@185 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@185 (+ (- $k@130 $k@155) $k@179)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@186 $Perm)
(assert ($Perm.isValidVar $k@186))
(assert ($Perm.isReadVar $k@186 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@186 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@186 (+ (- $k@132 $k@156) $k@180)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@187 $Perm)
(assert ($Perm.isValidVar $k@187))
(assert ($Perm.isReadVar $k@187 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@187 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@133 $t@173)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@187 (+ (- $k@134 $k@157) $k@181)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@133 $t@173)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@188 $Perm)
(assert ($Perm.isValidVar $k@188))
(assert ($Perm.isReadVar $k@188 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@188 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@188 (+ (- $k@136 $k@158) $k@182)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@189 $Perm)
(assert ($Perm.isValidVar $k@189))
(assert ($Perm.isReadVar $k@189 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@189 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@137 $t@167)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@189 (+ (- $k@138 $k@159) $k@183)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@137 $t@167)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@190 $Ref)
(declare-const $t@191 $Snap)
(declare-const $t@192 $Snap)
(assert (= $t@191 ($Snap.combine $t@192 $Snap.unit)))
(declare-const $t@193 $Snap)
(declare-const $t@194 $Ref)
(assert (= $t@192 ($Snap.combine $t@193 ($SortWrappers.$RefTo$Snap $t@194))))
(declare-const $t@195 $Snap)
(assert (= $t@193 ($Snap.combine $t@195 $Snap.unit)))
(declare-const $t@196 $Snap)
(declare-const $t@197 $Ref)
(assert (= $t@195 ($Snap.combine $t@196 ($SortWrappers.$RefTo$Snap $t@197))))
(declare-const $t@198 $Snap)
(assert (= $t@196 ($Snap.combine $t@198 $Snap.unit)))
(declare-const $t@199 $Snap)
(declare-const $t@200 $Ref)
(assert (= $t@198 ($Snap.combine $t@199 ($SortWrappers.$RefTo$Snap $t@200))))
(declare-const $t@201 $Snap)
(assert (= $t@199 ($Snap.combine $t@201 $Snap.unit)))
(declare-const $t@202 $Snap)
(declare-const $t@203 $Ref)
(assert (= $t@201 ($Snap.combine $t@202 ($SortWrappers.$RefTo$Snap $t@203))))
(declare-const $t@204 $Snap)
(assert (= $t@202 ($Snap.combine $t@204 $Snap.unit)))
(declare-const $t@205 Int)
(declare-const $t@206 $Ref)
(assert (=
  $t@204
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@205)
    ($SortWrappers.$RefTo$Snap $t@206))))
(declare-const $t@207 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@205)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@207) $Snap.unit)))
(declare-const $k@208 $Perm)
(assert ($Perm.isValidVar $k@208))
(assert ($Perm.isReadVar $k@208 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@128 $k@154) $k@178) $k@184)) (= $t@207 $t@177)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@128 $k@154) $k@178) $k@184) $k@208) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@128 $k@154) $k@178) $k@184) $k@208) $Perm.No)))
(assert (> $t@207 0))
(declare-const $k@209 $Perm)
(assert ($Perm.isValidVar $k@209))
(assert ($Perm.isReadVar $k@209 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@130 $k@155) $k@179) $k@185)) (= $t@206 $t@176)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@130 $k@155) $k@179) $k@185) $k@209) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@130 $k@155) $k@179) $k@185) $k@209) $Perm.No)))
(assert (not (= $t@206 $Ref.null)))
(declare-const $k@210 $Perm)
(assert ($Perm.isValidVar $k@210))
(assert ($Perm.isReadVar $k@210 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@132 $k@156) $k@180) $k@186)) (= $t@203 $t@173)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@132 $k@156) $k@180) $k@186) $k@210) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@132 $k@156) $k@180) $k@186) $k@210) $Perm.No)))
(assert (not (= $t@203 $Ref.null)))
(declare-const $k@211 $Perm)
(assert ($Perm.isValidVar $k@211))
(assert ($Perm.isReadVar $k@211 $Perm.Write))
(push) ; 4
(assert (not (= $t@133 $t@203)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@134 $k@157) $k@181) $k@187)) (= $t@200 $t@170)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@133 $t@203)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@134 $k@157) $k@181) $k@187) $k@211) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@134 $k@157) $k@181) $k@187) $k@211) $Perm.No)))
(assert (= $t@200 $t@127))
(declare-const $k@212 $Perm)
(assert ($Perm.isValidVar $k@212))
(assert ($Perm.isReadVar $k@212 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@136 $k@158) $k@182) $k@188)) (= $t@197 $t@167)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@136 $k@158) $k@182) $k@188) $k@212) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@136 $k@158) $k@182) $k@188) $k@212) $Perm.No)))
(assert (not (= $t@197 $Ref.null)))
(declare-const $k@213 $Perm)
(assert ($Perm.isValidVar $k@213))
(assert ($Perm.isReadVar $k@213 $Perm.Write))
(push) ; 4
(assert (not (= $t@137 $t@197)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@138 $k@159) $k@183) $k@189)) (= $t@194 $t@164)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@137 $t@197)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@138 $k@159) $k@183) $k@189) $k@213) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@138 $k@159) $k@183) $k@189) $k@213) $Perm.No)))
(assert (= $t@194 $t@127))
; [exec]
; i := __flatten_10
(declare-const $k@214 $Perm)
(assert ($Perm.isValidVar $k@214))
(assert ($Perm.isReadVar $k@214 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@214 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@214 $k@126))
(declare-const $k@215 $Perm)
(assert ($Perm.isValidVar $k@215))
(assert ($Perm.isReadVar $k@215 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@215 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@215 (+ (- (+ (- $k@128 $k@154) $k@178) $k@184) $k@208)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@216 $Perm)
(assert ($Perm.isValidVar $k@216))
(assert ($Perm.isReadVar $k@216 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@216 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@216 (+ (- (+ (- $k@130 $k@155) $k@179) $k@185) $k@209)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(declare-const $k@217 $Perm)
(assert ($Perm.isValidVar $k@217))
(assert ($Perm.isReadVar $k@217 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@217 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@217 (+ (- (+ (- $k@132 $k@156) $k@180) $k@186) $k@210)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(declare-const $k@218 $Perm)
(assert ($Perm.isValidVar $k@218))
(assert ($Perm.isReadVar $k@218 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@218 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@133 $t@203)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@218 (+ (- (+ (- $k@134 $k@157) $k@181) $k@187) $k@211)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (= $t@133 $t@203)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@219 $Perm)
(assert ($Perm.isValidVar $k@219))
(assert ($Perm.isReadVar $k@219 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@219 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@219 (+ (- (+ (- $k@136 $k@158) $k@182) $k@188) $k@212)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@220 $Perm)
(assert ($Perm.isValidVar $k@220))
(assert ($Perm.isReadVar $k@220 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@220 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@137 $t@197)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@220 (+ (- (+ (- $k@138 $k@159) $k@183) $k@189) $k@213)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (= $t@137 $t@197)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- PutWorker__PutWorker ----------
(declare-const queue@221 $Ref)
(declare-const sys__result@222 $Ref)
(declare-const diz@223 $Ref)
(declare-const __flatten_11@224 $Ref)
(declare-const __flatten_133@225 $Ref)
(push) ; 2
(assert (not (= queue@221 $Ref.null)))
(declare-const $k@226 $Perm)
(assert ($Perm.isValidVar $k@226))
(assert ($Perm.isReadVar $k@226 $Perm.Write))
(declare-const $t@227 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@226 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@226 $Perm.No)))
(assert (> $t@227 0))
(declare-const $k@228 $Perm)
(assert ($Perm.isValidVar $k@228))
(assert ($Perm.isReadVar $k@228 $Perm.Write))
(declare-const $t@229 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@228 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@228 $Perm.No)))
(assert (not (= $t@229 $Ref.null)))
(declare-const $k@230 $Perm)
(assert ($Perm.isValidVar $k@230))
(assert ($Perm.isReadVar $k@230 $Perm.Write))
(declare-const $t@231 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@230 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@230 $Perm.No)))
(assert (not (= $t@231 $Ref.null)))
(declare-const $k@232 $Perm)
(assert ($Perm.isValidVar $k@232))
(assert ($Perm.isReadVar $k@232 $Perm.Write))
(declare-const $t@233 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@232 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@232 $Perm.No)))
(assert (= $t@233 queue@221))
(declare-const $k@234 $Perm)
(assert ($Perm.isValidVar $k@234))
(assert ($Perm.isReadVar $k@234 $Perm.Write))
(declare-const $t@235 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@234 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@234 $Perm.No)))
(assert (not (= $t@235 $Ref.null)))
(declare-const $k@236 $Perm)
(assert ($Perm.isValidVar $k@236))
(assert ($Perm.isReadVar $k@236 $Perm.Write))
(declare-const $t@237 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@236 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@236 $Perm.No)))
(assert (= $t@237 queue@221))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@222 $Ref.null)))
(declare-const $k@238 $Perm)
(assert ($Perm.isValidVar $k@238))
(assert ($Perm.isReadVar $k@238 $Perm.Write))
(declare-const $t@239 $Ref)
(push) ; 4
(assert (not (not (= $k@238 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@238 $Perm.No)))
(assert (not (= $t@239 $Ref.null)))
(declare-const $k@240 $Perm)
(assert ($Perm.isValidVar $k@240))
(assert ($Perm.isReadVar $k@240 $Perm.Write))
(declare-const $t@241 Int)
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@240 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@240 $Perm.No)))
(assert (> $t@241 0))
(declare-const $k@242 $Perm)
(assert ($Perm.isValidVar $k@242))
(assert ($Perm.isReadVar $k@242 $Perm.Write))
(declare-const $t@243 $Ref)
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@242 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@242 $Perm.No)))
(assert (not (= $t@243 $Ref.null)))
(declare-const $k@244 $Perm)
(assert ($Perm.isValidVar $k@244))
(assert ($Perm.isReadVar $k@244 $Perm.Write))
(declare-const $t@245 $Ref)
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@244 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@244 $Perm.No)))
(assert (not (= $t@245 $Ref.null)))
(declare-const $k@246 $Perm)
(assert ($Perm.isValidVar $k@246))
(assert ($Perm.isReadVar $k@246 $Perm.Write))
(declare-const $t@247 $Ref)
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@246 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@246 $Perm.No)))
(assert (= $t@247 $t@239))
(declare-const $k@248 $Perm)
(assert ($Perm.isValidVar $k@248))
(assert ($Perm.isReadVar $k@248 $Perm.Write))
(declare-const $t@249 $Ref)
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@248 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@248 $Perm.No)))
(assert (not (= $t@249 $Ref.null)))
(declare-const $k@250 $Perm)
(assert ($Perm.isValidVar $k@250))
(assert ($Perm.isReadVar $k@250 $Perm.Write))
(declare-const $t@251 $Ref)
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@250 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@250 $Perm.No)))
(assert (= $t@251 $t@239))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(PutWorker__queue)
(declare-const diz@252 $Ref)
(assert (not (= diz@252 $Ref.null)))
(declare-const PutWorker__queue@253 $Ref)
(assert (and
  (not (= queue@221 diz@252))
  (not (= sys__result@222 diz@252))
  (not (= __flatten_11@224 diz@252))
  (not (= __flatten_133@225 diz@252))
  (not (= $t@231 diz@252))
  (not (= $t@235 diz@252))
  (not (= PutWorker__queue@253 diz@252))
  (not (= $t@229 diz@252))
  (not (= $t@233 diz@252))
  (not (= $t@237 diz@252))))
; [exec]
; __flatten_11 := queue
; [exec]
; __flatten_133 := __flatten_11
; [exec]
; diz.PutWorker__queue := __flatten_133
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.PutWorker__queue, wildcard) && acc(sys__result.PutWorker__queue.BlockingQueue__capacity, wildcard) && (sys__result.PutWorker__queue.BlockingQueue__capacity > 0) && acc(sys__result.PutWorker__queue.BlockingQueue__count, wildcard) && (sys__result.PutWorker__queue.BlockingQueue__count != null) && acc(sys__result.PutWorker__queue.BlockingQueue__headLock, wildcard) && (sys__result.PutWorker__queue.BlockingQueue__headLock != null) && acc(sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue) && acc(sys__result.PutWorker__queue.BlockingQueue__lastLock, wildcard) && (sys__result.PutWorker__queue.BlockingQueue__lastLock != null) && acc(sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue)
; [eval] sys__result != null
(declare-const $k@254 $Perm)
(assert ($Perm.isValidVar $k@254))
(assert ($Perm.isReadVar $k@254 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@254 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@254 $Perm.Write))
(declare-const $k@255 $Perm)
(assert ($Perm.isValidVar $k@255))
(assert ($Perm.isReadVar $k@255 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@255 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@255 $k@226))
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@256 $Perm)
(assert ($Perm.isValidVar $k@256))
(assert ($Perm.isReadVar $k@256 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@256 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@256 $k@228))
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@257 $Perm)
(assert ($Perm.isValidVar $k@257))
(assert ($Perm.isReadVar $k@257 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@257 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@257 $k@230))
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@258 $Perm)
(assert ($Perm.isValidVar $k@258))
(assert ($Perm.isReadVar $k@258 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@258 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@258 $k@232))
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(declare-const $k@259 $Perm)
(assert ($Perm.isValidVar $k@259))
(assert ($Perm.isReadVar $k@259 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@259 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@259 $k@234))
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@260 $Perm)
(assert ($Perm.isValidVar $k@260))
(assert ($Perm.isReadVar $k@260 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@260 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@260 $k@236))
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- PutWorker__forkOperator ----------
(declare-const diz@261 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@261 $Ref.null)))
(declare-const $k@262 $Perm)
(assert ($Perm.isValidVar $k@262))
(assert ($Perm.isReadVar $k@262 $Perm.Write))
(declare-const $t@263 $Ref)
(push) ; 3
(assert (not (not (= $k@262 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@262 $Perm.No)))
(assert (not (= $t@263 $Ref.null)))
(declare-const $k@264 $Perm)
(assert ($Perm.isValidVar $k@264))
(assert ($Perm.isReadVar $k@264 $Perm.Write))
(declare-const $t@265 Int)
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@264 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@264 $Perm.No)))
(assert (> $t@265 0))
(declare-const $k@266 $Perm)
(assert ($Perm.isValidVar $k@266))
(assert ($Perm.isReadVar $k@266 $Perm.Write))
(declare-const $t@267 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@266 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@266 $Perm.No)))
(assert (not (= $t@267 $Ref.null)))
(declare-const $k@268 $Perm)
(assert ($Perm.isValidVar $k@268))
(assert ($Perm.isReadVar $k@268 $Perm.Write))
(declare-const $t@269 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@268 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@268 $Perm.No)))
(assert (not (= $t@269 $Ref.null)))
(declare-const $k@270 $Perm)
(assert ($Perm.isValidVar $k@270))
(assert ($Perm.isReadVar $k@270 $Perm.Write))
(declare-const $t@271 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 3
(assert (not (not (= $k@270 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@270 $Perm.No)))
(assert (= $t@271 $t@263))
(declare-const $k@272 $Perm)
(assert ($Perm.isValidVar $k@272))
(assert ($Perm.isReadVar $k@272 $Perm.Write))
(declare-const $t@273 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@272 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@272 $Perm.No)))
(assert (not (= $t@273 $Ref.null)))
(declare-const $k@274 $Perm)
(assert ($Perm.isValidVar $k@274))
(assert ($Perm.isReadVar $k@274 $Perm.Write))
(declare-const $t@275 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 3
(assert (not (not (= $k@274 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@274 $Perm.No)))
(assert (= $t@275 $t@263))
(push) ; 3
(declare-const $t@276 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- PutWorker__joinOperator ----------
(declare-const diz@277 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@277 $Ref.null)))
(declare-const $t@278 $Snap)
(push) ; 3
(declare-const $k@279 $Perm)
(assert ($Perm.isValidVar $k@279))
(assert ($Perm.isReadVar $k@279 $Perm.Write))
(declare-const $t@280 $Ref)
(push) ; 4
(assert (not (not (= $k@279 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@279 $Perm.No)))
(assert (not (= $t@280 $Ref.null)))
(declare-const $k@281 $Perm)
(assert ($Perm.isValidVar $k@281))
(assert ($Perm.isReadVar $k@281 $Perm.Write))
(declare-const $t@282 Int)
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@281 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@281 $Perm.No)))
(assert (> $t@282 0))
(declare-const $k@283 $Perm)
(assert ($Perm.isValidVar $k@283))
(assert ($Perm.isReadVar $k@283 $Perm.Write))
(declare-const $t@284 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@283 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@283 $Perm.No)))
(assert (not (= $t@284 $Ref.null)))
(declare-const $k@285 $Perm)
(assert ($Perm.isValidVar $k@285))
(assert ($Perm.isReadVar $k@285 $Perm.Write))
(declare-const $t@286 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@285 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@285 $Perm.No)))
(assert (not (= $t@286 $Ref.null)))
(declare-const $k@287 $Perm)
(assert ($Perm.isValidVar $k@287))
(assert ($Perm.isReadVar $k@287 $Perm.Write))
(declare-const $t@288 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@287 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@287 $Perm.No)))
(assert (= $t@288 $t@280))
(declare-const $k@289 $Perm)
(assert ($Perm.isValidVar $k@289))
(assert ($Perm.isReadVar $k@289 $Perm.Write))
(declare-const $t@290 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@289 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@289 $Perm.No)))
(assert (not (= $t@290 $Ref.null)))
(declare-const $k@291 $Perm)
(assert ($Perm.isValidVar $k@291))
(assert ($Perm.isReadVar $k@291 $Perm.Write))
(declare-const $t@292 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@291 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@291 $Perm.No)))
(assert (= $t@292 $t@280))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- PutWorker__run ----------
(declare-const diz@293 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@293 $Ref.null)))
(declare-const $k@294 $Perm)
(assert ($Perm.isValidVar $k@294))
(assert ($Perm.isReadVar $k@294 $Perm.Write))
(declare-const $t@295 $Ref)
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
(declare-const $t@297 Int)
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@296 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@296 $Perm.No)))
(assert (> $t@297 0))
(declare-const $k@298 $Perm)
(assert ($Perm.isValidVar $k@298))
(assert ($Perm.isReadVar $k@298 $Perm.Write))
(declare-const $t@299 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
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
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@300 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@300 $Perm.No)))
(assert (not (= $t@301 $Ref.null)))
(declare-const $k@302 $Perm)
(assert ($Perm.isValidVar $k@302))
(assert ($Perm.isReadVar $k@302 $Perm.Write))
(declare-const $t@303 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 3
(assert (not (not (= $k@302 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@302 $Perm.No)))
(assert (= $t@303 $t@295))
(declare-const $k@304 $Perm)
(assert ($Perm.isValidVar $k@304))
(assert ($Perm.isReadVar $k@304 $Perm.Write))
(declare-const $t@305 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@304 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@304 $Perm.No)))
(assert (not (= $t@305 $Ref.null)))
(declare-const $k@306 $Perm)
(assert ($Perm.isValidVar $k@306))
(assert ($Perm.isReadVar $k@306 $Perm.Write))
(declare-const $t@307 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 3
(assert (not (not (= $k@306 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@306 $Perm.No)))
(assert (= $t@307 $t@295))
(push) ; 3
(declare-const $k@308 $Perm)
(assert ($Perm.isValidVar $k@308))
(assert ($Perm.isReadVar $k@308 $Perm.Write))
(declare-const $t@309 $Ref)
(push) ; 4
(assert (not (not (= $k@308 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@308 $Perm.No)))
(assert (not (= $t@309 $Ref.null)))
(declare-const $k@310 $Perm)
(assert ($Perm.isValidVar $k@310))
(assert ($Perm.isReadVar $k@310 $Perm.Write))
(declare-const $t@311 Int)
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@310 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@310 $Perm.No)))
(assert (> $t@311 0))
(declare-const $k@312 $Perm)
(assert ($Perm.isValidVar $k@312))
(assert ($Perm.isReadVar $k@312 $Perm.Write))
(declare-const $t@313 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@312 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@312 $Perm.No)))
(assert (not (= $t@313 $Ref.null)))
(declare-const $k@314 $Perm)
(assert ($Perm.isValidVar $k@314))
(assert ($Perm.isReadVar $k@314 $Perm.Write))
(declare-const $t@315 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@314 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@314 $Perm.No)))
(assert (not (= $t@315 $Ref.null)))
(declare-const $k@316 $Perm)
(assert ($Perm.isValidVar $k@316))
(assert ($Perm.isReadVar $k@316 $Perm.Write))
(declare-const $t@317 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@316 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@316 $Perm.No)))
(assert (= $t@317 $t@309))
(declare-const $k@318 $Perm)
(assert ($Perm.isValidVar $k@318))
(assert ($Perm.isReadVar $k@318 $Perm.Write))
(declare-const $t@319 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@318 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@318 $Perm.No)))
(assert (not (= $t@319 $Ref.null)))
(declare-const $k@320 $Perm)
(assert ($Perm.isValidVar $k@320))
(assert ($Perm.isReadVar $k@320 $Perm.Write))
(declare-const $t@321 $Ref)
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@320 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@320 $Perm.No)))
(assert (= $t@321 $t@309))
(pop) ; 3
(push) ; 3
; [exec]
; BlockingQueue__put(diz.PutWorker__queue, 1)
; [eval] diz != null
(declare-const $k@322 $Perm)
(assert ($Perm.isValidVar $k@322))
(assert ($Perm.isReadVar $k@322 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@322 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@322 $k@296))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@323 $Perm)
(assert ($Perm.isValidVar $k@323))
(assert ($Perm.isReadVar $k@323 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@323 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@323 $k@298))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@324 $Perm)
(assert ($Perm.isValidVar $k@324))
(assert ($Perm.isReadVar $k@324 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@324 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@324 $k@300))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@325 $Perm)
(assert ($Perm.isValidVar $k@325))
(assert ($Perm.isReadVar $k@325 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@325 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@325 $k@302))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@326 $Perm)
(assert ($Perm.isValidVar $k@326))
(assert ($Perm.isReadVar $k@326 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@326 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@326 $k@304))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@327 $Perm)
(assert ($Perm.isValidVar $k@327))
(assert ($Perm.isReadVar $k@327 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@327 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@327 $k@306))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const $t@328 $Snap)
(declare-const $t@329 $Snap)
(assert (= $t@328 ($Snap.combine $t@329 $Snap.unit)))
(declare-const $t@330 $Snap)
(declare-const $t@331 $Ref)
(assert (= $t@329 ($Snap.combine $t@330 ($SortWrappers.$RefTo$Snap $t@331))))
(declare-const $t@332 $Snap)
(assert (= $t@330 ($Snap.combine $t@332 $Snap.unit)))
(declare-const $t@333 $Snap)
(declare-const $t@334 $Ref)
(assert (= $t@332 ($Snap.combine $t@333 ($SortWrappers.$RefTo$Snap $t@334))))
(declare-const $t@335 $Snap)
(assert (= $t@333 ($Snap.combine $t@335 $Snap.unit)))
(declare-const $t@336 $Snap)
(declare-const $t@337 $Ref)
(assert (= $t@335 ($Snap.combine $t@336 ($SortWrappers.$RefTo$Snap $t@337))))
(declare-const $t@338 $Snap)
(assert (= $t@336 ($Snap.combine $t@338 $Snap.unit)))
(declare-const $t@339 $Snap)
(declare-const $t@340 $Ref)
(assert (= $t@338 ($Snap.combine $t@339 ($SortWrappers.$RefTo$Snap $t@340))))
(declare-const $t@341 $Snap)
(assert (= $t@339 ($Snap.combine $t@341 $Snap.unit)))
(declare-const $t@342 Int)
(declare-const $t@343 $Ref)
(assert (=
  $t@341
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@342)
    ($SortWrappers.$RefTo$Snap $t@343))))
(declare-const $t@344 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@342)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@344) $Snap.unit)))
(declare-const $k@345 $Perm)
(assert ($Perm.isValidVar $k@345))
(assert ($Perm.isReadVar $k@345 $Perm.Write))
(assert (implies (< $Perm.No (- $k@296 $k@322)) (= $t@344 $t@297)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@296 $k@322) $k@345) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@296 $k@322) $k@345) $Perm.No)))
(assert (> $t@344 0))
(declare-const $k@346 $Perm)
(assert ($Perm.isValidVar $k@346))
(assert ($Perm.isReadVar $k@346 $Perm.Write))
(assert (implies (< $Perm.No (- $k@298 $k@323)) (= $t@343 $t@299)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@298 $k@323) $k@346) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@298 $k@323) $k@346) $Perm.No)))
(assert (not (= $t@343 $Ref.null)))
(declare-const $k@347 $Perm)
(assert ($Perm.isValidVar $k@347))
(assert ($Perm.isReadVar $k@347 $Perm.Write))
(assert (implies (< $Perm.No (- $k@300 $k@324)) (= $t@340 $t@301)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@300 $k@324) $k@347) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@300 $k@324) $k@347) $Perm.No)))
(assert (not (= $t@340 $Ref.null)))
(declare-const $k@348 $Perm)
(assert ($Perm.isValidVar $k@348))
(assert ($Perm.isReadVar $k@348 $Perm.Write))
(push) ; 4
(assert (not (= $t@301 $t@340)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@302 $k@325)) (= $t@337 $t@303)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@301 $t@340)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@302 $k@325) $k@348) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@302 $k@325) $k@348) $Perm.No)))
(assert (= $t@337 $t@295))
(declare-const $k@349 $Perm)
(assert ($Perm.isValidVar $k@349))
(assert ($Perm.isReadVar $k@349 $Perm.Write))
(assert (implies (< $Perm.No (- $k@304 $k@326)) (= $t@334 $t@305)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@304 $k@326) $k@349) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@304 $k@326) $k@349) $Perm.No)))
(assert (not (= $t@334 $Ref.null)))
(declare-const $k@350 $Perm)
(assert ($Perm.isValidVar $k@350))
(assert ($Perm.isReadVar $k@350 $Perm.Write))
(push) ; 4
(assert (not (= $t@305 $t@334)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@306 $k@327)) (= $t@331 $t@307)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@305 $t@334)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@306 $k@327) $k@350) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@306 $k@327) $k@350) $Perm.No)))
(assert (= $t@331 $t@295))
(declare-const $k@351 $Perm)
(assert ($Perm.isValidVar $k@351))
(assert ($Perm.isReadVar $k@351 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@351 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@351 $k@294))
(declare-const $k@352 $Perm)
(assert ($Perm.isValidVar $k@352))
(assert ($Perm.isReadVar $k@352 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@352 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@352 (+ (- $k@296 $k@322) $k@345)))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@353 $Perm)
(assert ($Perm.isValidVar $k@353))
(assert ($Perm.isReadVar $k@353 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@353 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@353 (+ (- $k@298 $k@323) $k@346)))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@354 $Perm)
(assert ($Perm.isValidVar $k@354))
(assert ($Perm.isReadVar $k@354 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@354 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@354 (+ (- $k@300 $k@324) $k@347)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@355 $Perm)
(assert ($Perm.isValidVar $k@355))
(assert ($Perm.isReadVar $k@355 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@355 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@301 $t@340)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@355 (+ (- $k@302 $k@325) $k@348)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= $t@301 $t@340)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@356 $Perm)
(assert ($Perm.isValidVar $k@356))
(assert ($Perm.isReadVar $k@356 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@356 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@356 (+ (- $k@304 $k@326) $k@349)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@357 $Perm)
(assert ($Perm.isValidVar $k@357))
(assert ($Perm.isReadVar $k@357 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@357 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@305 $t@334)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@357 (+ (- $k@306 $k@327) $k@350)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= $t@305 $t@334)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- PutPollWorker__PutPollWorker ----------
(declare-const queue@358 $Ref)
(declare-const sys__result@359 $Ref)
(declare-const diz@360 $Ref)
(declare-const __flatten_13@361 $Ref)
(declare-const __flatten_135@362 $Ref)
(push) ; 2
(assert (not (= queue@358 $Ref.null)))
(declare-const $k@363 $Perm)
(assert ($Perm.isValidVar $k@363))
(assert ($Perm.isReadVar $k@363 $Perm.Write))
(declare-const $t@364 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@363 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@363 $Perm.No)))
(assert (> $t@364 0))
(declare-const $k@365 $Perm)
(assert ($Perm.isValidVar $k@365))
(assert ($Perm.isReadVar $k@365 $Perm.Write))
(declare-const $t@366 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@365 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@365 $Perm.No)))
(assert (not (= $t@366 $Ref.null)))
(declare-const $k@367 $Perm)
(assert ($Perm.isValidVar $k@367))
(assert ($Perm.isReadVar $k@367 $Perm.Write))
(declare-const $t@368 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@367 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@367 $Perm.No)))
(assert (not (= $t@368 $Ref.null)))
(declare-const $k@369 $Perm)
(assert ($Perm.isValidVar $k@369))
(assert ($Perm.isReadVar $k@369 $Perm.Write))
(declare-const $t@370 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@369 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@369 $Perm.No)))
(assert (= $t@370 queue@358))
(declare-const $k@371 $Perm)
(assert ($Perm.isValidVar $k@371))
(assert ($Perm.isReadVar $k@371 $Perm.Write))
(declare-const $t@372 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@371 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@371 $Perm.No)))
(assert (not (= $t@372 $Ref.null)))
(declare-const $k@373 $Perm)
(assert ($Perm.isValidVar $k@373))
(assert ($Perm.isReadVar $k@373 $Perm.Write))
(declare-const $t@374 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@373 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@373 $Perm.No)))
(assert (= $t@374 queue@358))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@359 $Ref.null)))
(declare-const $k@375 $Perm)
(assert ($Perm.isValidVar $k@375))
(assert ($Perm.isReadVar $k@375 $Perm.Write))
(declare-const $t@376 $Ref)
(push) ; 4
(assert (not (not (= $k@375 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@375 $Perm.No)))
(assert (not (= $t@376 $Ref.null)))
(declare-const $k@377 $Perm)
(assert ($Perm.isValidVar $k@377))
(assert ($Perm.isReadVar $k@377 $Perm.Write))
(declare-const $t@378 Int)
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@377 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@377 $Perm.No)))
(assert (> $t@378 0))
(declare-const $k@379 $Perm)
(assert ($Perm.isValidVar $k@379))
(assert ($Perm.isReadVar $k@379 $Perm.Write))
(declare-const $t@380 $Ref)
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@379 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@379 $Perm.No)))
(assert (not (= $t@380 $Ref.null)))
(declare-const $k@381 $Perm)
(assert ($Perm.isValidVar $k@381))
(assert ($Perm.isReadVar $k@381 $Perm.Write))
(declare-const $t@382 $Ref)
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@381 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@381 $Perm.No)))
(assert (not (= $t@382 $Ref.null)))
(declare-const $k@383 $Perm)
(assert ($Perm.isValidVar $k@383))
(assert ($Perm.isReadVar $k@383 $Perm.Write))
(declare-const $t@384 $Ref)
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@383 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@383 $Perm.No)))
(assert (= $t@384 $t@376))
(declare-const $k@385 $Perm)
(assert ($Perm.isValidVar $k@385))
(assert ($Perm.isReadVar $k@385 $Perm.Write))
(declare-const $t@386 $Ref)
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@385 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@385 $Perm.No)))
(assert (not (= $t@386 $Ref.null)))
(declare-const $k@387 $Perm)
(assert ($Perm.isValidVar $k@387))
(assert ($Perm.isReadVar $k@387 $Perm.Write))
(declare-const $t@388 $Ref)
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@387 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@387 $Perm.No)))
(assert (= $t@388 $t@376))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(PutPollWorker__queue)
(declare-const diz@389 $Ref)
(assert (not (= diz@389 $Ref.null)))
(declare-const PutPollWorker__queue@390 $Ref)
(assert (and
  (not (= queue@358 diz@389))
  (not (= sys__result@359 diz@389))
  (not (= __flatten_13@361 diz@389))
  (not (= __flatten_135@362 diz@389))
  (not (= $t@368 diz@389))
  (not (= $t@372 diz@389))
  (not (= PutPollWorker__queue@390 diz@389))
  (not (= $t@366 diz@389))
  (not (= $t@370 diz@389))
  (not (= $t@374 diz@389))))
; [exec]
; __flatten_13 := queue
; [exec]
; __flatten_135 := __flatten_13
; [exec]
; diz.PutPollWorker__queue := __flatten_135
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.PutPollWorker__queue, wildcard) && acc(sys__result.PutPollWorker__queue.BlockingQueue__capacity, wildcard) && (sys__result.PutPollWorker__queue.BlockingQueue__capacity > 0) && acc(sys__result.PutPollWorker__queue.BlockingQueue__count, wildcard) && (sys__result.PutPollWorker__queue.BlockingQueue__count != null) && acc(sys__result.PutPollWorker__queue.BlockingQueue__headLock, wildcard) && (sys__result.PutPollWorker__queue.BlockingQueue__headLock != null) && acc(sys__result.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutPollWorker__queue) && acc(sys__result.PutPollWorker__queue.BlockingQueue__lastLock, wildcard) && (sys__result.PutPollWorker__queue.BlockingQueue__lastLock != null) && acc(sys__result.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutPollWorker__queue)
; [eval] sys__result != null
(declare-const $k@391 $Perm)
(assert ($Perm.isValidVar $k@391))
(assert ($Perm.isReadVar $k@391 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@391 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@391 $Perm.Write))
(declare-const $k@392 $Perm)
(assert ($Perm.isValidVar $k@392))
(assert ($Perm.isReadVar $k@392 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@392 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@392 $k@363))
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@393 $Perm)
(assert ($Perm.isValidVar $k@393))
(assert ($Perm.isReadVar $k@393 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@393 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@393 $k@365))
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__count != null
(declare-const $k@394 $Perm)
(assert ($Perm.isValidVar $k@394))
(assert ($Perm.isReadVar $k@394 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@394 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@394 $k@367))
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__headLock != null
(declare-const $k@395 $Perm)
(assert ($Perm.isValidVar $k@395))
(assert ($Perm.isReadVar $k@395 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@395 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@395 $k@369))
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutPollWorker__queue
(declare-const $k@396 $Perm)
(assert ($Perm.isValidVar $k@396))
(assert ($Perm.isReadVar $k@396 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@396 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@396 $k@371))
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@397 $Perm)
(assert ($Perm.isValidVar $k@397))
(assert ($Perm.isReadVar $k@397 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@397 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@397 $k@373))
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutPollWorker__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- PutPollWorker__forkOperator ----------
(declare-const diz@398 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@398 $Ref.null)))
(declare-const $k@399 $Perm)
(assert ($Perm.isValidVar $k@399))
(assert ($Perm.isReadVar $k@399 $Perm.Write))
(declare-const $t@400 $Ref)
(push) ; 3
(assert (not (not (= $k@399 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@399 $Perm.No)))
(assert (not (= $t@400 $Ref.null)))
(declare-const $k@401 $Perm)
(assert ($Perm.isValidVar $k@401))
(assert ($Perm.isReadVar $k@401 $Perm.Write))
(declare-const $t@402 Int)
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@401 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@401 $Perm.No)))
(assert (> $t@402 0))
(declare-const $k@403 $Perm)
(assert ($Perm.isValidVar $k@403))
(assert ($Perm.isReadVar $k@403 $Perm.Write))
(declare-const $t@404 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@403 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@403 $Perm.No)))
(assert (not (= $t@404 $Ref.null)))
(declare-const $k@405 $Perm)
(assert ($Perm.isValidVar $k@405))
(assert ($Perm.isReadVar $k@405 $Perm.Write))
(declare-const $t@406 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@405 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@405 $Perm.No)))
(assert (not (= $t@406 $Ref.null)))
(declare-const $k@407 $Perm)
(assert ($Perm.isValidVar $k@407))
(assert ($Perm.isReadVar $k@407 $Perm.Write))
(declare-const $t@408 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(push) ; 3
(assert (not (not (= $k@407 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@407 $Perm.No)))
(assert (= $t@408 $t@400))
(declare-const $k@409 $Perm)
(assert ($Perm.isValidVar $k@409))
(assert ($Perm.isReadVar $k@409 $Perm.Write))
(declare-const $t@410 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@409 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@409 $Perm.No)))
(assert (not (= $t@410 $Ref.null)))
(declare-const $k@411 $Perm)
(assert ($Perm.isValidVar $k@411))
(assert ($Perm.isReadVar $k@411 $Perm.Write))
(declare-const $t@412 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(push) ; 3
(assert (not (not (= $k@411 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@411 $Perm.No)))
(assert (= $t@412 $t@400))
(push) ; 3
(declare-const $t@413 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- PutPollWorker__joinOperator ----------
(declare-const diz@414 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@414 $Ref.null)))
(declare-const $t@415 $Snap)
(push) ; 3
(declare-const $k@416 $Perm)
(assert ($Perm.isValidVar $k@416))
(assert ($Perm.isReadVar $k@416 $Perm.Write))
(declare-const $t@417 $Ref)
(push) ; 4
(assert (not (not (= $k@416 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@416 $Perm.No)))
(assert (not (= $t@417 $Ref.null)))
(declare-const $k@418 $Perm)
(assert ($Perm.isValidVar $k@418))
(assert ($Perm.isReadVar $k@418 $Perm.Write))
(declare-const $t@419 Int)
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@418 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@418 $Perm.No)))
(assert (> $t@419 0))
(declare-const $k@420 $Perm)
(assert ($Perm.isValidVar $k@420))
(assert ($Perm.isReadVar $k@420 $Perm.Write))
(declare-const $t@421 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@420 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@420 $Perm.No)))
(assert (not (= $t@421 $Ref.null)))
(declare-const $k@422 $Perm)
(assert ($Perm.isValidVar $k@422))
(assert ($Perm.isReadVar $k@422 $Perm.Write))
(declare-const $t@423 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@422 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@422 $Perm.No)))
(assert (not (= $t@423 $Ref.null)))
(declare-const $k@424 $Perm)
(assert ($Perm.isValidVar $k@424))
(assert ($Perm.isReadVar $k@424 $Perm.Write))
(declare-const $t@425 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@424 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@424 $Perm.No)))
(assert (= $t@425 $t@417))
(declare-const $k@426 $Perm)
(assert ($Perm.isValidVar $k@426))
(assert ($Perm.isReadVar $k@426 $Perm.Write))
(declare-const $t@427 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@426 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@426 $Perm.No)))
(assert (not (= $t@427 $Ref.null)))
(declare-const $k@428 $Perm)
(assert ($Perm.isValidVar $k@428))
(assert ($Perm.isReadVar $k@428 $Perm.Write))
(declare-const $t@429 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@428 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@428 $Perm.No)))
(assert (= $t@429 $t@417))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- PutPollWorker__run ----------
(declare-const diz@430 $Ref)
(declare-const i@431 $Ref)
(declare-const __flatten_15@432 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@430 $Ref.null)))
(declare-const $k@433 $Perm)
(assert ($Perm.isValidVar $k@433))
(assert ($Perm.isReadVar $k@433 $Perm.Write))
(declare-const $t@434 $Ref)
(push) ; 3
(assert (not (not (= $k@433 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@433 $Perm.No)))
(assert (not (= $t@434 $Ref.null)))
(declare-const $k@435 $Perm)
(assert ($Perm.isValidVar $k@435))
(assert ($Perm.isReadVar $k@435 $Perm.Write))
(declare-const $t@436 Int)
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@435 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@435 $Perm.No)))
(assert (> $t@436 0))
(declare-const $k@437 $Perm)
(assert ($Perm.isValidVar $k@437))
(assert ($Perm.isReadVar $k@437 $Perm.Write))
(declare-const $t@438 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@437 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@437 $Perm.No)))
(assert (not (= $t@438 $Ref.null)))
(declare-const $k@439 $Perm)
(assert ($Perm.isValidVar $k@439))
(assert ($Perm.isReadVar $k@439 $Perm.Write))
(declare-const $t@440 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@439 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@439 $Perm.No)))
(assert (not (= $t@440 $Ref.null)))
(declare-const $k@441 $Perm)
(assert ($Perm.isValidVar $k@441))
(assert ($Perm.isReadVar $k@441 $Perm.Write))
(declare-const $t@442 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(push) ; 3
(assert (not (not (= $k@441 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@441 $Perm.No)))
(assert (= $t@442 $t@434))
(declare-const $k@443 $Perm)
(assert ($Perm.isValidVar $k@443))
(assert ($Perm.isReadVar $k@443 $Perm.Write))
(declare-const $t@444 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@443 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@443 $Perm.No)))
(assert (not (= $t@444 $Ref.null)))
(declare-const $k@445 $Perm)
(assert ($Perm.isValidVar $k@445))
(assert ($Perm.isReadVar $k@445 $Perm.Write))
(declare-const $t@446 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(push) ; 3
(assert (not (not (= $k@445 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@445 $Perm.No)))
(assert (= $t@446 $t@434))
(push) ; 3
(declare-const $k@447 $Perm)
(assert ($Perm.isValidVar $k@447))
(assert ($Perm.isReadVar $k@447 $Perm.Write))
(declare-const $t@448 $Ref)
(push) ; 4
(assert (not (not (= $k@447 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@447 $Perm.No)))
(assert (not (= $t@448 $Ref.null)))
(declare-const $k@449 $Perm)
(assert ($Perm.isValidVar $k@449))
(assert ($Perm.isReadVar $k@449 $Perm.Write))
(declare-const $t@450 Int)
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@449 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@449 $Perm.No)))
(assert (> $t@450 0))
(declare-const $k@451 $Perm)
(assert ($Perm.isValidVar $k@451))
(assert ($Perm.isReadVar $k@451 $Perm.Write))
(declare-const $t@452 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@451 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@451 $Perm.No)))
(assert (not (= $t@452 $Ref.null)))
(declare-const $k@453 $Perm)
(assert ($Perm.isValidVar $k@453))
(assert ($Perm.isReadVar $k@453 $Perm.Write))
(declare-const $t@454 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@453 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@453 $Perm.No)))
(assert (not (= $t@454 $Ref.null)))
(declare-const $k@455 $Perm)
(assert ($Perm.isValidVar $k@455))
(assert ($Perm.isReadVar $k@455 $Perm.Write))
(declare-const $t@456 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@455 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@455 $Perm.No)))
(assert (= $t@456 $t@448))
(declare-const $k@457 $Perm)
(assert ($Perm.isValidVar $k@457))
(assert ($Perm.isReadVar $k@457 $Perm.Write))
(declare-const $t@458 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@457 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@457 $Perm.No)))
(assert (not (= $t@458 $Ref.null)))
(declare-const $k@459 $Perm)
(assert ($Perm.isValidVar $k@459))
(assert ($Perm.isReadVar $k@459 $Perm.Write))
(declare-const $t@460 $Ref)
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@459 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@459 $Perm.No)))
(assert (= $t@460 $t@448))
(pop) ; 3
(push) ; 3
; [exec]
; BlockingQueue__put(diz.PutPollWorker__queue, 2)
; [eval] diz != null
(declare-const $k@461 $Perm)
(assert ($Perm.isValidVar $k@461))
(assert ($Perm.isReadVar $k@461 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@461 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@461 $k@435))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@462 $Perm)
(assert ($Perm.isValidVar $k@462))
(assert ($Perm.isReadVar $k@462 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@462 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@462 $k@437))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@463 $Perm)
(assert ($Perm.isValidVar $k@463))
(assert ($Perm.isReadVar $k@463 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@463 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@463 $k@439))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@464 $Perm)
(assert ($Perm.isValidVar $k@464))
(assert ($Perm.isReadVar $k@464 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@464 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@464 $k@441))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@465 $Perm)
(assert ($Perm.isValidVar $k@465))
(assert ($Perm.isReadVar $k@465 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@465 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@465 $k@443))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@466 $Perm)
(assert ($Perm.isValidVar $k@466))
(assert ($Perm.isReadVar $k@466 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@466 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@466 $k@445))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const $t@467 $Snap)
(declare-const $t@468 $Snap)
(assert (= $t@467 ($Snap.combine $t@468 $Snap.unit)))
(declare-const $t@469 $Snap)
(declare-const $t@470 $Ref)
(assert (= $t@468 ($Snap.combine $t@469 ($SortWrappers.$RefTo$Snap $t@470))))
(declare-const $t@471 $Snap)
(assert (= $t@469 ($Snap.combine $t@471 $Snap.unit)))
(declare-const $t@472 $Snap)
(declare-const $t@473 $Ref)
(assert (= $t@471 ($Snap.combine $t@472 ($SortWrappers.$RefTo$Snap $t@473))))
(declare-const $t@474 $Snap)
(assert (= $t@472 ($Snap.combine $t@474 $Snap.unit)))
(declare-const $t@475 $Snap)
(declare-const $t@476 $Ref)
(assert (= $t@474 ($Snap.combine $t@475 ($SortWrappers.$RefTo$Snap $t@476))))
(declare-const $t@477 $Snap)
(assert (= $t@475 ($Snap.combine $t@477 $Snap.unit)))
(declare-const $t@478 $Snap)
(declare-const $t@479 $Ref)
(assert (= $t@477 ($Snap.combine $t@478 ($SortWrappers.$RefTo$Snap $t@479))))
(declare-const $t@480 $Snap)
(assert (= $t@478 ($Snap.combine $t@480 $Snap.unit)))
(declare-const $t@481 Int)
(declare-const $t@482 $Ref)
(assert (=
  $t@480
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@481)
    ($SortWrappers.$RefTo$Snap $t@482))))
(declare-const $t@483 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@481)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@483) $Snap.unit)))
(declare-const $k@484 $Perm)
(assert ($Perm.isValidVar $k@484))
(assert ($Perm.isReadVar $k@484 $Perm.Write))
(assert (implies (< $Perm.No (- $k@435 $k@461)) (= $t@483 $t@436)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@435 $k@461) $k@484) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@435 $k@461) $k@484) $Perm.No)))
(assert (> $t@483 0))
(declare-const $k@485 $Perm)
(assert ($Perm.isValidVar $k@485))
(assert ($Perm.isReadVar $k@485 $Perm.Write))
(assert (implies (< $Perm.No (- $k@437 $k@462)) (= $t@482 $t@438)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@437 $k@462) $k@485) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@437 $k@462) $k@485) $Perm.No)))
(assert (not (= $t@482 $Ref.null)))
(declare-const $k@486 $Perm)
(assert ($Perm.isValidVar $k@486))
(assert ($Perm.isReadVar $k@486 $Perm.Write))
(assert (implies (< $Perm.No (- $k@439 $k@463)) (= $t@479 $t@440)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@439 $k@463) $k@486) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@439 $k@463) $k@486) $Perm.No)))
(assert (not (= $t@479 $Ref.null)))
(declare-const $k@487 $Perm)
(assert ($Perm.isValidVar $k@487))
(assert ($Perm.isReadVar $k@487 $Perm.Write))
(push) ; 4
(assert (not (= $t@440 $t@479)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@441 $k@464)) (= $t@476 $t@442)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@440 $t@479)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@441 $k@464) $k@487) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@441 $k@464) $k@487) $Perm.No)))
(assert (= $t@476 $t@434))
(declare-const $k@488 $Perm)
(assert ($Perm.isValidVar $k@488))
(assert ($Perm.isReadVar $k@488 $Perm.Write))
(assert (implies (< $Perm.No (- $k@443 $k@465)) (= $t@473 $t@444)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@443 $k@465) $k@488) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@443 $k@465) $k@488) $Perm.No)))
(assert (not (= $t@473 $Ref.null)))
(declare-const $k@489 $Perm)
(assert ($Perm.isValidVar $k@489))
(assert ($Perm.isReadVar $k@489 $Perm.Write))
(push) ; 4
(assert (not (= $t@444 $t@473)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@445 $k@466)) (= $t@470 $t@446)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@444 $t@473)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@445 $k@466) $k@489) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@445 $k@466) $k@489) $Perm.No)))
(assert (= $t@470 $t@434))
; [exec]
; __flatten_15 := BlockingQueue__poll(diz.PutPollWorker__queue)
; [eval] diz != null
(declare-const $k@490 $Perm)
(assert ($Perm.isValidVar $k@490))
(assert ($Perm.isReadVar $k@490 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@490 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@490 (+ (- $k@435 $k@461) $k@484)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@491 $Perm)
(assert ($Perm.isValidVar $k@491))
(assert ($Perm.isReadVar $k@491 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@491 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@491 (+ (- $k@437 $k@462) $k@485)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@492 $Perm)
(assert ($Perm.isValidVar $k@492))
(assert ($Perm.isReadVar $k@492 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@492 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@492 (+ (- $k@439 $k@463) $k@486)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@493 $Perm)
(assert ($Perm.isValidVar $k@493))
(assert ($Perm.isReadVar $k@493 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@493 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@440 $t@479)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@493 (+ (- $k@441 $k@464) $k@487)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@440 $t@479)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@494 $Perm)
(assert ($Perm.isValidVar $k@494))
(assert ($Perm.isReadVar $k@494 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@494 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@494 (+ (- $k@443 $k@465) $k@488)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@495 $Perm)
(assert ($Perm.isValidVar $k@495))
(assert ($Perm.isReadVar $k@495 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@495 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@444 $t@473)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@495 (+ (- $k@445 $k@466) $k@489)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@444 $t@473)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@496 $Ref)
(declare-const $t@497 $Snap)
(declare-const $t@498 $Snap)
(assert (= $t@497 ($Snap.combine $t@498 $Snap.unit)))
(declare-const $t@499 $Snap)
(declare-const $t@500 $Ref)
(assert (= $t@498 ($Snap.combine $t@499 ($SortWrappers.$RefTo$Snap $t@500))))
(declare-const $t@501 $Snap)
(assert (= $t@499 ($Snap.combine $t@501 $Snap.unit)))
(declare-const $t@502 $Snap)
(declare-const $t@503 $Ref)
(assert (= $t@501 ($Snap.combine $t@502 ($SortWrappers.$RefTo$Snap $t@503))))
(declare-const $t@504 $Snap)
(assert (= $t@502 ($Snap.combine $t@504 $Snap.unit)))
(declare-const $t@505 $Snap)
(declare-const $t@506 $Ref)
(assert (= $t@504 ($Snap.combine $t@505 ($SortWrappers.$RefTo$Snap $t@506))))
(declare-const $t@507 $Snap)
(assert (= $t@505 ($Snap.combine $t@507 $Snap.unit)))
(declare-const $t@508 $Snap)
(declare-const $t@509 $Ref)
(assert (= $t@507 ($Snap.combine $t@508 ($SortWrappers.$RefTo$Snap $t@509))))
(declare-const $t@510 $Snap)
(assert (= $t@508 ($Snap.combine $t@510 $Snap.unit)))
(declare-const $t@511 Int)
(declare-const $t@512 $Ref)
(assert (=
  $t@510
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@511)
    ($SortWrappers.$RefTo$Snap $t@512))))
(declare-const $t@513 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@511)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@513) $Snap.unit)))
(declare-const $k@514 $Perm)
(assert ($Perm.isValidVar $k@514))
(assert ($Perm.isReadVar $k@514 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@435 $k@461) $k@484) $k@490)) (= $t@513 $t@483)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@435 $k@461) $k@484) $k@490) $k@514) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@435 $k@461) $k@484) $k@490) $k@514) $Perm.No)))
(assert (> $t@513 0))
(declare-const $k@515 $Perm)
(assert ($Perm.isValidVar $k@515))
(assert ($Perm.isReadVar $k@515 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@437 $k@462) $k@485) $k@491)) (= $t@512 $t@482)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@437 $k@462) $k@485) $k@491) $k@515) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@437 $k@462) $k@485) $k@491) $k@515) $Perm.No)))
(assert (not (= $t@512 $Ref.null)))
(declare-const $k@516 $Perm)
(assert ($Perm.isValidVar $k@516))
(assert ($Perm.isReadVar $k@516 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@439 $k@463) $k@486) $k@492)) (= $t@509 $t@479)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@439 $k@463) $k@486) $k@492) $k@516) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@439 $k@463) $k@486) $k@492) $k@516) $Perm.No)))
(assert (not (= $t@509 $Ref.null)))
(declare-const $k@517 $Perm)
(assert ($Perm.isValidVar $k@517))
(assert ($Perm.isReadVar $k@517 $Perm.Write))
(push) ; 4
(assert (not (= $t@440 $t@509)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@441 $k@464) $k@487) $k@493)) (= $t@506 $t@476)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@440 $t@509)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@441 $k@464) $k@487) $k@493) $k@517) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@441 $k@464) $k@487) $k@493) $k@517) $Perm.No)))
(assert (= $t@506 $t@434))
(declare-const $k@518 $Perm)
(assert ($Perm.isValidVar $k@518))
(assert ($Perm.isReadVar $k@518 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@443 $k@465) $k@488) $k@494)) (= $t@503 $t@473)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@443 $k@465) $k@488) $k@494) $k@518) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@443 $k@465) $k@488) $k@494) $k@518) $Perm.No)))
(assert (not (= $t@503 $Ref.null)))
(declare-const $k@519 $Perm)
(assert ($Perm.isValidVar $k@519))
(assert ($Perm.isReadVar $k@519 $Perm.Write))
(push) ; 4
(assert (not (= $t@444 $t@503)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@445 $k@466) $k@489) $k@495)) (= $t@500 $t@470)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@444 $t@503)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@445 $k@466) $k@489) $k@495) $k@519) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@445 $k@466) $k@489) $k@495) $k@519) $Perm.No)))
(assert (= $t@500 $t@434))
; [exec]
; i := __flatten_15
(declare-const $k@520 $Perm)
(assert ($Perm.isValidVar $k@520))
(assert ($Perm.isReadVar $k@520 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@520 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@520 $k@433))
(declare-const $k@521 $Perm)
(assert ($Perm.isValidVar $k@521))
(assert ($Perm.isReadVar $k@521 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@521 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@521 (+ (- (+ (- $k@435 $k@461) $k@484) $k@490) $k@514)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@522 $Perm)
(assert ($Perm.isValidVar $k@522))
(assert ($Perm.isReadVar $k@522 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@522 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@522 (+ (- (+ (- $k@437 $k@462) $k@485) $k@491) $k@515)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(declare-const $k@523 $Perm)
(assert ($Perm.isValidVar $k@523))
(assert ($Perm.isReadVar $k@523 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@523 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@523 (+ (- (+ (- $k@439 $k@463) $k@486) $k@492) $k@516)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(declare-const $k@524 $Perm)
(assert ($Perm.isValidVar $k@524))
(assert ($Perm.isReadVar $k@524 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@524 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@440 $t@509)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@524 (+ (- (+ (- $k@441 $k@464) $k@487) $k@493) $k@517)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (= $t@440 $t@509)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@525 $Perm)
(assert ($Perm.isValidVar $k@525))
(assert ($Perm.isReadVar $k@525 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@525 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@525 (+ (- (+ (- $k@443 $k@465) $k@488) $k@494) $k@518)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@526 $Perm)
(assert ($Perm.isValidVar $k@526))
(assert ($Perm.isReadVar $k@526 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@526 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@444 $t@503)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@526 (+ (- (+ (- $k@445 $k@466) $k@489) $k@495) $k@519)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (= $t@444 $t@503)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- TakeWorker__TakeWorker ----------
(declare-const queue@527 $Ref)
(declare-const sys__result@528 $Ref)
(declare-const diz@529 $Ref)
(declare-const __flatten_16@530 $Ref)
(declare-const __flatten_138@531 $Ref)
(push) ; 2
(assert (not (= queue@527 $Ref.null)))
(declare-const $k@532 $Perm)
(assert ($Perm.isValidVar $k@532))
(assert ($Perm.isReadVar $k@532 $Perm.Write))
(declare-const $t@533 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@532 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@532 $Perm.No)))
(assert (> $t@533 0))
(declare-const $k@534 $Perm)
(assert ($Perm.isValidVar $k@534))
(assert ($Perm.isReadVar $k@534 $Perm.Write))
(declare-const $t@535 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@534 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@534 $Perm.No)))
(assert (not (= $t@535 $Ref.null)))
(declare-const $k@536 $Perm)
(assert ($Perm.isValidVar $k@536))
(assert ($Perm.isReadVar $k@536 $Perm.Write))
(declare-const $t@537 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@536 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@536 $Perm.No)))
(assert (not (= $t@537 $Ref.null)))
(declare-const $k@538 $Perm)
(assert ($Perm.isValidVar $k@538))
(assert ($Perm.isReadVar $k@538 $Perm.Write))
(declare-const $t@539 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@538 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@538 $Perm.No)))
(assert (= $t@539 queue@527))
(declare-const $k@540 $Perm)
(assert ($Perm.isValidVar $k@540))
(assert ($Perm.isReadVar $k@540 $Perm.Write))
(declare-const $t@541 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@540 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@540 $Perm.No)))
(assert (not (= $t@541 $Ref.null)))
(declare-const $k@542 $Perm)
(assert ($Perm.isValidVar $k@542))
(assert ($Perm.isReadVar $k@542 $Perm.Write))
(declare-const $t@543 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@542 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@542 $Perm.No)))
(assert (= $t@543 queue@527))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@528 $Ref.null)))
(declare-const $k@544 $Perm)
(assert ($Perm.isValidVar $k@544))
(assert ($Perm.isReadVar $k@544 $Perm.Write))
(declare-const $t@545 $Ref)
(push) ; 4
(assert (not (not (= $k@544 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@544 $Perm.No)))
(assert (not (= $t@545 $Ref.null)))
(declare-const $k@546 $Perm)
(assert ($Perm.isValidVar $k@546))
(assert ($Perm.isReadVar $k@546 $Perm.Write))
(declare-const $t@547 Int)
; [eval] sys__result.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@546 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@546 $Perm.No)))
(assert (> $t@547 0))
(declare-const $k@548 $Perm)
(assert ($Perm.isValidVar $k@548))
(assert ($Perm.isReadVar $k@548 $Perm.Write))
(declare-const $t@549 $Ref)
; [eval] sys__result.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@548 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@548 $Perm.No)))
(assert (not (= $t@549 $Ref.null)))
(declare-const $k@550 $Perm)
(assert ($Perm.isValidVar $k@550))
(assert ($Perm.isReadVar $k@550 $Perm.Write))
(declare-const $t@551 $Ref)
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@550 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@550 $Perm.No)))
(assert (not (= $t@551 $Ref.null)))
(declare-const $k@552 $Perm)
(assert ($Perm.isValidVar $k@552))
(assert ($Perm.isReadVar $k@552 $Perm.Write))
(declare-const $t@553 $Ref)
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@552 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@552 $Perm.No)))
(assert (= $t@553 $t@545))
(declare-const $k@554 $Perm)
(assert ($Perm.isValidVar $k@554))
(assert ($Perm.isReadVar $k@554 $Perm.Write))
(declare-const $t@555 $Ref)
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@554 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@554 $Perm.No)))
(assert (not (= $t@555 $Ref.null)))
(declare-const $k@556 $Perm)
(assert ($Perm.isValidVar $k@556))
(assert ($Perm.isReadVar $k@556 $Perm.Write))
(declare-const $t@557 $Ref)
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@556 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@556 $Perm.No)))
(assert (= $t@557 $t@545))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(TakeWorker__queue)
(declare-const diz@558 $Ref)
(assert (not (= diz@558 $Ref.null)))
(declare-const TakeWorker__queue@559 $Ref)
(assert (and
  (not (= queue@527 diz@558))
  (not (= sys__result@528 diz@558))
  (not (= __flatten_16@530 diz@558))
  (not (= __flatten_138@531 diz@558))
  (not (= $t@537 diz@558))
  (not (= $t@541 diz@558))
  (not (= TakeWorker__queue@559 diz@558))
  (not (= $t@535 diz@558))
  (not (= $t@539 diz@558))
  (not (= $t@543 diz@558))))
; [exec]
; __flatten_16 := queue
; [exec]
; __flatten_138 := __flatten_16
; [exec]
; diz.TakeWorker__queue := __flatten_138
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.TakeWorker__queue, wildcard) && acc(sys__result.TakeWorker__queue.BlockingQueue__capacity, wildcard) && (sys__result.TakeWorker__queue.BlockingQueue__capacity > 0) && acc(sys__result.TakeWorker__queue.BlockingQueue__count, wildcard) && (sys__result.TakeWorker__queue.BlockingQueue__count != null) && acc(sys__result.TakeWorker__queue.BlockingQueue__headLock, wildcard) && (sys__result.TakeWorker__queue.BlockingQueue__headLock != null) && acc(sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.TakeWorker__queue) && acc(sys__result.TakeWorker__queue.BlockingQueue__lastLock, wildcard) && (sys__result.TakeWorker__queue.BlockingQueue__lastLock != null) && acc(sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.TakeWorker__queue)
; [eval] sys__result != null
(declare-const $k@560 $Perm)
(assert ($Perm.isValidVar $k@560))
(assert ($Perm.isReadVar $k@560 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@560 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@560 $Perm.Write))
(declare-const $k@561 $Perm)
(assert ($Perm.isValidVar $k@561))
(assert ($Perm.isReadVar $k@561 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@561 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@561 $k@532))
; [eval] sys__result.TakeWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@562 $Perm)
(assert ($Perm.isValidVar $k@562))
(assert ($Perm.isReadVar $k@562 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@562 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@562 $k@534))
; [eval] sys__result.TakeWorker__queue.BlockingQueue__count != null
(declare-const $k@563 $Perm)
(assert ($Perm.isValidVar $k@563))
(assert ($Perm.isReadVar $k@563 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@563 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@563 $k@536))
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock != null
(declare-const $k@564 $Perm)
(assert ($Perm.isValidVar $k@564))
(assert ($Perm.isReadVar $k@564 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@564 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@564 $k@538))
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.TakeWorker__queue
(declare-const $k@565 $Perm)
(assert ($Perm.isValidVar $k@565))
(assert ($Perm.isReadVar $k@565 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@565 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@565 $k@540))
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@566 $Perm)
(assert ($Perm.isValidVar $k@566))
(assert ($Perm.isReadVar $k@566 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@566 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@566 $k@542))
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.TakeWorker__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- TakeWorker__forkOperator ----------
(declare-const diz@567 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@567 $Ref.null)))
(declare-const $k@568 $Perm)
(assert ($Perm.isValidVar $k@568))
(assert ($Perm.isReadVar $k@568 $Perm.Write))
(declare-const $t@569 $Ref)
(push) ; 3
(assert (not (not (= $k@568 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@568 $Perm.No)))
(assert (not (= $t@569 $Ref.null)))
(declare-const $k@570 $Perm)
(assert ($Perm.isValidVar $k@570))
(assert ($Perm.isReadVar $k@570 $Perm.Write))
(declare-const $t@571 Int)
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@570 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@570 $Perm.No)))
(assert (> $t@571 0))
(declare-const $k@572 $Perm)
(assert ($Perm.isValidVar $k@572))
(assert ($Perm.isReadVar $k@572 $Perm.Write))
(declare-const $t@573 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@572 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@572 $Perm.No)))
(assert (not (= $t@573 $Ref.null)))
(declare-const $k@574 $Perm)
(assert ($Perm.isValidVar $k@574))
(assert ($Perm.isReadVar $k@574 $Perm.Write))
(declare-const $t@575 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@574 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@574 $Perm.No)))
(assert (not (= $t@575 $Ref.null)))
(declare-const $k@576 $Perm)
(assert ($Perm.isValidVar $k@576))
(assert ($Perm.isReadVar $k@576 $Perm.Write))
(declare-const $t@577 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 3
(assert (not (not (= $k@576 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@576 $Perm.No)))
(assert (= $t@577 $t@569))
(declare-const $k@578 $Perm)
(assert ($Perm.isValidVar $k@578))
(assert ($Perm.isReadVar $k@578 $Perm.Write))
(declare-const $t@579 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@578 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@578 $Perm.No)))
(assert (not (= $t@579 $Ref.null)))
(declare-const $k@580 $Perm)
(assert ($Perm.isValidVar $k@580))
(assert ($Perm.isReadVar $k@580 $Perm.Write))
(declare-const $t@581 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 3
(assert (not (not (= $k@580 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@580 $Perm.No)))
(assert (= $t@581 $t@569))
(push) ; 3
(declare-const $t@582 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- TakeWorker__joinOperator ----------
(declare-const diz@583 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@583 $Ref.null)))
(declare-const $t@584 $Snap)
(push) ; 3
(declare-const $k@585 $Perm)
(assert ($Perm.isValidVar $k@585))
(assert ($Perm.isReadVar $k@585 $Perm.Write))
(declare-const $t@586 $Ref)
(push) ; 4
(assert (not (not (= $k@585 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@585 $Perm.No)))
(assert (not (= $t@586 $Ref.null)))
(declare-const $k@587 $Perm)
(assert ($Perm.isValidVar $k@587))
(assert ($Perm.isReadVar $k@587 $Perm.Write))
(declare-const $t@588 Int)
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@587 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@587 $Perm.No)))
(assert (> $t@588 0))
(declare-const $k@589 $Perm)
(assert ($Perm.isValidVar $k@589))
(assert ($Perm.isReadVar $k@589 $Perm.Write))
(declare-const $t@590 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@589 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@589 $Perm.No)))
(assert (not (= $t@590 $Ref.null)))
(declare-const $k@591 $Perm)
(assert ($Perm.isValidVar $k@591))
(assert ($Perm.isReadVar $k@591 $Perm.Write))
(declare-const $t@592 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@591 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@591 $Perm.No)))
(assert (not (= $t@592 $Ref.null)))
(declare-const $k@593 $Perm)
(assert ($Perm.isValidVar $k@593))
(assert ($Perm.isReadVar $k@593 $Perm.Write))
(declare-const $t@594 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@593 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@593 $Perm.No)))
(assert (= $t@594 $t@586))
(declare-const $k@595 $Perm)
(assert ($Perm.isValidVar $k@595))
(assert ($Perm.isReadVar $k@595 $Perm.Write))
(declare-const $t@596 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@595 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@595 $Perm.No)))
(assert (not (= $t@596 $Ref.null)))
(declare-const $k@597 $Perm)
(assert ($Perm.isValidVar $k@597))
(assert ($Perm.isReadVar $k@597 $Perm.Write))
(declare-const $t@598 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@597 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@597 $Perm.No)))
(assert (= $t@598 $t@586))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- TakeWorker__run ----------
(declare-const diz@599 $Ref)
(declare-const i@600 Int)
(declare-const __flatten_17@601 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@599 $Ref.null)))
(declare-const $k@602 $Perm)
(assert ($Perm.isValidVar $k@602))
(assert ($Perm.isReadVar $k@602 $Perm.Write))
(declare-const $t@603 $Ref)
(push) ; 3
(assert (not (not (= $k@602 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@602 $Perm.No)))
(assert (not (= $t@603 $Ref.null)))
(declare-const $k@604 $Perm)
(assert ($Perm.isValidVar $k@604))
(assert ($Perm.isReadVar $k@604 $Perm.Write))
(declare-const $t@605 Int)
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@604 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@604 $Perm.No)))
(assert (> $t@605 0))
(declare-const $k@606 $Perm)
(assert ($Perm.isValidVar $k@606))
(assert ($Perm.isReadVar $k@606 $Perm.Write))
(declare-const $t@607 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@606 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@606 $Perm.No)))
(assert (not (= $t@607 $Ref.null)))
(declare-const $k@608 $Perm)
(assert ($Perm.isValidVar $k@608))
(assert ($Perm.isReadVar $k@608 $Perm.Write))
(declare-const $t@609 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@608 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@608 $Perm.No)))
(assert (not (= $t@609 $Ref.null)))
(declare-const $k@610 $Perm)
(assert ($Perm.isValidVar $k@610))
(assert ($Perm.isReadVar $k@610 $Perm.Write))
(declare-const $t@611 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 3
(assert (not (not (= $k@610 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@610 $Perm.No)))
(assert (= $t@611 $t@603))
(declare-const $k@612 $Perm)
(assert ($Perm.isValidVar $k@612))
(assert ($Perm.isReadVar $k@612 $Perm.Write))
(declare-const $t@613 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@612 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@612 $Perm.No)))
(assert (not (= $t@613 $Ref.null)))
(declare-const $k@614 $Perm)
(assert ($Perm.isValidVar $k@614))
(assert ($Perm.isReadVar $k@614 $Perm.Write))
(declare-const $t@615 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 3
(assert (not (not (= $k@614 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@614 $Perm.No)))
(assert (= $t@615 $t@603))
(push) ; 3
(declare-const $k@616 $Perm)
(assert ($Perm.isValidVar $k@616))
(assert ($Perm.isReadVar $k@616 $Perm.Write))
(declare-const $t@617 $Ref)
(push) ; 4
(assert (not (not (= $k@616 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@616 $Perm.No)))
(assert (not (= $t@617 $Ref.null)))
(declare-const $k@618 $Perm)
(assert ($Perm.isValidVar $k@618))
(assert ($Perm.isReadVar $k@618 $Perm.Write))
(declare-const $t@619 Int)
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@618 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@618 $Perm.No)))
(assert (> $t@619 0))
(declare-const $k@620 $Perm)
(assert ($Perm.isValidVar $k@620))
(assert ($Perm.isReadVar $k@620 $Perm.Write))
(declare-const $t@621 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@620 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@620 $Perm.No)))
(assert (not (= $t@621 $Ref.null)))
(declare-const $k@622 $Perm)
(assert ($Perm.isValidVar $k@622))
(assert ($Perm.isReadVar $k@622 $Perm.Write))
(declare-const $t@623 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@622 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@622 $Perm.No)))
(assert (not (= $t@623 $Ref.null)))
(declare-const $k@624 $Perm)
(assert ($Perm.isValidVar $k@624))
(assert ($Perm.isReadVar $k@624 $Perm.Write))
(declare-const $t@625 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@624 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@624 $Perm.No)))
(assert (= $t@625 $t@617))
(declare-const $k@626 $Perm)
(assert ($Perm.isValidVar $k@626))
(assert ($Perm.isReadVar $k@626 $Perm.Write))
(declare-const $t@627 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@626 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@626 $Perm.No)))
(assert (not (= $t@627 $Ref.null)))
(declare-const $k@628 $Perm)
(assert ($Perm.isValidVar $k@628))
(assert ($Perm.isReadVar $k@628 $Perm.Write))
(declare-const $t@629 $Ref)
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@628 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@628 $Perm.No)))
(assert (= $t@629 $t@617))
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_17 := BlockingQueue__take(diz.TakeWorker__queue)
; [eval] diz != null
(declare-const $k@630 $Perm)
(assert ($Perm.isValidVar $k@630))
(assert ($Perm.isReadVar $k@630 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@630 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@630 $k@604))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@631 $Perm)
(assert ($Perm.isValidVar $k@631))
(assert ($Perm.isReadVar $k@631 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@631 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@631 $k@606))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@632 $Perm)
(assert ($Perm.isValidVar $k@632))
(assert ($Perm.isReadVar $k@632 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@632 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@632 $k@608))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@633 $Perm)
(assert ($Perm.isValidVar $k@633))
(assert ($Perm.isReadVar $k@633 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@633 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@633 $k@610))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@634 $Perm)
(assert ($Perm.isValidVar $k@634))
(assert ($Perm.isReadVar $k@634 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@634 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@634 $k@612))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@635 $Perm)
(assert ($Perm.isValidVar $k@635))
(assert ($Perm.isReadVar $k@635 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@635 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@635 $k@614))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@636 Int)
(declare-const $t@637 $Snap)
(declare-const $t@638 $Snap)
(assert (= $t@637 ($Snap.combine $t@638 $Snap.unit)))
(declare-const $t@639 $Snap)
(declare-const $t@640 $Ref)
(assert (= $t@638 ($Snap.combine $t@639 ($SortWrappers.$RefTo$Snap $t@640))))
(declare-const $t@641 $Snap)
(assert (= $t@639 ($Snap.combine $t@641 $Snap.unit)))
(declare-const $t@642 $Snap)
(declare-const $t@643 $Ref)
(assert (= $t@641 ($Snap.combine $t@642 ($SortWrappers.$RefTo$Snap $t@643))))
(declare-const $t@644 $Snap)
(assert (= $t@642 ($Snap.combine $t@644 $Snap.unit)))
(declare-const $t@645 $Snap)
(declare-const $t@646 $Ref)
(assert (= $t@644 ($Snap.combine $t@645 ($SortWrappers.$RefTo$Snap $t@646))))
(declare-const $t@647 $Snap)
(assert (= $t@645 ($Snap.combine $t@647 $Snap.unit)))
(declare-const $t@648 $Snap)
(declare-const $t@649 $Ref)
(assert (= $t@647 ($Snap.combine $t@648 ($SortWrappers.$RefTo$Snap $t@649))))
(declare-const $t@650 $Snap)
(assert (= $t@648 ($Snap.combine $t@650 $Snap.unit)))
(declare-const $t@651 Int)
(declare-const $t@652 $Ref)
(assert (=
  $t@650
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@651)
    ($SortWrappers.$RefTo$Snap $t@652))))
(declare-const $t@653 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@651)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@653) $Snap.unit)))
(declare-const $k@654 $Perm)
(assert ($Perm.isValidVar $k@654))
(assert ($Perm.isReadVar $k@654 $Perm.Write))
(assert (implies (< $Perm.No (- $k@604 $k@630)) (= $t@653 $t@605)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@604 $k@630) $k@654) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@604 $k@630) $k@654) $Perm.No)))
(assert (> $t@653 0))
(declare-const $k@655 $Perm)
(assert ($Perm.isValidVar $k@655))
(assert ($Perm.isReadVar $k@655 $Perm.Write))
(assert (implies (< $Perm.No (- $k@606 $k@631)) (= $t@652 $t@607)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@606 $k@631) $k@655) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@606 $k@631) $k@655) $Perm.No)))
(assert (not (= $t@652 $Ref.null)))
(declare-const $k@656 $Perm)
(assert ($Perm.isValidVar $k@656))
(assert ($Perm.isReadVar $k@656 $Perm.Write))
(assert (implies (< $Perm.No (- $k@608 $k@632)) (= $t@649 $t@609)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@608 $k@632) $k@656) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@608 $k@632) $k@656) $Perm.No)))
(assert (not (= $t@649 $Ref.null)))
(declare-const $k@657 $Perm)
(assert ($Perm.isValidVar $k@657))
(assert ($Perm.isReadVar $k@657 $Perm.Write))
(push) ; 4
(assert (not (= $t@609 $t@649)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@610 $k@633)) (= $t@646 $t@611)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@609 $t@649)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@610 $k@633) $k@657) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@610 $k@633) $k@657) $Perm.No)))
(assert (= $t@646 $t@603))
(declare-const $k@658 $Perm)
(assert ($Perm.isValidVar $k@658))
(assert ($Perm.isReadVar $k@658 $Perm.Write))
(assert (implies (< $Perm.No (- $k@612 $k@634)) (= $t@643 $t@613)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@612 $k@634) $k@658) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@612 $k@634) $k@658) $Perm.No)))
(assert (not (= $t@643 $Ref.null)))
(declare-const $k@659 $Perm)
(assert ($Perm.isValidVar $k@659))
(assert ($Perm.isReadVar $k@659 $Perm.Write))
(push) ; 4
(assert (not (= $t@613 $t@643)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@614 $k@635)) (= $t@640 $t@615)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@613 $t@643)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@614 $k@635) $k@659) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@614 $k@635) $k@659) $Perm.No)))
(assert (= $t@640 $t@603))
; [exec]
; i := __flatten_17
(declare-const $k@660 $Perm)
(assert ($Perm.isValidVar $k@660))
(assert ($Perm.isReadVar $k@660 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@660 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@660 $k@602))
(declare-const $k@661 $Perm)
(assert ($Perm.isValidVar $k@661))
(assert ($Perm.isReadVar $k@661 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@661 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@661 (+ (- $k@604 $k@630) $k@654)))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@662 $Perm)
(assert ($Perm.isValidVar $k@662))
(assert ($Perm.isReadVar $k@662 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@662 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@662 (+ (- $k@606 $k@631) $k@655)))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(declare-const $k@663 $Perm)
(assert ($Perm.isValidVar $k@663))
(assert ($Perm.isReadVar $k@663 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@663 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@663 (+ (- $k@608 $k@632) $k@656)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(declare-const $k@664 $Perm)
(assert ($Perm.isValidVar $k@664))
(assert ($Perm.isReadVar $k@664 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@664 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@609 $t@649)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@664 (+ (- $k@610 $k@633) $k@657)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= $t@609 $t@649)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@665 $Perm)
(assert ($Perm.isValidVar $k@665))
(assert ($Perm.isReadVar $k@665 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@665 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@665 (+ (- $k@612 $k@634) $k@658)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@666 $Perm)
(assert ($Perm.isValidVar $k@666))
(assert ($Perm.isReadVar $k@666 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@666 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@613 $t@643)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@666 (+ (- $k@614 $k@635) $k@659)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= $t@613 $t@643)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- OfferWorker__OfferWorker ----------
(declare-const queue@667 $Ref)
(declare-const sys__result@668 $Ref)
(declare-const diz@669 $Ref)
(declare-const __flatten_18@670 $Ref)
(declare-const __flatten_140@671 $Ref)
(push) ; 2
(assert (not (= queue@667 $Ref.null)))
(declare-const $k@672 $Perm)
(assert ($Perm.isValidVar $k@672))
(assert ($Perm.isReadVar $k@672 $Perm.Write))
(declare-const $t@673 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@672 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@672 $Perm.No)))
(assert (> $t@673 0))
(declare-const $k@674 $Perm)
(assert ($Perm.isValidVar $k@674))
(assert ($Perm.isReadVar $k@674 $Perm.Write))
(declare-const $t@675 $Ref)
; [eval] queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@674 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@674 $Perm.No)))
(assert (not (= $t@675 $Ref.null)))
(declare-const $k@676 $Perm)
(assert ($Perm.isValidVar $k@676))
(assert ($Perm.isReadVar $k@676 $Perm.Write))
(declare-const $t@677 $Ref)
; [eval] queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@676 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@676 $Perm.No)))
(assert (not (= $t@677 $Ref.null)))
(declare-const $k@678 $Perm)
(assert ($Perm.isValidVar $k@678))
(assert ($Perm.isReadVar $k@678 $Perm.Write))
(declare-const $t@679 $Ref)
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(push) ; 3
(assert (not (not (= $k@678 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@678 $Perm.No)))
(assert (= $t@679 queue@667))
(declare-const $k@680 $Perm)
(assert ($Perm.isValidVar $k@680))
(assert ($Perm.isReadVar $k@680 $Perm.Write))
(declare-const $t@681 $Ref)
; [eval] queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@680 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@680 $Perm.No)))
(assert (not (= $t@681 $Ref.null)))
(declare-const $k@682 $Perm)
(assert ($Perm.isValidVar $k@682))
(assert ($Perm.isReadVar $k@682 $Perm.Write))
(declare-const $t@683 $Ref)
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(push) ; 3
(assert (not (not (= $k@682 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@682 $Perm.No)))
(assert (= $t@683 queue@667))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@668 $Ref.null)))
(declare-const $k@684 $Perm)
(assert ($Perm.isValidVar $k@684))
(assert ($Perm.isReadVar $k@684 $Perm.Write))
(declare-const $t@685 $Ref)
(push) ; 4
(assert (not (not (= $k@684 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@684 $Perm.No)))
(assert (not (= $t@685 $Ref.null)))
(declare-const $k@686 $Perm)
(assert ($Perm.isValidVar $k@686))
(assert ($Perm.isReadVar $k@686 $Perm.Write))
(declare-const $t@687 Int)
; [eval] sys__result.OfferWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@686 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@686 $Perm.No)))
(assert (> $t@687 0))
(declare-const $k@688 $Perm)
(assert ($Perm.isValidVar $k@688))
(assert ($Perm.isReadVar $k@688 $Perm.Write))
(declare-const $t@689 $Ref)
; [eval] sys__result.OfferWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@688 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@688 $Perm.No)))
(assert (not (= $t@689 $Ref.null)))
(declare-const $k@690 $Perm)
(assert ($Perm.isValidVar $k@690))
(assert ($Perm.isReadVar $k@690 $Perm.Write))
(declare-const $t@691 $Ref)
; [eval] sys__result.OfferWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@690 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@690 $Perm.No)))
(assert (not (= $t@691 $Ref.null)))
(declare-const $k@692 $Perm)
(assert ($Perm.isValidVar $k@692))
(assert ($Perm.isReadVar $k@692 $Perm.Write))
(declare-const $t@693 $Ref)
; [eval] sys__result.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferWorker__queue
(push) ; 4
(assert (not (not (= $k@692 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@692 $Perm.No)))
(assert (= $t@693 $t@685))
(declare-const $k@694 $Perm)
(assert ($Perm.isValidVar $k@694))
(assert ($Perm.isReadVar $k@694 $Perm.Write))
(declare-const $t@695 $Ref)
; [eval] sys__result.OfferWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@694 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@694 $Perm.No)))
(assert (not (= $t@695 $Ref.null)))
(declare-const $k@696 $Perm)
(assert ($Perm.isValidVar $k@696))
(assert ($Perm.isReadVar $k@696 $Perm.Write))
(declare-const $t@697 $Ref)
; [eval] sys__result.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferWorker__queue
(push) ; 4
(assert (not (not (= $k@696 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@696 $Perm.No)))
(assert (= $t@697 $t@685))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(OfferWorker__queue)
(declare-const diz@698 $Ref)
(assert (not (= diz@698 $Ref.null)))
(declare-const OfferWorker__queue@699 $Ref)
(assert (and
  (not (= queue@667 diz@698))
  (not (= sys__result@668 diz@698))
  (not (= __flatten_18@670 diz@698))
  (not (= __flatten_140@671 diz@698))
  (not (= $t@677 diz@698))
  (not (= $t@681 diz@698))
  (not (= OfferWorker__queue@699 diz@698))
  (not (= $t@675 diz@698))
  (not (= $t@679 diz@698))
  (not (= $t@683 diz@698))))
; [exec]
; __flatten_18 := queue
; [exec]
; __flatten_140 := __flatten_18
; [exec]
; diz.OfferWorker__queue := __flatten_140
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.OfferWorker__queue, wildcard) && acc(sys__result.OfferWorker__queue.BlockingQueue__capacity, wildcard) && (sys__result.OfferWorker__queue.BlockingQueue__capacity > 0) && acc(sys__result.OfferWorker__queue.BlockingQueue__count, wildcard) && (sys__result.OfferWorker__queue.BlockingQueue__count != null) && acc(sys__result.OfferWorker__queue.BlockingQueue__headLock, wildcard) && (sys__result.OfferWorker__queue.BlockingQueue__headLock != null) && acc(sys__result.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferWorker__queue) && acc(sys__result.OfferWorker__queue.BlockingQueue__lastLock, wildcard) && (sys__result.OfferWorker__queue.BlockingQueue__lastLock != null) && acc(sys__result.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferWorker__queue)
; [eval] sys__result != null
(declare-const $k@700 $Perm)
(assert ($Perm.isValidVar $k@700))
(assert ($Perm.isReadVar $k@700 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@700 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@700 $Perm.Write))
(declare-const $k@701 $Perm)
(assert ($Perm.isValidVar $k@701))
(assert ($Perm.isReadVar $k@701 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@701 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@701 $k@672))
; [eval] sys__result.OfferWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@702 $Perm)
(assert ($Perm.isValidVar $k@702))
(assert ($Perm.isReadVar $k@702 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@702 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@702 $k@674))
; [eval] sys__result.OfferWorker__queue.BlockingQueue__count != null
(declare-const $k@703 $Perm)
(assert ($Perm.isValidVar $k@703))
(assert ($Perm.isReadVar $k@703 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@703 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@703 $k@676))
; [eval] sys__result.OfferWorker__queue.BlockingQueue__headLock != null
(declare-const $k@704 $Perm)
(assert ($Perm.isValidVar $k@704))
(assert ($Perm.isReadVar $k@704 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@704 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@704 $k@678))
; [eval] sys__result.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferWorker__queue
(declare-const $k@705 $Perm)
(assert ($Perm.isValidVar $k@705))
(assert ($Perm.isReadVar $k@705 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@705 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@705 $k@680))
; [eval] sys__result.OfferWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@706 $Perm)
(assert ($Perm.isValidVar $k@706))
(assert ($Perm.isReadVar $k@706 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@706 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@706 $k@682))
; [eval] sys__result.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferWorker__queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferWorker__forkOperator ----------
(declare-const diz@707 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@707 $Ref.null)))
(declare-const $k@708 $Perm)
(assert ($Perm.isValidVar $k@708))
(assert ($Perm.isReadVar $k@708 $Perm.Write))
(declare-const $t@709 $Ref)
(push) ; 3
(assert (not (not (= $k@708 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@708 $Perm.No)))
(assert (not (= $t@709 $Ref.null)))
(declare-const $k@710 $Perm)
(assert ($Perm.isValidVar $k@710))
(assert ($Perm.isReadVar $k@710 $Perm.Write))
(declare-const $t@711 Int)
; [eval] diz.OfferWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@710 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@710 $Perm.No)))
(assert (> $t@711 0))
(declare-const $k@712 $Perm)
(assert ($Perm.isValidVar $k@712))
(assert ($Perm.isReadVar $k@712 $Perm.Write))
(declare-const $t@713 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@712 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@712 $Perm.No)))
(assert (not (= $t@713 $Ref.null)))
(declare-const $k@714 $Perm)
(assert ($Perm.isValidVar $k@714))
(assert ($Perm.isReadVar $k@714 $Perm.Write))
(declare-const $t@715 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@714 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@714 $Perm.No)))
(assert (not (= $t@715 $Ref.null)))
(declare-const $k@716 $Perm)
(assert ($Perm.isValidVar $k@716))
(assert ($Perm.isReadVar $k@716 $Perm.Write))
(declare-const $t@717 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferWorker__queue
(push) ; 3
(assert (not (not (= $k@716 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@716 $Perm.No)))
(assert (= $t@717 $t@709))
(declare-const $k@718 $Perm)
(assert ($Perm.isValidVar $k@718))
(assert ($Perm.isReadVar $k@718 $Perm.Write))
(declare-const $t@719 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@718 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@718 $Perm.No)))
(assert (not (= $t@719 $Ref.null)))
(declare-const $k@720 $Perm)
(assert ($Perm.isValidVar $k@720))
(assert ($Perm.isReadVar $k@720 $Perm.Write))
(declare-const $t@721 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferWorker__queue
(push) ; 3
(assert (not (not (= $k@720 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@720 $Perm.No)))
(assert (= $t@721 $t@709))
(push) ; 3
(declare-const $t@722 $Snap)
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferWorker__joinOperator ----------
(declare-const diz@723 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@723 $Ref.null)))
(declare-const $t@724 $Snap)
(push) ; 3
(declare-const $k@725 $Perm)
(assert ($Perm.isValidVar $k@725))
(assert ($Perm.isReadVar $k@725 $Perm.Write))
(declare-const $t@726 $Ref)
(push) ; 4
(assert (not (not (= $k@725 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@725 $Perm.No)))
(assert (not (= $t@726 $Ref.null)))
(declare-const $k@727 $Perm)
(assert ($Perm.isValidVar $k@727))
(assert ($Perm.isReadVar $k@727 $Perm.Write))
(declare-const $t@728 Int)
; [eval] diz.OfferWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@727 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@727 $Perm.No)))
(assert (> $t@728 0))
(declare-const $k@729 $Perm)
(assert ($Perm.isValidVar $k@729))
(assert ($Perm.isReadVar $k@729 $Perm.Write))
(declare-const $t@730 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@729 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@729 $Perm.No)))
(assert (not (= $t@730 $Ref.null)))
(declare-const $k@731 $Perm)
(assert ($Perm.isValidVar $k@731))
(assert ($Perm.isReadVar $k@731 $Perm.Write))
(declare-const $t@732 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@731 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@731 $Perm.No)))
(assert (not (= $t@732 $Ref.null)))
(declare-const $k@733 $Perm)
(assert ($Perm.isValidVar $k@733))
(assert ($Perm.isReadVar $k@733 $Perm.Write))
(declare-const $t@734 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferWorker__queue
(push) ; 4
(assert (not (not (= $k@733 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@733 $Perm.No)))
(assert (= $t@734 $t@726))
(declare-const $k@735 $Perm)
(assert ($Perm.isValidVar $k@735))
(assert ($Perm.isReadVar $k@735 $Perm.Write))
(declare-const $t@736 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@735 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@735 $Perm.No)))
(assert (not (= $t@736 $Ref.null)))
(declare-const $k@737 $Perm)
(assert ($Perm.isValidVar $k@737))
(assert ($Perm.isReadVar $k@737 $Perm.Write))
(declare-const $t@738 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferWorker__queue
(push) ; 4
(assert (not (not (= $k@737 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@737 $Perm.No)))
(assert (= $t@738 $t@726))
(pop) ; 3
(push) ; 3
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- OfferWorker__run ----------
(declare-const diz@739 $Ref)
(declare-const b@740 Bool)
(declare-const __flatten_19@741 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@739 $Ref.null)))
(declare-const $k@742 $Perm)
(assert ($Perm.isValidVar $k@742))
(assert ($Perm.isReadVar $k@742 $Perm.Write))
(declare-const $t@743 $Ref)
(push) ; 3
(assert (not (not (= $k@742 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@742 $Perm.No)))
(assert (not (= $t@743 $Ref.null)))
(declare-const $k@744 $Perm)
(assert ($Perm.isValidVar $k@744))
(assert ($Perm.isReadVar $k@744 $Perm.Write))
(declare-const $t@745 Int)
; [eval] diz.OfferWorker__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@744 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@744 $Perm.No)))
(assert (> $t@745 0))
(declare-const $k@746 $Perm)
(assert ($Perm.isValidVar $k@746))
(assert ($Perm.isReadVar $k@746 $Perm.Write))
(declare-const $t@747 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@746 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@746 $Perm.No)))
(assert (not (= $t@747 $Ref.null)))
(declare-const $k@748 $Perm)
(assert ($Perm.isValidVar $k@748))
(assert ($Perm.isReadVar $k@748 $Perm.Write))
(declare-const $t@749 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@748 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@748 $Perm.No)))
(assert (not (= $t@749 $Ref.null)))
(declare-const $k@750 $Perm)
(assert ($Perm.isValidVar $k@750))
(assert ($Perm.isReadVar $k@750 $Perm.Write))
(declare-const $t@751 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferWorker__queue
(push) ; 3
(assert (not (not (= $k@750 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@750 $Perm.No)))
(assert (= $t@751 $t@743))
(declare-const $k@752 $Perm)
(assert ($Perm.isValidVar $k@752))
(assert ($Perm.isReadVar $k@752 $Perm.Write))
(declare-const $t@753 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@752 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@752 $Perm.No)))
(assert (not (= $t@753 $Ref.null)))
(declare-const $k@754 $Perm)
(assert ($Perm.isValidVar $k@754))
(assert ($Perm.isReadVar $k@754 $Perm.Write))
(declare-const $t@755 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferWorker__queue
(push) ; 3
(assert (not (not (= $k@754 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@754 $Perm.No)))
(assert (= $t@755 $t@743))
(push) ; 3
(declare-const $k@756 $Perm)
(assert ($Perm.isValidVar $k@756))
(assert ($Perm.isReadVar $k@756 $Perm.Write))
(declare-const $t@757 $Ref)
(push) ; 4
(assert (not (not (= $k@756 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@756 $Perm.No)))
(assert (not (= $t@757 $Ref.null)))
(declare-const $k@758 $Perm)
(assert ($Perm.isValidVar $k@758))
(assert ($Perm.isReadVar $k@758 $Perm.Write))
(declare-const $t@759 Int)
; [eval] diz.OfferWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@758 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@758 $Perm.No)))
(assert (> $t@759 0))
(declare-const $k@760 $Perm)
(assert ($Perm.isValidVar $k@760))
(assert ($Perm.isReadVar $k@760 $Perm.Write))
(declare-const $t@761 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@760 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@760 $Perm.No)))
(assert (not (= $t@761 $Ref.null)))
(declare-const $k@762 $Perm)
(assert ($Perm.isValidVar $k@762))
(assert ($Perm.isReadVar $k@762 $Perm.Write))
(declare-const $t@763 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@762 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@762 $Perm.No)))
(assert (not (= $t@763 $Ref.null)))
(declare-const $k@764 $Perm)
(assert ($Perm.isValidVar $k@764))
(assert ($Perm.isReadVar $k@764 $Perm.Write))
(declare-const $t@765 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferWorker__queue
(push) ; 4
(assert (not (not (= $k@764 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@764 $Perm.No)))
(assert (= $t@765 $t@757))
(declare-const $k@766 $Perm)
(assert ($Perm.isValidVar $k@766))
(assert ($Perm.isReadVar $k@766 $Perm.Write))
(declare-const $t@767 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@766 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@766 $Perm.No)))
(assert (not (= $t@767 $Ref.null)))
(declare-const $k@768 $Perm)
(assert ($Perm.isValidVar $k@768))
(assert ($Perm.isReadVar $k@768 $Perm.Write))
(declare-const $t@769 $Ref)
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferWorker__queue
(push) ; 4
(assert (not (not (= $k@768 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@768 $Perm.No)))
(assert (= $t@769 $t@757))
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_19 := BlockingQueue__offer(diz.OfferWorker__queue, 7)
; [eval] diz != null
(declare-const $k@770 $Perm)
(assert ($Perm.isValidVar $k@770))
(assert ($Perm.isReadVar $k@770 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@770 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@770 $k@744))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@771 $Perm)
(assert ($Perm.isValidVar $k@771))
(assert ($Perm.isReadVar $k@771 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@771 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@771 $k@746))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@772 $Perm)
(assert ($Perm.isValidVar $k@772))
(assert ($Perm.isReadVar $k@772 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@772 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@772 $k@748))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@773 $Perm)
(assert ($Perm.isValidVar $k@773))
(assert ($Perm.isReadVar $k@773 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@773 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@773 $k@750))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@774 $Perm)
(assert ($Perm.isValidVar $k@774))
(assert ($Perm.isReadVar $k@774 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@774 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@774 $k@752))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@775 $Perm)
(assert ($Perm.isValidVar $k@775))
(assert ($Perm.isReadVar $k@775 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@775 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@775 $k@754))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@776 Bool)
(declare-const $t@777 $Snap)
(declare-const $t@778 $Snap)
(assert (= $t@777 ($Snap.combine $t@778 $Snap.unit)))
(declare-const $t@779 $Snap)
(declare-const $t@780 $Ref)
(assert (= $t@778 ($Snap.combine $t@779 ($SortWrappers.$RefTo$Snap $t@780))))
(declare-const $t@781 $Snap)
(assert (= $t@779 ($Snap.combine $t@781 $Snap.unit)))
(declare-const $t@782 $Snap)
(declare-const $t@783 $Ref)
(assert (= $t@781 ($Snap.combine $t@782 ($SortWrappers.$RefTo$Snap $t@783))))
(declare-const $t@784 $Snap)
(assert (= $t@782 ($Snap.combine $t@784 $Snap.unit)))
(declare-const $t@785 $Snap)
(declare-const $t@786 $Ref)
(assert (= $t@784 ($Snap.combine $t@785 ($SortWrappers.$RefTo$Snap $t@786))))
(declare-const $t@787 $Snap)
(assert (= $t@785 ($Snap.combine $t@787 $Snap.unit)))
(declare-const $t@788 $Snap)
(declare-const $t@789 $Ref)
(assert (= $t@787 ($Snap.combine $t@788 ($SortWrappers.$RefTo$Snap $t@789))))
(declare-const $t@790 $Snap)
(assert (= $t@788 ($Snap.combine $t@790 $Snap.unit)))
(declare-const $t@791 Int)
(declare-const $t@792 $Ref)
(assert (=
  $t@790
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@791)
    ($SortWrappers.$RefTo$Snap $t@792))))
(declare-const $t@793 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@791)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@793) $Snap.unit)))
(declare-const $k@794 $Perm)
(assert ($Perm.isValidVar $k@794))
(assert ($Perm.isReadVar $k@794 $Perm.Write))
(assert (implies (< $Perm.No (- $k@744 $k@770)) (= $t@793 $t@745)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@744 $k@770) $k@794) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@744 $k@770) $k@794) $Perm.No)))
(assert (> $t@793 0))
(declare-const $k@795 $Perm)
(assert ($Perm.isValidVar $k@795))
(assert ($Perm.isReadVar $k@795 $Perm.Write))
(assert (implies (< $Perm.No (- $k@746 $k@771)) (= $t@792 $t@747)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@746 $k@771) $k@795) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@746 $k@771) $k@795) $Perm.No)))
(assert (not (= $t@792 $Ref.null)))
(declare-const $k@796 $Perm)
(assert ($Perm.isValidVar $k@796))
(assert ($Perm.isReadVar $k@796 $Perm.Write))
(assert (implies (< $Perm.No (- $k@748 $k@772)) (= $t@789 $t@749)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@748 $k@772) $k@796) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@748 $k@772) $k@796) $Perm.No)))
(assert (not (= $t@789 $Ref.null)))
(declare-const $k@797 $Perm)
(assert ($Perm.isValidVar $k@797))
(assert ($Perm.isReadVar $k@797 $Perm.Write))
(push) ; 4
(assert (not (= $t@749 $t@789)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@750 $k@773)) (= $t@786 $t@751)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@749 $t@789)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@750 $k@773) $k@797) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@750 $k@773) $k@797) $Perm.No)))
(assert (= $t@786 $t@743))
(declare-const $k@798 $Perm)
(assert ($Perm.isValidVar $k@798))
(assert ($Perm.isReadVar $k@798 $Perm.Write))
(assert (implies (< $Perm.No (- $k@752 $k@774)) (= $t@783 $t@753)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@752 $k@774) $k@798) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@752 $k@774) $k@798) $Perm.No)))
(assert (not (= $t@783 $Ref.null)))
(declare-const $k@799 $Perm)
(assert ($Perm.isValidVar $k@799))
(assert ($Perm.isReadVar $k@799 $Perm.Write))
(push) ; 4
(assert (not (= $t@753 $t@783)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@754 $k@775)) (= $t@780 $t@755)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@753 $t@783)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@754 $k@775) $k@799) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@754 $k@775) $k@799) $Perm.No)))
(assert (= $t@780 $t@743))
; [exec]
; b := __flatten_19
(declare-const $k@800 $Perm)
(assert ($Perm.isValidVar $k@800))
(assert ($Perm.isReadVar $k@800 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@800 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@800 $k@742))
(declare-const $k@801 $Perm)
(assert ($Perm.isValidVar $k@801))
(assert ($Perm.isReadVar $k@801 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@801 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@801 (+ (- $k@744 $k@770) $k@794)))
; [eval] diz.OfferWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@802 $Perm)
(assert ($Perm.isValidVar $k@802))
(assert ($Perm.isReadVar $k@802 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@802 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@802 (+ (- $k@746 $k@771) $k@795)))
; [eval] diz.OfferWorker__queue.BlockingQueue__count != null
(declare-const $k@803 $Perm)
(assert ($Perm.isValidVar $k@803))
(assert ($Perm.isReadVar $k@803 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@803 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@803 (+ (- $k@748 $k@772) $k@796)))
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock != null
(declare-const $k@804 $Perm)
(assert ($Perm.isValidVar $k@804))
(assert ($Perm.isReadVar $k@804 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@804 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@749 $t@789)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@804 (+ (- $k@750 $k@773) $k@797)))
; [eval] diz.OfferWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferWorker__queue
(push) ; 4
(assert (not (= $t@749 $t@789)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@805 $Perm)
(assert ($Perm.isValidVar $k@805))
(assert ($Perm.isReadVar $k@805 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@805 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@805 (+ (- $k@752 $k@774) $k@798)))
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@806 $Perm)
(assert ($Perm.isValidVar $k@806))
(assert ($Perm.isReadVar $k@806 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@806 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@753 $t@783)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@806 (+ (- $k@754 $k@775) $k@799)))
; [eval] diz.OfferWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferWorker__queue
(push) ; 4
(assert (not (= $t@753 $t@783)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Test__testEmpty ----------
(declare-const diz@807 $Ref)
(declare-const queue@808 $Ref)
(declare-const __flatten_20@809 $Ref)
(declare-const i@810 $Ref)
(declare-const __flatten_21@811 $Ref)
(declare-const j@812 $Ref)
(declare-const __flatten_22@813 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@807 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_20 := BlockingQueue__BlockingQueue(10)
; [eval] capacity > 0
(declare-const sys__result@814 $Ref)
(declare-const $t@815 $Snap)
(declare-const $t@816 $Snap)
(assert (= $t@815 ($Snap.combine $t@816 $Snap.unit)))
(declare-const $t@817 $Snap)
(assert (= $t@816 ($Snap.combine $t@817 $Snap.unit)))
(declare-const $t@818 $Snap)
(declare-const $t@819 $Ref)
(assert (= $t@817 ($Snap.combine $t@818 ($SortWrappers.$RefTo$Snap $t@819))))
(declare-const $t@820 $Snap)
(assert (= $t@818 ($Snap.combine $t@820 $Snap.unit)))
(declare-const $t@821 $Snap)
(declare-const $t@822 $Ref)
(assert (= $t@820 ($Snap.combine $t@821 ($SortWrappers.$RefTo$Snap $t@822))))
(declare-const $t@823 $Snap)
(assert (= $t@821 ($Snap.combine $t@823 $Snap.unit)))
(declare-const $t@824 $Snap)
(declare-const $t@825 $Ref)
(assert (= $t@823 ($Snap.combine $t@824 ($SortWrappers.$RefTo$Snap $t@825))))
(declare-const $t@826 $Snap)
(assert (= $t@824 ($Snap.combine $t@826 $Snap.unit)))
(declare-const $t@827 $Snap)
(declare-const $t@828 $Ref)
(assert (= $t@826 ($Snap.combine $t@827 ($SortWrappers.$RefTo$Snap $t@828))))
(declare-const $t@829 $Snap)
(assert (= $t@827 ($Snap.combine $t@829 $Snap.unit)))
(declare-const $t@830 Int)
(declare-const $t@831 $Ref)
(assert (=
  $t@829
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@830)
    ($SortWrappers.$RefTo$Snap $t@831))))
(declare-const $t@832 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@830)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@832) $Snap.unit)))
(declare-const $t@833 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@832)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@833))))
; [eval] sys__result != null
(assert (not (= sys__result@814 $Ref.null)))
(declare-const $k@834 $Perm)
(assert ($Perm.isValidVar $k@834))
(assert ($Perm.isReadVar $k@834 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@834 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@834 $Perm.No)))
(assert (> $t@833 0))
(declare-const $k@835 $Perm)
(assert ($Perm.isValidVar $k@835))
(assert ($Perm.isReadVar $k@835 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@835 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@835 $Perm.No)))
(assert (not (= $t@831 $Ref.null)))
(declare-const $k@836 $Perm)
(assert ($Perm.isValidVar $k@836))
(assert ($Perm.isReadVar $k@836 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@836 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@836 $Perm.No)))
(assert (not (= $t@828 $Ref.null)))
(declare-const $k@837 $Perm)
(assert ($Perm.isValidVar $k@837))
(assert ($Perm.isReadVar $k@837 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@837 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@837 $Perm.No)))
(assert (= $t@825 sys__result@814))
(declare-const $k@838 $Perm)
(assert ($Perm.isValidVar $k@838))
(assert ($Perm.isReadVar $k@838 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@838 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@838 $Perm.No)))
(assert (not (= $t@822 $Ref.null)))
(declare-const $k@839 $Perm)
(assert ($Perm.isValidVar $k@839))
(assert ($Perm.isReadVar $k@839 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@839 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@839 $Perm.No)))
(assert (= $t@819 sys__result@814))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@833 10))
; [exec]
; queue := __flatten_20
; [exec]
; __flatten_21 := BlockingQueue__peek(queue)
; [eval] diz != null
(declare-const $k@840 $Perm)
(assert ($Perm.isValidVar $k@840))
(assert ($Perm.isReadVar $k@840 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@840 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@840 $k@834))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@841 $Perm)
(assert ($Perm.isValidVar $k@841))
(assert ($Perm.isReadVar $k@841 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@841 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@841 $k@835))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@842 $Perm)
(assert ($Perm.isValidVar $k@842))
(assert ($Perm.isReadVar $k@842 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@842 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@842 $k@836))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@843 $Perm)
(assert ($Perm.isValidVar $k@843))
(assert ($Perm.isReadVar $k@843 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@843 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@843 $k@837))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@844 $Perm)
(assert ($Perm.isValidVar $k@844))
(assert ($Perm.isReadVar $k@844 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@844 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@844 $k@838))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@845 $Perm)
(assert ($Perm.isValidVar $k@845))
(assert ($Perm.isReadVar $k@845 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@845 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@845 $k@839))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@846 $Ref)
(declare-const $t@847 $Snap)
(declare-const $t@848 $Snap)
(assert (= $t@847 ($Snap.combine $t@848 $Snap.unit)))
(declare-const $t@849 $Snap)
(declare-const $t@850 $Ref)
(assert (= $t@848 ($Snap.combine $t@849 ($SortWrappers.$RefTo$Snap $t@850))))
(declare-const $t@851 $Snap)
(assert (= $t@849 ($Snap.combine $t@851 $Snap.unit)))
(declare-const $t@852 $Snap)
(declare-const $t@853 $Ref)
(assert (= $t@851 ($Snap.combine $t@852 ($SortWrappers.$RefTo$Snap $t@853))))
(declare-const $t@854 $Snap)
(assert (= $t@852 ($Snap.combine $t@854 $Snap.unit)))
(declare-const $t@855 $Snap)
(declare-const $t@856 $Ref)
(assert (= $t@854 ($Snap.combine $t@855 ($SortWrappers.$RefTo$Snap $t@856))))
(declare-const $t@857 $Snap)
(assert (= $t@855 ($Snap.combine $t@857 $Snap.unit)))
(declare-const $t@858 $Snap)
(declare-const $t@859 $Ref)
(assert (= $t@857 ($Snap.combine $t@858 ($SortWrappers.$RefTo$Snap $t@859))))
(declare-const $t@860 $Snap)
(assert (= $t@858 ($Snap.combine $t@860 $Snap.unit)))
(declare-const $t@861 Int)
(declare-const $t@862 $Ref)
(assert (=
  $t@860
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@861)
    ($SortWrappers.$RefTo$Snap $t@862))))
(declare-const $t@863 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@861)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@863) $Snap.unit)))
(declare-const $k@864 $Perm)
(assert ($Perm.isValidVar $k@864))
(assert ($Perm.isReadVar $k@864 $Perm.Write))
(assert (implies (< $Perm.No (- $k@834 $k@840)) (= $t@863 $t@833)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@834 $k@840) $k@864) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@834 $k@840) $k@864) $Perm.No)))
(assert (> $t@863 0))
(declare-const $k@865 $Perm)
(assert ($Perm.isValidVar $k@865))
(assert ($Perm.isReadVar $k@865 $Perm.Write))
(assert (implies (< $Perm.No (- $k@835 $k@841)) (= $t@862 $t@831)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@835 $k@841) $k@865) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@835 $k@841) $k@865) $Perm.No)))
(assert (not (= $t@862 $Ref.null)))
(declare-const $k@866 $Perm)
(assert ($Perm.isValidVar $k@866))
(assert ($Perm.isReadVar $k@866 $Perm.Write))
(assert (implies (< $Perm.No (- $k@836 $k@842)) (= $t@859 $t@828)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@836 $k@842) $k@866) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@836 $k@842) $k@866) $Perm.No)))
(assert (not (= $t@859 $Ref.null)))
(declare-const $k@867 $Perm)
(assert ($Perm.isValidVar $k@867))
(assert ($Perm.isReadVar $k@867 $Perm.Write))
(push) ; 4
(assert (not (= $t@828 $t@859)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@837 $k@843)) (= $t@856 $t@825)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@828 $t@859)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@837 $k@843) $k@867) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@837 $k@843) $k@867) $Perm.No)))
(assert (= $t@856 sys__result@814))
(declare-const $k@868 $Perm)
(assert ($Perm.isValidVar $k@868))
(assert ($Perm.isReadVar $k@868 $Perm.Write))
(assert (implies (< $Perm.No (- $k@838 $k@844)) (= $t@853 $t@822)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@838 $k@844) $k@868) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@838 $k@844) $k@868) $Perm.No)))
(assert (not (= $t@853 $Ref.null)))
(declare-const $k@869 $Perm)
(assert ($Perm.isValidVar $k@869))
(assert ($Perm.isReadVar $k@869 $Perm.Write))
(push) ; 4
(assert (not (= $t@822 $t@853)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@839 $k@845)) (= $t@850 $t@819)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@822 $t@853)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@839 $k@845) $k@869) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@839 $k@845) $k@869) $Perm.No)))
(assert (= $t@850 sys__result@814))
; [exec]
; i := __flatten_21
; [exec]
; __flatten_22 := BlockingQueue__poll(queue)
; [eval] diz != null
(declare-const $k@870 $Perm)
(assert ($Perm.isValidVar $k@870))
(assert ($Perm.isReadVar $k@870 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@870 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@870 (+ (- $k@834 $k@840) $k@864)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@871 $Perm)
(assert ($Perm.isValidVar $k@871))
(assert ($Perm.isReadVar $k@871 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@871 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@871 (+ (- $k@835 $k@841) $k@865)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@872 $Perm)
(assert ($Perm.isValidVar $k@872))
(assert ($Perm.isReadVar $k@872 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@872 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@872 (+ (- $k@836 $k@842) $k@866)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@873 $Perm)
(assert ($Perm.isValidVar $k@873))
(assert ($Perm.isReadVar $k@873 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@873 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@828 $t@859)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@873 (+ (- $k@837 $k@843) $k@867)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@828 $t@859)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@874 $Perm)
(assert ($Perm.isValidVar $k@874))
(assert ($Perm.isReadVar $k@874 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@874 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@874 (+ (- $k@838 $k@844) $k@868)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@875 $Perm)
(assert ($Perm.isValidVar $k@875))
(assert ($Perm.isReadVar $k@875 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@875 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@822 $t@853)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@875 (+ (- $k@839 $k@845) $k@869)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@822 $t@853)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@876 $Ref)
(declare-const $t@877 $Snap)
(declare-const $t@878 $Snap)
(assert (= $t@877 ($Snap.combine $t@878 $Snap.unit)))
(declare-const $t@879 $Snap)
(declare-const $t@880 $Ref)
(assert (= $t@878 ($Snap.combine $t@879 ($SortWrappers.$RefTo$Snap $t@880))))
(declare-const $t@881 $Snap)
(assert (= $t@879 ($Snap.combine $t@881 $Snap.unit)))
(declare-const $t@882 $Snap)
(declare-const $t@883 $Ref)
(assert (= $t@881 ($Snap.combine $t@882 ($SortWrappers.$RefTo$Snap $t@883))))
(declare-const $t@884 $Snap)
(assert (= $t@882 ($Snap.combine $t@884 $Snap.unit)))
(declare-const $t@885 $Snap)
(declare-const $t@886 $Ref)
(assert (= $t@884 ($Snap.combine $t@885 ($SortWrappers.$RefTo$Snap $t@886))))
(declare-const $t@887 $Snap)
(assert (= $t@885 ($Snap.combine $t@887 $Snap.unit)))
(declare-const $t@888 $Snap)
(declare-const $t@889 $Ref)
(assert (= $t@887 ($Snap.combine $t@888 ($SortWrappers.$RefTo$Snap $t@889))))
(declare-const $t@890 $Snap)
(assert (= $t@888 ($Snap.combine $t@890 $Snap.unit)))
(declare-const $t@891 Int)
(declare-const $t@892 $Ref)
(assert (=
  $t@890
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@891)
    ($SortWrappers.$RefTo$Snap $t@892))))
(declare-const $t@893 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@891)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@893) $Snap.unit)))
(declare-const $k@894 $Perm)
(assert ($Perm.isValidVar $k@894))
(assert ($Perm.isReadVar $k@894 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@834 $k@840) $k@864) $k@870)) (= $t@893 $t@863)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@834 $k@840) $k@864) $k@870) $k@894) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@834 $k@840) $k@864) $k@870) $k@894) $Perm.No)))
(assert (> $t@893 0))
(declare-const $k@895 $Perm)
(assert ($Perm.isValidVar $k@895))
(assert ($Perm.isReadVar $k@895 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@835 $k@841) $k@865) $k@871)) (= $t@892 $t@862)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@835 $k@841) $k@865) $k@871) $k@895) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@835 $k@841) $k@865) $k@871) $k@895) $Perm.No)))
(assert (not (= $t@892 $Ref.null)))
(declare-const $k@896 $Perm)
(assert ($Perm.isValidVar $k@896))
(assert ($Perm.isReadVar $k@896 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@836 $k@842) $k@866) $k@872)) (= $t@889 $t@859)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@836 $k@842) $k@866) $k@872) $k@896) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@836 $k@842) $k@866) $k@872) $k@896) $Perm.No)))
(assert (not (= $t@889 $Ref.null)))
(declare-const $k@897 $Perm)
(assert ($Perm.isValidVar $k@897))
(assert ($Perm.isReadVar $k@897 $Perm.Write))
(push) ; 4
(assert (not (= $t@828 $t@889)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@837 $k@843) $k@867) $k@873)) (= $t@886 $t@856)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@828 $t@889)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@837 $k@843) $k@867) $k@873) $k@897) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@837 $k@843) $k@867) $k@873) $k@897) $Perm.No)))
(assert (= $t@886 sys__result@814))
(declare-const $k@898 $Perm)
(assert ($Perm.isValidVar $k@898))
(assert ($Perm.isReadVar $k@898 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@838 $k@844) $k@868) $k@874)) (= $t@883 $t@853)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@838 $k@844) $k@868) $k@874) $k@898) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@838 $k@844) $k@868) $k@874) $k@898) $Perm.No)))
(assert (not (= $t@883 $Ref.null)))
(declare-const $k@899 $Perm)
(assert ($Perm.isValidVar $k@899))
(assert ($Perm.isReadVar $k@899 $Perm.Write))
(push) ; 4
(assert (not (= $t@822 $t@883)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@839 $k@845) $k@869) $k@875)) (= $t@880 $t@850)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@822 $t@883)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@839 $k@845) $k@869) $k@875) $k@899) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@839 $k@845) $k@869) $k@875) $k@899) $Perm.No)))
(assert (= $t@880 sys__result@814))
; [exec]
; j := __flatten_22
(pop) ; 3
(pop) ; 2
; ---------- Test__testFillAndEmpty ----------
(declare-const diz@900 $Ref)
(declare-const queue@901 $Ref)
(declare-const __flatten_23@902 $Ref)
(declare-const b@903 Bool)
(declare-const __flatten_24@904 Bool)
(declare-const __flatten_25@905 Bool)
(declare-const m@906 $Ref)
(declare-const __flatten_26@907 $Ref)
(declare-const __flatten_27@908 Bool)
(declare-const n@909 $Ref)
(declare-const __flatten_28@910 $Ref)
(declare-const o@911 $Ref)
(declare-const __flatten_29@912 $Ref)
(declare-const p@913 $Ref)
(declare-const __flatten_30@914 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@900 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_23 := BlockingQueue__BlockingQueue(10)
; [eval] capacity > 0
(declare-const sys__result@915 $Ref)
(declare-const $t@916 $Snap)
(declare-const $t@917 $Snap)
(assert (= $t@916 ($Snap.combine $t@917 $Snap.unit)))
(declare-const $t@918 $Snap)
(assert (= $t@917 ($Snap.combine $t@918 $Snap.unit)))
(declare-const $t@919 $Snap)
(declare-const $t@920 $Ref)
(assert (= $t@918 ($Snap.combine $t@919 ($SortWrappers.$RefTo$Snap $t@920))))
(declare-const $t@921 $Snap)
(assert (= $t@919 ($Snap.combine $t@921 $Snap.unit)))
(declare-const $t@922 $Snap)
(declare-const $t@923 $Ref)
(assert (= $t@921 ($Snap.combine $t@922 ($SortWrappers.$RefTo$Snap $t@923))))
(declare-const $t@924 $Snap)
(assert (= $t@922 ($Snap.combine $t@924 $Snap.unit)))
(declare-const $t@925 $Snap)
(declare-const $t@926 $Ref)
(assert (= $t@924 ($Snap.combine $t@925 ($SortWrappers.$RefTo$Snap $t@926))))
(declare-const $t@927 $Snap)
(assert (= $t@925 ($Snap.combine $t@927 $Snap.unit)))
(declare-const $t@928 $Snap)
(declare-const $t@929 $Ref)
(assert (= $t@927 ($Snap.combine $t@928 ($SortWrappers.$RefTo$Snap $t@929))))
(declare-const $t@930 $Snap)
(assert (= $t@928 ($Snap.combine $t@930 $Snap.unit)))
(declare-const $t@931 Int)
(declare-const $t@932 $Ref)
(assert (=
  $t@930
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@931)
    ($SortWrappers.$RefTo$Snap $t@932))))
(declare-const $t@933 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@931)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@933) $Snap.unit)))
(declare-const $t@934 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@933)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@934))))
; [eval] sys__result != null
(assert (not (= sys__result@915 $Ref.null)))
(declare-const $k@935 $Perm)
(assert ($Perm.isValidVar $k@935))
(assert ($Perm.isReadVar $k@935 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@935 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@935 $Perm.No)))
(assert (> $t@934 0))
(declare-const $k@936 $Perm)
(assert ($Perm.isValidVar $k@936))
(assert ($Perm.isReadVar $k@936 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@936 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@936 $Perm.No)))
(assert (not (= $t@932 $Ref.null)))
(declare-const $k@937 $Perm)
(assert ($Perm.isValidVar $k@937))
(assert ($Perm.isReadVar $k@937 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@937 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@937 $Perm.No)))
(assert (not (= $t@929 $Ref.null)))
(declare-const $k@938 $Perm)
(assert ($Perm.isValidVar $k@938))
(assert ($Perm.isReadVar $k@938 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@938 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@938 $Perm.No)))
(assert (= $t@926 sys__result@915))
(declare-const $k@939 $Perm)
(assert ($Perm.isValidVar $k@939))
(assert ($Perm.isReadVar $k@939 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@939 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@939 $Perm.No)))
(assert (not (= $t@923 $Ref.null)))
(declare-const $k@940 $Perm)
(assert ($Perm.isValidVar $k@940))
(assert ($Perm.isReadVar $k@940 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@940 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@940 $Perm.No)))
(assert (= $t@920 sys__result@915))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@934 10))
; [exec]
; queue := __flatten_23
; [exec]
; __flatten_24 := BlockingQueue__offer(queue, 3)
; [eval] diz != null
(declare-const $k@941 $Perm)
(assert ($Perm.isValidVar $k@941))
(assert ($Perm.isReadVar $k@941 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@941 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@941 $k@935))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@942 $Perm)
(assert ($Perm.isValidVar $k@942))
(assert ($Perm.isReadVar $k@942 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@942 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@942 $k@936))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@943 $Perm)
(assert ($Perm.isValidVar $k@943))
(assert ($Perm.isReadVar $k@943 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@943 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@943 $k@937))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@944 $Perm)
(assert ($Perm.isValidVar $k@944))
(assert ($Perm.isReadVar $k@944 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@944 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@944 $k@938))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@945 $Perm)
(assert ($Perm.isValidVar $k@945))
(assert ($Perm.isReadVar $k@945 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@945 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@945 $k@939))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@946 $Perm)
(assert ($Perm.isValidVar $k@946))
(assert ($Perm.isReadVar $k@946 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@946 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@946 $k@940))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@947 Bool)
(declare-const $t@948 $Snap)
(declare-const $t@949 $Snap)
(assert (= $t@948 ($Snap.combine $t@949 $Snap.unit)))
(declare-const $t@950 $Snap)
(declare-const $t@951 $Ref)
(assert (= $t@949 ($Snap.combine $t@950 ($SortWrappers.$RefTo$Snap $t@951))))
(declare-const $t@952 $Snap)
(assert (= $t@950 ($Snap.combine $t@952 $Snap.unit)))
(declare-const $t@953 $Snap)
(declare-const $t@954 $Ref)
(assert (= $t@952 ($Snap.combine $t@953 ($SortWrappers.$RefTo$Snap $t@954))))
(declare-const $t@955 $Snap)
(assert (= $t@953 ($Snap.combine $t@955 $Snap.unit)))
(declare-const $t@956 $Snap)
(declare-const $t@957 $Ref)
(assert (= $t@955 ($Snap.combine $t@956 ($SortWrappers.$RefTo$Snap $t@957))))
(declare-const $t@958 $Snap)
(assert (= $t@956 ($Snap.combine $t@958 $Snap.unit)))
(declare-const $t@959 $Snap)
(declare-const $t@960 $Ref)
(assert (= $t@958 ($Snap.combine $t@959 ($SortWrappers.$RefTo$Snap $t@960))))
(declare-const $t@961 $Snap)
(assert (= $t@959 ($Snap.combine $t@961 $Snap.unit)))
(declare-const $t@962 Int)
(declare-const $t@963 $Ref)
(assert (=
  $t@961
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@962)
    ($SortWrappers.$RefTo$Snap $t@963))))
(declare-const $t@964 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@962)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@964) $Snap.unit)))
(declare-const $k@965 $Perm)
(assert ($Perm.isValidVar $k@965))
(assert ($Perm.isReadVar $k@965 $Perm.Write))
(assert (implies (< $Perm.No (- $k@935 $k@941)) (= $t@964 $t@934)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@935 $k@941) $k@965) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@935 $k@941) $k@965) $Perm.No)))
(assert (> $t@964 0))
(declare-const $k@966 $Perm)
(assert ($Perm.isValidVar $k@966))
(assert ($Perm.isReadVar $k@966 $Perm.Write))
(assert (implies (< $Perm.No (- $k@936 $k@942)) (= $t@963 $t@932)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@936 $k@942) $k@966) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@936 $k@942) $k@966) $Perm.No)))
(assert (not (= $t@963 $Ref.null)))
(declare-const $k@967 $Perm)
(assert ($Perm.isValidVar $k@967))
(assert ($Perm.isReadVar $k@967 $Perm.Write))
(assert (implies (< $Perm.No (- $k@937 $k@943)) (= $t@960 $t@929)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@937 $k@943) $k@967) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@937 $k@943) $k@967) $Perm.No)))
(assert (not (= $t@960 $Ref.null)))
(declare-const $k@968 $Perm)
(assert ($Perm.isValidVar $k@968))
(assert ($Perm.isReadVar $k@968 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@960)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@938 $k@944)) (= $t@957 $t@926)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@960)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@938 $k@944) $k@968) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@938 $k@944) $k@968) $Perm.No)))
(assert (= $t@957 sys__result@915))
(declare-const $k@969 $Perm)
(assert ($Perm.isValidVar $k@969))
(assert ($Perm.isReadVar $k@969 $Perm.Write))
(assert (implies (< $Perm.No (- $k@939 $k@945)) (= $t@954 $t@923)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@939 $k@945) $k@969) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@939 $k@945) $k@969) $Perm.No)))
(assert (not (= $t@954 $Ref.null)))
(declare-const $k@970 $Perm)
(assert ($Perm.isValidVar $k@970))
(assert ($Perm.isReadVar $k@970 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@954)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@940 $k@946)) (= $t@951 $t@920)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@954)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@940 $k@946) $k@970) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@940 $k@946) $k@970) $Perm.No)))
(assert (= $t@951 sys__result@915))
; [exec]
; b := __flatten_24
; [exec]
; __flatten_25 := BlockingQueue__offer(queue, 5)
; [eval] diz != null
(declare-const $k@971 $Perm)
(assert ($Perm.isValidVar $k@971))
(assert ($Perm.isReadVar $k@971 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@971 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@971 (+ (- $k@935 $k@941) $k@965)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@972 $Perm)
(assert ($Perm.isValidVar $k@972))
(assert ($Perm.isReadVar $k@972 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@972 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@972 (+ (- $k@936 $k@942) $k@966)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@973 $Perm)
(assert ($Perm.isValidVar $k@973))
(assert ($Perm.isReadVar $k@973 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@973 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@973 (+ (- $k@937 $k@943) $k@967)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@974 $Perm)
(assert ($Perm.isValidVar $k@974))
(assert ($Perm.isReadVar $k@974 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@974 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@929 $t@960)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@974 (+ (- $k@938 $k@944) $k@968)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@960)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@975 $Perm)
(assert ($Perm.isValidVar $k@975))
(assert ($Perm.isReadVar $k@975 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@975 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@975 (+ (- $k@939 $k@945) $k@969)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@976 $Perm)
(assert ($Perm.isValidVar $k@976))
(assert ($Perm.isReadVar $k@976 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@976 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@923 $t@954)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@976 (+ (- $k@940 $k@946) $k@970)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@954)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@977 Bool)
(declare-const $t@978 $Snap)
(declare-const $t@979 $Snap)
(assert (= $t@978 ($Snap.combine $t@979 $Snap.unit)))
(declare-const $t@980 $Snap)
(declare-const $t@981 $Ref)
(assert (= $t@979 ($Snap.combine $t@980 ($SortWrappers.$RefTo$Snap $t@981))))
(declare-const $t@982 $Snap)
(assert (= $t@980 ($Snap.combine $t@982 $Snap.unit)))
(declare-const $t@983 $Snap)
(declare-const $t@984 $Ref)
(assert (= $t@982 ($Snap.combine $t@983 ($SortWrappers.$RefTo$Snap $t@984))))
(declare-const $t@985 $Snap)
(assert (= $t@983 ($Snap.combine $t@985 $Snap.unit)))
(declare-const $t@986 $Snap)
(declare-const $t@987 $Ref)
(assert (= $t@985 ($Snap.combine $t@986 ($SortWrappers.$RefTo$Snap $t@987))))
(declare-const $t@988 $Snap)
(assert (= $t@986 ($Snap.combine $t@988 $Snap.unit)))
(declare-const $t@989 $Snap)
(declare-const $t@990 $Ref)
(assert (= $t@988 ($Snap.combine $t@989 ($SortWrappers.$RefTo$Snap $t@990))))
(declare-const $t@991 $Snap)
(assert (= $t@989 ($Snap.combine $t@991 $Snap.unit)))
(declare-const $t@992 Int)
(declare-const $t@993 $Ref)
(assert (=
  $t@991
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@992)
    ($SortWrappers.$RefTo$Snap $t@993))))
(declare-const $t@994 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@992)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@994) $Snap.unit)))
(declare-const $k@995 $Perm)
(assert ($Perm.isValidVar $k@995))
(assert ($Perm.isReadVar $k@995 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@935 $k@941) $k@965) $k@971)) (= $t@994 $t@964)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $Perm.No)))
(assert (> $t@994 0))
(declare-const $k@996 $Perm)
(assert ($Perm.isValidVar $k@996))
(assert ($Perm.isReadVar $k@996 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@936 $k@942) $k@966) $k@972)) (= $t@993 $t@963)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $Perm.No)))
(assert (not (= $t@993 $Ref.null)))
(declare-const $k@997 $Perm)
(assert ($Perm.isValidVar $k@997))
(assert ($Perm.isReadVar $k@997 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@937 $k@943) $k@967) $k@973)) (= $t@990 $t@960)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $Perm.No)))
(assert (not (= $t@990 $Ref.null)))
(declare-const $k@998 $Perm)
(assert ($Perm.isValidVar $k@998))
(assert ($Perm.isReadVar $k@998 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@990)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@938 $k@944) $k@968) $k@974)) (= $t@987 $t@957)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@990)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $Perm.No)))
(assert (= $t@987 sys__result@915))
(declare-const $k@999 $Perm)
(assert ($Perm.isValidVar $k@999))
(assert ($Perm.isReadVar $k@999 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@939 $k@945) $k@969) $k@975)) (= $t@984 $t@954)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $Perm.No)))
(assert (not (= $t@984 $Ref.null)))
(declare-const $k@1000 $Perm)
(assert ($Perm.isValidVar $k@1000))
(assert ($Perm.isReadVar $k@1000 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@984)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- (+ (- $k@940 $k@946) $k@970) $k@976)) (= $t@981 $t@951)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@984)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $Perm.No)))
(assert (= $t@981 sys__result@915))
; [exec]
; b := __flatten_25
; [exec]
; __flatten_26 := BlockingQueue__poll(queue)
; [eval] diz != null
(declare-const $k@1001 $Perm)
(assert ($Perm.isValidVar $k@1001))
(assert ($Perm.isReadVar $k@1001 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1001 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1001 (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1002 $Perm)
(assert ($Perm.isValidVar $k@1002))
(assert ($Perm.isReadVar $k@1002 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1002 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1002 (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1003 $Perm)
(assert ($Perm.isValidVar $k@1003))
(assert ($Perm.isReadVar $k@1003 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1003 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1003 (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1004 $Perm)
(assert ($Perm.isValidVar $k@1004))
(assert ($Perm.isReadVar $k@1004 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1004 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@929 $t@990)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1004 (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@990)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1005 $Perm)
(assert ($Perm.isValidVar $k@1005))
(assert ($Perm.isReadVar $k@1005 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1005 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1005 (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1006 $Perm)
(assert ($Perm.isValidVar $k@1006))
(assert ($Perm.isReadVar $k@1006 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1006 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@923 $t@984)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1006 (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@984)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1007 $Ref)
(declare-const $t@1008 $Snap)
(declare-const $t@1009 $Snap)
(assert (= $t@1008 ($Snap.combine $t@1009 $Snap.unit)))
(declare-const $t@1010 $Snap)
(declare-const $t@1011 $Ref)
(assert (= $t@1009 ($Snap.combine $t@1010 ($SortWrappers.$RefTo$Snap $t@1011))))
(declare-const $t@1012 $Snap)
(assert (= $t@1010 ($Snap.combine $t@1012 $Snap.unit)))
(declare-const $t@1013 $Snap)
(declare-const $t@1014 $Ref)
(assert (= $t@1012 ($Snap.combine $t@1013 ($SortWrappers.$RefTo$Snap $t@1014))))
(declare-const $t@1015 $Snap)
(assert (= $t@1013 ($Snap.combine $t@1015 $Snap.unit)))
(declare-const $t@1016 $Snap)
(declare-const $t@1017 $Ref)
(assert (= $t@1015 ($Snap.combine $t@1016 ($SortWrappers.$RefTo$Snap $t@1017))))
(declare-const $t@1018 $Snap)
(assert (= $t@1016 ($Snap.combine $t@1018 $Snap.unit)))
(declare-const $t@1019 $Snap)
(declare-const $t@1020 $Ref)
(assert (= $t@1018 ($Snap.combine $t@1019 ($SortWrappers.$RefTo$Snap $t@1020))))
(declare-const $t@1021 $Snap)
(assert (= $t@1019 ($Snap.combine $t@1021 $Snap.unit)))
(declare-const $t@1022 Int)
(declare-const $t@1023 $Ref)
(assert (=
  $t@1021
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1022)
    ($SortWrappers.$RefTo$Snap $t@1023))))
(declare-const $t@1024 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1022)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1024) $Snap.unit)))
(declare-const $k@1025 $Perm)
(assert ($Perm.isValidVar $k@1025))
(assert ($Perm.isReadVar $k@1025 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001))
  (= $t@1024 $t@994)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+ (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001) $k@1025)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+ (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001) $k@1025)
    $Perm.No)))
(assert (> $t@1024 0))
(declare-const $k@1026 $Perm)
(assert ($Perm.isValidVar $k@1026))
(assert ($Perm.isReadVar $k@1026 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002))
  (= $t@1023 $t@993)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+ (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002) $k@1026)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+ (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002) $k@1026)
    $Perm.No)))
(assert (not (= $t@1023 $Ref.null)))
(declare-const $k@1027 $Perm)
(assert ($Perm.isValidVar $k@1027))
(assert ($Perm.isReadVar $k@1027 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003))
  (= $t@1020 $t@990)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+ (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003) $k@1027)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+ (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003) $k@1027)
    $Perm.No)))
(assert (not (= $t@1020 $Ref.null)))
(declare-const $k@1028 $Perm)
(assert ($Perm.isValidVar $k@1028))
(assert ($Perm.isReadVar $k@1028 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@1020)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (< $Perm.No (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004))
  (= $t@1017 $t@987)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1020)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+ (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004) $k@1028)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+ (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004) $k@1028)
    $Perm.No)))
(assert (= $t@1017 sys__result@915))
(declare-const $k@1029 $Perm)
(assert ($Perm.isValidVar $k@1029))
(assert ($Perm.isReadVar $k@1029 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005))
  (= $t@1014 $t@984)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+ (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005) $k@1029)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+ (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005) $k@1029)
    $Perm.No)))
(assert (not (= $t@1014 $Ref.null)))
(declare-const $k@1030 $Perm)
(assert ($Perm.isValidVar $k@1030))
(assert ($Perm.isReadVar $k@1030 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@1014)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (< $Perm.No (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006))
  (= $t@1011 $t@981)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1014)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+ (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006) $k@1030)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+ (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006) $k@1030)
    $Perm.No)))
(assert (= $t@1011 sys__result@915))
; [exec]
; m := __flatten_26
; [exec]
; __flatten_27 := BlockingQueue__offer(queue, 7)
; [eval] diz != null
(declare-const $k@1031 $Perm)
(assert ($Perm.isValidVar $k@1031))
(assert ($Perm.isReadVar $k@1031 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1031 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1031
  (+ (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001) $k@1025)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1032 $Perm)
(assert ($Perm.isValidVar $k@1032))
(assert ($Perm.isReadVar $k@1032 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1032 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1032
  (+ (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002) $k@1026)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1033 $Perm)
(assert ($Perm.isValidVar $k@1033))
(assert ($Perm.isReadVar $k@1033 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1033 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1033
  (+ (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003) $k@1027)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1034 $Perm)
(assert ($Perm.isValidVar $k@1034))
(assert ($Perm.isReadVar $k@1034 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1034 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@929 $t@1020)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1034
  (+ (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004) $k@1028)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1020)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1035 $Perm)
(assert ($Perm.isValidVar $k@1035))
(assert ($Perm.isReadVar $k@1035 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1035 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1035
  (+ (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005) $k@1029)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1036 $Perm)
(assert ($Perm.isValidVar $k@1036))
(assert ($Perm.isReadVar $k@1036 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1036 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@923 $t@1014)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1036
  (+ (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006) $k@1030)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1014)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1037 Bool)
(declare-const $t@1038 $Snap)
(declare-const $t@1039 $Snap)
(assert (= $t@1038 ($Snap.combine $t@1039 $Snap.unit)))
(declare-const $t@1040 $Snap)
(declare-const $t@1041 $Ref)
(assert (= $t@1039 ($Snap.combine $t@1040 ($SortWrappers.$RefTo$Snap $t@1041))))
(declare-const $t@1042 $Snap)
(assert (= $t@1040 ($Snap.combine $t@1042 $Snap.unit)))
(declare-const $t@1043 $Snap)
(declare-const $t@1044 $Ref)
(assert (= $t@1042 ($Snap.combine $t@1043 ($SortWrappers.$RefTo$Snap $t@1044))))
(declare-const $t@1045 $Snap)
(assert (= $t@1043 ($Snap.combine $t@1045 $Snap.unit)))
(declare-const $t@1046 $Snap)
(declare-const $t@1047 $Ref)
(assert (= $t@1045 ($Snap.combine $t@1046 ($SortWrappers.$RefTo$Snap $t@1047))))
(declare-const $t@1048 $Snap)
(assert (= $t@1046 ($Snap.combine $t@1048 $Snap.unit)))
(declare-const $t@1049 $Snap)
(declare-const $t@1050 $Ref)
(assert (= $t@1048 ($Snap.combine $t@1049 ($SortWrappers.$RefTo$Snap $t@1050))))
(declare-const $t@1051 $Snap)
(assert (= $t@1049 ($Snap.combine $t@1051 $Snap.unit)))
(declare-const $t@1052 Int)
(declare-const $t@1053 $Ref)
(assert (=
  $t@1051
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1052)
    ($SortWrappers.$RefTo$Snap $t@1053))))
(declare-const $t@1054 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1052)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1054) $Snap.unit)))
(declare-const $k@1055 $Perm)
(assert ($Perm.isValidVar $k@1055))
(assert ($Perm.isReadVar $k@1055 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+ (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001) $k@1025)
      $k@1031))
  (= $t@1054 $t@1024)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
          $k@1025)
        $k@1031)
      $k@1055)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
          $k@1025)
        $k@1031)
      $k@1055)
    $Perm.No)))
(assert (> $t@1054 0))
(declare-const $k@1056 $Perm)
(assert ($Perm.isValidVar $k@1056))
(assert ($Perm.isReadVar $k@1056 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+ (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002) $k@1026)
      $k@1032))
  (= $t@1053 $t@1023)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
          $k@1026)
        $k@1032)
      $k@1056)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
          $k@1026)
        $k@1032)
      $k@1056)
    $Perm.No)))
(assert (not (= $t@1053 $Ref.null)))
(declare-const $k@1057 $Perm)
(assert ($Perm.isValidVar $k@1057))
(assert ($Perm.isReadVar $k@1057 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+ (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003) $k@1027)
      $k@1033))
  (= $t@1050 $t@1020)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
          $k@1027)
        $k@1033)
      $k@1057)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
          $k@1027)
        $k@1033)
      $k@1057)
    $Perm.No)))
(assert (not (= $t@1050 $Ref.null)))
(declare-const $k@1058 $Perm)
(assert ($Perm.isValidVar $k@1058))
(assert ($Perm.isReadVar $k@1058 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@1050)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+ (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004) $k@1028)
      $k@1034))
  (= $t@1047 $t@1017)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1050)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
          $k@1028)
        $k@1034)
      $k@1058)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
          $k@1028)
        $k@1034)
      $k@1058)
    $Perm.No)))
(assert (= $t@1047 sys__result@915))
(declare-const $k@1059 $Perm)
(assert ($Perm.isValidVar $k@1059))
(assert ($Perm.isReadVar $k@1059 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+ (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005) $k@1029)
      $k@1035))
  (= $t@1044 $t@1014)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
          $k@1029)
        $k@1035)
      $k@1059)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
          $k@1029)
        $k@1035)
      $k@1059)
    $Perm.No)))
(assert (not (= $t@1044 $Ref.null)))
(declare-const $k@1060 $Perm)
(assert ($Perm.isValidVar $k@1060))
(assert ($Perm.isReadVar $k@1060 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@1044)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+ (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006) $k@1030)
      $k@1036))
  (= $t@1041 $t@1011)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1044)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
          $k@1030)
        $k@1036)
      $k@1060)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
          $k@1030)
        $k@1036)
      $k@1060)
    $Perm.No)))
(assert (= $t@1041 sys__result@915))
; [exec]
; b := __flatten_27
; [exec]
; __flatten_28 := BlockingQueue__poll(queue)
; [eval] diz != null
(declare-const $k@1061 $Perm)
(assert ($Perm.isValidVar $k@1061))
(assert ($Perm.isReadVar $k@1061 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1061 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1061
  (+
    (-
      (+ (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001) $k@1025)
      $k@1031)
    $k@1055)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1062 $Perm)
(assert ($Perm.isValidVar $k@1062))
(assert ($Perm.isReadVar $k@1062 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1062 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1062
  (+
    (-
      (+ (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002) $k@1026)
      $k@1032)
    $k@1056)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1063 $Perm)
(assert ($Perm.isValidVar $k@1063))
(assert ($Perm.isReadVar $k@1063 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1063 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1063
  (+
    (-
      (+ (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003) $k@1027)
      $k@1033)
    $k@1057)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1064 $Perm)
(assert ($Perm.isValidVar $k@1064))
(assert ($Perm.isReadVar $k@1064 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1064 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@929 $t@1050)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1064
  (+
    (-
      (+ (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004) $k@1028)
      $k@1034)
    $k@1058)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1050)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1065 $Perm)
(assert ($Perm.isValidVar $k@1065))
(assert ($Perm.isReadVar $k@1065 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1065 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1065
  (+
    (-
      (+ (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005) $k@1029)
      $k@1035)
    $k@1059)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1066 $Perm)
(assert ($Perm.isValidVar $k@1066))
(assert ($Perm.isReadVar $k@1066 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1066 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@923 $t@1044)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1066
  (+
    (-
      (+ (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006) $k@1030)
      $k@1036)
    $k@1060)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1044)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1067 $Ref)
(declare-const $t@1068 $Snap)
(declare-const $t@1069 $Snap)
(assert (= $t@1068 ($Snap.combine $t@1069 $Snap.unit)))
(declare-const $t@1070 $Snap)
(declare-const $t@1071 $Ref)
(assert (= $t@1069 ($Snap.combine $t@1070 ($SortWrappers.$RefTo$Snap $t@1071))))
(declare-const $t@1072 $Snap)
(assert (= $t@1070 ($Snap.combine $t@1072 $Snap.unit)))
(declare-const $t@1073 $Snap)
(declare-const $t@1074 $Ref)
(assert (= $t@1072 ($Snap.combine $t@1073 ($SortWrappers.$RefTo$Snap $t@1074))))
(declare-const $t@1075 $Snap)
(assert (= $t@1073 ($Snap.combine $t@1075 $Snap.unit)))
(declare-const $t@1076 $Snap)
(declare-const $t@1077 $Ref)
(assert (= $t@1075 ($Snap.combine $t@1076 ($SortWrappers.$RefTo$Snap $t@1077))))
(declare-const $t@1078 $Snap)
(assert (= $t@1076 ($Snap.combine $t@1078 $Snap.unit)))
(declare-const $t@1079 $Snap)
(declare-const $t@1080 $Ref)
(assert (= $t@1078 ($Snap.combine $t@1079 ($SortWrappers.$RefTo$Snap $t@1080))))
(declare-const $t@1081 $Snap)
(assert (= $t@1079 ($Snap.combine $t@1081 $Snap.unit)))
(declare-const $t@1082 Int)
(declare-const $t@1083 $Ref)
(assert (=
  $t@1081
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1082)
    ($SortWrappers.$RefTo$Snap $t@1083))))
(declare-const $t@1084 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1082)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1084) $Snap.unit)))
(declare-const $k@1085 $Perm)
(assert ($Perm.isValidVar $k@1085))
(assert ($Perm.isReadVar $k@1085 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
            $k@1025)
          $k@1031)
        $k@1055)
      $k@1061))
  (= $t@1084 $t@1054)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
              $k@1025)
            $k@1031)
          $k@1055)
        $k@1061)
      $k@1085)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
              $k@1025)
            $k@1031)
          $k@1055)
        $k@1061)
      $k@1085)
    $Perm.No)))
(assert (> $t@1084 0))
(declare-const $k@1086 $Perm)
(assert ($Perm.isValidVar $k@1086))
(assert ($Perm.isReadVar $k@1086 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
            $k@1026)
          $k@1032)
        $k@1056)
      $k@1062))
  (= $t@1083 $t@1053)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
              $k@1026)
            $k@1032)
          $k@1056)
        $k@1062)
      $k@1086)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
              $k@1026)
            $k@1032)
          $k@1056)
        $k@1062)
      $k@1086)
    $Perm.No)))
(assert (not (= $t@1083 $Ref.null)))
(declare-const $k@1087 $Perm)
(assert ($Perm.isValidVar $k@1087))
(assert ($Perm.isReadVar $k@1087 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
            $k@1027)
          $k@1033)
        $k@1057)
      $k@1063))
  (= $t@1080 $t@1050)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
              $k@1027)
            $k@1033)
          $k@1057)
        $k@1063)
      $k@1087)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
              $k@1027)
            $k@1033)
          $k@1057)
        $k@1063)
      $k@1087)
    $Perm.No)))
(assert (not (= $t@1080 $Ref.null)))
(declare-const $k@1088 $Perm)
(assert ($Perm.isValidVar $k@1088))
(assert ($Perm.isReadVar $k@1088 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@1080)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
            $k@1028)
          $k@1034)
        $k@1058)
      $k@1064))
  (= $t@1077 $t@1047)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1080)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
              $k@1028)
            $k@1034)
          $k@1058)
        $k@1064)
      $k@1088)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
              $k@1028)
            $k@1034)
          $k@1058)
        $k@1064)
      $k@1088)
    $Perm.No)))
(assert (= $t@1077 sys__result@915))
(declare-const $k@1089 $Perm)
(assert ($Perm.isValidVar $k@1089))
(assert ($Perm.isReadVar $k@1089 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
            $k@1029)
          $k@1035)
        $k@1059)
      $k@1065))
  (= $t@1074 $t@1044)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
              $k@1029)
            $k@1035)
          $k@1059)
        $k@1065)
      $k@1089)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
              $k@1029)
            $k@1035)
          $k@1059)
        $k@1065)
      $k@1089)
    $Perm.No)))
(assert (not (= $t@1074 $Ref.null)))
(declare-const $k@1090 $Perm)
(assert ($Perm.isValidVar $k@1090))
(assert ($Perm.isReadVar $k@1090 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@1074)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
            $k@1030)
          $k@1036)
        $k@1060)
      $k@1066))
  (= $t@1071 $t@1041)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1074)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
              $k@1030)
            $k@1036)
          $k@1060)
        $k@1066)
      $k@1090)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
              $k@1030)
            $k@1036)
          $k@1060)
        $k@1066)
      $k@1090)
    $Perm.No)))
(assert (= $t@1071 sys__result@915))
; [exec]
; n := __flatten_28
; [exec]
; __flatten_29 := BlockingQueue__poll(queue)
; [eval] diz != null
(declare-const $k@1091 $Perm)
(assert ($Perm.isValidVar $k@1091))
(assert ($Perm.isReadVar $k@1091 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1091 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1091
  (+
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
            $k@1025)
          $k@1031)
        $k@1055)
      $k@1061)
    $k@1085)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1092 $Perm)
(assert ($Perm.isValidVar $k@1092))
(assert ($Perm.isReadVar $k@1092 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1092 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1092
  (+
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
            $k@1026)
          $k@1032)
        $k@1056)
      $k@1062)
    $k@1086)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1093 $Perm)
(assert ($Perm.isValidVar $k@1093))
(assert ($Perm.isReadVar $k@1093 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1093 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1093
  (+
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
            $k@1027)
          $k@1033)
        $k@1057)
      $k@1063)
    $k@1087)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1094 $Perm)
(assert ($Perm.isValidVar $k@1094))
(assert ($Perm.isReadVar $k@1094 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1094 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@929 $t@1080)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1094
  (+
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
            $k@1028)
          $k@1034)
        $k@1058)
      $k@1064)
    $k@1088)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1080)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1095 $Perm)
(assert ($Perm.isValidVar $k@1095))
(assert ($Perm.isReadVar $k@1095 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1095 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1095
  (+
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
            $k@1029)
          $k@1035)
        $k@1059)
      $k@1065)
    $k@1089)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1096 $Perm)
(assert ($Perm.isValidVar $k@1096))
(assert ($Perm.isReadVar $k@1096 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1096 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@923 $t@1074)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1096
  (+
    (-
      (+
        (-
          (+
            (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
            $k@1030)
          $k@1036)
        $k@1060)
      $k@1066)
    $k@1090)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1074)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1097 $Ref)
(declare-const $t@1098 $Snap)
(declare-const $t@1099 $Snap)
(assert (= $t@1098 ($Snap.combine $t@1099 $Snap.unit)))
(declare-const $t@1100 $Snap)
(declare-const $t@1101 $Ref)
(assert (= $t@1099 ($Snap.combine $t@1100 ($SortWrappers.$RefTo$Snap $t@1101))))
(declare-const $t@1102 $Snap)
(assert (= $t@1100 ($Snap.combine $t@1102 $Snap.unit)))
(declare-const $t@1103 $Snap)
(declare-const $t@1104 $Ref)
(assert (= $t@1102 ($Snap.combine $t@1103 ($SortWrappers.$RefTo$Snap $t@1104))))
(declare-const $t@1105 $Snap)
(assert (= $t@1103 ($Snap.combine $t@1105 $Snap.unit)))
(declare-const $t@1106 $Snap)
(declare-const $t@1107 $Ref)
(assert (= $t@1105 ($Snap.combine $t@1106 ($SortWrappers.$RefTo$Snap $t@1107))))
(declare-const $t@1108 $Snap)
(assert (= $t@1106 ($Snap.combine $t@1108 $Snap.unit)))
(declare-const $t@1109 $Snap)
(declare-const $t@1110 $Ref)
(assert (= $t@1108 ($Snap.combine $t@1109 ($SortWrappers.$RefTo$Snap $t@1110))))
(declare-const $t@1111 $Snap)
(assert (= $t@1109 ($Snap.combine $t@1111 $Snap.unit)))
(declare-const $t@1112 Int)
(declare-const $t@1113 $Ref)
(assert (=
  $t@1111
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1112)
    ($SortWrappers.$RefTo$Snap $t@1113))))
(declare-const $t@1114 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1112)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1114) $Snap.unit)))
(declare-const $k@1115 $Perm)
(assert ($Perm.isValidVar $k@1115))
(assert ($Perm.isReadVar $k@1115 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
                $k@1025)
              $k@1031)
            $k@1055)
          $k@1061)
        $k@1085)
      $k@1091))
  (= $t@1114 $t@1084)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
                  $k@1025)
                $k@1031)
              $k@1055)
            $k@1061)
          $k@1085)
        $k@1091)
      $k@1115)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
                  $k@1025)
                $k@1031)
              $k@1055)
            $k@1061)
          $k@1085)
        $k@1091)
      $k@1115)
    $Perm.No)))
(assert (> $t@1114 0))
(declare-const $k@1116 $Perm)
(assert ($Perm.isValidVar $k@1116))
(assert ($Perm.isReadVar $k@1116 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
                $k@1026)
              $k@1032)
            $k@1056)
          $k@1062)
        $k@1086)
      $k@1092))
  (= $t@1113 $t@1083)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
                  $k@1026)
                $k@1032)
              $k@1056)
            $k@1062)
          $k@1086)
        $k@1092)
      $k@1116)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
                  $k@1026)
                $k@1032)
              $k@1056)
            $k@1062)
          $k@1086)
        $k@1092)
      $k@1116)
    $Perm.No)))
(assert (not (= $t@1113 $Ref.null)))
(declare-const $k@1117 $Perm)
(assert ($Perm.isValidVar $k@1117))
(assert ($Perm.isReadVar $k@1117 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
                $k@1027)
              $k@1033)
            $k@1057)
          $k@1063)
        $k@1087)
      $k@1093))
  (= $t@1110 $t@1080)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
                  $k@1027)
                $k@1033)
              $k@1057)
            $k@1063)
          $k@1087)
        $k@1093)
      $k@1117)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
                  $k@1027)
                $k@1033)
              $k@1057)
            $k@1063)
          $k@1087)
        $k@1093)
      $k@1117)
    $Perm.No)))
(assert (not (= $t@1110 $Ref.null)))
(declare-const $k@1118 $Perm)
(assert ($Perm.isValidVar $k@1118))
(assert ($Perm.isReadVar $k@1118 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@1110)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
                $k@1028)
              $k@1034)
            $k@1058)
          $k@1064)
        $k@1088)
      $k@1094))
  (= $t@1107 $t@1077)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1110)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
                  $k@1028)
                $k@1034)
              $k@1058)
            $k@1064)
          $k@1088)
        $k@1094)
      $k@1118)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
                  $k@1028)
                $k@1034)
              $k@1058)
            $k@1064)
          $k@1088)
        $k@1094)
      $k@1118)
    $Perm.No)))
(assert (= $t@1107 sys__result@915))
(declare-const $k@1119 $Perm)
(assert ($Perm.isValidVar $k@1119))
(assert ($Perm.isReadVar $k@1119 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
                $k@1029)
              $k@1035)
            $k@1059)
          $k@1065)
        $k@1089)
      $k@1095))
  (= $t@1104 $t@1074)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
                  $k@1029)
                $k@1035)
              $k@1059)
            $k@1065)
          $k@1089)
        $k@1095)
      $k@1119)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
                  $k@1029)
                $k@1035)
              $k@1059)
            $k@1065)
          $k@1089)
        $k@1095)
      $k@1119)
    $Perm.No)))
(assert (not (= $t@1104 $Ref.null)))
(declare-const $k@1120 $Perm)
(assert ($Perm.isValidVar $k@1120))
(assert ($Perm.isReadVar $k@1120 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@1104)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
                $k@1030)
              $k@1036)
            $k@1060)
          $k@1066)
        $k@1090)
      $k@1096))
  (= $t@1101 $t@1071)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1104)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
                  $k@1030)
                $k@1036)
              $k@1060)
            $k@1066)
          $k@1090)
        $k@1096)
      $k@1120)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
                  $k@1030)
                $k@1036)
              $k@1060)
            $k@1066)
          $k@1090)
        $k@1096)
      $k@1120)
    $Perm.No)))
(assert (= $t@1101 sys__result@915))
; [exec]
; o := __flatten_29
; [exec]
; __flatten_30 := BlockingQueue__poll(queue)
; [eval] diz != null
(declare-const $k@1121 $Perm)
(assert ($Perm.isValidVar $k@1121))
(assert ($Perm.isReadVar $k@1121 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1121 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1121
  (+
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995) $k@1001)
                $k@1025)
              $k@1031)
            $k@1055)
          $k@1061)
        $k@1085)
      $k@1091)
    $k@1115)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1122 $Perm)
(assert ($Perm.isValidVar $k@1122))
(assert ($Perm.isReadVar $k@1122 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1122 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1122
  (+
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996) $k@1002)
                $k@1026)
              $k@1032)
            $k@1056)
          $k@1062)
        $k@1086)
      $k@1092)
    $k@1116)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1123 $Perm)
(assert ($Perm.isValidVar $k@1123))
(assert ($Perm.isReadVar $k@1123 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1123 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1123
  (+
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997) $k@1003)
                $k@1027)
              $k@1033)
            $k@1057)
          $k@1063)
        $k@1087)
      $k@1093)
    $k@1117)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1124 $Perm)
(assert ($Perm.isValidVar $k@1124))
(assert ($Perm.isReadVar $k@1124 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1124 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@929 $t@1110)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1124
  (+
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998) $k@1004)
                $k@1028)
              $k@1034)
            $k@1058)
          $k@1064)
        $k@1088)
      $k@1094)
    $k@1118)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1110)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1125 $Perm)
(assert ($Perm.isValidVar $k@1125))
(assert ($Perm.isReadVar $k@1125 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1125 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1125
  (+
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999) $k@1005)
                $k@1029)
              $k@1035)
            $k@1059)
          $k@1065)
        $k@1089)
      $k@1095)
    $k@1119)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1126 $Perm)
(assert ($Perm.isValidVar $k@1126))
(assert ($Perm.isReadVar $k@1126 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1126 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@923 $t@1104)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1126
  (+
    (-
      (+
        (-
          (+
            (-
              (+
                (- (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000) $k@1006)
                $k@1030)
              $k@1036)
            $k@1060)
          $k@1066)
        $k@1090)
      $k@1096)
    $k@1120)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1104)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1127 $Ref)
(declare-const $t@1128 $Snap)
(declare-const $t@1129 $Snap)
(assert (= $t@1128 ($Snap.combine $t@1129 $Snap.unit)))
(declare-const $t@1130 $Snap)
(declare-const $t@1131 $Ref)
(assert (= $t@1129 ($Snap.combine $t@1130 ($SortWrappers.$RefTo$Snap $t@1131))))
(declare-const $t@1132 $Snap)
(assert (= $t@1130 ($Snap.combine $t@1132 $Snap.unit)))
(declare-const $t@1133 $Snap)
(declare-const $t@1134 $Ref)
(assert (= $t@1132 ($Snap.combine $t@1133 ($SortWrappers.$RefTo$Snap $t@1134))))
(declare-const $t@1135 $Snap)
(assert (= $t@1133 ($Snap.combine $t@1135 $Snap.unit)))
(declare-const $t@1136 $Snap)
(declare-const $t@1137 $Ref)
(assert (= $t@1135 ($Snap.combine $t@1136 ($SortWrappers.$RefTo$Snap $t@1137))))
(declare-const $t@1138 $Snap)
(assert (= $t@1136 ($Snap.combine $t@1138 $Snap.unit)))
(declare-const $t@1139 $Snap)
(declare-const $t@1140 $Ref)
(assert (= $t@1138 ($Snap.combine $t@1139 ($SortWrappers.$RefTo$Snap $t@1140))))
(declare-const $t@1141 $Snap)
(assert (= $t@1139 ($Snap.combine $t@1141 $Snap.unit)))
(declare-const $t@1142 Int)
(declare-const $t@1143 $Ref)
(assert (=
  $t@1141
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1142)
    ($SortWrappers.$RefTo$Snap $t@1143))))
(declare-const $t@1144 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1142)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1144) $Snap.unit)))
(declare-const $k@1145 $Perm)
(assert ($Perm.isValidVar $k@1145))
(assert ($Perm.isReadVar $k@1145 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (-
                  (+
                    (-
                      (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995)
                      $k@1001)
                    $k@1025)
                  $k@1031)
                $k@1055)
              $k@1061)
            $k@1085)
          $k@1091)
        $k@1115)
      $k@1121))
  (= $t@1144 $t@1114)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995)
                        $k@1001)
                      $k@1025)
                    $k@1031)
                  $k@1055)
                $k@1061)
              $k@1085)
            $k@1091)
          $k@1115)
        $k@1121)
      $k@1145)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@935 $k@941) $k@965) $k@971) $k@995)
                        $k@1001)
                      $k@1025)
                    $k@1031)
                  $k@1055)
                $k@1061)
              $k@1085)
            $k@1091)
          $k@1115)
        $k@1121)
      $k@1145)
    $Perm.No)))
(assert (> $t@1144 0))
(declare-const $k@1146 $Perm)
(assert ($Perm.isValidVar $k@1146))
(assert ($Perm.isReadVar $k@1146 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (-
                  (+
                    (-
                      (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996)
                      $k@1002)
                    $k@1026)
                  $k@1032)
                $k@1056)
              $k@1062)
            $k@1086)
          $k@1092)
        $k@1116)
      $k@1122))
  (= $t@1143 $t@1113)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996)
                        $k@1002)
                      $k@1026)
                    $k@1032)
                  $k@1056)
                $k@1062)
              $k@1086)
            $k@1092)
          $k@1116)
        $k@1122)
      $k@1146)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@936 $k@942) $k@966) $k@972) $k@996)
                        $k@1002)
                      $k@1026)
                    $k@1032)
                  $k@1056)
                $k@1062)
              $k@1086)
            $k@1092)
          $k@1116)
        $k@1122)
      $k@1146)
    $Perm.No)))
(assert (not (= $t@1143 $Ref.null)))
(declare-const $k@1147 $Perm)
(assert ($Perm.isValidVar $k@1147))
(assert ($Perm.isReadVar $k@1147 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (-
                  (+
                    (-
                      (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997)
                      $k@1003)
                    $k@1027)
                  $k@1033)
                $k@1057)
              $k@1063)
            $k@1087)
          $k@1093)
        $k@1117)
      $k@1123))
  (= $t@1140 $t@1110)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997)
                        $k@1003)
                      $k@1027)
                    $k@1033)
                  $k@1057)
                $k@1063)
              $k@1087)
            $k@1093)
          $k@1117)
        $k@1123)
      $k@1147)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@937 $k@943) $k@967) $k@973) $k@997)
                        $k@1003)
                      $k@1027)
                    $k@1033)
                  $k@1057)
                $k@1063)
              $k@1087)
            $k@1093)
          $k@1117)
        $k@1123)
      $k@1147)
    $Perm.No)))
(assert (not (= $t@1140 $Ref.null)))
(declare-const $k@1148 $Perm)
(assert ($Perm.isValidVar $k@1148))
(assert ($Perm.isReadVar $k@1148 $Perm.Write))
(push) ; 4
(assert (not (= $t@929 $t@1140)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (-
                  (+
                    (-
                      (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998)
                      $k@1004)
                    $k@1028)
                  $k@1034)
                $k@1058)
              $k@1064)
            $k@1088)
          $k@1094)
        $k@1118)
      $k@1124))
  (= $t@1137 $t@1107)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@929 $t@1140)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998)
                        $k@1004)
                      $k@1028)
                    $k@1034)
                  $k@1058)
                $k@1064)
              $k@1088)
            $k@1094)
          $k@1118)
        $k@1124)
      $k@1148)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@938 $k@944) $k@968) $k@974) $k@998)
                        $k@1004)
                      $k@1028)
                    $k@1034)
                  $k@1058)
                $k@1064)
              $k@1088)
            $k@1094)
          $k@1118)
        $k@1124)
      $k@1148)
    $Perm.No)))
(assert (= $t@1137 sys__result@915))
(declare-const $k@1149 $Perm)
(assert ($Perm.isValidVar $k@1149))
(assert ($Perm.isReadVar $k@1149 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (-
                  (+
                    (-
                      (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999)
                      $k@1005)
                    $k@1029)
                  $k@1035)
                $k@1059)
              $k@1065)
            $k@1089)
          $k@1095)
        $k@1119)
      $k@1125))
  (= $t@1134 $t@1104)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999)
                        $k@1005)
                      $k@1029)
                    $k@1035)
                  $k@1059)
                $k@1065)
              $k@1089)
            $k@1095)
          $k@1119)
        $k@1125)
      $k@1149)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@939 $k@945) $k@969) $k@975) $k@999)
                        $k@1005)
                      $k@1029)
                    $k@1035)
                  $k@1059)
                $k@1065)
              $k@1089)
            $k@1095)
          $k@1119)
        $k@1125)
      $k@1149)
    $Perm.No)))
(assert (not (= $t@1134 $Ref.null)))
(declare-const $k@1150 $Perm)
(assert ($Perm.isValidVar $k@1150))
(assert ($Perm.isReadVar $k@1150 $Perm.Write))
(push) ; 4
(assert (not (= $t@923 $t@1134)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (-
          (+
            (-
              (+
                (-
                  (+
                    (-
                      (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000)
                      $k@1006)
                    $k@1030)
                  $k@1036)
                $k@1060)
              $k@1066)
            $k@1090)
          $k@1096)
        $k@1120)
      $k@1126))
  (= $t@1131 $t@1101)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@923 $t@1134)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000)
                        $k@1006)
                      $k@1030)
                    $k@1036)
                  $k@1060)
                $k@1066)
              $k@1090)
            $k@1096)
          $k@1120)
        $k@1126)
      $k@1150)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (-
            (+
              (-
                (+
                  (-
                    (+
                      (-
                        (+ (- (+ (- $k@940 $k@946) $k@970) $k@976) $k@1000)
                        $k@1006)
                      $k@1030)
                    $k@1036)
                  $k@1060)
                $k@1066)
              $k@1090)
            $k@1096)
          $k@1120)
        $k@1126)
      $k@1150)
    $Perm.No)))
(assert (= $t@1131 sys__result@915))
; [exec]
; p := __flatten_30
(pop) ; 3
(pop) ; 2
; ---------- Test__testFillAndPeek ----------
(declare-const diz@1151 $Ref)
(declare-const queue@1152 $Ref)
(declare-const __flatten_31@1153 $Ref)
(declare-const b@1154 Bool)
(declare-const __flatten_32@1155 Bool)
(declare-const __flatten_33@1156 Bool)
(declare-const i@1157 $Ref)
(declare-const __flatten_34@1158 $Ref)
(declare-const j@1159 $Ref)
(declare-const __flatten_35@1160 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1151 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_31 := BlockingQueue__BlockingQueue(10)
; [eval] capacity > 0
(declare-const sys__result@1161 $Ref)
(declare-const $t@1162 $Snap)
(declare-const $t@1163 $Snap)
(assert (= $t@1162 ($Snap.combine $t@1163 $Snap.unit)))
(declare-const $t@1164 $Snap)
(assert (= $t@1163 ($Snap.combine $t@1164 $Snap.unit)))
(declare-const $t@1165 $Snap)
(declare-const $t@1166 $Ref)
(assert (= $t@1164 ($Snap.combine $t@1165 ($SortWrappers.$RefTo$Snap $t@1166))))
(declare-const $t@1167 $Snap)
(assert (= $t@1165 ($Snap.combine $t@1167 $Snap.unit)))
(declare-const $t@1168 $Snap)
(declare-const $t@1169 $Ref)
(assert (= $t@1167 ($Snap.combine $t@1168 ($SortWrappers.$RefTo$Snap $t@1169))))
(declare-const $t@1170 $Snap)
(assert (= $t@1168 ($Snap.combine $t@1170 $Snap.unit)))
(declare-const $t@1171 $Snap)
(declare-const $t@1172 $Ref)
(assert (= $t@1170 ($Snap.combine $t@1171 ($SortWrappers.$RefTo$Snap $t@1172))))
(declare-const $t@1173 $Snap)
(assert (= $t@1171 ($Snap.combine $t@1173 $Snap.unit)))
(declare-const $t@1174 $Snap)
(declare-const $t@1175 $Ref)
(assert (= $t@1173 ($Snap.combine $t@1174 ($SortWrappers.$RefTo$Snap $t@1175))))
(declare-const $t@1176 $Snap)
(assert (= $t@1174 ($Snap.combine $t@1176 $Snap.unit)))
(declare-const $t@1177 Int)
(declare-const $t@1178 $Ref)
(assert (=
  $t@1176
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1177)
    ($SortWrappers.$RefTo$Snap $t@1178))))
(declare-const $t@1179 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1177)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1179) $Snap.unit)))
(declare-const $t@1180 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1179)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1180))))
; [eval] sys__result != null
(assert (not (= sys__result@1161 $Ref.null)))
(declare-const $k@1181 $Perm)
(assert ($Perm.isValidVar $k@1181))
(assert ($Perm.isReadVar $k@1181 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1181 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1181 $Perm.No)))
(assert (> $t@1180 0))
(declare-const $k@1182 $Perm)
(assert ($Perm.isValidVar $k@1182))
(assert ($Perm.isReadVar $k@1182 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1182 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1182 $Perm.No)))
(assert (not (= $t@1178 $Ref.null)))
(declare-const $k@1183 $Perm)
(assert ($Perm.isValidVar $k@1183))
(assert ($Perm.isReadVar $k@1183 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1183 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1183 $Perm.No)))
(assert (not (= $t@1175 $Ref.null)))
(declare-const $k@1184 $Perm)
(assert ($Perm.isValidVar $k@1184))
(assert ($Perm.isReadVar $k@1184 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1184 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1184 $Perm.No)))
(assert (= $t@1172 sys__result@1161))
(declare-const $k@1185 $Perm)
(assert ($Perm.isValidVar $k@1185))
(assert ($Perm.isReadVar $k@1185 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1185 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1185 $Perm.No)))
(assert (not (= $t@1169 $Ref.null)))
(declare-const $k@1186 $Perm)
(assert ($Perm.isValidVar $k@1186))
(assert ($Perm.isReadVar $k@1186 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1186 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1186 $Perm.No)))
(assert (= $t@1166 sys__result@1161))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1180 10))
; [exec]
; queue := __flatten_31
; [exec]
; __flatten_32 := BlockingQueue__offer(queue, 3)
; [eval] diz != null
(declare-const $k@1187 $Perm)
(assert ($Perm.isValidVar $k@1187))
(assert ($Perm.isReadVar $k@1187 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1187 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1187 $k@1181))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1188 $Perm)
(assert ($Perm.isValidVar $k@1188))
(assert ($Perm.isReadVar $k@1188 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1188 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1188 $k@1182))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1189 $Perm)
(assert ($Perm.isValidVar $k@1189))
(assert ($Perm.isReadVar $k@1189 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1189 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1189 $k@1183))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1190 $Perm)
(assert ($Perm.isValidVar $k@1190))
(assert ($Perm.isReadVar $k@1190 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1190 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1190 $k@1184))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@1191 $Perm)
(assert ($Perm.isValidVar $k@1191))
(assert ($Perm.isReadVar $k@1191 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1191 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1191 $k@1185))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1192 $Perm)
(assert ($Perm.isValidVar $k@1192))
(assert ($Perm.isReadVar $k@1192 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1192 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1192 $k@1186))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@1193 Bool)
(declare-const $t@1194 $Snap)
(declare-const $t@1195 $Snap)
(assert (= $t@1194 ($Snap.combine $t@1195 $Snap.unit)))
(declare-const $t@1196 $Snap)
(declare-const $t@1197 $Ref)
(assert (= $t@1195 ($Snap.combine $t@1196 ($SortWrappers.$RefTo$Snap $t@1197))))
(declare-const $t@1198 $Snap)
(assert (= $t@1196 ($Snap.combine $t@1198 $Snap.unit)))
(declare-const $t@1199 $Snap)
(declare-const $t@1200 $Ref)
(assert (= $t@1198 ($Snap.combine $t@1199 ($SortWrappers.$RefTo$Snap $t@1200))))
(declare-const $t@1201 $Snap)
(assert (= $t@1199 ($Snap.combine $t@1201 $Snap.unit)))
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
(declare-const $t@1208 Int)
(declare-const $t@1209 $Ref)
(assert (=
  $t@1207
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1208)
    ($SortWrappers.$RefTo$Snap $t@1209))))
(declare-const $t@1210 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1208)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1210) $Snap.unit)))
(declare-const $k@1211 $Perm)
(assert ($Perm.isValidVar $k@1211))
(assert ($Perm.isReadVar $k@1211 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1181 $k@1187)) (= $t@1210 $t@1180)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@1181 $k@1187) $k@1211) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1181 $k@1187) $k@1211) $Perm.No)))
(assert (> $t@1210 0))
(declare-const $k@1212 $Perm)
(assert ($Perm.isValidVar $k@1212))
(assert ($Perm.isReadVar $k@1212 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1182 $k@1188)) (= $t@1209 $t@1178)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@1182 $k@1188) $k@1212) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1182 $k@1188) $k@1212) $Perm.No)))
(assert (not (= $t@1209 $Ref.null)))
(declare-const $k@1213 $Perm)
(assert ($Perm.isValidVar $k@1213))
(assert ($Perm.isReadVar $k@1213 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1183 $k@1189)) (= $t@1206 $t@1175)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1183 $k@1189) $k@1213) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1183 $k@1189) $k@1213) $Perm.No)))
(assert (not (= $t@1206 $Ref.null)))
(declare-const $k@1214 $Perm)
(assert ($Perm.isValidVar $k@1214))
(assert ($Perm.isReadVar $k@1214 $Perm.Write))
(push) ; 4
(assert (not (= $t@1175 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1184 $k@1190)) (= $t@1203 $t@1172)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1184 $k@1190) $k@1214) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1184 $k@1190) $k@1214) $Perm.No)))
(assert (= $t@1203 sys__result@1161))
(declare-const $k@1215 $Perm)
(assert ($Perm.isValidVar $k@1215))
(assert ($Perm.isReadVar $k@1215 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1185 $k@1191)) (= $t@1200 $t@1169)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1185 $k@1191) $k@1215) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1185 $k@1191) $k@1215) $Perm.No)))
(assert (not (= $t@1200 $Ref.null)))
(declare-const $k@1216 $Perm)
(assert ($Perm.isValidVar $k@1216))
(assert ($Perm.isReadVar $k@1216 $Perm.Write))
(push) ; 4
(assert (not (= $t@1169 $t@1200)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1186 $k@1192)) (= $t@1197 $t@1166)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1200)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1186 $k@1192) $k@1216) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1186 $k@1192) $k@1216) $Perm.No)))
(assert (= $t@1197 sys__result@1161))
; [exec]
; b := __flatten_32
; [exec]
; __flatten_33 := BlockingQueue__offer(queue, 5)
; [eval] diz != null
(declare-const $k@1217 $Perm)
(assert ($Perm.isValidVar $k@1217))
(assert ($Perm.isReadVar $k@1217 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1217 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1217 (+ (- $k@1181 $k@1187) $k@1211)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1218 $Perm)
(assert ($Perm.isValidVar $k@1218))
(assert ($Perm.isReadVar $k@1218 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1218 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1218 (+ (- $k@1182 $k@1188) $k@1212)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1219 $Perm)
(assert ($Perm.isValidVar $k@1219))
(assert ($Perm.isReadVar $k@1219 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1219 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1219 (+ (- $k@1183 $k@1189) $k@1213)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1220 $Perm)
(assert ($Perm.isValidVar $k@1220))
(assert ($Perm.isReadVar $k@1220 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1220 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1175 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1220 (+ (- $k@1184 $k@1190) $k@1214)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1206)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1221 $Perm)
(assert ($Perm.isValidVar $k@1221))
(assert ($Perm.isReadVar $k@1221 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1221 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1221 (+ (- $k@1185 $k@1191) $k@1215)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1222 $Perm)
(assert ($Perm.isValidVar $k@1222))
(assert ($Perm.isReadVar $k@1222 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1222 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1169 $t@1200)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1222 (+ (- $k@1186 $k@1192) $k@1216)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1200)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1223 Bool)
(declare-const $t@1224 $Snap)
(declare-const $t@1225 $Snap)
(assert (= $t@1224 ($Snap.combine $t@1225 $Snap.unit)))
(declare-const $t@1226 $Snap)
(declare-const $t@1227 $Ref)
(assert (= $t@1225 ($Snap.combine $t@1226 ($SortWrappers.$RefTo$Snap $t@1227))))
(declare-const $t@1228 $Snap)
(assert (= $t@1226 ($Snap.combine $t@1228 $Snap.unit)))
(declare-const $t@1229 $Snap)
(declare-const $t@1230 $Ref)
(assert (= $t@1228 ($Snap.combine $t@1229 ($SortWrappers.$RefTo$Snap $t@1230))))
(declare-const $t@1231 $Snap)
(assert (= $t@1229 ($Snap.combine $t@1231 $Snap.unit)))
(declare-const $t@1232 $Snap)
(declare-const $t@1233 $Ref)
(assert (= $t@1231 ($Snap.combine $t@1232 ($SortWrappers.$RefTo$Snap $t@1233))))
(declare-const $t@1234 $Snap)
(assert (= $t@1232 ($Snap.combine $t@1234 $Snap.unit)))
(declare-const $t@1235 $Snap)
(declare-const $t@1236 $Ref)
(assert (= $t@1234 ($Snap.combine $t@1235 ($SortWrappers.$RefTo$Snap $t@1236))))
(declare-const $t@1237 $Snap)
(assert (= $t@1235 ($Snap.combine $t@1237 $Snap.unit)))
(declare-const $t@1238 Int)
(declare-const $t@1239 $Ref)
(assert (=
  $t@1237
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1238)
    ($SortWrappers.$RefTo$Snap $t@1239))))
(declare-const $t@1240 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1238)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1240) $Snap.unit)))
(declare-const $k@1241 $Perm)
(assert ($Perm.isValidVar $k@1241))
(assert ($Perm.isReadVar $k@1241 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217))
  (= $t@1240 $t@1210)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $Perm.No)))
(assert (> $t@1240 0))
(declare-const $k@1242 $Perm)
(assert ($Perm.isValidVar $k@1242))
(assert ($Perm.isReadVar $k@1242 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218))
  (= $t@1239 $t@1209)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $Perm.No)))
(assert (not (= $t@1239 $Ref.null)))
(declare-const $k@1243 $Perm)
(assert ($Perm.isValidVar $k@1243))
(assert ($Perm.isReadVar $k@1243 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219))
  (= $t@1236 $t@1206)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $Perm.No)))
(assert (not (= $t@1236 $Ref.null)))
(declare-const $k@1244 $Perm)
(assert ($Perm.isValidVar $k@1244))
(assert ($Perm.isReadVar $k@1244 $Perm.Write))
(push) ; 4
(assert (not (= $t@1175 $t@1236)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (< $Perm.No (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220))
  (= $t@1233 $t@1203)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1236)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $Perm.No)))
(assert (= $t@1233 sys__result@1161))
(declare-const $k@1245 $Perm)
(assert ($Perm.isValidVar $k@1245))
(assert ($Perm.isReadVar $k@1245 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221))
  (= $t@1230 $t@1200)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $Perm.No)))
(assert (not (= $t@1230 $Ref.null)))
(declare-const $k@1246 $Perm)
(assert ($Perm.isValidVar $k@1246))
(assert ($Perm.isReadVar $k@1246 $Perm.Write))
(push) ; 4
(assert (not (= $t@1169 $t@1230)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (< $Perm.No (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222))
  (= $t@1227 $t@1197)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1230)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $Perm.No)))
(assert (= $t@1227 sys__result@1161))
; [exec]
; b := __flatten_33
; [exec]
; __flatten_34 := BlockingQueue__peek(queue)
; [eval] diz != null
(declare-const $k@1247 $Perm)
(assert ($Perm.isValidVar $k@1247))
(assert ($Perm.isReadVar $k@1247 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1247 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1247 (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1248 $Perm)
(assert ($Perm.isValidVar $k@1248))
(assert ($Perm.isReadVar $k@1248 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1248 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1248 (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1249 $Perm)
(assert ($Perm.isValidVar $k@1249))
(assert ($Perm.isReadVar $k@1249 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1249 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1249 (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1250 $Perm)
(assert ($Perm.isValidVar $k@1250))
(assert ($Perm.isReadVar $k@1250 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1250 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1175 $t@1236)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1250 (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1236)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1251 $Perm)
(assert ($Perm.isValidVar $k@1251))
(assert ($Perm.isReadVar $k@1251 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1251 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1251 (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1252 $Perm)
(assert ($Perm.isValidVar $k@1252))
(assert ($Perm.isReadVar $k@1252 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1252 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1169 $t@1230)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1252 (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1230)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1253 $Ref)
(declare-const $t@1254 $Snap)
(declare-const $t@1255 $Snap)
(assert (= $t@1254 ($Snap.combine $t@1255 $Snap.unit)))
(declare-const $t@1256 $Snap)
(declare-const $t@1257 $Ref)
(assert (= $t@1255 ($Snap.combine $t@1256 ($SortWrappers.$RefTo$Snap $t@1257))))
(declare-const $t@1258 $Snap)
(assert (= $t@1256 ($Snap.combine $t@1258 $Snap.unit)))
(declare-const $t@1259 $Snap)
(declare-const $t@1260 $Ref)
(assert (= $t@1258 ($Snap.combine $t@1259 ($SortWrappers.$RefTo$Snap $t@1260))))
(declare-const $t@1261 $Snap)
(assert (= $t@1259 ($Snap.combine $t@1261 $Snap.unit)))
(declare-const $t@1262 $Snap)
(declare-const $t@1263 $Ref)
(assert (= $t@1261 ($Snap.combine $t@1262 ($SortWrappers.$RefTo$Snap $t@1263))))
(declare-const $t@1264 $Snap)
(assert (= $t@1262 ($Snap.combine $t@1264 $Snap.unit)))
(declare-const $t@1265 $Snap)
(declare-const $t@1266 $Ref)
(assert (= $t@1264 ($Snap.combine $t@1265 ($SortWrappers.$RefTo$Snap $t@1266))))
(declare-const $t@1267 $Snap)
(assert (= $t@1265 ($Snap.combine $t@1267 $Snap.unit)))
(declare-const $t@1268 Int)
(declare-const $t@1269 $Ref)
(assert (=
  $t@1267
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1268)
    ($SortWrappers.$RefTo$Snap $t@1269))))
(declare-const $t@1270 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1268)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1270) $Snap.unit)))
(declare-const $k@1271 $Perm)
(assert ($Perm.isValidVar $k@1271))
(assert ($Perm.isReadVar $k@1271 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247))
  (= $t@1270 $t@1240)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247)
      $k@1271)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247)
      $k@1271)
    $Perm.No)))
(assert (> $t@1270 0))
(declare-const $k@1272 $Perm)
(assert ($Perm.isValidVar $k@1272))
(assert ($Perm.isReadVar $k@1272 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248))
  (= $t@1269 $t@1239)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248)
      $k@1272)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248)
      $k@1272)
    $Perm.No)))
(assert (not (= $t@1269 $Ref.null)))
(declare-const $k@1273 $Perm)
(assert ($Perm.isValidVar $k@1273))
(assert ($Perm.isReadVar $k@1273 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249))
  (= $t@1266 $t@1236)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249)
      $k@1273)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249)
      $k@1273)
    $Perm.No)))
(assert (not (= $t@1266 $Ref.null)))
(declare-const $k@1274 $Perm)
(assert ($Perm.isValidVar $k@1274))
(assert ($Perm.isReadVar $k@1274 $Perm.Write))
(push) ; 4
(assert (not (= $t@1175 $t@1266)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250))
  (= $t@1263 $t@1233)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1266)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250)
      $k@1274)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250)
      $k@1274)
    $Perm.No)))
(assert (= $t@1263 sys__result@1161))
(declare-const $k@1275 $Perm)
(assert ($Perm.isValidVar $k@1275))
(assert ($Perm.isReadVar $k@1275 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251))
  (= $t@1260 $t@1230)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251)
      $k@1275)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251)
      $k@1275)
    $Perm.No)))
(assert (not (= $t@1260 $Ref.null)))
(declare-const $k@1276 $Perm)
(assert ($Perm.isValidVar $k@1276))
(assert ($Perm.isReadVar $k@1276 $Perm.Write))
(push) ; 4
(assert (not (= $t@1169 $t@1260)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252))
  (= $t@1257 $t@1227)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1260)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252)
      $k@1276)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252)
      $k@1276)
    $Perm.No)))
(assert (= $t@1257 sys__result@1161))
; [exec]
; i := __flatten_34
; [exec]
; __flatten_35 := BlockingQueue__peek(queue)
; [eval] diz != null
(declare-const $k@1277 $Perm)
(assert ($Perm.isValidVar $k@1277))
(assert ($Perm.isReadVar $k@1277 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1277 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1277
  (+ (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247) $k@1271)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1278 $Perm)
(assert ($Perm.isValidVar $k@1278))
(assert ($Perm.isReadVar $k@1278 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1278 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1278
  (+ (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248) $k@1272)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1279 $Perm)
(assert ($Perm.isValidVar $k@1279))
(assert ($Perm.isReadVar $k@1279 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1279 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1279
  (+ (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249) $k@1273)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1280 $Perm)
(assert ($Perm.isValidVar $k@1280))
(assert ($Perm.isReadVar $k@1280 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1280 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1175 $t@1266)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1280
  (+ (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250) $k@1274)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1266)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1281 $Perm)
(assert ($Perm.isValidVar $k@1281))
(assert ($Perm.isReadVar $k@1281 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1281 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1281
  (+ (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251) $k@1275)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1282 $Perm)
(assert ($Perm.isValidVar $k@1282))
(assert ($Perm.isReadVar $k@1282 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1282 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1169 $t@1260)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1282
  (+ (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252) $k@1276)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1260)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1283 $Ref)
(declare-const $t@1284 $Snap)
(declare-const $t@1285 $Snap)
(assert (= $t@1284 ($Snap.combine $t@1285 $Snap.unit)))
(declare-const $t@1286 $Snap)
(declare-const $t@1287 $Ref)
(assert (= $t@1285 ($Snap.combine $t@1286 ($SortWrappers.$RefTo$Snap $t@1287))))
(declare-const $t@1288 $Snap)
(assert (= $t@1286 ($Snap.combine $t@1288 $Snap.unit)))
(declare-const $t@1289 $Snap)
(declare-const $t@1290 $Ref)
(assert (= $t@1288 ($Snap.combine $t@1289 ($SortWrappers.$RefTo$Snap $t@1290))))
(declare-const $t@1291 $Snap)
(assert (= $t@1289 ($Snap.combine $t@1291 $Snap.unit)))
(declare-const $t@1292 $Snap)
(declare-const $t@1293 $Ref)
(assert (= $t@1291 ($Snap.combine $t@1292 ($SortWrappers.$RefTo$Snap $t@1293))))
(declare-const $t@1294 $Snap)
(assert (= $t@1292 ($Snap.combine $t@1294 $Snap.unit)))
(declare-const $t@1295 $Snap)
(declare-const $t@1296 $Ref)
(assert (= $t@1294 ($Snap.combine $t@1295 ($SortWrappers.$RefTo$Snap $t@1296))))
(declare-const $t@1297 $Snap)
(assert (= $t@1295 ($Snap.combine $t@1297 $Snap.unit)))
(declare-const $t@1298 Int)
(declare-const $t@1299 $Ref)
(assert (=
  $t@1297
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1298)
    ($SortWrappers.$RefTo$Snap $t@1299))))
(declare-const $t@1300 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1298)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1300) $Snap.unit)))
(declare-const $k@1301 $Perm)
(assert ($Perm.isValidVar $k@1301))
(assert ($Perm.isReadVar $k@1301 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247)
        $k@1271)
      $k@1277))
  (= $t@1300 $t@1270)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247)
          $k@1271)
        $k@1277)
      $k@1301)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1181 $k@1187) $k@1211) $k@1217) $k@1241) $k@1247)
          $k@1271)
        $k@1277)
      $k@1301)
    $Perm.No)))
(assert (> $t@1300 0))
(declare-const $k@1302 $Perm)
(assert ($Perm.isValidVar $k@1302))
(assert ($Perm.isReadVar $k@1302 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248)
        $k@1272)
      $k@1278))
  (= $t@1299 $t@1269)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248)
          $k@1272)
        $k@1278)
      $k@1302)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1182 $k@1188) $k@1212) $k@1218) $k@1242) $k@1248)
          $k@1272)
        $k@1278)
      $k@1302)
    $Perm.No)))
(assert (not (= $t@1299 $Ref.null)))
(declare-const $k@1303 $Perm)
(assert ($Perm.isValidVar $k@1303))
(assert ($Perm.isReadVar $k@1303 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249)
        $k@1273)
      $k@1279))
  (= $t@1296 $t@1266)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249)
          $k@1273)
        $k@1279)
      $k@1303)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1183 $k@1189) $k@1213) $k@1219) $k@1243) $k@1249)
          $k@1273)
        $k@1279)
      $k@1303)
    $Perm.No)))
(assert (not (= $t@1296 $Ref.null)))
(declare-const $k@1304 $Perm)
(assert ($Perm.isValidVar $k@1304))
(assert ($Perm.isReadVar $k@1304 $Perm.Write))
(push) ; 4
(assert (not (= $t@1175 $t@1296)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250)
        $k@1274)
      $k@1280))
  (= $t@1293 $t@1263)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1175 $t@1296)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250)
          $k@1274)
        $k@1280)
      $k@1304)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1184 $k@1190) $k@1214) $k@1220) $k@1244) $k@1250)
          $k@1274)
        $k@1280)
      $k@1304)
    $Perm.No)))
(assert (= $t@1293 sys__result@1161))
(declare-const $k@1305 $Perm)
(assert ($Perm.isValidVar $k@1305))
(assert ($Perm.isReadVar $k@1305 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251)
        $k@1275)
      $k@1281))
  (= $t@1290 $t@1260)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251)
          $k@1275)
        $k@1281)
      $k@1305)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1185 $k@1191) $k@1215) $k@1221) $k@1245) $k@1251)
          $k@1275)
        $k@1281)
      $k@1305)
    $Perm.No)))
(assert (not (= $t@1290 $Ref.null)))
(declare-const $k@1306 $Perm)
(assert ($Perm.isValidVar $k@1306))
(assert ($Perm.isReadVar $k@1306 $Perm.Write))
(push) ; 4
(assert (not (= $t@1169 $t@1290)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252)
        $k@1276)
      $k@1282))
  (= $t@1287 $t@1257)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1169 $t@1290)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252)
          $k@1276)
        $k@1282)
      $k@1306)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1186 $k@1192) $k@1216) $k@1222) $k@1246) $k@1252)
          $k@1276)
        $k@1282)
      $k@1306)
    $Perm.No)))
(assert (= $t@1287 sys__result@1161))
; [exec]
; j := __flatten_35
(pop) ; 3
(pop) ; 2
; ---------- Test__testFullAndFill ----------
(declare-const diz@1307 $Ref)
(declare-const queue@1308 $Ref)
(declare-const __flatten_36@1309 $Ref)
(declare-const b@1310 Bool)
(declare-const __flatten_40@1311 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1307 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_36 := BlockingQueue__BlockingQueue(3)
; [eval] capacity > 0
(declare-const sys__result@1312 $Ref)
(declare-const $t@1313 $Snap)
(declare-const $t@1314 $Snap)
(assert (= $t@1313 ($Snap.combine $t@1314 $Snap.unit)))
(declare-const $t@1315 $Snap)
(assert (= $t@1314 ($Snap.combine $t@1315 $Snap.unit)))
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
(declare-const $t@1325 $Snap)
(declare-const $t@1326 $Ref)
(assert (= $t@1324 ($Snap.combine $t@1325 ($SortWrappers.$RefTo$Snap $t@1326))))
(declare-const $t@1327 $Snap)
(assert (= $t@1325 ($Snap.combine $t@1327 $Snap.unit)))
(declare-const $t@1328 Int)
(declare-const $t@1329 $Ref)
(assert (=
  $t@1327
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1328)
    ($SortWrappers.$RefTo$Snap $t@1329))))
(declare-const $t@1330 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1328)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1330) $Snap.unit)))
(declare-const $t@1331 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1330)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1331))))
; [eval] sys__result != null
(assert (not (= sys__result@1312 $Ref.null)))
(declare-const $k@1332 $Perm)
(assert ($Perm.isValidVar $k@1332))
(assert ($Perm.isReadVar $k@1332 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1332 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1332 $Perm.No)))
(assert (> $t@1331 0))
(declare-const $k@1333 $Perm)
(assert ($Perm.isValidVar $k@1333))
(assert ($Perm.isReadVar $k@1333 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1333 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1333 $Perm.No)))
(assert (not (= $t@1329 $Ref.null)))
(declare-const $k@1334 $Perm)
(assert ($Perm.isValidVar $k@1334))
(assert ($Perm.isReadVar $k@1334 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1334 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1334 $Perm.No)))
(assert (not (= $t@1326 $Ref.null)))
(declare-const $k@1335 $Perm)
(assert ($Perm.isValidVar $k@1335))
(assert ($Perm.isReadVar $k@1335 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1335 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1335 $Perm.No)))
(assert (= $t@1323 sys__result@1312))
(declare-const $k@1336 $Perm)
(assert ($Perm.isValidVar $k@1336))
(assert ($Perm.isReadVar $k@1336 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1336 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1336 $Perm.No)))
(assert (not (= $t@1320 $Ref.null)))
(declare-const $k@1337 $Perm)
(assert ($Perm.isValidVar $k@1337))
(assert ($Perm.isReadVar $k@1337 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1337 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1337 $Perm.No)))
(assert (= $t@1317 sys__result@1312))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1331 3))
; [exec]
; queue := __flatten_36
; [exec]
; BlockingQueue__put(queue, 1)
; [eval] diz != null
(declare-const $k@1338 $Perm)
(assert ($Perm.isValidVar $k@1338))
(assert ($Perm.isReadVar $k@1338 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1338 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1338 $k@1332))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1339 $Perm)
(assert ($Perm.isValidVar $k@1339))
(assert ($Perm.isReadVar $k@1339 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1339 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1339 $k@1333))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1340 $Perm)
(assert ($Perm.isValidVar $k@1340))
(assert ($Perm.isReadVar $k@1340 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1340 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1340 $k@1334))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1341 $Perm)
(assert ($Perm.isValidVar $k@1341))
(assert ($Perm.isReadVar $k@1341 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1341 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1341 $k@1335))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@1342 $Perm)
(assert ($Perm.isValidVar $k@1342))
(assert ($Perm.isReadVar $k@1342 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1342 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1342 $k@1336))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1343 $Perm)
(assert ($Perm.isValidVar $k@1343))
(assert ($Perm.isReadVar $k@1343 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1343 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1343 $k@1337))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const $t@1344 $Snap)
(declare-const $t@1345 $Snap)
(assert (= $t@1344 ($Snap.combine $t@1345 $Snap.unit)))
(declare-const $t@1346 $Snap)
(declare-const $t@1347 $Ref)
(assert (= $t@1345 ($Snap.combine $t@1346 ($SortWrappers.$RefTo$Snap $t@1347))))
(declare-const $t@1348 $Snap)
(assert (= $t@1346 ($Snap.combine $t@1348 $Snap.unit)))
(declare-const $t@1349 $Snap)
(declare-const $t@1350 $Ref)
(assert (= $t@1348 ($Snap.combine $t@1349 ($SortWrappers.$RefTo$Snap $t@1350))))
(declare-const $t@1351 $Snap)
(assert (= $t@1349 ($Snap.combine $t@1351 $Snap.unit)))
(declare-const $t@1352 $Snap)
(declare-const $t@1353 $Ref)
(assert (= $t@1351 ($Snap.combine $t@1352 ($SortWrappers.$RefTo$Snap $t@1353))))
(declare-const $t@1354 $Snap)
(assert (= $t@1352 ($Snap.combine $t@1354 $Snap.unit)))
(declare-const $t@1355 $Snap)
(declare-const $t@1356 $Ref)
(assert (= $t@1354 ($Snap.combine $t@1355 ($SortWrappers.$RefTo$Snap $t@1356))))
(declare-const $t@1357 $Snap)
(assert (= $t@1355 ($Snap.combine $t@1357 $Snap.unit)))
(declare-const $t@1358 Int)
(declare-const $t@1359 $Ref)
(assert (=
  $t@1357
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1358)
    ($SortWrappers.$RefTo$Snap $t@1359))))
(declare-const $t@1360 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1358)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1360) $Snap.unit)))
(declare-const $k@1361 $Perm)
(assert ($Perm.isValidVar $k@1361))
(assert ($Perm.isReadVar $k@1361 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1332 $k@1338)) (= $t@1360 $t@1331)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- $k@1332 $k@1338) $k@1361) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1332 $k@1338) $k@1361) $Perm.No)))
(assert (> $t@1360 0))
(declare-const $k@1362 $Perm)
(assert ($Perm.isValidVar $k@1362))
(assert ($Perm.isReadVar $k@1362 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1333 $k@1339)) (= $t@1359 $t@1329)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- $k@1333 $k@1339) $k@1362) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1333 $k@1339) $k@1362) $Perm.No)))
(assert (not (= $t@1359 $Ref.null)))
(declare-const $k@1363 $Perm)
(assert ($Perm.isValidVar $k@1363))
(assert ($Perm.isReadVar $k@1363 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1334 $k@1340)) (= $t@1356 $t@1326)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1334 $k@1340) $k@1363) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1334 $k@1340) $k@1363) $Perm.No)))
(assert (not (= $t@1356 $Ref.null)))
(declare-const $k@1364 $Perm)
(assert ($Perm.isValidVar $k@1364))
(assert ($Perm.isReadVar $k@1364 $Perm.Write))
(push) ; 4
(assert (not (= $t@1326 $t@1356)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1335 $k@1341)) (= $t@1353 $t@1323)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1356)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1335 $k@1341) $k@1364) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1335 $k@1341) $k@1364) $Perm.No)))
(assert (= $t@1353 sys__result@1312))
(declare-const $k@1365 $Perm)
(assert ($Perm.isValidVar $k@1365))
(assert ($Perm.isReadVar $k@1365 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1336 $k@1342)) (= $t@1350 $t@1320)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- $k@1336 $k@1342) $k@1365) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1336 $k@1342) $k@1365) $Perm.No)))
(assert (not (= $t@1350 $Ref.null)))
(declare-const $k@1366 $Perm)
(assert ($Perm.isValidVar $k@1366))
(assert ($Perm.isReadVar $k@1366 $Perm.Write))
(push) ; 4
(assert (not (= $t@1320 $t@1350)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1337 $k@1343)) (= $t@1347 $t@1317)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1350)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1337 $k@1343) $k@1366) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1337 $k@1343) $k@1366) $Perm.No)))
(assert (= $t@1347 sys__result@1312))
; [exec]
; BlockingQueue__put(queue, 2)
; [eval] diz != null
(declare-const $k@1367 $Perm)
(assert ($Perm.isValidVar $k@1367))
(assert ($Perm.isReadVar $k@1367 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1367 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1367 (+ (- $k@1332 $k@1338) $k@1361)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1368 $Perm)
(assert ($Perm.isValidVar $k@1368))
(assert ($Perm.isReadVar $k@1368 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1368 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1368 (+ (- $k@1333 $k@1339) $k@1362)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1369 $Perm)
(assert ($Perm.isValidVar $k@1369))
(assert ($Perm.isReadVar $k@1369 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1369 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1369 (+ (- $k@1334 $k@1340) $k@1363)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1370 $Perm)
(assert ($Perm.isValidVar $k@1370))
(assert ($Perm.isReadVar $k@1370 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1370 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1326 $t@1356)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1370 (+ (- $k@1335 $k@1341) $k@1364)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1356)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1371 $Perm)
(assert ($Perm.isValidVar $k@1371))
(assert ($Perm.isReadVar $k@1371 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1371 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1371 (+ (- $k@1336 $k@1342) $k@1365)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1372 $Perm)
(assert ($Perm.isValidVar $k@1372))
(assert ($Perm.isReadVar $k@1372 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1372 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1320 $t@1350)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1372 (+ (- $k@1337 $k@1343) $k@1366)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1350)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $t@1373 $Snap)
(declare-const $t@1374 $Snap)
(assert (= $t@1373 ($Snap.combine $t@1374 $Snap.unit)))
(declare-const $t@1375 $Snap)
(declare-const $t@1376 $Ref)
(assert (= $t@1374 ($Snap.combine $t@1375 ($SortWrappers.$RefTo$Snap $t@1376))))
(declare-const $t@1377 $Snap)
(assert (= $t@1375 ($Snap.combine $t@1377 $Snap.unit)))
(declare-const $t@1378 $Snap)
(declare-const $t@1379 $Ref)
(assert (= $t@1377 ($Snap.combine $t@1378 ($SortWrappers.$RefTo$Snap $t@1379))))
(declare-const $t@1380 $Snap)
(assert (= $t@1378 ($Snap.combine $t@1380 $Snap.unit)))
(declare-const $t@1381 $Snap)
(declare-const $t@1382 $Ref)
(assert (= $t@1380 ($Snap.combine $t@1381 ($SortWrappers.$RefTo$Snap $t@1382))))
(declare-const $t@1383 $Snap)
(assert (= $t@1381 ($Snap.combine $t@1383 $Snap.unit)))
(declare-const $t@1384 $Snap)
(declare-const $t@1385 $Ref)
(assert (= $t@1383 ($Snap.combine $t@1384 ($SortWrappers.$RefTo$Snap $t@1385))))
(declare-const $t@1386 $Snap)
(assert (= $t@1384 ($Snap.combine $t@1386 $Snap.unit)))
(declare-const $t@1387 Int)
(declare-const $t@1388 $Ref)
(assert (=
  $t@1386
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1387)
    ($SortWrappers.$RefTo$Snap $t@1388))))
(declare-const $t@1389 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1387)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1389) $Snap.unit)))
(declare-const $k@1390 $Perm)
(assert ($Perm.isValidVar $k@1390))
(assert ($Perm.isReadVar $k@1390 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367))
  (= $t@1389 $t@1360)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $Perm.No)))
(assert (> $t@1389 0))
(declare-const $k@1391 $Perm)
(assert ($Perm.isValidVar $k@1391))
(assert ($Perm.isReadVar $k@1391 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368))
  (= $t@1388 $t@1359)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $Perm.No)))
(assert (not (= $t@1388 $Ref.null)))
(declare-const $k@1392 $Perm)
(assert ($Perm.isValidVar $k@1392))
(assert ($Perm.isReadVar $k@1392 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369))
  (= $t@1385 $t@1356)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $Perm.No)))
(assert (not (= $t@1385 $Ref.null)))
(declare-const $k@1393 $Perm)
(assert ($Perm.isValidVar $k@1393))
(assert ($Perm.isReadVar $k@1393 $Perm.Write))
(push) ; 4
(assert (not (= $t@1326 $t@1385)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (< $Perm.No (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370))
  (= $t@1382 $t@1353)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1385)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $Perm.No)))
(assert (= $t@1382 sys__result@1312))
(declare-const $k@1394 $Perm)
(assert ($Perm.isValidVar $k@1394))
(assert ($Perm.isReadVar $k@1394 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371))
  (= $t@1379 $t@1350)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $Perm.No)))
(assert (not (= $t@1379 $Ref.null)))
(declare-const $k@1395 $Perm)
(assert ($Perm.isValidVar $k@1395))
(assert ($Perm.isReadVar $k@1395 $Perm.Write))
(push) ; 4
(assert (not (= $t@1320 $t@1379)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (< $Perm.No (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372))
  (= $t@1376 $t@1347)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1379)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $Perm.No)))
(assert (= $t@1376 sys__result@1312))
; [exec]
; BlockingQueue__put(queue, 3)
; [eval] diz != null
(declare-const $k@1396 $Perm)
(assert ($Perm.isValidVar $k@1396))
(assert ($Perm.isReadVar $k@1396 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1396 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1396 (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1397 $Perm)
(assert ($Perm.isValidVar $k@1397))
(assert ($Perm.isReadVar $k@1397 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1397 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1397 (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1398 $Perm)
(assert ($Perm.isValidVar $k@1398))
(assert ($Perm.isReadVar $k@1398 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1398 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1398 (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1399 $Perm)
(assert ($Perm.isValidVar $k@1399))
(assert ($Perm.isReadVar $k@1399 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1399 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1326 $t@1385)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1399 (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1385)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1400 $Perm)
(assert ($Perm.isValidVar $k@1400))
(assert ($Perm.isReadVar $k@1400 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1400 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1400 (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1401 $Perm)
(assert ($Perm.isValidVar $k@1401))
(assert ($Perm.isReadVar $k@1401 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1401 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1320 $t@1379)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1401 (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1379)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $t@1402 $Snap)
(declare-const $t@1403 $Snap)
(assert (= $t@1402 ($Snap.combine $t@1403 $Snap.unit)))
(declare-const $t@1404 $Snap)
(declare-const $t@1405 $Ref)
(assert (= $t@1403 ($Snap.combine $t@1404 ($SortWrappers.$RefTo$Snap $t@1405))))
(declare-const $t@1406 $Snap)
(assert (= $t@1404 ($Snap.combine $t@1406 $Snap.unit)))
(declare-const $t@1407 $Snap)
(declare-const $t@1408 $Ref)
(assert (= $t@1406 ($Snap.combine $t@1407 ($SortWrappers.$RefTo$Snap $t@1408))))
(declare-const $t@1409 $Snap)
(assert (= $t@1407 ($Snap.combine $t@1409 $Snap.unit)))
(declare-const $t@1410 $Snap)
(declare-const $t@1411 $Ref)
(assert (= $t@1409 ($Snap.combine $t@1410 ($SortWrappers.$RefTo$Snap $t@1411))))
(declare-const $t@1412 $Snap)
(assert (= $t@1410 ($Snap.combine $t@1412 $Snap.unit)))
(declare-const $t@1413 $Snap)
(declare-const $t@1414 $Ref)
(assert (= $t@1412 ($Snap.combine $t@1413 ($SortWrappers.$RefTo$Snap $t@1414))))
(declare-const $t@1415 $Snap)
(assert (= $t@1413 ($Snap.combine $t@1415 $Snap.unit)))
(declare-const $t@1416 Int)
(declare-const $t@1417 $Ref)
(assert (=
  $t@1415
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1416)
    ($SortWrappers.$RefTo$Snap $t@1417))))
(declare-const $t@1418 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1416)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1418) $Snap.unit)))
(declare-const $k@1419 $Perm)
(assert ($Perm.isValidVar $k@1419))
(assert ($Perm.isReadVar $k@1419 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396))
  (= $t@1418 $t@1389)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396)
      $k@1419)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396)
      $k@1419)
    $Perm.No)))
(assert (> $t@1418 0))
(declare-const $k@1420 $Perm)
(assert ($Perm.isValidVar $k@1420))
(assert ($Perm.isReadVar $k@1420 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397))
  (= $t@1417 $t@1388)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397)
      $k@1420)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397)
      $k@1420)
    $Perm.No)))
(assert (not (= $t@1417 $Ref.null)))
(declare-const $k@1421 $Perm)
(assert ($Perm.isValidVar $k@1421))
(assert ($Perm.isReadVar $k@1421 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398))
  (= $t@1414 $t@1385)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398)
      $k@1421)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398)
      $k@1421)
    $Perm.No)))
(assert (not (= $t@1414 $Ref.null)))
(declare-const $k@1422 $Perm)
(assert ($Perm.isValidVar $k@1422))
(assert ($Perm.isReadVar $k@1422 $Perm.Write))
(push) ; 4
(assert (not (= $t@1326 $t@1414)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399))
  (= $t@1411 $t@1382)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1414)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399)
      $k@1422)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399)
      $k@1422)
    $Perm.No)))
(assert (= $t@1411 sys__result@1312))
(declare-const $k@1423 $Perm)
(assert ($Perm.isValidVar $k@1423))
(assert ($Perm.isReadVar $k@1423 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400))
  (= $t@1408 $t@1379)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400)
      $k@1423)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400)
      $k@1423)
    $Perm.No)))
(assert (not (= $t@1408 $Ref.null)))
(declare-const $k@1424 $Perm)
(assert ($Perm.isValidVar $k@1424))
(assert ($Perm.isReadVar $k@1424 $Perm.Write))
(push) ; 4
(assert (not (= $t@1320 $t@1408)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401))
  (= $t@1405 $t@1376)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1408)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401)
      $k@1424)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401)
      $k@1424)
    $Perm.No)))
(assert (= $t@1405 sys__result@1312))
; [exec]
; __flatten_40 := BlockingQueue__offer(queue, 4)
; [eval] diz != null
(declare-const $k@1425 $Perm)
(assert ($Perm.isValidVar $k@1425))
(assert ($Perm.isReadVar $k@1425 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1425 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1425
  (+ (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396) $k@1419)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1426 $Perm)
(assert ($Perm.isValidVar $k@1426))
(assert ($Perm.isReadVar $k@1426 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1426 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1426
  (+ (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397) $k@1420)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@1427 $Perm)
(assert ($Perm.isValidVar $k@1427))
(assert ($Perm.isReadVar $k@1427 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1427 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1427
  (+ (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398) $k@1421)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@1428 $Perm)
(assert ($Perm.isValidVar $k@1428))
(assert ($Perm.isReadVar $k@1428 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1428 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1326 $t@1414)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1428
  (+ (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399) $k@1422)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1414)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1429 $Perm)
(assert ($Perm.isValidVar $k@1429))
(assert ($Perm.isReadVar $k@1429 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1429 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1429
  (+ (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400) $k@1423)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@1430 $Perm)
(assert ($Perm.isValidVar $k@1430))
(assert ($Perm.isReadVar $k@1430 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1430 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1320 $t@1408)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (<
  $k@1430
  (+ (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401) $k@1424)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1408)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const sys__result@1431 Bool)
(declare-const $t@1432 $Snap)
(declare-const $t@1433 $Snap)
(assert (= $t@1432 ($Snap.combine $t@1433 $Snap.unit)))
(declare-const $t@1434 $Snap)
(declare-const $t@1435 $Ref)
(assert (= $t@1433 ($Snap.combine $t@1434 ($SortWrappers.$RefTo$Snap $t@1435))))
(declare-const $t@1436 $Snap)
(assert (= $t@1434 ($Snap.combine $t@1436 $Snap.unit)))
(declare-const $t@1437 $Snap)
(declare-const $t@1438 $Ref)
(assert (= $t@1436 ($Snap.combine $t@1437 ($SortWrappers.$RefTo$Snap $t@1438))))
(declare-const $t@1439 $Snap)
(assert (= $t@1437 ($Snap.combine $t@1439 $Snap.unit)))
(declare-const $t@1440 $Snap)
(declare-const $t@1441 $Ref)
(assert (= $t@1439 ($Snap.combine $t@1440 ($SortWrappers.$RefTo$Snap $t@1441))))
(declare-const $t@1442 $Snap)
(assert (= $t@1440 ($Snap.combine $t@1442 $Snap.unit)))
(declare-const $t@1443 $Snap)
(declare-const $t@1444 $Ref)
(assert (= $t@1442 ($Snap.combine $t@1443 ($SortWrappers.$RefTo$Snap $t@1444))))
(declare-const $t@1445 $Snap)
(assert (= $t@1443 ($Snap.combine $t@1445 $Snap.unit)))
(declare-const $t@1446 Int)
(declare-const $t@1447 $Ref)
(assert (=
  $t@1445
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1446)
    ($SortWrappers.$RefTo$Snap $t@1447))))
(declare-const $t@1448 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1446)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1448) $Snap.unit)))
(declare-const $k@1449 $Perm)
(assert ($Perm.isValidVar $k@1449))
(assert ($Perm.isReadVar $k@1449 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396)
        $k@1419)
      $k@1425))
  (= $t@1448 $t@1418)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396)
          $k@1419)
        $k@1425)
      $k@1449)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1332 $k@1338) $k@1361) $k@1367) $k@1390) $k@1396)
          $k@1419)
        $k@1425)
      $k@1449)
    $Perm.No)))
(assert (> $t@1448 0))
(declare-const $k@1450 $Perm)
(assert ($Perm.isValidVar $k@1450))
(assert ($Perm.isReadVar $k@1450 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397)
        $k@1420)
      $k@1426))
  (= $t@1447 $t@1417)))
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397)
          $k@1420)
        $k@1426)
      $k@1450)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1333 $k@1339) $k@1362) $k@1368) $k@1391) $k@1397)
          $k@1420)
        $k@1426)
      $k@1450)
    $Perm.No)))
(assert (not (= $t@1447 $Ref.null)))
(declare-const $k@1451 $Perm)
(assert ($Perm.isValidVar $k@1451))
(assert ($Perm.isReadVar $k@1451 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398)
        $k@1421)
      $k@1427))
  (= $t@1444 $t@1414)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398)
          $k@1421)
        $k@1427)
      $k@1451)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1334 $k@1340) $k@1363) $k@1369) $k@1392) $k@1398)
          $k@1421)
        $k@1427)
      $k@1451)
    $Perm.No)))
(assert (not (= $t@1444 $Ref.null)))
(declare-const $k@1452 $Perm)
(assert ($Perm.isValidVar $k@1452))
(assert ($Perm.isReadVar $k@1452 $Perm.Write))
(push) ; 4
(assert (not (= $t@1326 $t@1444)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399)
        $k@1422)
      $k@1428))
  (= $t@1441 $t@1411)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (= $t@1326 $t@1444)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399)
          $k@1422)
        $k@1428)
      $k@1452)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1335 $k@1341) $k@1364) $k@1370) $k@1393) $k@1399)
          $k@1422)
        $k@1428)
      $k@1452)
    $Perm.No)))
(assert (= $t@1441 sys__result@1312))
(declare-const $k@1453 $Perm)
(assert ($Perm.isValidVar $k@1453))
(assert ($Perm.isReadVar $k@1453 $Perm.Write))
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400)
        $k@1423)
      $k@1429))
  (= $t@1438 $t@1408)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400)
          $k@1423)
        $k@1429)
      $k@1453)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1336 $k@1342) $k@1365) $k@1371) $k@1394) $k@1400)
          $k@1423)
        $k@1429)
      $k@1453)
    $Perm.No)))
(assert (not (= $t@1438 $Ref.null)))
(declare-const $k@1454 $Perm)
(assert ($Perm.isValidVar $k@1454))
(assert ($Perm.isReadVar $k@1454 $Perm.Write))
(push) ; 4
(assert (not (= $t@1320 $t@1438)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies
  (<
    $Perm.No
    (-
      (+
        (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401)
        $k@1424)
      $k@1430))
  (= $t@1435 $t@1405)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (= $t@1320 $t@1438)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401)
          $k@1424)
        $k@1430)
      $k@1454)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not
  (=
    (+
      (-
        (+
          (- (+ (- (+ (- $k@1337 $k@1343) $k@1366) $k@1372) $k@1395) $k@1401)
          $k@1424)
        $k@1430)
      $k@1454)
    $Perm.No)))
(assert (= $t@1435 sys__result@1312))
; [exec]
; b := __flatten_40
(pop) ; 3
(pop) ; 2
; ---------- Test__test1 ----------
(declare-const diz@1455 $Ref)
(declare-const queue@1456 $Ref)
(declare-const __flatten_41@1457 $Ref)
(declare-const t1@1458 $Ref)
(declare-const __flatten_42@1459 $Ref)
(declare-const t2@1460 $Ref)
(declare-const __flatten_43@1461 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1455 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_41 := BlockingQueue__BlockingQueue(2)
; [eval] capacity > 0
(declare-const sys__result@1462 $Ref)
(declare-const $t@1463 $Snap)
(declare-const $t@1464 $Snap)
(assert (= $t@1463 ($Snap.combine $t@1464 $Snap.unit)))
(declare-const $t@1465 $Snap)
(assert (= $t@1464 ($Snap.combine $t@1465 $Snap.unit)))
(declare-const $t@1466 $Snap)
(declare-const $t@1467 $Ref)
(assert (= $t@1465 ($Snap.combine $t@1466 ($SortWrappers.$RefTo$Snap $t@1467))))
(declare-const $t@1468 $Snap)
(assert (= $t@1466 ($Snap.combine $t@1468 $Snap.unit)))
(declare-const $t@1469 $Snap)
(declare-const $t@1470 $Ref)
(assert (= $t@1468 ($Snap.combine $t@1469 ($SortWrappers.$RefTo$Snap $t@1470))))
(declare-const $t@1471 $Snap)
(assert (= $t@1469 ($Snap.combine $t@1471 $Snap.unit)))
(declare-const $t@1472 $Snap)
(declare-const $t@1473 $Ref)
(assert (= $t@1471 ($Snap.combine $t@1472 ($SortWrappers.$RefTo$Snap $t@1473))))
(declare-const $t@1474 $Snap)
(assert (= $t@1472 ($Snap.combine $t@1474 $Snap.unit)))
(declare-const $t@1475 $Snap)
(declare-const $t@1476 $Ref)
(assert (= $t@1474 ($Snap.combine $t@1475 ($SortWrappers.$RefTo$Snap $t@1476))))
(declare-const $t@1477 $Snap)
(assert (= $t@1475 ($Snap.combine $t@1477 $Snap.unit)))
(declare-const $t@1478 Int)
(declare-const $t@1479 $Ref)
(assert (=
  $t@1477
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1478)
    ($SortWrappers.$RefTo$Snap $t@1479))))
(declare-const $t@1480 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1478)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1480) $Snap.unit)))
(declare-const $t@1481 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1480)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1481))))
; [eval] sys__result != null
(assert (not (= sys__result@1462 $Ref.null)))
(declare-const $k@1482 $Perm)
(assert ($Perm.isValidVar $k@1482))
(assert ($Perm.isReadVar $k@1482 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1482 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1482 $Perm.No)))
(assert (> $t@1481 0))
(declare-const $k@1483 $Perm)
(assert ($Perm.isValidVar $k@1483))
(assert ($Perm.isReadVar $k@1483 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1483 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1483 $Perm.No)))
(assert (not (= $t@1479 $Ref.null)))
(declare-const $k@1484 $Perm)
(assert ($Perm.isValidVar $k@1484))
(assert ($Perm.isReadVar $k@1484 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1484 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1484 $Perm.No)))
(assert (not (= $t@1476 $Ref.null)))
(declare-const $k@1485 $Perm)
(assert ($Perm.isValidVar $k@1485))
(assert ($Perm.isReadVar $k@1485 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1485 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1485 $Perm.No)))
(assert (= $t@1473 sys__result@1462))
(declare-const $k@1486 $Perm)
(assert ($Perm.isValidVar $k@1486))
(assert ($Perm.isReadVar $k@1486 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1486 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1486 $Perm.No)))
(assert (not (= $t@1470 $Ref.null)))
(declare-const $k@1487 $Perm)
(assert ($Perm.isValidVar $k@1487))
(assert ($Perm.isReadVar $k@1487 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1487 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1487 $Perm.No)))
(assert (= $t@1467 sys__result@1462))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1481 2))
; [exec]
; queue := __flatten_41
; [exec]
; __flatten_42 := OfferPeekWorker__OfferPeekWorker(queue)
(declare-const $k@1488 $Perm)
(assert ($Perm.isValidVar $k@1488))
(assert ($Perm.isReadVar $k@1488 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1488 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1488 $k@1482))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1489 $Perm)
(assert ($Perm.isValidVar $k@1489))
(assert ($Perm.isReadVar $k@1489 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1489 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1489 $k@1483))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1490 $Perm)
(assert ($Perm.isValidVar $k@1490))
(assert ($Perm.isReadVar $k@1490 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1490 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1490 $k@1484))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1491 $Perm)
(assert ($Perm.isValidVar $k@1491))
(assert ($Perm.isReadVar $k@1491 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1491 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1491 $k@1485))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1492 $Perm)
(assert ($Perm.isValidVar $k@1492))
(assert ($Perm.isReadVar $k@1492 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1492 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1492 $k@1486))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1493 $Perm)
(assert ($Perm.isValidVar $k@1493))
(assert ($Perm.isReadVar $k@1493 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1493 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1493 $k@1487))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1494 $Ref)
(declare-const $t@1495 $Snap)
(declare-const $t@1496 $Snap)
(assert (= $t@1495 ($Snap.combine $t@1496 $Snap.unit)))
(declare-const $t@1497 $Snap)
(declare-const $t@1498 $Ref)
(assert (= $t@1496 ($Snap.combine $t@1497 ($SortWrappers.$RefTo$Snap $t@1498))))
(declare-const $t@1499 $Snap)
(assert (= $t@1497 ($Snap.combine $t@1499 $Snap.unit)))
(declare-const $t@1500 $Snap)
(declare-const $t@1501 $Ref)
(assert (= $t@1499 ($Snap.combine $t@1500 ($SortWrappers.$RefTo$Snap $t@1501))))
(declare-const $t@1502 $Snap)
(assert (= $t@1500 ($Snap.combine $t@1502 $Snap.unit)))
(declare-const $t@1503 $Snap)
(declare-const $t@1504 $Ref)
(assert (= $t@1502 ($Snap.combine $t@1503 ($SortWrappers.$RefTo$Snap $t@1504))))
(declare-const $t@1505 $Snap)
(assert (= $t@1503 ($Snap.combine $t@1505 $Snap.unit)))
(declare-const $t@1506 $Snap)
(declare-const $t@1507 $Ref)
(assert (= $t@1505 ($Snap.combine $t@1506 ($SortWrappers.$RefTo$Snap $t@1507))))
(declare-const $t@1508 $Snap)
(assert (= $t@1506 ($Snap.combine $t@1508 $Snap.unit)))
(declare-const $t@1509 $Snap)
(declare-const $t@1510 $Ref)
(assert (= $t@1508 ($Snap.combine $t@1509 ($SortWrappers.$RefTo$Snap $t@1510))))
(declare-const $t@1511 $Snap)
(assert (= $t@1509 ($Snap.combine $t@1511 $Snap.unit)))
(declare-const $t@1512 $Ref)
(declare-const $t@1513 Int)
(assert (=
  $t@1511
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1512)
    ($SortWrappers.IntTo$Snap $t@1513))))
(declare-const $t@1514 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1512)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1514))))
; [eval] sys__result != null
(assert (not (= sys__result@1494 $Ref.null)))
(declare-const $k@1515 $Perm)
(assert ($Perm.isValidVar $k@1515))
(assert ($Perm.isReadVar $k@1515 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1515 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1515 $Perm.No)))
(assert (not (= $t@1514 $Ref.null)))
(declare-const $k@1516 $Perm)
(assert ($Perm.isValidVar $k@1516))
(assert ($Perm.isReadVar $k@1516 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1514)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1516 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1516 $Perm.No)))
(assert (> $t@1513 0))
(declare-const $k@1517 $Perm)
(assert ($Perm.isValidVar $k@1517))
(assert ($Perm.isReadVar $k@1517 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1514)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1517 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1517 $Perm.No)))
(assert (not (= $t@1510 $Ref.null)))
(declare-const $k@1518 $Perm)
(assert ($Perm.isValidVar $k@1518))
(assert ($Perm.isReadVar $k@1518 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1514)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1518 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1518 $Perm.No)))
(assert (not (= $t@1507 $Ref.null)))
(declare-const $k@1519 $Perm)
(assert ($Perm.isValidVar $k@1519))
(assert ($Perm.isReadVar $k@1519 $Perm.Write))
(push) ; 4
(assert (not (= $t@1476 $t@1507)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@1519 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1519 $Perm.No)))
(assert (= $t@1504 $t@1514))
(declare-const $k@1520 $Perm)
(assert ($Perm.isValidVar $k@1520))
(assert ($Perm.isReadVar $k@1520 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1514)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1520 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1520 $Perm.No)))
(assert (not (= $t@1501 $Ref.null)))
(declare-const $k@1521 $Perm)
(assert ($Perm.isValidVar $k@1521))
(assert ($Perm.isReadVar $k@1521 $Perm.Write))
(push) ; 4
(assert (not (= $t@1470 $t@1501)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@1521 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1521 $Perm.No)))
(assert (= $t@1498 $t@1514))
; [exec]
; t1 := __flatten_42
; [exec]
; __flatten_43 := OfferPeekWorker__OfferPeekWorker(queue)
(declare-const $k@1522 $Perm)
(assert ($Perm.isValidVar $k@1522))
(assert ($Perm.isReadVar $k@1522 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1522 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1482 $k@1488) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1482 $k@1488) $Perm.No)))
(assert (< $k@1522 (- $k@1482 $k@1488)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1523 $Perm)
(assert ($Perm.isValidVar $k@1523))
(assert ($Perm.isReadVar $k@1523 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1523 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1483 $k@1489) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1483 $k@1489) $Perm.No)))
(assert (< $k@1523 (- $k@1483 $k@1489)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1524 $Perm)
(assert ($Perm.isValidVar $k@1524))
(assert ($Perm.isReadVar $k@1524 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1524 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1484 $k@1490) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1484 $k@1490) $Perm.No)))
(assert (< $k@1524 (- $k@1484 $k@1490)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1525 $Perm)
(assert ($Perm.isValidVar $k@1525))
(assert ($Perm.isReadVar $k@1525 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1525 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1485 $k@1491) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1485 $k@1491) $Perm.No)))
(assert (< $k@1525 (- $k@1485 $k@1491)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1526 $Perm)
(assert ($Perm.isValidVar $k@1526))
(assert ($Perm.isReadVar $k@1526 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1526 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1486 $k@1492) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1486 $k@1492) $Perm.No)))
(assert (< $k@1526 (- $k@1486 $k@1492)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1527 $Perm)
(assert ($Perm.isValidVar $k@1527))
(assert ($Perm.isReadVar $k@1527 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1527 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1487 $k@1493) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1487 $k@1493) $Perm.No)))
(assert (< $k@1527 (- $k@1487 $k@1493)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1528 $Ref)
(declare-const $t@1529 $Snap)
(declare-const $t@1530 $Snap)
(assert (= $t@1529 ($Snap.combine $t@1530 $Snap.unit)))
(declare-const $t@1531 $Snap)
(declare-const $t@1532 $Ref)
(assert (= $t@1530 ($Snap.combine $t@1531 ($SortWrappers.$RefTo$Snap $t@1532))))
(declare-const $t@1533 $Snap)
(assert (= $t@1531 ($Snap.combine $t@1533 $Snap.unit)))
(declare-const $t@1534 $Snap)
(declare-const $t@1535 $Ref)
(assert (= $t@1533 ($Snap.combine $t@1534 ($SortWrappers.$RefTo$Snap $t@1535))))
(declare-const $t@1536 $Snap)
(assert (= $t@1534 ($Snap.combine $t@1536 $Snap.unit)))
(declare-const $t@1537 $Snap)
(declare-const $t@1538 $Ref)
(assert (= $t@1536 ($Snap.combine $t@1537 ($SortWrappers.$RefTo$Snap $t@1538))))
(declare-const $t@1539 $Snap)
(assert (= $t@1537 ($Snap.combine $t@1539 $Snap.unit)))
(declare-const $t@1540 $Snap)
(declare-const $t@1541 $Ref)
(assert (= $t@1539 ($Snap.combine $t@1540 ($SortWrappers.$RefTo$Snap $t@1541))))
(declare-const $t@1542 $Snap)
(assert (= $t@1540 ($Snap.combine $t@1542 $Snap.unit)))
(declare-const $t@1543 $Snap)
(declare-const $t@1544 $Ref)
(assert (= $t@1542 ($Snap.combine $t@1543 ($SortWrappers.$RefTo$Snap $t@1544))))
(declare-const $t@1545 $Snap)
(assert (= $t@1543 ($Snap.combine $t@1545 $Snap.unit)))
(declare-const $t@1546 $Ref)
(declare-const $t@1547 Int)
(assert (=
  $t@1545
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1546)
    ($SortWrappers.IntTo$Snap $t@1547))))
(declare-const $t@1548 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1546)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1548))))
; [eval] sys__result != null
(assert (not (= sys__result@1528 $Ref.null)))
(declare-const $k@1549 $Perm)
(assert ($Perm.isValidVar $k@1549))
(assert ($Perm.isReadVar $k@1549 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1494 sys__result@1528)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $k@1549 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1549 $Perm.No)))
(assert (not (= $t@1548 $Ref.null)))
(declare-const $k@1550 $Perm)
(assert ($Perm.isValidVar $k@1550))
(assert ($Perm.isReadVar $k@1550 $Perm.Write))
(push) ; 4
(assert (not (= $t@1514 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1462 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1550 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1550 $Perm.No)))
(assert (> $t@1547 0))
(declare-const $k@1551 $Perm)
(assert ($Perm.isValidVar $k@1551))
(assert ($Perm.isReadVar $k@1551 $Perm.Write))
(push) ; 4
(assert (not (= $t@1514 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1462 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1551 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1551 $Perm.No)))
(assert (not (= $t@1544 $Ref.null)))
(declare-const $k@1552 $Perm)
(assert ($Perm.isValidVar $k@1552))
(assert ($Perm.isReadVar $k@1552 $Perm.Write))
(push) ; 4
(assert (not (= $t@1514 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1462 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1552 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1552 $Perm.No)))
(assert (not (= $t@1541 $Ref.null)))
(declare-const $k@1553 $Perm)
(assert ($Perm.isValidVar $k@1553))
(assert ($Perm.isReadVar $k@1553 $Perm.Write))
(push) ; 4
(assert (not (= $t@1507 $t@1541)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1476 $t@1541)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@1553 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1553 $Perm.No)))
(assert (= $t@1538 $t@1548))
(declare-const $k@1554 $Perm)
(assert ($Perm.isValidVar $k@1554))
(assert ($Perm.isReadVar $k@1554 $Perm.Write))
(push) ; 4
(assert (not (= $t@1514 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1462 $t@1548)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1554 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1554 $Perm.No)))
(assert (not (= $t@1535 $Ref.null)))
(declare-const $k@1555 $Perm)
(assert ($Perm.isValidVar $k@1555))
(assert ($Perm.isReadVar $k@1555 $Perm.Write))
(push) ; 4
(assert (not (= $t@1501 $t@1535)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1470 $t@1535)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.OfferPeekWorker__queue
(push) ; 4
(assert (not (not (= $k@1555 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1555 $Perm.No)))
(assert (= $t@1532 $t@1548))
; [exec]
; t2 := __flatten_43
; [exec]
; OfferPeekWorker__forkOperator(t1)
; [eval] diz != null
(declare-const $k@1556 $Perm)
(assert ($Perm.isValidVar $k@1556))
(assert ($Perm.isReadVar $k@1556 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1556 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1556 $k@1515))
(declare-const $k@1557 $Perm)
(assert ($Perm.isValidVar $k@1557))
(assert ($Perm.isReadVar $k@1557 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1557 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1557 $k@1516))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@1558 $Perm)
(assert ($Perm.isValidVar $k@1558))
(assert ($Perm.isReadVar $k@1558 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1558 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1558 $k@1517))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(declare-const $k@1559 $Perm)
(assert ($Perm.isValidVar $k@1559))
(assert ($Perm.isReadVar $k@1559 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1559 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1559 $k@1518))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(declare-const $k@1560 $Perm)
(assert ($Perm.isValidVar $k@1560))
(assert ($Perm.isReadVar $k@1560 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1560 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1560 $k@1519))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(declare-const $k@1561 $Perm)
(assert ($Perm.isValidVar $k@1561))
(assert ($Perm.isReadVar $k@1561 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1561 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1561 $k@1520))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@1562 $Perm)
(assert ($Perm.isValidVar $k@1562))
(assert ($Perm.isReadVar $k@1562 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1562 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1562 $k@1521))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(declare-const $t@1563 $Snap)
; [exec]
; OfferPeekWorker__forkOperator(t2)
; [eval] diz != null
(declare-const $k@1564 $Perm)
(assert ($Perm.isValidVar $k@1564))
(assert ($Perm.isReadVar $k@1564 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1564 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1564 $k@1549))
(declare-const $k@1565 $Perm)
(assert ($Perm.isValidVar $k@1565))
(assert ($Perm.isReadVar $k@1565 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1565 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1565 $k@1550))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@1566 $Perm)
(assert ($Perm.isValidVar $k@1566))
(assert ($Perm.isReadVar $k@1566 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1566 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1566 $k@1551))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(declare-const $k@1567 $Perm)
(assert ($Perm.isValidVar $k@1567))
(assert ($Perm.isReadVar $k@1567 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1567 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1567 $k@1552))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(declare-const $k@1568 $Perm)
(assert ($Perm.isValidVar $k@1568))
(assert ($Perm.isReadVar $k@1568 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1568 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1568 $k@1553))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(declare-const $k@1569 $Perm)
(assert ($Perm.isValidVar $k@1569))
(assert ($Perm.isReadVar $k@1569 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1569 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1569 $k@1554))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@1570 $Perm)
(assert ($Perm.isValidVar $k@1570))
(assert ($Perm.isReadVar $k@1570 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1570 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1570 $k@1555))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(declare-const $t@1571 $Snap)
(push) ; 4
(assert (not (= sys__result@1494 sys__result@1528)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [exec]
; OfferPeekWorker__joinOperator(t1)
; [eval] diz != null
(declare-const $t@1572 $Snap)
(declare-const $t@1573 $Snap)
(assert (= $t@1572 ($Snap.combine $t@1573 $Snap.unit)))
(declare-const $t@1574 $Snap)
(declare-const $t@1575 $Ref)
(assert (= $t@1573 ($Snap.combine $t@1574 ($SortWrappers.$RefTo$Snap $t@1575))))
(declare-const $t@1576 $Snap)
(assert (= $t@1574 ($Snap.combine $t@1576 $Snap.unit)))
(declare-const $t@1577 $Snap)
(declare-const $t@1578 $Ref)
(assert (= $t@1576 ($Snap.combine $t@1577 ($SortWrappers.$RefTo$Snap $t@1578))))
(declare-const $t@1579 $Snap)
(assert (= $t@1577 ($Snap.combine $t@1579 $Snap.unit)))
(declare-const $t@1580 $Snap)
(declare-const $t@1581 $Ref)
(assert (= $t@1579 ($Snap.combine $t@1580 ($SortWrappers.$RefTo$Snap $t@1581))))
(declare-const $t@1582 $Snap)
(assert (= $t@1580 ($Snap.combine $t@1582 $Snap.unit)))
(declare-const $t@1583 $Snap)
(declare-const $t@1584 $Ref)
(assert (= $t@1582 ($Snap.combine $t@1583 ($SortWrappers.$RefTo$Snap $t@1584))))
(declare-const $t@1585 $Snap)
(assert (= $t@1583 ($Snap.combine $t@1585 $Snap.unit)))
(declare-const $t@1586 $Snap)
(declare-const $t@1587 $Ref)
(assert (= $t@1585 ($Snap.combine $t@1586 ($SortWrappers.$RefTo$Snap $t@1587))))
(declare-const $t@1588 $Snap)
(assert (= $t@1586 ($Snap.combine $t@1588 $Snap.unit)))
(declare-const $t@1589 $Ref)
(declare-const $t@1590 Int)
(assert (=
  $t@1588
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1589)
    ($SortWrappers.IntTo$Snap $t@1590))))
(declare-const $k@1591 $Perm)
(assert ($Perm.isValidVar $k@1591))
(assert ($Perm.isReadVar $k@1591 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1515 $k@1556)) (= $t@1589 $t@1514)))
(push) ; 4
(assert (not (not (= (+ (- $k@1515 $k@1556) $k@1591) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1515 $k@1556) $k@1591) $Perm.No)))
(assert (not (= $t@1589 $Ref.null)))
(declare-const $k@1592 $Perm)
(assert ($Perm.isValidVar $k@1592))
(assert ($Perm.isReadVar $k@1592 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1516 $k@1557)) (= $t@1590 $t@1513)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1516 $k@1557) $k@1592) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1516 $k@1557) $k@1592) $Perm.No)))
(assert (> $t@1590 0))
(declare-const $k@1593 $Perm)
(assert ($Perm.isValidVar $k@1593))
(assert ($Perm.isReadVar $k@1593 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1517 $k@1558)) (= $t@1587 $t@1510)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1517 $k@1558) $k@1593) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1517 $k@1558) $k@1593) $Perm.No)))
(assert (not (= $t@1587 $Ref.null)))
(declare-const $k@1594 $Perm)
(assert ($Perm.isValidVar $k@1594))
(assert ($Perm.isReadVar $k@1594 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1518 $k@1559)) (= $t@1584 $t@1507)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1518 $k@1559) $k@1594) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1518 $k@1559) $k@1594) $Perm.No)))
(assert (not (= $t@1584 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1595 $Perm)
(assert ($Perm.isValidVar $k@1595))
(assert ($Perm.isReadVar $k@1595 $Perm.Write))
(push) ; 4
(assert (not (= $t@1476 $t@1584)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1507 $t@1584)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1519 $k@1560)) (= $t@1581 $t@1504)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1476 $t@1584)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1541 $t@1584)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1507 $t@1584)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1519 $k@1560) $k@1595) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1519 $k@1560) $k@1595) $Perm.No)))
(assert (= $t@1581 $t@1589))
(declare-const $k@1596 $Perm)
(assert ($Perm.isValidVar $k@1596))
(assert ($Perm.isReadVar $k@1596 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1520 $k@1561)) (= $t@1578 $t@1501)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1520 $k@1561) $k@1596) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1520 $k@1561) $k@1596) $Perm.No)))
(assert (not (= $t@1578 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1597 $Perm)
(assert ($Perm.isValidVar $k@1597))
(assert ($Perm.isReadVar $k@1597 $Perm.Write))
(push) ; 4
(assert (not (= $t@1470 $t@1578)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1501 $t@1578)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1521 $k@1562)) (= $t@1575 $t@1498)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (= sys__result@1462 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1589)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1589)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1470 $t@1578)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1535 $t@1578)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1501 $t@1578)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1521 $k@1562) $k@1597) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1521 $k@1562) $k@1597) $Perm.No)))
(assert (= $t@1575 $t@1589))
; [exec]
; OfferPeekWorker__joinOperator(t2)
; [eval] diz != null
(declare-const $t@1598 $Snap)
(declare-const $t@1599 $Snap)
(assert (= $t@1598 ($Snap.combine $t@1599 $Snap.unit)))
(declare-const $t@1600 $Snap)
(declare-const $t@1601 $Ref)
(assert (= $t@1599 ($Snap.combine $t@1600 ($SortWrappers.$RefTo$Snap $t@1601))))
(declare-const $t@1602 $Snap)
(assert (= $t@1600 ($Snap.combine $t@1602 $Snap.unit)))
(declare-const $t@1603 $Snap)
(declare-const $t@1604 $Ref)
(assert (= $t@1602 ($Snap.combine $t@1603 ($SortWrappers.$RefTo$Snap $t@1604))))
(declare-const $t@1605 $Snap)
(assert (= $t@1603 ($Snap.combine $t@1605 $Snap.unit)))
(declare-const $t@1606 $Snap)
(declare-const $t@1607 $Ref)
(assert (= $t@1605 ($Snap.combine $t@1606 ($SortWrappers.$RefTo$Snap $t@1607))))
(declare-const $t@1608 $Snap)
(assert (= $t@1606 ($Snap.combine $t@1608 $Snap.unit)))
(declare-const $t@1609 $Snap)
(declare-const $t@1610 $Ref)
(assert (= $t@1608 ($Snap.combine $t@1609 ($SortWrappers.$RefTo$Snap $t@1610))))
(declare-const $t@1611 $Snap)
(assert (= $t@1609 ($Snap.combine $t@1611 $Snap.unit)))
(declare-const $t@1612 $Snap)
(declare-const $t@1613 $Ref)
(assert (= $t@1611 ($Snap.combine $t@1612 ($SortWrappers.$RefTo$Snap $t@1613))))
(declare-const $t@1614 $Snap)
(assert (= $t@1612 ($Snap.combine $t@1614 $Snap.unit)))
(declare-const $t@1615 $Ref)
(declare-const $t@1616 Int)
(assert (=
  $t@1614
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1615)
    ($SortWrappers.IntTo$Snap $t@1616))))
(declare-const $k@1617 $Perm)
(assert ($Perm.isValidVar $k@1617))
(assert ($Perm.isReadVar $k@1617 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1549 $k@1564)) (= $t@1615 $t@1548)))
(push) ; 4
(assert (not (not (= (+ (- $k@1549 $k@1564) $k@1617) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1549 $k@1564) $k@1617) $Perm.No)))
(assert (not (= $t@1615 $Ref.null)))
(declare-const $k@1618 $Perm)
(assert ($Perm.isValidVar $k@1618))
(assert ($Perm.isReadVar $k@1618 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1550 $k@1565)) (= $t@1616 $t@1547)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1550 $k@1565) $k@1618) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1550 $k@1565) $k@1618) $Perm.No)))
(assert (> $t@1616 0))
(declare-const $k@1619 $Perm)
(assert ($Perm.isValidVar $k@1619))
(assert ($Perm.isReadVar $k@1619 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1551 $k@1566)) (= $t@1613 $t@1544)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1551 $k@1566) $k@1619) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1551 $k@1566) $k@1619) $Perm.No)))
(assert (not (= $t@1613 $Ref.null)))
(declare-const $k@1620 $Perm)
(assert ($Perm.isValidVar $k@1620))
(assert ($Perm.isReadVar $k@1620 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1552 $k@1567)) (= $t@1610 $t@1541)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1552 $k@1567) $k@1620) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1552 $k@1567) $k@1620) $Perm.No)))
(assert (not (= $t@1610 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1621 $Perm)
(assert ($Perm.isValidVar $k@1621))
(assert ($Perm.isReadVar $k@1621 $Perm.Write))
(push) ; 4
(assert (not (= $t@1476 $t@1610)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1541 $t@1610)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1553 $k@1568)) (= $t@1607 $t@1538)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1476 $t@1610)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1507 $t@1610)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1541 $t@1610)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1553 $k@1568) $k@1621) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1553 $k@1568) $k@1621) $Perm.No)))
(assert (= $t@1607 $t@1615))
(declare-const $k@1622 $Perm)
(assert ($Perm.isValidVar $k@1622))
(assert ($Perm.isReadVar $k@1622 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1554 $k@1569)) (= $t@1604 $t@1535)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1554 $k@1569) $k@1622) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1554 $k@1569) $k@1622) $Perm.No)))
(assert (not (= $t@1604 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1623 $Perm)
(assert ($Perm.isValidVar $k@1623))
(assert ($Perm.isReadVar $k@1623 $Perm.Write))
(push) ; 4
(assert (not (= $t@1470 $t@1604)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1535 $t@1604)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1555 $k@1570)) (= $t@1601 $t@1532)))
; [eval] diz.OfferPeekWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.OfferPeekWorker__queue
(push) ; 4
(assert (not (= sys__result@1462 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1514 $t@1615)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1548 $t@1615)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1470 $t@1604)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1501 $t@1604)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1535 $t@1604)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1555 $k@1570) $k@1623) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1555 $k@1570) $k@1623) $Perm.No)))
(assert (= $t@1601 $t@1615))
(pop) ; 3
(pop) ; 2
; ---------- Test__test2 ----------
(declare-const diz@1624 $Ref)
(declare-const queue@1625 $Ref)
(declare-const __flatten_48@1626 $Ref)
(declare-const t1@1627 $Ref)
(declare-const __flatten_49@1628 $Ref)
(declare-const t2@1629 $Ref)
(declare-const __flatten_50@1630 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1624 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_48 := BlockingQueue__BlockingQueue(2)
; [eval] capacity > 0
(declare-const sys__result@1631 $Ref)
(declare-const $t@1632 $Snap)
(declare-const $t@1633 $Snap)
(assert (= $t@1632 ($Snap.combine $t@1633 $Snap.unit)))
(declare-const $t@1634 $Snap)
(assert (= $t@1633 ($Snap.combine $t@1634 $Snap.unit)))
(declare-const $t@1635 $Snap)
(declare-const $t@1636 $Ref)
(assert (= $t@1634 ($Snap.combine $t@1635 ($SortWrappers.$RefTo$Snap $t@1636))))
(declare-const $t@1637 $Snap)
(assert (= $t@1635 ($Snap.combine $t@1637 $Snap.unit)))
(declare-const $t@1638 $Snap)
(declare-const $t@1639 $Ref)
(assert (= $t@1637 ($Snap.combine $t@1638 ($SortWrappers.$RefTo$Snap $t@1639))))
(declare-const $t@1640 $Snap)
(assert (= $t@1638 ($Snap.combine $t@1640 $Snap.unit)))
(declare-const $t@1641 $Snap)
(declare-const $t@1642 $Ref)
(assert (= $t@1640 ($Snap.combine $t@1641 ($SortWrappers.$RefTo$Snap $t@1642))))
(declare-const $t@1643 $Snap)
(assert (= $t@1641 ($Snap.combine $t@1643 $Snap.unit)))
(declare-const $t@1644 $Snap)
(declare-const $t@1645 $Ref)
(assert (= $t@1643 ($Snap.combine $t@1644 ($SortWrappers.$RefTo$Snap $t@1645))))
(declare-const $t@1646 $Snap)
(assert (= $t@1644 ($Snap.combine $t@1646 $Snap.unit)))
(declare-const $t@1647 Int)
(declare-const $t@1648 $Ref)
(assert (=
  $t@1646
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1647)
    ($SortWrappers.$RefTo$Snap $t@1648))))
(declare-const $t@1649 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1647)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1649) $Snap.unit)))
(declare-const $t@1650 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1649)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1650))))
; [eval] sys__result != null
(assert (not (= sys__result@1631 $Ref.null)))
(declare-const $k@1651 $Perm)
(assert ($Perm.isValidVar $k@1651))
(assert ($Perm.isReadVar $k@1651 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1651 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1651 $Perm.No)))
(assert (> $t@1650 0))
(declare-const $k@1652 $Perm)
(assert ($Perm.isValidVar $k@1652))
(assert ($Perm.isReadVar $k@1652 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1652 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1652 $Perm.No)))
(assert (not (= $t@1648 $Ref.null)))
(declare-const $k@1653 $Perm)
(assert ($Perm.isValidVar $k@1653))
(assert ($Perm.isReadVar $k@1653 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1653 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1653 $Perm.No)))
(assert (not (= $t@1645 $Ref.null)))
(declare-const $k@1654 $Perm)
(assert ($Perm.isValidVar $k@1654))
(assert ($Perm.isReadVar $k@1654 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1654 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1654 $Perm.No)))
(assert (= $t@1642 sys__result@1631))
(declare-const $k@1655 $Perm)
(assert ($Perm.isValidVar $k@1655))
(assert ($Perm.isReadVar $k@1655 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1655 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1655 $Perm.No)))
(assert (not (= $t@1639 $Ref.null)))
(declare-const $k@1656 $Perm)
(assert ($Perm.isValidVar $k@1656))
(assert ($Perm.isReadVar $k@1656 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1656 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1656 $Perm.No)))
(assert (= $t@1636 sys__result@1631))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1650 2))
; [exec]
; queue := __flatten_48
; [exec]
; __flatten_49 := PutWorker__PutWorker(queue)
(declare-const $k@1657 $Perm)
(assert ($Perm.isValidVar $k@1657))
(assert ($Perm.isReadVar $k@1657 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1657 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1657 $k@1651))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1658 $Perm)
(assert ($Perm.isValidVar $k@1658))
(assert ($Perm.isReadVar $k@1658 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1658 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1658 $k@1652))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1659 $Perm)
(assert ($Perm.isValidVar $k@1659))
(assert ($Perm.isReadVar $k@1659 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1659 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1659 $k@1653))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1660 $Perm)
(assert ($Perm.isValidVar $k@1660))
(assert ($Perm.isReadVar $k@1660 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1660 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1660 $k@1654))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1661 $Perm)
(assert ($Perm.isValidVar $k@1661))
(assert ($Perm.isReadVar $k@1661 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1661 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1661 $k@1655))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1662 $Perm)
(assert ($Perm.isValidVar $k@1662))
(assert ($Perm.isReadVar $k@1662 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1662 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1662 $k@1656))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1663 $Ref)
(declare-const $t@1664 $Snap)
(declare-const $t@1665 $Snap)
(assert (= $t@1664 ($Snap.combine $t@1665 $Snap.unit)))
(declare-const $t@1666 $Snap)
(declare-const $t@1667 $Ref)
(assert (= $t@1665 ($Snap.combine $t@1666 ($SortWrappers.$RefTo$Snap $t@1667))))
(declare-const $t@1668 $Snap)
(assert (= $t@1666 ($Snap.combine $t@1668 $Snap.unit)))
(declare-const $t@1669 $Snap)
(declare-const $t@1670 $Ref)
(assert (= $t@1668 ($Snap.combine $t@1669 ($SortWrappers.$RefTo$Snap $t@1670))))
(declare-const $t@1671 $Snap)
(assert (= $t@1669 ($Snap.combine $t@1671 $Snap.unit)))
(declare-const $t@1672 $Snap)
(declare-const $t@1673 $Ref)
(assert (= $t@1671 ($Snap.combine $t@1672 ($SortWrappers.$RefTo$Snap $t@1673))))
(declare-const $t@1674 $Snap)
(assert (= $t@1672 ($Snap.combine $t@1674 $Snap.unit)))
(declare-const $t@1675 $Snap)
(declare-const $t@1676 $Ref)
(assert (= $t@1674 ($Snap.combine $t@1675 ($SortWrappers.$RefTo$Snap $t@1676))))
(declare-const $t@1677 $Snap)
(assert (= $t@1675 ($Snap.combine $t@1677 $Snap.unit)))
(declare-const $t@1678 $Snap)
(declare-const $t@1679 $Ref)
(assert (= $t@1677 ($Snap.combine $t@1678 ($SortWrappers.$RefTo$Snap $t@1679))))
(declare-const $t@1680 $Snap)
(assert (= $t@1678 ($Snap.combine $t@1680 $Snap.unit)))
(declare-const $t@1681 $Ref)
(declare-const $t@1682 Int)
(assert (=
  $t@1680
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1681)
    ($SortWrappers.IntTo$Snap $t@1682))))
(declare-const $t@1683 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1681)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1683))))
; [eval] sys__result != null
(assert (not (= sys__result@1663 $Ref.null)))
(declare-const $k@1684 $Perm)
(assert ($Perm.isValidVar $k@1684))
(assert ($Perm.isReadVar $k@1684 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1684 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1684 $Perm.No)))
(assert (not (= $t@1683 $Ref.null)))
(declare-const $k@1685 $Perm)
(assert ($Perm.isValidVar $k@1685))
(assert ($Perm.isReadVar $k@1685 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1683)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1685 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1685 $Perm.No)))
(assert (> $t@1682 0))
(declare-const $k@1686 $Perm)
(assert ($Perm.isValidVar $k@1686))
(assert ($Perm.isReadVar $k@1686 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1683)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1686 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1686 $Perm.No)))
(assert (not (= $t@1679 $Ref.null)))
(declare-const $k@1687 $Perm)
(assert ($Perm.isValidVar $k@1687))
(assert ($Perm.isReadVar $k@1687 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1683)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1687 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1687 $Perm.No)))
(assert (not (= $t@1676 $Ref.null)))
(declare-const $k@1688 $Perm)
(assert ($Perm.isValidVar $k@1688))
(assert ($Perm.isReadVar $k@1688 $Perm.Write))
(push) ; 4
(assert (not (= $t@1645 $t@1676)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@1688 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1688 $Perm.No)))
(assert (= $t@1673 $t@1683))
(declare-const $k@1689 $Perm)
(assert ($Perm.isValidVar $k@1689))
(assert ($Perm.isReadVar $k@1689 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1683)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1689 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1689 $Perm.No)))
(assert (not (= $t@1670 $Ref.null)))
(declare-const $k@1690 $Perm)
(assert ($Perm.isValidVar $k@1690))
(assert ($Perm.isReadVar $k@1690 $Perm.Write))
(push) ; 4
(assert (not (= $t@1639 $t@1670)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@1690 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1690 $Perm.No)))
(assert (= $t@1667 $t@1683))
; [exec]
; t1 := __flatten_49
; [exec]
; __flatten_50 := PutPollWorker__PutPollWorker(queue)
(declare-const $k@1691 $Perm)
(assert ($Perm.isValidVar $k@1691))
(assert ($Perm.isReadVar $k@1691 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1691 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1651 $k@1657) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1651 $k@1657) $Perm.No)))
(assert (< $k@1691 (- $k@1651 $k@1657)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1692 $Perm)
(assert ($Perm.isValidVar $k@1692))
(assert ($Perm.isReadVar $k@1692 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1692 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1652 $k@1658) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1652 $k@1658) $Perm.No)))
(assert (< $k@1692 (- $k@1652 $k@1658)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1693 $Perm)
(assert ($Perm.isValidVar $k@1693))
(assert ($Perm.isReadVar $k@1693 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1693 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1653 $k@1659) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1653 $k@1659) $Perm.No)))
(assert (< $k@1693 (- $k@1653 $k@1659)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1694 $Perm)
(assert ($Perm.isValidVar $k@1694))
(assert ($Perm.isReadVar $k@1694 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1694 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1654 $k@1660) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1654 $k@1660) $Perm.No)))
(assert (< $k@1694 (- $k@1654 $k@1660)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1695 $Perm)
(assert ($Perm.isValidVar $k@1695))
(assert ($Perm.isReadVar $k@1695 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1695 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1655 $k@1661) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1655 $k@1661) $Perm.No)))
(assert (< $k@1695 (- $k@1655 $k@1661)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1696 $Perm)
(assert ($Perm.isValidVar $k@1696))
(assert ($Perm.isReadVar $k@1696 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1696 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1656 $k@1662) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1656 $k@1662) $Perm.No)))
(assert (< $k@1696 (- $k@1656 $k@1662)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1697 $Ref)
(declare-const $t@1698 $Snap)
(declare-const $t@1699 $Snap)
(assert (= $t@1698 ($Snap.combine $t@1699 $Snap.unit)))
(declare-const $t@1700 $Snap)
(declare-const $t@1701 $Ref)
(assert (= $t@1699 ($Snap.combine $t@1700 ($SortWrappers.$RefTo$Snap $t@1701))))
(declare-const $t@1702 $Snap)
(assert (= $t@1700 ($Snap.combine $t@1702 $Snap.unit)))
(declare-const $t@1703 $Snap)
(declare-const $t@1704 $Ref)
(assert (= $t@1702 ($Snap.combine $t@1703 ($SortWrappers.$RefTo$Snap $t@1704))))
(declare-const $t@1705 $Snap)
(assert (= $t@1703 ($Snap.combine $t@1705 $Snap.unit)))
(declare-const $t@1706 $Snap)
(declare-const $t@1707 $Ref)
(assert (= $t@1705 ($Snap.combine $t@1706 ($SortWrappers.$RefTo$Snap $t@1707))))
(declare-const $t@1708 $Snap)
(assert (= $t@1706 ($Snap.combine $t@1708 $Snap.unit)))
(declare-const $t@1709 $Snap)
(declare-const $t@1710 $Ref)
(assert (= $t@1708 ($Snap.combine $t@1709 ($SortWrappers.$RefTo$Snap $t@1710))))
(declare-const $t@1711 $Snap)
(assert (= $t@1709 ($Snap.combine $t@1711 $Snap.unit)))
(declare-const $t@1712 $Snap)
(declare-const $t@1713 $Ref)
(assert (= $t@1711 ($Snap.combine $t@1712 ($SortWrappers.$RefTo$Snap $t@1713))))
(declare-const $t@1714 $Snap)
(assert (= $t@1712 ($Snap.combine $t@1714 $Snap.unit)))
(declare-const $t@1715 $Ref)
(declare-const $t@1716 Int)
(assert (=
  $t@1714
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1715)
    ($SortWrappers.IntTo$Snap $t@1716))))
(declare-const $t@1717 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1715)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1717))))
; [eval] sys__result != null
(assert (not (= sys__result@1697 $Ref.null)))
(declare-const $k@1718 $Perm)
(assert ($Perm.isValidVar $k@1718))
(assert ($Perm.isReadVar $k@1718 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1718 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1718 $Perm.No)))
(assert (not (= $t@1717 $Ref.null)))
(declare-const $k@1719 $Perm)
(assert ($Perm.isValidVar $k@1719))
(assert ($Perm.isReadVar $k@1719 $Perm.Write))
(push) ; 4
(assert (not (= $t@1683 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1631 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1719 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1719 $Perm.No)))
(assert (> $t@1716 0))
(declare-const $k@1720 $Perm)
(assert ($Perm.isValidVar $k@1720))
(assert ($Perm.isReadVar $k@1720 $Perm.Write))
(push) ; 4
(assert (not (= $t@1683 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1631 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1720 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1720 $Perm.No)))
(assert (not (= $t@1713 $Ref.null)))
(declare-const $k@1721 $Perm)
(assert ($Perm.isValidVar $k@1721))
(assert ($Perm.isReadVar $k@1721 $Perm.Write))
(push) ; 4
(assert (not (= $t@1683 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1631 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1721 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1721 $Perm.No)))
(assert (not (= $t@1710 $Ref.null)))
(declare-const $k@1722 $Perm)
(assert ($Perm.isValidVar $k@1722))
(assert ($Perm.isReadVar $k@1722 $Perm.Write))
(push) ; 4
(assert (not (= $t@1676 $t@1710)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1645 $t@1710)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@1722 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1722 $Perm.No)))
(assert (= $t@1707 $t@1717))
(declare-const $k@1723 $Perm)
(assert ($Perm.isValidVar $k@1723))
(assert ($Perm.isReadVar $k@1723 $Perm.Write))
(push) ; 4
(assert (not (= $t@1683 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1631 $t@1717)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1723 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1723 $Perm.No)))
(assert (not (= $t@1704 $Ref.null)))
(declare-const $k@1724 $Perm)
(assert ($Perm.isValidVar $k@1724))
(assert ($Perm.isReadVar $k@1724 $Perm.Write))
(push) ; 4
(assert (not (= $t@1670 $t@1704)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1639 $t@1704)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutPollWorker__queue
(push) ; 4
(assert (not (not (= $k@1724 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1724 $Perm.No)))
(assert (= $t@1701 $t@1717))
; [exec]
; t2 := __flatten_50
; [exec]
; PutWorker__forkOperator(t1)
; [eval] diz != null
(declare-const $k@1725 $Perm)
(assert ($Perm.isValidVar $k@1725))
(assert ($Perm.isReadVar $k@1725 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1725 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1725 $k@1684))
(declare-const $k@1726 $Perm)
(assert ($Perm.isValidVar $k@1726))
(assert ($Perm.isReadVar $k@1726 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1726 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1726 $k@1685))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@1727 $Perm)
(assert ($Perm.isValidVar $k@1727))
(assert ($Perm.isReadVar $k@1727 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1727 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1727 $k@1686))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@1728 $Perm)
(assert ($Perm.isValidVar $k@1728))
(assert ($Perm.isReadVar $k@1728 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1728 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1728 $k@1687))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@1729 $Perm)
(assert ($Perm.isValidVar $k@1729))
(assert ($Perm.isReadVar $k@1729 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1729 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1729 $k@1688))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(declare-const $k@1730 $Perm)
(assert ($Perm.isValidVar $k@1730))
(assert ($Perm.isReadVar $k@1730 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1730 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1730 $k@1689))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@1731 $Perm)
(assert ($Perm.isValidVar $k@1731))
(assert ($Perm.isReadVar $k@1731 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1731 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1731 $k@1690))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(declare-const $t@1732 $Snap)
; [exec]
; PutPollWorker__forkOperator(t2)
; [eval] diz != null
(declare-const $k@1733 $Perm)
(assert ($Perm.isValidVar $k@1733))
(assert ($Perm.isReadVar $k@1733 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1733 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1733 $k@1718))
(declare-const $k@1734 $Perm)
(assert ($Perm.isValidVar $k@1734))
(assert ($Perm.isReadVar $k@1734 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1734 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1734 $k@1719))
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@1735 $Perm)
(assert ($Perm.isValidVar $k@1735))
(assert ($Perm.isReadVar $k@1735 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1735 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1735 $k@1720))
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(declare-const $k@1736 $Perm)
(assert ($Perm.isValidVar $k@1736))
(assert ($Perm.isReadVar $k@1736 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1736 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1736 $k@1721))
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(declare-const $k@1737 $Perm)
(assert ($Perm.isValidVar $k@1737))
(assert ($Perm.isReadVar $k@1737 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1737 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1737 $k@1722))
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(declare-const $k@1738 $Perm)
(assert ($Perm.isValidVar $k@1738))
(assert ($Perm.isReadVar $k@1738 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1738 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1738 $k@1723))
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@1739 $Perm)
(assert ($Perm.isValidVar $k@1739))
(assert ($Perm.isReadVar $k@1739 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1739 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1739 $k@1724))
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(declare-const $t@1740 $Snap)
; [exec]
; PutWorker__joinOperator(t1)
; [eval] diz != null
(declare-const $t@1741 $Snap)
(declare-const $t@1742 $Snap)
(assert (= $t@1741 ($Snap.combine $t@1742 $Snap.unit)))
(declare-const $t@1743 $Snap)
(declare-const $t@1744 $Ref)
(assert (= $t@1742 ($Snap.combine $t@1743 ($SortWrappers.$RefTo$Snap $t@1744))))
(declare-const $t@1745 $Snap)
(assert (= $t@1743 ($Snap.combine $t@1745 $Snap.unit)))
(declare-const $t@1746 $Snap)
(declare-const $t@1747 $Ref)
(assert (= $t@1745 ($Snap.combine $t@1746 ($SortWrappers.$RefTo$Snap $t@1747))))
(declare-const $t@1748 $Snap)
(assert (= $t@1746 ($Snap.combine $t@1748 $Snap.unit)))
(declare-const $t@1749 $Snap)
(declare-const $t@1750 $Ref)
(assert (= $t@1748 ($Snap.combine $t@1749 ($SortWrappers.$RefTo$Snap $t@1750))))
(declare-const $t@1751 $Snap)
(assert (= $t@1749 ($Snap.combine $t@1751 $Snap.unit)))
(declare-const $t@1752 $Snap)
(declare-const $t@1753 $Ref)
(assert (= $t@1751 ($Snap.combine $t@1752 ($SortWrappers.$RefTo$Snap $t@1753))))
(declare-const $t@1754 $Snap)
(assert (= $t@1752 ($Snap.combine $t@1754 $Snap.unit)))
(declare-const $t@1755 $Snap)
(declare-const $t@1756 $Ref)
(assert (= $t@1754 ($Snap.combine $t@1755 ($SortWrappers.$RefTo$Snap $t@1756))))
(declare-const $t@1757 $Snap)
(assert (= $t@1755 ($Snap.combine $t@1757 $Snap.unit)))
(declare-const $t@1758 $Ref)
(declare-const $t@1759 Int)
(assert (=
  $t@1757
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1758)
    ($SortWrappers.IntTo$Snap $t@1759))))
(declare-const $k@1760 $Perm)
(assert ($Perm.isValidVar $k@1760))
(assert ($Perm.isReadVar $k@1760 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1684 $k@1725)) (= $t@1758 $t@1683)))
(push) ; 4
(assert (not (not (= (+ (- $k@1684 $k@1725) $k@1760) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1684 $k@1725) $k@1760) $Perm.No)))
(assert (not (= $t@1758 $Ref.null)))
(declare-const $k@1761 $Perm)
(assert ($Perm.isValidVar $k@1761))
(assert ($Perm.isReadVar $k@1761 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1685 $k@1726)) (= $t@1759 $t@1682)))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1685 $k@1726) $k@1761) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1685 $k@1726) $k@1761) $Perm.No)))
(assert (> $t@1759 0))
(declare-const $k@1762 $Perm)
(assert ($Perm.isValidVar $k@1762))
(assert ($Perm.isReadVar $k@1762 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1686 $k@1727)) (= $t@1756 $t@1679)))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1686 $k@1727) $k@1762) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1686 $k@1727) $k@1762) $Perm.No)))
(assert (not (= $t@1756 $Ref.null)))
(declare-const $k@1763 $Perm)
(assert ($Perm.isValidVar $k@1763))
(assert ($Perm.isReadVar $k@1763 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1687 $k@1728)) (= $t@1753 $t@1676)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1687 $k@1728) $k@1763) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1687 $k@1728) $k@1763) $Perm.No)))
(assert (not (= $t@1753 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1764 $Perm)
(assert ($Perm.isValidVar $k@1764))
(assert ($Perm.isReadVar $k@1764 $Perm.Write))
(push) ; 4
(assert (not (= $t@1645 $t@1753)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1676 $t@1753)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1688 $k@1729)) (= $t@1750 $t@1673)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1645 $t@1753)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1710 $t@1753)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1676 $t@1753)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1688 $k@1729) $k@1764) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1688 $k@1729) $k@1764) $Perm.No)))
(assert (= $t@1750 $t@1758))
(declare-const $k@1765 $Perm)
(assert ($Perm.isValidVar $k@1765))
(assert ($Perm.isReadVar $k@1765 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1689 $k@1730)) (= $t@1747 $t@1670)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1689 $k@1730) $k@1765) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1689 $k@1730) $k@1765) $Perm.No)))
(assert (not (= $t@1747 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1766 $Perm)
(assert ($Perm.isValidVar $k@1766))
(assert ($Perm.isReadVar $k@1766 $Perm.Write))
(push) ; 4
(assert (not (= $t@1639 $t@1747)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1670 $t@1747)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1690 $k@1731)) (= $t@1744 $t@1667)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1631 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1758)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1758)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1639 $t@1747)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1704 $t@1747)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1670 $t@1747)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1690 $k@1731) $k@1766) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1690 $k@1731) $k@1766) $Perm.No)))
(assert (= $t@1744 $t@1758))
; [exec]
; PutPollWorker__joinOperator(t2)
; [eval] diz != null
(declare-const $t@1767 $Snap)
(declare-const $t@1768 $Snap)
(assert (= $t@1767 ($Snap.combine $t@1768 $Snap.unit)))
(declare-const $t@1769 $Snap)
(declare-const $t@1770 $Ref)
(assert (= $t@1768 ($Snap.combine $t@1769 ($SortWrappers.$RefTo$Snap $t@1770))))
(declare-const $t@1771 $Snap)
(assert (= $t@1769 ($Snap.combine $t@1771 $Snap.unit)))
(declare-const $t@1772 $Snap)
(declare-const $t@1773 $Ref)
(assert (= $t@1771 ($Snap.combine $t@1772 ($SortWrappers.$RefTo$Snap $t@1773))))
(declare-const $t@1774 $Snap)
(assert (= $t@1772 ($Snap.combine $t@1774 $Snap.unit)))
(declare-const $t@1775 $Snap)
(declare-const $t@1776 $Ref)
(assert (= $t@1774 ($Snap.combine $t@1775 ($SortWrappers.$RefTo$Snap $t@1776))))
(declare-const $t@1777 $Snap)
(assert (= $t@1775 ($Snap.combine $t@1777 $Snap.unit)))
(declare-const $t@1778 $Snap)
(declare-const $t@1779 $Ref)
(assert (= $t@1777 ($Snap.combine $t@1778 ($SortWrappers.$RefTo$Snap $t@1779))))
(declare-const $t@1780 $Snap)
(assert (= $t@1778 ($Snap.combine $t@1780 $Snap.unit)))
(declare-const $t@1781 $Snap)
(declare-const $t@1782 $Ref)
(assert (= $t@1780 ($Snap.combine $t@1781 ($SortWrappers.$RefTo$Snap $t@1782))))
(declare-const $t@1783 $Snap)
(assert (= $t@1781 ($Snap.combine $t@1783 $Snap.unit)))
(declare-const $t@1784 $Ref)
(declare-const $t@1785 Int)
(assert (=
  $t@1783
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1784)
    ($SortWrappers.IntTo$Snap $t@1785))))
(declare-const $k@1786 $Perm)
(assert ($Perm.isValidVar $k@1786))
(assert ($Perm.isReadVar $k@1786 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1718 $k@1733)) (= $t@1784 $t@1717)))
(push) ; 4
(assert (not (not (= (+ (- $k@1718 $k@1733) $k@1786) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1718 $k@1733) $k@1786) $Perm.No)))
(assert (not (= $t@1784 $Ref.null)))
(declare-const $k@1787 $Perm)
(assert ($Perm.isValidVar $k@1787))
(assert ($Perm.isReadVar $k@1787 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1719 $k@1734)) (= $t@1785 $t@1716)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1719 $k@1734) $k@1787) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1719 $k@1734) $k@1787) $Perm.No)))
(assert (> $t@1785 0))
(declare-const $k@1788 $Perm)
(assert ($Perm.isValidVar $k@1788))
(assert ($Perm.isReadVar $k@1788 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1720 $k@1735)) (= $t@1782 $t@1713)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1720 $k@1735) $k@1788) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1720 $k@1735) $k@1788) $Perm.No)))
(assert (not (= $t@1782 $Ref.null)))
(declare-const $k@1789 $Perm)
(assert ($Perm.isValidVar $k@1789))
(assert ($Perm.isReadVar $k@1789 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1721 $k@1736)) (= $t@1779 $t@1710)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1721 $k@1736) $k@1789) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1721 $k@1736) $k@1789) $Perm.No)))
(assert (not (= $t@1779 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1790 $Perm)
(assert ($Perm.isValidVar $k@1790))
(assert ($Perm.isReadVar $k@1790 $Perm.Write))
(push) ; 4
(assert (not (= $t@1645 $t@1779)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1710 $t@1779)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1722 $k@1737)) (= $t@1776 $t@1707)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1645 $t@1779)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1676 $t@1779)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1710 $t@1779)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1722 $k@1737) $k@1790) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1722 $k@1737) $k@1790) $Perm.No)))
(assert (= $t@1776 $t@1784))
(declare-const $k@1791 $Perm)
(assert ($Perm.isValidVar $k@1791))
(assert ($Perm.isReadVar $k@1791 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1723 $k@1738)) (= $t@1773 $t@1704)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1723 $k@1738) $k@1791) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1723 $k@1738) $k@1791) $Perm.No)))
(assert (not (= $t@1773 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1792 $Perm)
(assert ($Perm.isValidVar $k@1792))
(assert ($Perm.isReadVar $k@1792 $Perm.Write))
(push) ; 4
(assert (not (= $t@1639 $t@1773)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1704 $t@1773)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1724 $k@1739)) (= $t@1770 $t@1701)))
; [eval] diz.PutPollWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutPollWorker__queue
(push) ; 4
(assert (not (= sys__result@1631 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1683 $t@1784)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1717 $t@1784)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1639 $t@1773)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1670 $t@1773)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1704 $t@1773)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1724 $k@1739) $k@1792) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1724 $k@1739) $k@1792) $Perm.No)))
(assert (= $t@1770 $t@1784))
(pop) ; 3
(pop) ; 2
; ---------- Test__test3 ----------
(declare-const diz@1793 $Ref)
(declare-const queue@1794 $Ref)
(declare-const __flatten_55@1795 $Ref)
(declare-const t1@1796 $Ref)
(declare-const __flatten_56@1797 $Ref)
(declare-const t2@1798 $Ref)
(declare-const __flatten_57@1799 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1793 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_55 := BlockingQueue__BlockingQueue(2)
; [eval] capacity > 0
(declare-const sys__result@1800 $Ref)
(declare-const $t@1801 $Snap)
(declare-const $t@1802 $Snap)
(assert (= $t@1801 ($Snap.combine $t@1802 $Snap.unit)))
(declare-const $t@1803 $Snap)
(assert (= $t@1802 ($Snap.combine $t@1803 $Snap.unit)))
(declare-const $t@1804 $Snap)
(declare-const $t@1805 $Ref)
(assert (= $t@1803 ($Snap.combine $t@1804 ($SortWrappers.$RefTo$Snap $t@1805))))
(declare-const $t@1806 $Snap)
(assert (= $t@1804 ($Snap.combine $t@1806 $Snap.unit)))
(declare-const $t@1807 $Snap)
(declare-const $t@1808 $Ref)
(assert (= $t@1806 ($Snap.combine $t@1807 ($SortWrappers.$RefTo$Snap $t@1808))))
(declare-const $t@1809 $Snap)
(assert (= $t@1807 ($Snap.combine $t@1809 $Snap.unit)))
(declare-const $t@1810 $Snap)
(declare-const $t@1811 $Ref)
(assert (= $t@1809 ($Snap.combine $t@1810 ($SortWrappers.$RefTo$Snap $t@1811))))
(declare-const $t@1812 $Snap)
(assert (= $t@1810 ($Snap.combine $t@1812 $Snap.unit)))
(declare-const $t@1813 $Snap)
(declare-const $t@1814 $Ref)
(assert (= $t@1812 ($Snap.combine $t@1813 ($SortWrappers.$RefTo$Snap $t@1814))))
(declare-const $t@1815 $Snap)
(assert (= $t@1813 ($Snap.combine $t@1815 $Snap.unit)))
(declare-const $t@1816 Int)
(declare-const $t@1817 $Ref)
(assert (=
  $t@1815
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1816)
    ($SortWrappers.$RefTo$Snap $t@1817))))
(declare-const $t@1818 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1816)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1818) $Snap.unit)))
(declare-const $t@1819 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1818)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1819))))
; [eval] sys__result != null
(assert (not (= sys__result@1800 $Ref.null)))
(declare-const $k@1820 $Perm)
(assert ($Perm.isValidVar $k@1820))
(assert ($Perm.isReadVar $k@1820 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1820 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1820 $Perm.No)))
(assert (> $t@1819 0))
(declare-const $k@1821 $Perm)
(assert ($Perm.isValidVar $k@1821))
(assert ($Perm.isReadVar $k@1821 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1821 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1821 $Perm.No)))
(assert (not (= $t@1817 $Ref.null)))
(declare-const $k@1822 $Perm)
(assert ($Perm.isValidVar $k@1822))
(assert ($Perm.isReadVar $k@1822 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1822 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1822 $Perm.No)))
(assert (not (= $t@1814 $Ref.null)))
(declare-const $k@1823 $Perm)
(assert ($Perm.isValidVar $k@1823))
(assert ($Perm.isReadVar $k@1823 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1823 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1823 $Perm.No)))
(assert (= $t@1811 sys__result@1800))
(declare-const $k@1824 $Perm)
(assert ($Perm.isValidVar $k@1824))
(assert ($Perm.isReadVar $k@1824 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1824 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1824 $Perm.No)))
(assert (not (= $t@1808 $Ref.null)))
(declare-const $k@1825 $Perm)
(assert ($Perm.isValidVar $k@1825))
(assert ($Perm.isReadVar $k@1825 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1825 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1825 $Perm.No)))
(assert (= $t@1805 sys__result@1800))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1819 2))
; [exec]
; queue := __flatten_55
; [exec]
; __flatten_56 := PutWorker__PutWorker(queue)
(declare-const $k@1826 $Perm)
(assert ($Perm.isValidVar $k@1826))
(assert ($Perm.isReadVar $k@1826 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1826 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1826 $k@1820))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1827 $Perm)
(assert ($Perm.isValidVar $k@1827))
(assert ($Perm.isReadVar $k@1827 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1827 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1827 $k@1821))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1828 $Perm)
(assert ($Perm.isValidVar $k@1828))
(assert ($Perm.isReadVar $k@1828 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1828 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1828 $k@1822))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1829 $Perm)
(assert ($Perm.isValidVar $k@1829))
(assert ($Perm.isReadVar $k@1829 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1829 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1829 $k@1823))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1830 $Perm)
(assert ($Perm.isValidVar $k@1830))
(assert ($Perm.isReadVar $k@1830 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1830 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1830 $k@1824))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1831 $Perm)
(assert ($Perm.isValidVar $k@1831))
(assert ($Perm.isReadVar $k@1831 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1831 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1831 $k@1825))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1832 $Ref)
(declare-const $t@1833 $Snap)
(declare-const $t@1834 $Snap)
(assert (= $t@1833 ($Snap.combine $t@1834 $Snap.unit)))
(declare-const $t@1835 $Snap)
(declare-const $t@1836 $Ref)
(assert (= $t@1834 ($Snap.combine $t@1835 ($SortWrappers.$RefTo$Snap $t@1836))))
(declare-const $t@1837 $Snap)
(assert (= $t@1835 ($Snap.combine $t@1837 $Snap.unit)))
(declare-const $t@1838 $Snap)
(declare-const $t@1839 $Ref)
(assert (= $t@1837 ($Snap.combine $t@1838 ($SortWrappers.$RefTo$Snap $t@1839))))
(declare-const $t@1840 $Snap)
(assert (= $t@1838 ($Snap.combine $t@1840 $Snap.unit)))
(declare-const $t@1841 $Snap)
(declare-const $t@1842 $Ref)
(assert (= $t@1840 ($Snap.combine $t@1841 ($SortWrappers.$RefTo$Snap $t@1842))))
(declare-const $t@1843 $Snap)
(assert (= $t@1841 ($Snap.combine $t@1843 $Snap.unit)))
(declare-const $t@1844 $Snap)
(declare-const $t@1845 $Ref)
(assert (= $t@1843 ($Snap.combine $t@1844 ($SortWrappers.$RefTo$Snap $t@1845))))
(declare-const $t@1846 $Snap)
(assert (= $t@1844 ($Snap.combine $t@1846 $Snap.unit)))
(declare-const $t@1847 $Snap)
(declare-const $t@1848 $Ref)
(assert (= $t@1846 ($Snap.combine $t@1847 ($SortWrappers.$RefTo$Snap $t@1848))))
(declare-const $t@1849 $Snap)
(assert (= $t@1847 ($Snap.combine $t@1849 $Snap.unit)))
(declare-const $t@1850 $Ref)
(declare-const $t@1851 Int)
(assert (=
  $t@1849
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1850)
    ($SortWrappers.IntTo$Snap $t@1851))))
(declare-const $t@1852 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1850)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1852))))
; [eval] sys__result != null
(assert (not (= sys__result@1832 $Ref.null)))
(declare-const $k@1853 $Perm)
(assert ($Perm.isValidVar $k@1853))
(assert ($Perm.isReadVar $k@1853 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1853 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1853 $Perm.No)))
(assert (not (= $t@1852 $Ref.null)))
(declare-const $k@1854 $Perm)
(assert ($Perm.isValidVar $k@1854))
(assert ($Perm.isReadVar $k@1854 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1852)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1854 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1854 $Perm.No)))
(assert (> $t@1851 0))
(declare-const $k@1855 $Perm)
(assert ($Perm.isValidVar $k@1855))
(assert ($Perm.isReadVar $k@1855 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1852)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1855 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1855 $Perm.No)))
(assert (not (= $t@1848 $Ref.null)))
(declare-const $k@1856 $Perm)
(assert ($Perm.isValidVar $k@1856))
(assert ($Perm.isReadVar $k@1856 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1852)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1856 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1856 $Perm.No)))
(assert (not (= $t@1845 $Ref.null)))
(declare-const $k@1857 $Perm)
(assert ($Perm.isValidVar $k@1857))
(assert ($Perm.isReadVar $k@1857 $Perm.Write))
(push) ; 4
(assert (not (= $t@1814 $t@1845)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@1857 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1857 $Perm.No)))
(assert (= $t@1842 $t@1852))
(declare-const $k@1858 $Perm)
(assert ($Perm.isValidVar $k@1858))
(assert ($Perm.isReadVar $k@1858 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1852)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1858 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1858 $Perm.No)))
(assert (not (= $t@1839 $Ref.null)))
(declare-const $k@1859 $Perm)
(assert ($Perm.isValidVar $k@1859))
(assert ($Perm.isReadVar $k@1859 $Perm.Write))
(push) ; 4
(assert (not (= $t@1808 $t@1839)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@1859 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1859 $Perm.No)))
(assert (= $t@1836 $t@1852))
; [exec]
; t1 := __flatten_56
; [exec]
; __flatten_57 := TakeWorker__TakeWorker(queue)
(declare-const $k@1860 $Perm)
(assert ($Perm.isValidVar $k@1860))
(assert ($Perm.isReadVar $k@1860 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1860 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1820 $k@1826) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1820 $k@1826) $Perm.No)))
(assert (< $k@1860 (- $k@1820 $k@1826)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@1861 $Perm)
(assert ($Perm.isValidVar $k@1861))
(assert ($Perm.isReadVar $k@1861 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1861 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1821 $k@1827) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1821 $k@1827) $Perm.No)))
(assert (< $k@1861 (- $k@1821 $k@1827)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@1862 $Perm)
(assert ($Perm.isValidVar $k@1862))
(assert ($Perm.isReadVar $k@1862 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1862 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1822 $k@1828) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1822 $k@1828) $Perm.No)))
(assert (< $k@1862 (- $k@1822 $k@1828)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@1863 $Perm)
(assert ($Perm.isValidVar $k@1863))
(assert ($Perm.isReadVar $k@1863 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1863 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1823 $k@1829) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1823 $k@1829) $Perm.No)))
(assert (< $k@1863 (- $k@1823 $k@1829)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@1864 $Perm)
(assert ($Perm.isValidVar $k@1864))
(assert ($Perm.isReadVar $k@1864 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1864 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1824 $k@1830) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1824 $k@1830) $Perm.No)))
(assert (< $k@1864 (- $k@1824 $k@1830)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@1865 $Perm)
(assert ($Perm.isValidVar $k@1865))
(assert ($Perm.isReadVar $k@1865 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1865 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1825 $k@1831) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1825 $k@1831) $Perm.No)))
(assert (< $k@1865 (- $k@1825 $k@1831)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@1866 $Ref)
(declare-const $t@1867 $Snap)
(declare-const $t@1868 $Snap)
(assert (= $t@1867 ($Snap.combine $t@1868 $Snap.unit)))
(declare-const $t@1869 $Snap)
(declare-const $t@1870 $Ref)
(assert (= $t@1868 ($Snap.combine $t@1869 ($SortWrappers.$RefTo$Snap $t@1870))))
(declare-const $t@1871 $Snap)
(assert (= $t@1869 ($Snap.combine $t@1871 $Snap.unit)))
(declare-const $t@1872 $Snap)
(declare-const $t@1873 $Ref)
(assert (= $t@1871 ($Snap.combine $t@1872 ($SortWrappers.$RefTo$Snap $t@1873))))
(declare-const $t@1874 $Snap)
(assert (= $t@1872 ($Snap.combine $t@1874 $Snap.unit)))
(declare-const $t@1875 $Snap)
(declare-const $t@1876 $Ref)
(assert (= $t@1874 ($Snap.combine $t@1875 ($SortWrappers.$RefTo$Snap $t@1876))))
(declare-const $t@1877 $Snap)
(assert (= $t@1875 ($Snap.combine $t@1877 $Snap.unit)))
(declare-const $t@1878 $Snap)
(declare-const $t@1879 $Ref)
(assert (= $t@1877 ($Snap.combine $t@1878 ($SortWrappers.$RefTo$Snap $t@1879))))
(declare-const $t@1880 $Snap)
(assert (= $t@1878 ($Snap.combine $t@1880 $Snap.unit)))
(declare-const $t@1881 $Snap)
(declare-const $t@1882 $Ref)
(assert (= $t@1880 ($Snap.combine $t@1881 ($SortWrappers.$RefTo$Snap $t@1882))))
(declare-const $t@1883 $Snap)
(assert (= $t@1881 ($Snap.combine $t@1883 $Snap.unit)))
(declare-const $t@1884 $Ref)
(declare-const $t@1885 Int)
(assert (=
  $t@1883
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1884)
    ($SortWrappers.IntTo$Snap $t@1885))))
(declare-const $t@1886 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@1884)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@1886))))
; [eval] sys__result != null
(assert (not (= sys__result@1866 $Ref.null)))
(declare-const $k@1887 $Perm)
(assert ($Perm.isValidVar $k@1887))
(assert ($Perm.isReadVar $k@1887 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@1887 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1887 $Perm.No)))
(assert (not (= $t@1886 $Ref.null)))
(declare-const $k@1888 $Perm)
(assert ($Perm.isValidVar $k@1888))
(assert ($Perm.isReadVar $k@1888 $Perm.Write))
(push) ; 4
(assert (not (= $t@1852 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1800 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1888 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1888 $Perm.No)))
(assert (> $t@1885 0))
(declare-const $k@1889 $Perm)
(assert ($Perm.isValidVar $k@1889))
(assert ($Perm.isReadVar $k@1889 $Perm.Write))
(push) ; 4
(assert (not (= $t@1852 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1800 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1889 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1889 $Perm.No)))
(assert (not (= $t@1882 $Ref.null)))
(declare-const $k@1890 $Perm)
(assert ($Perm.isValidVar $k@1890))
(assert ($Perm.isReadVar $k@1890 $Perm.Write))
(push) ; 4
(assert (not (= $t@1852 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1800 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1890 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1890 $Perm.No)))
(assert (not (= $t@1879 $Ref.null)))
(declare-const $k@1891 $Perm)
(assert ($Perm.isValidVar $k@1891))
(assert ($Perm.isReadVar $k@1891 $Perm.Write))
(push) ; 4
(assert (not (= $t@1845 $t@1879)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1814 $t@1879)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@1891 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1891 $Perm.No)))
(assert (= $t@1876 $t@1886))
(declare-const $k@1892 $Perm)
(assert ($Perm.isValidVar $k@1892))
(assert ($Perm.isReadVar $k@1892 $Perm.Write))
(push) ; 4
(assert (not (= $t@1852 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1800 $t@1886)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1892 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1892 $Perm.No)))
(assert (not (= $t@1873 $Ref.null)))
(declare-const $k@1893 $Perm)
(assert ($Perm.isValidVar $k@1893))
(assert ($Perm.isReadVar $k@1893 $Perm.Write))
(push) ; 4
(assert (not (= $t@1839 $t@1873)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1808 $t@1873)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@1893 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1893 $Perm.No)))
(assert (= $t@1870 $t@1886))
; [exec]
; t2 := __flatten_57
; [exec]
; PutWorker__forkOperator(t1)
; [eval] diz != null
(declare-const $k@1894 $Perm)
(assert ($Perm.isValidVar $k@1894))
(assert ($Perm.isReadVar $k@1894 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1894 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1894 $k@1853))
(declare-const $k@1895 $Perm)
(assert ($Perm.isValidVar $k@1895))
(assert ($Perm.isReadVar $k@1895 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1895 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1895 $k@1854))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@1896 $Perm)
(assert ($Perm.isValidVar $k@1896))
(assert ($Perm.isReadVar $k@1896 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1896 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1896 $k@1855))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@1897 $Perm)
(assert ($Perm.isValidVar $k@1897))
(assert ($Perm.isReadVar $k@1897 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1897 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1897 $k@1856))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@1898 $Perm)
(assert ($Perm.isValidVar $k@1898))
(assert ($Perm.isReadVar $k@1898 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1898 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1898 $k@1857))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(declare-const $k@1899 $Perm)
(assert ($Perm.isValidVar $k@1899))
(assert ($Perm.isReadVar $k@1899 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1899 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1899 $k@1858))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@1900 $Perm)
(assert ($Perm.isValidVar $k@1900))
(assert ($Perm.isReadVar $k@1900 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1900 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1900 $k@1859))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(declare-const $t@1901 $Snap)
; [exec]
; TakeWorker__forkOperator(t2)
; [eval] diz != null
(declare-const $k@1902 $Perm)
(assert ($Perm.isValidVar $k@1902))
(assert ($Perm.isReadVar $k@1902 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1902 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1902 $k@1887))
(declare-const $k@1903 $Perm)
(assert ($Perm.isValidVar $k@1903))
(assert ($Perm.isReadVar $k@1903 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1903 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1903 $k@1888))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@1904 $Perm)
(assert ($Perm.isValidVar $k@1904))
(assert ($Perm.isReadVar $k@1904 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1904 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1904 $k@1889))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(declare-const $k@1905 $Perm)
(assert ($Perm.isValidVar $k@1905))
(assert ($Perm.isReadVar $k@1905 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1905 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1905 $k@1890))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(declare-const $k@1906 $Perm)
(assert ($Perm.isValidVar $k@1906))
(assert ($Perm.isReadVar $k@1906 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1906 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1906 $k@1891))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(declare-const $k@1907 $Perm)
(assert ($Perm.isValidVar $k@1907))
(assert ($Perm.isReadVar $k@1907 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1907 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1907 $k@1892))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@1908 $Perm)
(assert ($Perm.isValidVar $k@1908))
(assert ($Perm.isReadVar $k@1908 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1908 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1908 $k@1893))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(declare-const $t@1909 $Snap)
; [exec]
; PutWorker__joinOperator(t1)
; [eval] diz != null
(declare-const $t@1910 $Snap)
(declare-const $t@1911 $Snap)
(assert (= $t@1910 ($Snap.combine $t@1911 $Snap.unit)))
(declare-const $t@1912 $Snap)
(declare-const $t@1913 $Ref)
(assert (= $t@1911 ($Snap.combine $t@1912 ($SortWrappers.$RefTo$Snap $t@1913))))
(declare-const $t@1914 $Snap)
(assert (= $t@1912 ($Snap.combine $t@1914 $Snap.unit)))
(declare-const $t@1915 $Snap)
(declare-const $t@1916 $Ref)
(assert (= $t@1914 ($Snap.combine $t@1915 ($SortWrappers.$RefTo$Snap $t@1916))))
(declare-const $t@1917 $Snap)
(assert (= $t@1915 ($Snap.combine $t@1917 $Snap.unit)))
(declare-const $t@1918 $Snap)
(declare-const $t@1919 $Ref)
(assert (= $t@1917 ($Snap.combine $t@1918 ($SortWrappers.$RefTo$Snap $t@1919))))
(declare-const $t@1920 $Snap)
(assert (= $t@1918 ($Snap.combine $t@1920 $Snap.unit)))
(declare-const $t@1921 $Snap)
(declare-const $t@1922 $Ref)
(assert (= $t@1920 ($Snap.combine $t@1921 ($SortWrappers.$RefTo$Snap $t@1922))))
(declare-const $t@1923 $Snap)
(assert (= $t@1921 ($Snap.combine $t@1923 $Snap.unit)))
(declare-const $t@1924 $Snap)
(declare-const $t@1925 $Ref)
(assert (= $t@1923 ($Snap.combine $t@1924 ($SortWrappers.$RefTo$Snap $t@1925))))
(declare-const $t@1926 $Snap)
(assert (= $t@1924 ($Snap.combine $t@1926 $Snap.unit)))
(declare-const $t@1927 $Ref)
(declare-const $t@1928 Int)
(assert (=
  $t@1926
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1927)
    ($SortWrappers.IntTo$Snap $t@1928))))
(declare-const $k@1929 $Perm)
(assert ($Perm.isValidVar $k@1929))
(assert ($Perm.isReadVar $k@1929 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1853 $k@1894)) (= $t@1927 $t@1852)))
(push) ; 4
(assert (not (not (= (+ (- $k@1853 $k@1894) $k@1929) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1853 $k@1894) $k@1929) $Perm.No)))
(assert (not (= $t@1927 $Ref.null)))
(declare-const $k@1930 $Perm)
(assert ($Perm.isValidVar $k@1930))
(assert ($Perm.isReadVar $k@1930 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1854 $k@1895)) (= $t@1928 $t@1851)))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1854 $k@1895) $k@1930) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1854 $k@1895) $k@1930) $Perm.No)))
(assert (> $t@1928 0))
(declare-const $k@1931 $Perm)
(assert ($Perm.isValidVar $k@1931))
(assert ($Perm.isReadVar $k@1931 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1855 $k@1896)) (= $t@1925 $t@1848)))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1855 $k@1896) $k@1931) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1855 $k@1896) $k@1931) $Perm.No)))
(assert (not (= $t@1925 $Ref.null)))
(declare-const $k@1932 $Perm)
(assert ($Perm.isValidVar $k@1932))
(assert ($Perm.isReadVar $k@1932 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1856 $k@1897)) (= $t@1922 $t@1845)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1856 $k@1897) $k@1932) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1856 $k@1897) $k@1932) $Perm.No)))
(assert (not (= $t@1922 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1933 $Perm)
(assert ($Perm.isValidVar $k@1933))
(assert ($Perm.isReadVar $k@1933 $Perm.Write))
(push) ; 4
(assert (not (= $t@1814 $t@1922)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1845 $t@1922)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1857 $k@1898)) (= $t@1919 $t@1842)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1814 $t@1922)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1879 $t@1922)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1845 $t@1922)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1857 $k@1898) $k@1933) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1857 $k@1898) $k@1933) $Perm.No)))
(assert (= $t@1919 $t@1927))
(declare-const $k@1934 $Perm)
(assert ($Perm.isValidVar $k@1934))
(assert ($Perm.isReadVar $k@1934 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1858 $k@1899)) (= $t@1916 $t@1839)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1858 $k@1899) $k@1934) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1858 $k@1899) $k@1934) $Perm.No)))
(assert (not (= $t@1916 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1935 $Perm)
(assert ($Perm.isValidVar $k@1935))
(assert ($Perm.isReadVar $k@1935 $Perm.Write))
(push) ; 4
(assert (not (= $t@1808 $t@1916)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1839 $t@1916)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1859 $k@1900)) (= $t@1913 $t@1836)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1800 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1927)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1927)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1808 $t@1916)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1873 $t@1916)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1839 $t@1916)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1859 $k@1900) $k@1935) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1859 $k@1900) $k@1935) $Perm.No)))
(assert (= $t@1913 $t@1927))
; [exec]
; TakeWorker__joinOperator(t2)
; [eval] diz != null
(declare-const $t@1936 $Snap)
(declare-const $t@1937 $Snap)
(assert (= $t@1936 ($Snap.combine $t@1937 $Snap.unit)))
(declare-const $t@1938 $Snap)
(declare-const $t@1939 $Ref)
(assert (= $t@1937 ($Snap.combine $t@1938 ($SortWrappers.$RefTo$Snap $t@1939))))
(declare-const $t@1940 $Snap)
(assert (= $t@1938 ($Snap.combine $t@1940 $Snap.unit)))
(declare-const $t@1941 $Snap)
(declare-const $t@1942 $Ref)
(assert (= $t@1940 ($Snap.combine $t@1941 ($SortWrappers.$RefTo$Snap $t@1942))))
(declare-const $t@1943 $Snap)
(assert (= $t@1941 ($Snap.combine $t@1943 $Snap.unit)))
(declare-const $t@1944 $Snap)
(declare-const $t@1945 $Ref)
(assert (= $t@1943 ($Snap.combine $t@1944 ($SortWrappers.$RefTo$Snap $t@1945))))
(declare-const $t@1946 $Snap)
(assert (= $t@1944 ($Snap.combine $t@1946 $Snap.unit)))
(declare-const $t@1947 $Snap)
(declare-const $t@1948 $Ref)
(assert (= $t@1946 ($Snap.combine $t@1947 ($SortWrappers.$RefTo$Snap $t@1948))))
(declare-const $t@1949 $Snap)
(assert (= $t@1947 ($Snap.combine $t@1949 $Snap.unit)))
(declare-const $t@1950 $Snap)
(declare-const $t@1951 $Ref)
(assert (= $t@1949 ($Snap.combine $t@1950 ($SortWrappers.$RefTo$Snap $t@1951))))
(declare-const $t@1952 $Snap)
(assert (= $t@1950 ($Snap.combine $t@1952 $Snap.unit)))
(declare-const $t@1953 $Ref)
(declare-const $t@1954 Int)
(assert (=
  $t@1952
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@1953)
    ($SortWrappers.IntTo$Snap $t@1954))))
(declare-const $k@1955 $Perm)
(assert ($Perm.isValidVar $k@1955))
(assert ($Perm.isReadVar $k@1955 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1887 $k@1902)) (= $t@1953 $t@1886)))
(push) ; 4
(assert (not (not (= (+ (- $k@1887 $k@1902) $k@1955) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1887 $k@1902) $k@1955) $Perm.No)))
(assert (not (= $t@1953 $Ref.null)))
(declare-const $k@1956 $Perm)
(assert ($Perm.isValidVar $k@1956))
(assert ($Perm.isReadVar $k@1956 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1888 $k@1903)) (= $t@1954 $t@1885)))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1888 $k@1903) $k@1956) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1888 $k@1903) $k@1956) $Perm.No)))
(assert (> $t@1954 0))
(declare-const $k@1957 $Perm)
(assert ($Perm.isValidVar $k@1957))
(assert ($Perm.isReadVar $k@1957 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1889 $k@1904)) (= $t@1951 $t@1882)))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1889 $k@1904) $k@1957) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1889 $k@1904) $k@1957) $Perm.No)))
(assert (not (= $t@1951 $Ref.null)))
(declare-const $k@1958 $Perm)
(assert ($Perm.isValidVar $k@1958))
(assert ($Perm.isReadVar $k@1958 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1890 $k@1905)) (= $t@1948 $t@1879)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1890 $k@1905) $k@1958) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1890 $k@1905) $k@1958) $Perm.No)))
(assert (not (= $t@1948 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1959 $Perm)
(assert ($Perm.isValidVar $k@1959))
(assert ($Perm.isReadVar $k@1959 $Perm.Write))
(push) ; 4
(assert (not (= $t@1814 $t@1948)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1879 $t@1948)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1891 $k@1906)) (= $t@1945 $t@1876)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1814 $t@1948)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1845 $t@1948)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1879 $t@1948)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1891 $k@1906) $k@1959) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1891 $k@1906) $k@1959) $Perm.No)))
(assert (= $t@1945 $t@1953))
(declare-const $k@1960 $Perm)
(assert ($Perm.isValidVar $k@1960))
(assert ($Perm.isReadVar $k@1960 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1892 $k@1907)) (= $t@1942 $t@1873)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1892 $k@1907) $k@1960) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1892 $k@1907) $k@1960) $Perm.No)))
(assert (not (= $t@1942 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@1961 $Perm)
(assert ($Perm.isValidVar $k@1961))
(assert ($Perm.isReadVar $k@1961 $Perm.Write))
(push) ; 4
(assert (not (= $t@1808 $t@1942)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1873 $t@1942)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@1893 $k@1908)) (= $t@1939 $t@1870)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= sys__result@1800 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1852 $t@1953)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1886 $t@1953)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1808 $t@1942)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1839 $t@1942)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1873 $t@1942)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@1893 $k@1908) $k@1961) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@1893 $k@1908) $k@1961) $Perm.No)))
(assert (= $t@1939 $t@1953))
(pop) ; 3
(pop) ; 2
; ---------- Test__test4 ----------
(declare-const diz@1962 $Ref)
(declare-const queue@1963 $Ref)
(declare-const __flatten_62@1964 $Ref)
(declare-const t1@1965 $Ref)
(declare-const __flatten_63@1966 $Ref)
(declare-const t2@1967 $Ref)
(declare-const __flatten_64@1968 $Ref)
(declare-const t3@1969 $Ref)
(declare-const __flatten_65@1970 $Ref)
(declare-const t4@1971 $Ref)
(declare-const __flatten_66@1972 $Ref)
(declare-const t5@1973 $Ref)
(declare-const __flatten_67@1974 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1962 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_62 := BlockingQueue__BlockingQueue(10)
; [eval] capacity > 0
(declare-const sys__result@1975 $Ref)
(declare-const $t@1976 $Snap)
(declare-const $t@1977 $Snap)
(assert (= $t@1976 ($Snap.combine $t@1977 $Snap.unit)))
(declare-const $t@1978 $Snap)
(assert (= $t@1977 ($Snap.combine $t@1978 $Snap.unit)))
(declare-const $t@1979 $Snap)
(declare-const $t@1980 $Ref)
(assert (= $t@1978 ($Snap.combine $t@1979 ($SortWrappers.$RefTo$Snap $t@1980))))
(declare-const $t@1981 $Snap)
(assert (= $t@1979 ($Snap.combine $t@1981 $Snap.unit)))
(declare-const $t@1982 $Snap)
(declare-const $t@1983 $Ref)
(assert (= $t@1981 ($Snap.combine $t@1982 ($SortWrappers.$RefTo$Snap $t@1983))))
(declare-const $t@1984 $Snap)
(assert (= $t@1982 ($Snap.combine $t@1984 $Snap.unit)))
(declare-const $t@1985 $Snap)
(declare-const $t@1986 $Ref)
(assert (= $t@1984 ($Snap.combine $t@1985 ($SortWrappers.$RefTo$Snap $t@1986))))
(declare-const $t@1987 $Snap)
(assert (= $t@1985 ($Snap.combine $t@1987 $Snap.unit)))
(declare-const $t@1988 $Snap)
(declare-const $t@1989 $Ref)
(assert (= $t@1987 ($Snap.combine $t@1988 ($SortWrappers.$RefTo$Snap $t@1989))))
(declare-const $t@1990 $Snap)
(assert (= $t@1988 ($Snap.combine $t@1990 $Snap.unit)))
(declare-const $t@1991 Int)
(declare-const $t@1992 $Ref)
(assert (=
  $t@1990
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1991)
    ($SortWrappers.$RefTo$Snap $t@1992))))
(declare-const $t@1993 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1991)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1993) $Snap.unit)))
(declare-const $t@1994 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1993)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1994))))
; [eval] sys__result != null
(assert (not (= sys__result@1975 $Ref.null)))
(declare-const $k@1995 $Perm)
(assert ($Perm.isValidVar $k@1995))
(assert ($Perm.isReadVar $k@1995 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@1995 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1995 $Perm.No)))
(assert (> $t@1994 0))
(declare-const $k@1996 $Perm)
(assert ($Perm.isValidVar $k@1996))
(assert ($Perm.isReadVar $k@1996 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@1996 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1996 $Perm.No)))
(assert (not (= $t@1992 $Ref.null)))
(declare-const $k@1997 $Perm)
(assert ($Perm.isValidVar $k@1997))
(assert ($Perm.isReadVar $k@1997 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@1997 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1997 $Perm.No)))
(assert (not (= $t@1989 $Ref.null)))
(declare-const $k@1998 $Perm)
(assert ($Perm.isValidVar $k@1998))
(assert ($Perm.isReadVar $k@1998 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@1998 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1998 $Perm.No)))
(assert (= $t@1986 sys__result@1975))
(declare-const $k@1999 $Perm)
(assert ($Perm.isValidVar $k@1999))
(assert ($Perm.isReadVar $k@1999 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@1999 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1999 $Perm.No)))
(assert (not (= $t@1983 $Ref.null)))
(declare-const $k@2000 $Perm)
(assert ($Perm.isValidVar $k@2000))
(assert ($Perm.isReadVar $k@2000 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@2000 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2000 $Perm.No)))
(assert (= $t@1980 sys__result@1975))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@1994 10))
; [exec]
; queue := __flatten_62
; [exec]
; __flatten_63 := PutWorker__PutWorker(queue)
(declare-const $k@2001 $Perm)
(assert ($Perm.isValidVar $k@2001))
(assert ($Perm.isReadVar $k@2001 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2001 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2001 $k@1995))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@2002 $Perm)
(assert ($Perm.isValidVar $k@2002))
(assert ($Perm.isReadVar $k@2002 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2002 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2002 $k@1996))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@2003 $Perm)
(assert ($Perm.isValidVar $k@2003))
(assert ($Perm.isReadVar $k@2003 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2003 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2003 $k@1997))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@2004 $Perm)
(assert ($Perm.isValidVar $k@2004))
(assert ($Perm.isReadVar $k@2004 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2004 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2004 $k@1998))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@2005 $Perm)
(assert ($Perm.isValidVar $k@2005))
(assert ($Perm.isReadVar $k@2005 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2005 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2005 $k@1999))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@2006 $Perm)
(assert ($Perm.isValidVar $k@2006))
(assert ($Perm.isReadVar $k@2006 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2006 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2006 $k@2000))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@2007 $Ref)
(declare-const $t@2008 $Snap)
(declare-const $t@2009 $Snap)
(assert (= $t@2008 ($Snap.combine $t@2009 $Snap.unit)))
(declare-const $t@2010 $Snap)
(declare-const $t@2011 $Ref)
(assert (= $t@2009 ($Snap.combine $t@2010 ($SortWrappers.$RefTo$Snap $t@2011))))
(declare-const $t@2012 $Snap)
(assert (= $t@2010 ($Snap.combine $t@2012 $Snap.unit)))
(declare-const $t@2013 $Snap)
(declare-const $t@2014 $Ref)
(assert (= $t@2012 ($Snap.combine $t@2013 ($SortWrappers.$RefTo$Snap $t@2014))))
(declare-const $t@2015 $Snap)
(assert (= $t@2013 ($Snap.combine $t@2015 $Snap.unit)))
(declare-const $t@2016 $Snap)
(declare-const $t@2017 $Ref)
(assert (= $t@2015 ($Snap.combine $t@2016 ($SortWrappers.$RefTo$Snap $t@2017))))
(declare-const $t@2018 $Snap)
(assert (= $t@2016 ($Snap.combine $t@2018 $Snap.unit)))
(declare-const $t@2019 $Snap)
(declare-const $t@2020 $Ref)
(assert (= $t@2018 ($Snap.combine $t@2019 ($SortWrappers.$RefTo$Snap $t@2020))))
(declare-const $t@2021 $Snap)
(assert (= $t@2019 ($Snap.combine $t@2021 $Snap.unit)))
(declare-const $t@2022 $Snap)
(declare-const $t@2023 $Ref)
(assert (= $t@2021 ($Snap.combine $t@2022 ($SortWrappers.$RefTo$Snap $t@2023))))
(declare-const $t@2024 $Snap)
(assert (= $t@2022 ($Snap.combine $t@2024 $Snap.unit)))
(declare-const $t@2025 $Ref)
(declare-const $t@2026 Int)
(assert (=
  $t@2024
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2025)
    ($SortWrappers.IntTo$Snap $t@2026))))
(declare-const $t@2027 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2025)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2027))))
; [eval] sys__result != null
(assert (not (= sys__result@2007 $Ref.null)))
(declare-const $k@2028 $Perm)
(assert ($Perm.isValidVar $k@2028))
(assert ($Perm.isReadVar $k@2028 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@2028 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2028 $Perm.No)))
(assert (not (= $t@2027 $Ref.null)))
(declare-const $k@2029 $Perm)
(assert ($Perm.isValidVar $k@2029))
(assert ($Perm.isReadVar $k@2029 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2027)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2029 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2029 $Perm.No)))
(assert (> $t@2026 0))
(declare-const $k@2030 $Perm)
(assert ($Perm.isValidVar $k@2030))
(assert ($Perm.isReadVar $k@2030 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2027)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2030 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2030 $Perm.No)))
(assert (not (= $t@2023 $Ref.null)))
(declare-const $k@2031 $Perm)
(assert ($Perm.isValidVar $k@2031))
(assert ($Perm.isReadVar $k@2031 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2027)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2031 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2031 $Perm.No)))
(assert (not (= $t@2020 $Ref.null)))
(declare-const $k@2032 $Perm)
(assert ($Perm.isValidVar $k@2032))
(assert ($Perm.isReadVar $k@2032 $Perm.Write))
(push) ; 4
(assert (not (= $t@1989 $t@2020)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@2032 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2032 $Perm.No)))
(assert (= $t@2017 $t@2027))
(declare-const $k@2033 $Perm)
(assert ($Perm.isValidVar $k@2033))
(assert ($Perm.isReadVar $k@2033 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2027)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2033 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2033 $Perm.No)))
(assert (not (= $t@2014 $Ref.null)))
(declare-const $k@2034 $Perm)
(assert ($Perm.isValidVar $k@2034))
(assert ($Perm.isReadVar $k@2034 $Perm.Write))
(push) ; 4
(assert (not (= $t@1983 $t@2014)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@2034 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2034 $Perm.No)))
(assert (= $t@2011 $t@2027))
; [exec]
; t1 := __flatten_63
; [exec]
; __flatten_64 := TakeWorker__TakeWorker(queue)
(declare-const $k@2035 $Perm)
(assert ($Perm.isValidVar $k@2035))
(assert ($Perm.isReadVar $k@2035 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2035 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1995 $k@2001) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1995 $k@2001) $Perm.No)))
(assert (< $k@2035 (- $k@1995 $k@2001)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@2036 $Perm)
(assert ($Perm.isValidVar $k@2036))
(assert ($Perm.isReadVar $k@2036 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2036 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1996 $k@2002) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1996 $k@2002) $Perm.No)))
(assert (< $k@2036 (- $k@1996 $k@2002)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@2037 $Perm)
(assert ($Perm.isValidVar $k@2037))
(assert ($Perm.isReadVar $k@2037 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2037 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1997 $k@2003) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1997 $k@2003) $Perm.No)))
(assert (< $k@2037 (- $k@1997 $k@2003)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@2038 $Perm)
(assert ($Perm.isValidVar $k@2038))
(assert ($Perm.isReadVar $k@2038 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2038 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1998 $k@2004) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1998 $k@2004) $Perm.No)))
(assert (< $k@2038 (- $k@1998 $k@2004)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@2039 $Perm)
(assert ($Perm.isValidVar $k@2039))
(assert ($Perm.isReadVar $k@2039 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2039 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@1999 $k@2005) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@1999 $k@2005) $Perm.No)))
(assert (< $k@2039 (- $k@1999 $k@2005)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@2040 $Perm)
(assert ($Perm.isValidVar $k@2040))
(assert ($Perm.isReadVar $k@2040 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2040 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $k@2000 $k@2006) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $k@2000 $k@2006) $Perm.No)))
(assert (< $k@2040 (- $k@2000 $k@2006)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@2041 $Ref)
(declare-const $t@2042 $Snap)
(declare-const $t@2043 $Snap)
(assert (= $t@2042 ($Snap.combine $t@2043 $Snap.unit)))
(declare-const $t@2044 $Snap)
(declare-const $t@2045 $Ref)
(assert (= $t@2043 ($Snap.combine $t@2044 ($SortWrappers.$RefTo$Snap $t@2045))))
(declare-const $t@2046 $Snap)
(assert (= $t@2044 ($Snap.combine $t@2046 $Snap.unit)))
(declare-const $t@2047 $Snap)
(declare-const $t@2048 $Ref)
(assert (= $t@2046 ($Snap.combine $t@2047 ($SortWrappers.$RefTo$Snap $t@2048))))
(declare-const $t@2049 $Snap)
(assert (= $t@2047 ($Snap.combine $t@2049 $Snap.unit)))
(declare-const $t@2050 $Snap)
(declare-const $t@2051 $Ref)
(assert (= $t@2049 ($Snap.combine $t@2050 ($SortWrappers.$RefTo$Snap $t@2051))))
(declare-const $t@2052 $Snap)
(assert (= $t@2050 ($Snap.combine $t@2052 $Snap.unit)))
(declare-const $t@2053 $Snap)
(declare-const $t@2054 $Ref)
(assert (= $t@2052 ($Snap.combine $t@2053 ($SortWrappers.$RefTo$Snap $t@2054))))
(declare-const $t@2055 $Snap)
(assert (= $t@2053 ($Snap.combine $t@2055 $Snap.unit)))
(declare-const $t@2056 $Snap)
(declare-const $t@2057 $Ref)
(assert (= $t@2055 ($Snap.combine $t@2056 ($SortWrappers.$RefTo$Snap $t@2057))))
(declare-const $t@2058 $Snap)
(assert (= $t@2056 ($Snap.combine $t@2058 $Snap.unit)))
(declare-const $t@2059 $Ref)
(declare-const $t@2060 Int)
(assert (=
  $t@2058
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2059)
    ($SortWrappers.IntTo$Snap $t@2060))))
(declare-const $t@2061 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2059)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2061))))
; [eval] sys__result != null
(assert (not (= sys__result@2041 $Ref.null)))
(declare-const $k@2062 $Perm)
(assert ($Perm.isValidVar $k@2062))
(assert ($Perm.isReadVar $k@2062 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@2062 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2062 $Perm.No)))
(assert (not (= $t@2061 $Ref.null)))
(declare-const $k@2063 $Perm)
(assert ($Perm.isValidVar $k@2063))
(assert ($Perm.isReadVar $k@2063 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2063 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2063 $Perm.No)))
(assert (> $t@2060 0))
(declare-const $k@2064 $Perm)
(assert ($Perm.isValidVar $k@2064))
(assert ($Perm.isReadVar $k@2064 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2064 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2064 $Perm.No)))
(assert (not (= $t@2057 $Ref.null)))
(declare-const $k@2065 $Perm)
(assert ($Perm.isValidVar $k@2065))
(assert ($Perm.isReadVar $k@2065 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2065 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2065 $Perm.No)))
(assert (not (= $t@2054 $Ref.null)))
(declare-const $k@2066 $Perm)
(assert ($Perm.isValidVar $k@2066))
(assert ($Perm.isReadVar $k@2066 $Perm.Write))
(push) ; 4
(assert (not (= $t@2020 $t@2054)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2054)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@2066 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2066 $Perm.No)))
(assert (= $t@2051 $t@2061))
(declare-const $k@2067 $Perm)
(assert ($Perm.isValidVar $k@2067))
(assert ($Perm.isReadVar $k@2067 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2061)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2067 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2067 $Perm.No)))
(assert (not (= $t@2048 $Ref.null)))
(declare-const $k@2068 $Perm)
(assert ($Perm.isValidVar $k@2068))
(assert ($Perm.isReadVar $k@2068 $Perm.Write))
(push) ; 4
(assert (not (= $t@2014 $t@2048)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2048)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@2068 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2068 $Perm.No)))
(assert (= $t@2045 $t@2061))
; [exec]
; t2 := __flatten_64
; [exec]
; __flatten_65 := PutWorker__PutWorker(queue)
(declare-const $k@2069 $Perm)
(assert ($Perm.isValidVar $k@2069))
(assert ($Perm.isReadVar $k@2069 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2069 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- $k@1995 $k@2001) $k@2035) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- $k@1995 $k@2001) $k@2035) $Perm.No)))
(assert (< $k@2069 (- (- $k@1995 $k@2001) $k@2035)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@2070 $Perm)
(assert ($Perm.isValidVar $k@2070))
(assert ($Perm.isReadVar $k@2070 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2070 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- $k@1996 $k@2002) $k@2036) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- $k@1996 $k@2002) $k@2036) $Perm.No)))
(assert (< $k@2070 (- (- $k@1996 $k@2002) $k@2036)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@2071 $Perm)
(assert ($Perm.isValidVar $k@2071))
(assert ($Perm.isReadVar $k@2071 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2071 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- $k@1997 $k@2003) $k@2037) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- $k@1997 $k@2003) $k@2037) $Perm.No)))
(assert (< $k@2071 (- (- $k@1997 $k@2003) $k@2037)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@2072 $Perm)
(assert ($Perm.isValidVar $k@2072))
(assert ($Perm.isReadVar $k@2072 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2072 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- $k@1998 $k@2004) $k@2038) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- $k@1998 $k@2004) $k@2038) $Perm.No)))
(assert (< $k@2072 (- (- $k@1998 $k@2004) $k@2038)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@2073 $Perm)
(assert ($Perm.isValidVar $k@2073))
(assert ($Perm.isReadVar $k@2073 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2073 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- $k@1999 $k@2005) $k@2039) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- $k@1999 $k@2005) $k@2039) $Perm.No)))
(assert (< $k@2073 (- (- $k@1999 $k@2005) $k@2039)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@2074 $Perm)
(assert ($Perm.isValidVar $k@2074))
(assert ($Perm.isReadVar $k@2074 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2074 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- $k@2000 $k@2006) $k@2040) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- $k@2000 $k@2006) $k@2040) $Perm.No)))
(assert (< $k@2074 (- (- $k@2000 $k@2006) $k@2040)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@2075 $Ref)
(declare-const $t@2076 $Snap)
(declare-const $t@2077 $Snap)
(assert (= $t@2076 ($Snap.combine $t@2077 $Snap.unit)))
(declare-const $t@2078 $Snap)
(declare-const $t@2079 $Ref)
(assert (= $t@2077 ($Snap.combine $t@2078 ($SortWrappers.$RefTo$Snap $t@2079))))
(declare-const $t@2080 $Snap)
(assert (= $t@2078 ($Snap.combine $t@2080 $Snap.unit)))
(declare-const $t@2081 $Snap)
(declare-const $t@2082 $Ref)
(assert (= $t@2080 ($Snap.combine $t@2081 ($SortWrappers.$RefTo$Snap $t@2082))))
(declare-const $t@2083 $Snap)
(assert (= $t@2081 ($Snap.combine $t@2083 $Snap.unit)))
(declare-const $t@2084 $Snap)
(declare-const $t@2085 $Ref)
(assert (= $t@2083 ($Snap.combine $t@2084 ($SortWrappers.$RefTo$Snap $t@2085))))
(declare-const $t@2086 $Snap)
(assert (= $t@2084 ($Snap.combine $t@2086 $Snap.unit)))
(declare-const $t@2087 $Snap)
(declare-const $t@2088 $Ref)
(assert (= $t@2086 ($Snap.combine $t@2087 ($SortWrappers.$RefTo$Snap $t@2088))))
(declare-const $t@2089 $Snap)
(assert (= $t@2087 ($Snap.combine $t@2089 $Snap.unit)))
(declare-const $t@2090 $Snap)
(declare-const $t@2091 $Ref)
(assert (= $t@2089 ($Snap.combine $t@2090 ($SortWrappers.$RefTo$Snap $t@2091))))
(declare-const $t@2092 $Snap)
(assert (= $t@2090 ($Snap.combine $t@2092 $Snap.unit)))
(declare-const $t@2093 $Ref)
(declare-const $t@2094 Int)
(assert (=
  $t@2092
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2093)
    ($SortWrappers.IntTo$Snap $t@2094))))
(declare-const $t@2095 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2093)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2095))))
; [eval] sys__result != null
(assert (not (= sys__result@2075 $Ref.null)))
(declare-const $k@2096 $Perm)
(assert ($Perm.isValidVar $k@2096))
(assert ($Perm.isReadVar $k@2096 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@2007 sys__result@2075)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $k@2096 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2096 $Perm.No)))
(assert (not (= $t@2095 $Ref.null)))
(declare-const $k@2097 $Perm)
(assert ($Perm.isValidVar $k@2097))
(assert ($Perm.isReadVar $k@2097 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2097 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2097 $Perm.No)))
(assert (> $t@2094 0))
(declare-const $k@2098 $Perm)
(assert ($Perm.isValidVar $k@2098))
(assert ($Perm.isReadVar $k@2098 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2098 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2098 $Perm.No)))
(assert (not (= $t@2091 $Ref.null)))
(declare-const $k@2099 $Perm)
(assert ($Perm.isValidVar $k@2099))
(assert ($Perm.isReadVar $k@2099 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2099 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2099 $Perm.No)))
(assert (not (= $t@2088 $Ref.null)))
(declare-const $k@2100 $Perm)
(assert ($Perm.isValidVar $k@2100))
(assert ($Perm.isReadVar $k@2100 $Perm.Write))
(push) ; 4
(assert (not (= $t@2020 $t@2088)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2088)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2088)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@2100 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2100 $Perm.No)))
(assert (= $t@2085 $t@2095))
(declare-const $k@2101 $Perm)
(assert ($Perm.isValidVar $k@2101))
(assert ($Perm.isReadVar $k@2101 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2095)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2101 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2101 $Perm.No)))
(assert (not (= $t@2082 $Ref.null)))
(declare-const $k@2102 $Perm)
(assert ($Perm.isValidVar $k@2102))
(assert ($Perm.isReadVar $k@2102 $Perm.Write))
(push) ; 4
(assert (not (= $t@2014 $t@2082)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2082)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2082)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@2102 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2102 $Perm.No)))
(assert (= $t@2079 $t@2095))
; [exec]
; t3 := __flatten_65
; [exec]
; __flatten_66 := PutWorker__PutWorker(queue)
(declare-const $k@2103 $Perm)
(assert ($Perm.isValidVar $k@2103))
(assert ($Perm.isReadVar $k@2103 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2103 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- $k@1995 $k@2001) $k@2035) $k@2069) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- $k@1995 $k@2001) $k@2035) $k@2069) $Perm.No)))
(assert (< $k@2103 (- (- (- $k@1995 $k@2001) $k@2035) $k@2069)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@2104 $Perm)
(assert ($Perm.isValidVar $k@2104))
(assert ($Perm.isReadVar $k@2104 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2104 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- $k@1996 $k@2002) $k@2036) $k@2070) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- $k@1996 $k@2002) $k@2036) $k@2070) $Perm.No)))
(assert (< $k@2104 (- (- (- $k@1996 $k@2002) $k@2036) $k@2070)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@2105 $Perm)
(assert ($Perm.isValidVar $k@2105))
(assert ($Perm.isReadVar $k@2105 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2105 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- $k@1997 $k@2003) $k@2037) $k@2071) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- $k@1997 $k@2003) $k@2037) $k@2071) $Perm.No)))
(assert (< $k@2105 (- (- (- $k@1997 $k@2003) $k@2037) $k@2071)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@2106 $Perm)
(assert ($Perm.isValidVar $k@2106))
(assert ($Perm.isReadVar $k@2106 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2106 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- $k@1998 $k@2004) $k@2038) $k@2072) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- $k@1998 $k@2004) $k@2038) $k@2072) $Perm.No)))
(assert (< $k@2106 (- (- (- $k@1998 $k@2004) $k@2038) $k@2072)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@2107 $Perm)
(assert ($Perm.isValidVar $k@2107))
(assert ($Perm.isReadVar $k@2107 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2107 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- $k@1999 $k@2005) $k@2039) $k@2073) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- $k@1999 $k@2005) $k@2039) $k@2073) $Perm.No)))
(assert (< $k@2107 (- (- (- $k@1999 $k@2005) $k@2039) $k@2073)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@2108 $Perm)
(assert ($Perm.isValidVar $k@2108))
(assert ($Perm.isReadVar $k@2108 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2108 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- $k@2000 $k@2006) $k@2040) $k@2074) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- $k@2000 $k@2006) $k@2040) $k@2074) $Perm.No)))
(assert (< $k@2108 (- (- (- $k@2000 $k@2006) $k@2040) $k@2074)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@2109 $Ref)
(declare-const $t@2110 $Snap)
(declare-const $t@2111 $Snap)
(assert (= $t@2110 ($Snap.combine $t@2111 $Snap.unit)))
(declare-const $t@2112 $Snap)
(declare-const $t@2113 $Ref)
(assert (= $t@2111 ($Snap.combine $t@2112 ($SortWrappers.$RefTo$Snap $t@2113))))
(declare-const $t@2114 $Snap)
(assert (= $t@2112 ($Snap.combine $t@2114 $Snap.unit)))
(declare-const $t@2115 $Snap)
(declare-const $t@2116 $Ref)
(assert (= $t@2114 ($Snap.combine $t@2115 ($SortWrappers.$RefTo$Snap $t@2116))))
(declare-const $t@2117 $Snap)
(assert (= $t@2115 ($Snap.combine $t@2117 $Snap.unit)))
(declare-const $t@2118 $Snap)
(declare-const $t@2119 $Ref)
(assert (= $t@2117 ($Snap.combine $t@2118 ($SortWrappers.$RefTo$Snap $t@2119))))
(declare-const $t@2120 $Snap)
(assert (= $t@2118 ($Snap.combine $t@2120 $Snap.unit)))
(declare-const $t@2121 $Snap)
(declare-const $t@2122 $Ref)
(assert (= $t@2120 ($Snap.combine $t@2121 ($SortWrappers.$RefTo$Snap $t@2122))))
(declare-const $t@2123 $Snap)
(assert (= $t@2121 ($Snap.combine $t@2123 $Snap.unit)))
(declare-const $t@2124 $Snap)
(declare-const $t@2125 $Ref)
(assert (= $t@2123 ($Snap.combine $t@2124 ($SortWrappers.$RefTo$Snap $t@2125))))
(declare-const $t@2126 $Snap)
(assert (= $t@2124 ($Snap.combine $t@2126 $Snap.unit)))
(declare-const $t@2127 $Ref)
(declare-const $t@2128 Int)
(assert (=
  $t@2126
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2127)
    ($SortWrappers.IntTo$Snap $t@2128))))
(declare-const $t@2129 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2127)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2129))))
; [eval] sys__result != null
(assert (not (= sys__result@2109 $Ref.null)))
(declare-const $k@2130 $Perm)
(assert ($Perm.isValidVar $k@2130))
(assert ($Perm.isReadVar $k@2130 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@2007 sys__result@2109)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@2075 sys__result@2109)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $k@2130 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2130 $Perm.No)))
(assert (not (= $t@2129 $Ref.null)))
(declare-const $k@2131 $Perm)
(assert ($Perm.isValidVar $k@2131))
(assert ($Perm.isReadVar $k@2131 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2131 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2131 $Perm.No)))
(assert (> $t@2128 0))
(declare-const $k@2132 $Perm)
(assert ($Perm.isValidVar $k@2132))
(assert ($Perm.isReadVar $k@2132 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2132 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2132 $Perm.No)))
(assert (not (= $t@2125 $Ref.null)))
(declare-const $k@2133 $Perm)
(assert ($Perm.isValidVar $k@2133))
(assert ($Perm.isReadVar $k@2133 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2133 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2133 $Perm.No)))
(assert (not (= $t@2122 $Ref.null)))
(declare-const $k@2134 $Perm)
(assert ($Perm.isValidVar $k@2134))
(assert ($Perm.isReadVar $k@2134 $Perm.Write))
(push) ; 4
(assert (not (= $t@2020 $t@2122)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2122)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2122)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2122)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@2134 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2134 $Perm.No)))
(assert (= $t@2119 $t@2129))
(declare-const $k@2135 $Perm)
(assert ($Perm.isValidVar $k@2135))
(assert ($Perm.isReadVar $k@2135 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2129)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2135 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2135 $Perm.No)))
(assert (not (= $t@2116 $Ref.null)))
(declare-const $k@2136 $Perm)
(assert ($Perm.isValidVar $k@2136))
(assert ($Perm.isReadVar $k@2136 $Perm.Write))
(push) ; 4
(assert (not (= $t@2014 $t@2116)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2116)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2116)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2116)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.PutWorker__queue
(push) ; 4
(assert (not (not (= $k@2136 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2136 $Perm.No)))
(assert (= $t@2113 $t@2129))
; [exec]
; t4 := __flatten_66
; [exec]
; __flatten_67 := TakeWorker__TakeWorker(queue)
(declare-const $k@2137 $Perm)
(assert ($Perm.isValidVar $k@2137))
(assert ($Perm.isReadVar $k@2137 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2137 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- (- $k@1995 $k@2001) $k@2035) $k@2069) $k@2103) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- (- $k@1995 $k@2001) $k@2035) $k@2069) $k@2103) $Perm.No)))
(assert (< $k@2137 (- (- (- (- $k@1995 $k@2001) $k@2035) $k@2069) $k@2103)))
; [eval] queue.BlockingQueue__capacity > 0
(declare-const $k@2138 $Perm)
(assert ($Perm.isValidVar $k@2138))
(assert ($Perm.isReadVar $k@2138 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2138 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- (- $k@1996 $k@2002) $k@2036) $k@2070) $k@2104) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- (- $k@1996 $k@2002) $k@2036) $k@2070) $k@2104) $Perm.No)))
(assert (< $k@2138 (- (- (- (- $k@1996 $k@2002) $k@2036) $k@2070) $k@2104)))
; [eval] queue.BlockingQueue__count != null
(declare-const $k@2139 $Perm)
(assert ($Perm.isValidVar $k@2139))
(assert ($Perm.isReadVar $k@2139 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2139 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- (- $k@1997 $k@2003) $k@2037) $k@2071) $k@2105) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- (- $k@1997 $k@2003) $k@2037) $k@2071) $k@2105) $Perm.No)))
(assert (< $k@2139 (- (- (- (- $k@1997 $k@2003) $k@2037) $k@2071) $k@2105)))
; [eval] queue.BlockingQueue__headLock != null
(declare-const $k@2140 $Perm)
(assert ($Perm.isValidVar $k@2140))
(assert ($Perm.isReadVar $k@2140 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2140 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- (- $k@1998 $k@2004) $k@2038) $k@2072) $k@2106) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- (- $k@1998 $k@2004) $k@2038) $k@2072) $k@2106) $Perm.No)))
(assert (< $k@2140 (- (- (- (- $k@1998 $k@2004) $k@2038) $k@2072) $k@2106)))
; [eval] queue.BlockingQueue__headLock.HeadLock__queue == queue
(declare-const $k@2141 $Perm)
(assert ($Perm.isValidVar $k@2141))
(assert ($Perm.isReadVar $k@2141 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2141 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- (- $k@1999 $k@2005) $k@2039) $k@2073) $k@2107) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- (- $k@1999 $k@2005) $k@2039) $k@2073) $k@2107) $Perm.No)))
(assert (< $k@2141 (- (- (- (- $k@1999 $k@2005) $k@2039) $k@2073) $k@2107)))
; [eval] queue.BlockingQueue__lastLock != null
(declare-const $k@2142 $Perm)
(assert ($Perm.isValidVar $k@2142))
(assert ($Perm.isReadVar $k@2142 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2142 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- (- (- (- $k@2000 $k@2006) $k@2040) $k@2074) $k@2108) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- (- (- (- $k@2000 $k@2006) $k@2040) $k@2074) $k@2108) $Perm.No)))
(assert (< $k@2142 (- (- (- (- $k@2000 $k@2006) $k@2040) $k@2074) $k@2108)))
; [eval] queue.BlockingQueue__lastLock.LastLock__queue == queue
(declare-const sys__result@2143 $Ref)
(declare-const $t@2144 $Snap)
(declare-const $t@2145 $Snap)
(assert (= $t@2144 ($Snap.combine $t@2145 $Snap.unit)))
(declare-const $t@2146 $Snap)
(declare-const $t@2147 $Ref)
(assert (= $t@2145 ($Snap.combine $t@2146 ($SortWrappers.$RefTo$Snap $t@2147))))
(declare-const $t@2148 $Snap)
(assert (= $t@2146 ($Snap.combine $t@2148 $Snap.unit)))
(declare-const $t@2149 $Snap)
(declare-const $t@2150 $Ref)
(assert (= $t@2148 ($Snap.combine $t@2149 ($SortWrappers.$RefTo$Snap $t@2150))))
(declare-const $t@2151 $Snap)
(assert (= $t@2149 ($Snap.combine $t@2151 $Snap.unit)))
(declare-const $t@2152 $Snap)
(declare-const $t@2153 $Ref)
(assert (= $t@2151 ($Snap.combine $t@2152 ($SortWrappers.$RefTo$Snap $t@2153))))
(declare-const $t@2154 $Snap)
(assert (= $t@2152 ($Snap.combine $t@2154 $Snap.unit)))
(declare-const $t@2155 $Snap)
(declare-const $t@2156 $Ref)
(assert (= $t@2154 ($Snap.combine $t@2155 ($SortWrappers.$RefTo$Snap $t@2156))))
(declare-const $t@2157 $Snap)
(assert (= $t@2155 ($Snap.combine $t@2157 $Snap.unit)))
(declare-const $t@2158 $Snap)
(declare-const $t@2159 $Ref)
(assert (= $t@2157 ($Snap.combine $t@2158 ($SortWrappers.$RefTo$Snap $t@2159))))
(declare-const $t@2160 $Snap)
(assert (= $t@2158 ($Snap.combine $t@2160 $Snap.unit)))
(declare-const $t@2161 $Ref)
(declare-const $t@2162 Int)
(assert (=
  $t@2160
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2161)
    ($SortWrappers.IntTo$Snap $t@2162))))
(declare-const $t@2163 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2161)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2163))))
; [eval] sys__result != null
(assert (not (= sys__result@2143 $Ref.null)))
(declare-const $k@2164 $Perm)
(assert ($Perm.isValidVar $k@2164))
(assert ($Perm.isReadVar $k@2164 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@2041 sys__result@2143)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $k@2164 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2164 $Perm.No)))
(assert (not (= $t@2163 $Ref.null)))
(declare-const $k@2165 $Perm)
(assert ($Perm.isValidVar $k@2165))
(assert ($Perm.isReadVar $k@2165 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2165 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2165 $Perm.No)))
(assert (> $t@2162 0))
(declare-const $k@2166 $Perm)
(assert ($Perm.isValidVar $k@2166))
(assert ($Perm.isReadVar $k@2166 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2166 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2166 $Perm.No)))
(assert (not (= $t@2159 $Ref.null)))
(declare-const $k@2167 $Perm)
(assert ($Perm.isValidVar $k@2167))
(assert ($Perm.isReadVar $k@2167 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2167 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2167 $Perm.No)))
(assert (not (= $t@2156 $Ref.null)))
(declare-const $k@2168 $Perm)
(assert ($Perm.isValidVar $k@2168))
(assert ($Perm.isReadVar $k@2168 $Perm.Write))
(push) ; 4
(assert (not (= $t@2020 $t@2156)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2156)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2156)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2156)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2156)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@2168 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2168 $Perm.No)))
(assert (= $t@2153 $t@2163))
(declare-const $k@2169 $Perm)
(assert ($Perm.isValidVar $k@2169))
(assert ($Perm.isReadVar $k@2169 $Perm.Write))
(push) ; 4
(assert (not (= $t@2027 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@1975 $t@2163)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2169 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2169 $Perm.No)))
(assert (not (= $t@2150 $Ref.null)))
(declare-const $k@2170 $Perm)
(assert ($Perm.isValidVar $k@2170))
(assert ($Perm.isReadVar $k@2170 $Perm.Write))
(push) ; 4
(assert (not (= $t@2014 $t@2150)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2150)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2150)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2150)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2150)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [eval] sys__result.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == sys__result.TakeWorker__queue
(push) ; 4
(assert (not (not (= $k@2170 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2170 $Perm.No)))
(assert (= $t@2147 $t@2163))
; [exec]
; t5 := __flatten_67
; [exec]
; PutWorker__forkOperator(t1)
; [eval] diz != null
(declare-const $k@2171 $Perm)
(assert ($Perm.isValidVar $k@2171))
(assert ($Perm.isReadVar $k@2171 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2171 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2171 $k@2028))
(declare-const $k@2172 $Perm)
(assert ($Perm.isValidVar $k@2172))
(assert ($Perm.isReadVar $k@2172 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2172 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2172 $k@2029))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@2173 $Perm)
(assert ($Perm.isValidVar $k@2173))
(assert ($Perm.isReadVar $k@2173 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2173 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2173 $k@2030))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@2174 $Perm)
(assert ($Perm.isValidVar $k@2174))
(assert ($Perm.isReadVar $k@2174 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2174 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2174 $k@2031))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@2175 $Perm)
(assert ($Perm.isValidVar $k@2175))
(assert ($Perm.isReadVar $k@2175 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2175 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2175 $k@2032))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(declare-const $k@2176 $Perm)
(assert ($Perm.isValidVar $k@2176))
(assert ($Perm.isReadVar $k@2176 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2176 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2176 $k@2033))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@2177 $Perm)
(assert ($Perm.isValidVar $k@2177))
(assert ($Perm.isReadVar $k@2177 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2177 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2177 $k@2034))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(declare-const $t@2178 $Snap)
; [exec]
; TakeWorker__forkOperator(t2)
; [eval] diz != null
(declare-const $k@2179 $Perm)
(assert ($Perm.isValidVar $k@2179))
(assert ($Perm.isReadVar $k@2179 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2179 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2179 $k@2062))
(declare-const $k@2180 $Perm)
(assert ($Perm.isValidVar $k@2180))
(assert ($Perm.isReadVar $k@2180 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2180 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2180 $k@2063))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@2181 $Perm)
(assert ($Perm.isValidVar $k@2181))
(assert ($Perm.isReadVar $k@2181 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2181 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2181 $k@2064))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(declare-const $k@2182 $Perm)
(assert ($Perm.isValidVar $k@2182))
(assert ($Perm.isReadVar $k@2182 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2182 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2182 $k@2065))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(declare-const $k@2183 $Perm)
(assert ($Perm.isValidVar $k@2183))
(assert ($Perm.isReadVar $k@2183 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2183 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2183 $k@2066))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(declare-const $k@2184 $Perm)
(assert ($Perm.isValidVar $k@2184))
(assert ($Perm.isReadVar $k@2184 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2184 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2184 $k@2067))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@2185 $Perm)
(assert ($Perm.isValidVar $k@2185))
(assert ($Perm.isReadVar $k@2185 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2185 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2185 $k@2068))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(declare-const $t@2186 $Snap)
; [exec]
; PutWorker__forkOperator(t3)
; [eval] diz != null
(declare-const $k@2187 $Perm)
(assert ($Perm.isValidVar $k@2187))
(assert ($Perm.isReadVar $k@2187 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2187 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2187 $k@2096))
(declare-const $k@2188 $Perm)
(assert ($Perm.isValidVar $k@2188))
(assert ($Perm.isReadVar $k@2188 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2188 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2188 $k@2097))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@2189 $Perm)
(assert ($Perm.isValidVar $k@2189))
(assert ($Perm.isReadVar $k@2189 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2189 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2189 $k@2098))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@2190 $Perm)
(assert ($Perm.isValidVar $k@2190))
(assert ($Perm.isReadVar $k@2190 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2190 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2190 $k@2099))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@2191 $Perm)
(assert ($Perm.isValidVar $k@2191))
(assert ($Perm.isReadVar $k@2191 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2191 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2191 $k@2100))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(declare-const $k@2192 $Perm)
(assert ($Perm.isValidVar $k@2192))
(assert ($Perm.isReadVar $k@2192 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2192 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2192 $k@2101))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@2193 $Perm)
(assert ($Perm.isValidVar $k@2193))
(assert ($Perm.isReadVar $k@2193 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2193 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2193 $k@2102))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(declare-const $t@2194 $Snap)
(push) ; 4
(assert (not (= sys__result@2007 sys__result@2075)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [exec]
; PutWorker__forkOperator(t4)
; [eval] diz != null
(declare-const $k@2195 $Perm)
(assert ($Perm.isValidVar $k@2195))
(assert ($Perm.isReadVar $k@2195 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2195 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2195 $k@2130))
(declare-const $k@2196 $Perm)
(assert ($Perm.isValidVar $k@2196))
(assert ($Perm.isReadVar $k@2196 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2196 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2196 $k@2131))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@2197 $Perm)
(assert ($Perm.isValidVar $k@2197))
(assert ($Perm.isReadVar $k@2197 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2197 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2197 $k@2132))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(declare-const $k@2198 $Perm)
(assert ($Perm.isValidVar $k@2198))
(assert ($Perm.isReadVar $k@2198 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2198 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2198 $k@2133))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(declare-const $k@2199 $Perm)
(assert ($Perm.isValidVar $k@2199))
(assert ($Perm.isReadVar $k@2199 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2199 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2199 $k@2134))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(declare-const $k@2200 $Perm)
(assert ($Perm.isValidVar $k@2200))
(assert ($Perm.isReadVar $k@2200 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2200 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2200 $k@2135))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@2201 $Perm)
(assert ($Perm.isValidVar $k@2201))
(assert ($Perm.isReadVar $k@2201 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2201 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2201 $k@2136))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(declare-const $t@2202 $Snap)
(push) ; 4
(assert (not (= sys__result@2007 sys__result@2109)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@2075 sys__result@2109)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [exec]
; TakeWorker__forkOperator(t5)
; [eval] diz != null
(declare-const $k@2203 $Perm)
(assert ($Perm.isValidVar $k@2203))
(assert ($Perm.isReadVar $k@2203 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2203 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2203 $k@2164))
(declare-const $k@2204 $Perm)
(assert ($Perm.isValidVar $k@2204))
(assert ($Perm.isReadVar $k@2204 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2204 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2204 $k@2165))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(declare-const $k@2205 $Perm)
(assert ($Perm.isValidVar $k@2205))
(assert ($Perm.isReadVar $k@2205 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2205 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2205 $k@2166))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(declare-const $k@2206 $Perm)
(assert ($Perm.isValidVar $k@2206))
(assert ($Perm.isReadVar $k@2206 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2206 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2206 $k@2167))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(declare-const $k@2207 $Perm)
(assert ($Perm.isValidVar $k@2207))
(assert ($Perm.isReadVar $k@2207 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2207 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2207 $k@2168))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(declare-const $k@2208 $Perm)
(assert ($Perm.isValidVar $k@2208))
(assert ($Perm.isReadVar $k@2208 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2208 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2208 $k@2169))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(declare-const $k@2209 $Perm)
(assert ($Perm.isValidVar $k@2209))
(assert ($Perm.isReadVar $k@2209 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2209 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2209 $k@2170))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(declare-const $t@2210 $Snap)
(push) ; 4
(assert (not (= sys__result@2041 sys__result@2143)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [exec]
; PutWorker__joinOperator(t1)
; [eval] diz != null
(declare-const $t@2211 $Snap)
(declare-const $t@2212 $Snap)
(assert (= $t@2211 ($Snap.combine $t@2212 $Snap.unit)))
(declare-const $t@2213 $Snap)
(declare-const $t@2214 $Ref)
(assert (= $t@2212 ($Snap.combine $t@2213 ($SortWrappers.$RefTo$Snap $t@2214))))
(declare-const $t@2215 $Snap)
(assert (= $t@2213 ($Snap.combine $t@2215 $Snap.unit)))
(declare-const $t@2216 $Snap)
(declare-const $t@2217 $Ref)
(assert (= $t@2215 ($Snap.combine $t@2216 ($SortWrappers.$RefTo$Snap $t@2217))))
(declare-const $t@2218 $Snap)
(assert (= $t@2216 ($Snap.combine $t@2218 $Snap.unit)))
(declare-const $t@2219 $Snap)
(declare-const $t@2220 $Ref)
(assert (= $t@2218 ($Snap.combine $t@2219 ($SortWrappers.$RefTo$Snap $t@2220))))
(declare-const $t@2221 $Snap)
(assert (= $t@2219 ($Snap.combine $t@2221 $Snap.unit)))
(declare-const $t@2222 $Snap)
(declare-const $t@2223 $Ref)
(assert (= $t@2221 ($Snap.combine $t@2222 ($SortWrappers.$RefTo$Snap $t@2223))))
(declare-const $t@2224 $Snap)
(assert (= $t@2222 ($Snap.combine $t@2224 $Snap.unit)))
(declare-const $t@2225 $Snap)
(declare-const $t@2226 $Ref)
(assert (= $t@2224 ($Snap.combine $t@2225 ($SortWrappers.$RefTo$Snap $t@2226))))
(declare-const $t@2227 $Snap)
(assert (= $t@2225 ($Snap.combine $t@2227 $Snap.unit)))
(declare-const $t@2228 $Ref)
(declare-const $t@2229 Int)
(assert (=
  $t@2227
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2228)
    ($SortWrappers.IntTo$Snap $t@2229))))
(declare-const $k@2230 $Perm)
(assert ($Perm.isValidVar $k@2230))
(assert ($Perm.isReadVar $k@2230 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2028 $k@2171)) (= $t@2228 $t@2027)))
(push) ; 4
(assert (not (not (= (+ (- $k@2028 $k@2171) $k@2230) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2028 $k@2171) $k@2230) $Perm.No)))
(assert (not (= $t@2228 $Ref.null)))
(declare-const $k@2231 $Perm)
(assert ($Perm.isValidVar $k@2231))
(assert ($Perm.isReadVar $k@2231 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2029 $k@2172)) (= $t@2229 $t@2026)))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2029 $k@2172) $k@2231) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2029 $k@2172) $k@2231) $Perm.No)))
(assert (> $t@2229 0))
(declare-const $k@2232 $Perm)
(assert ($Perm.isValidVar $k@2232))
(assert ($Perm.isReadVar $k@2232 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2030 $k@2173)) (= $t@2226 $t@2023)))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2030 $k@2173) $k@2232) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2030 $k@2173) $k@2232) $Perm.No)))
(assert (not (= $t@2226 $Ref.null)))
(declare-const $k@2233 $Perm)
(assert ($Perm.isValidVar $k@2233))
(assert ($Perm.isReadVar $k@2233 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2031 $k@2174)) (= $t@2223 $t@2020)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2031 $k@2174) $k@2233) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2031 $k@2174) $k@2233) $Perm.No)))
(assert (not (= $t@2223 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2234 $Perm)
(assert ($Perm.isValidVar $k@2234))
(assert ($Perm.isReadVar $k@2234 $Perm.Write))
(push) ; 4
(assert (not (= $t@1989 $t@2223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2020 $t@2223)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2032 $k@2175)) (= $t@2220 $t@2017)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2156 $t@2223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2020 $t@2223)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2032 $k@2175) $k@2234) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2032 $k@2175) $k@2234) $Perm.No)))
(assert (= $t@2220 $t@2228))
(declare-const $k@2235 $Perm)
(assert ($Perm.isValidVar $k@2235))
(assert ($Perm.isReadVar $k@2235 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2033 $k@2176)) (= $t@2217 $t@2014)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2033 $k@2176) $k@2235) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2033 $k@2176) $k@2235) $Perm.No)))
(assert (not (= $t@2217 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2236 $Perm)
(assert ($Perm.isValidVar $k@2236))
(assert ($Perm.isReadVar $k@2236 $Perm.Write))
(push) ; 4
(assert (not (= $t@1983 $t@2217)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2014 $t@2217)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2034 $k@2177)) (= $t@2214 $t@2011)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2228)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2228)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2217)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2217)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2217)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2217)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2150 $t@2217)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2014 $t@2217)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2034 $k@2177) $k@2236) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2034 $k@2177) $k@2236) $Perm.No)))
(assert (= $t@2214 $t@2228))
; [exec]
; TakeWorker__joinOperator(t2)
; [eval] diz != null
(declare-const $t@2237 $Snap)
(declare-const $t@2238 $Snap)
(assert (= $t@2237 ($Snap.combine $t@2238 $Snap.unit)))
(declare-const $t@2239 $Snap)
(declare-const $t@2240 $Ref)
(assert (= $t@2238 ($Snap.combine $t@2239 ($SortWrappers.$RefTo$Snap $t@2240))))
(declare-const $t@2241 $Snap)
(assert (= $t@2239 ($Snap.combine $t@2241 $Snap.unit)))
(declare-const $t@2242 $Snap)
(declare-const $t@2243 $Ref)
(assert (= $t@2241 ($Snap.combine $t@2242 ($SortWrappers.$RefTo$Snap $t@2243))))
(declare-const $t@2244 $Snap)
(assert (= $t@2242 ($Snap.combine $t@2244 $Snap.unit)))
(declare-const $t@2245 $Snap)
(declare-const $t@2246 $Ref)
(assert (= $t@2244 ($Snap.combine $t@2245 ($SortWrappers.$RefTo$Snap $t@2246))))
(declare-const $t@2247 $Snap)
(assert (= $t@2245 ($Snap.combine $t@2247 $Snap.unit)))
(declare-const $t@2248 $Snap)
(declare-const $t@2249 $Ref)
(assert (= $t@2247 ($Snap.combine $t@2248 ($SortWrappers.$RefTo$Snap $t@2249))))
(declare-const $t@2250 $Snap)
(assert (= $t@2248 ($Snap.combine $t@2250 $Snap.unit)))
(declare-const $t@2251 $Snap)
(declare-const $t@2252 $Ref)
(assert (= $t@2250 ($Snap.combine $t@2251 ($SortWrappers.$RefTo$Snap $t@2252))))
(declare-const $t@2253 $Snap)
(assert (= $t@2251 ($Snap.combine $t@2253 $Snap.unit)))
(declare-const $t@2254 $Ref)
(declare-const $t@2255 Int)
(assert (=
  $t@2253
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2254)
    ($SortWrappers.IntTo$Snap $t@2255))))
(declare-const $k@2256 $Perm)
(assert ($Perm.isValidVar $k@2256))
(assert ($Perm.isReadVar $k@2256 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2062 $k@2179)) (= $t@2254 $t@2061)))
(push) ; 4
(assert (not (not (= (+ (- $k@2062 $k@2179) $k@2256) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2062 $k@2179) $k@2256) $Perm.No)))
(assert (not (= $t@2254 $Ref.null)))
(declare-const $k@2257 $Perm)
(assert ($Perm.isValidVar $k@2257))
(assert ($Perm.isReadVar $k@2257 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2063 $k@2180)) (= $t@2255 $t@2060)))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2063 $k@2180) $k@2257) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2063 $k@2180) $k@2257) $Perm.No)))
(assert (> $t@2255 0))
(declare-const $k@2258 $Perm)
(assert ($Perm.isValidVar $k@2258))
(assert ($Perm.isReadVar $k@2258 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2064 $k@2181)) (= $t@2252 $t@2057)))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2064 $k@2181) $k@2258) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2064 $k@2181) $k@2258) $Perm.No)))
(assert (not (= $t@2252 $Ref.null)))
(declare-const $k@2259 $Perm)
(assert ($Perm.isValidVar $k@2259))
(assert ($Perm.isReadVar $k@2259 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2065 $k@2182)) (= $t@2249 $t@2054)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2065 $k@2182) $k@2259) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2065 $k@2182) $k@2259) $Perm.No)))
(assert (not (= $t@2249 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2260 $Perm)
(assert ($Perm.isValidVar $k@2260))
(assert ($Perm.isReadVar $k@2260 $Perm.Write))
(push) ; 4
(assert (not (= $t@1989 $t@2249)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2249)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2066 $k@2183)) (= $t@2246 $t@2051)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2249)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2249)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2249)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2156 $t@2249)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2020 $t@2249)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2249)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2066 $k@2183) $k@2260) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2066 $k@2183) $k@2260) $Perm.No)))
(assert (= $t@2246 $t@2254))
(declare-const $k@2261 $Perm)
(assert ($Perm.isValidVar $k@2261))
(assert ($Perm.isReadVar $k@2261 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2067 $k@2184)) (= $t@2243 $t@2048)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2067 $k@2184) $k@2261) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2067 $k@2184) $k@2261) $Perm.No)))
(assert (not (= $t@2243 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2262 $Perm)
(assert ($Perm.isValidVar $k@2262))
(assert ($Perm.isReadVar $k@2262 $Perm.Write))
(push) ; 4
(assert (not (= $t@1983 $t@2243)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2243)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2068 $k@2185)) (= $t@2240 $t@2045)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2254)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2254)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2243)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2243)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2243)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2150 $t@2243)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2014 $t@2243)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2243)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2068 $k@2185) $k@2262) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2068 $k@2185) $k@2262) $Perm.No)))
(assert (= $t@2240 $t@2254))
; [exec]
; PutWorker__joinOperator(t3)
; [eval] diz != null
(declare-const $t@2263 $Snap)
(declare-const $t@2264 $Snap)
(assert (= $t@2263 ($Snap.combine $t@2264 $Snap.unit)))
(declare-const $t@2265 $Snap)
(declare-const $t@2266 $Ref)
(assert (= $t@2264 ($Snap.combine $t@2265 ($SortWrappers.$RefTo$Snap $t@2266))))
(declare-const $t@2267 $Snap)
(assert (= $t@2265 ($Snap.combine $t@2267 $Snap.unit)))
(declare-const $t@2268 $Snap)
(declare-const $t@2269 $Ref)
(assert (= $t@2267 ($Snap.combine $t@2268 ($SortWrappers.$RefTo$Snap $t@2269))))
(declare-const $t@2270 $Snap)
(assert (= $t@2268 ($Snap.combine $t@2270 $Snap.unit)))
(declare-const $t@2271 $Snap)
(declare-const $t@2272 $Ref)
(assert (= $t@2270 ($Snap.combine $t@2271 ($SortWrappers.$RefTo$Snap $t@2272))))
(declare-const $t@2273 $Snap)
(assert (= $t@2271 ($Snap.combine $t@2273 $Snap.unit)))
(declare-const $t@2274 $Snap)
(declare-const $t@2275 $Ref)
(assert (= $t@2273 ($Snap.combine $t@2274 ($SortWrappers.$RefTo$Snap $t@2275))))
(declare-const $t@2276 $Snap)
(assert (= $t@2274 ($Snap.combine $t@2276 $Snap.unit)))
(declare-const $t@2277 $Snap)
(declare-const $t@2278 $Ref)
(assert (= $t@2276 ($Snap.combine $t@2277 ($SortWrappers.$RefTo$Snap $t@2278))))
(declare-const $t@2279 $Snap)
(assert (= $t@2277 ($Snap.combine $t@2279 $Snap.unit)))
(declare-const $t@2280 $Ref)
(declare-const $t@2281 Int)
(assert (=
  $t@2279
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2280)
    ($SortWrappers.IntTo$Snap $t@2281))))
(declare-const $k@2282 $Perm)
(assert ($Perm.isValidVar $k@2282))
(assert ($Perm.isReadVar $k@2282 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2096 $k@2187)) (= $t@2280 $t@2095)))
(push) ; 4
(assert (not (not (= (+ (- $k@2096 $k@2187) $k@2282) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2096 $k@2187) $k@2282) $Perm.No)))
(assert (not (= $t@2280 $Ref.null)))
(declare-const $k@2283 $Perm)
(assert ($Perm.isValidVar $k@2283))
(assert ($Perm.isReadVar $k@2283 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2097 $k@2188)) (= $t@2281 $t@2094)))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2097 $k@2188) $k@2283) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2097 $k@2188) $k@2283) $Perm.No)))
(assert (> $t@2281 0))
(declare-const $k@2284 $Perm)
(assert ($Perm.isValidVar $k@2284))
(assert ($Perm.isReadVar $k@2284 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2098 $k@2189)) (= $t@2278 $t@2091)))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2098 $k@2189) $k@2284) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2098 $k@2189) $k@2284) $Perm.No)))
(assert (not (= $t@2278 $Ref.null)))
(declare-const $k@2285 $Perm)
(assert ($Perm.isValidVar $k@2285))
(assert ($Perm.isReadVar $k@2285 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2099 $k@2190)) (= $t@2275 $t@2088)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2099 $k@2190) $k@2285) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2099 $k@2190) $k@2285) $Perm.No)))
(assert (not (= $t@2275 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2286 $Perm)
(assert ($Perm.isValidVar $k@2286))
(assert ($Perm.isReadVar $k@2286 $Perm.Write))
(push) ; 4
(assert (not (= $t@1989 $t@2275)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2275)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2100 $k@2191)) (= $t@2272 $t@2085)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2275)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2275)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2156 $t@2275)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2020 $t@2275)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2275)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2275)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2100 $k@2191) $k@2286) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2100 $k@2191) $k@2286) $Perm.No)))
(assert (= $t@2272 $t@2280))
(declare-const $k@2287 $Perm)
(assert ($Perm.isValidVar $k@2287))
(assert ($Perm.isReadVar $k@2287 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2101 $k@2192)) (= $t@2269 $t@2082)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2101 $k@2192) $k@2287) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2101 $k@2192) $k@2287) $Perm.No)))
(assert (not (= $t@2269 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2288 $Perm)
(assert ($Perm.isValidVar $k@2288))
(assert ($Perm.isReadVar $k@2288 $Perm.Write))
(push) ; 4
(assert (not (= $t@1983 $t@2269)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2269)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2102 $k@2193)) (= $t@2266 $t@2079)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2280)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2280)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2269)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2269)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2150 $t@2269)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2014 $t@2269)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2269)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2269)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2102 $k@2193) $k@2288) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2102 $k@2193) $k@2288) $Perm.No)))
(assert (= $t@2266 $t@2280))
; [exec]
; PutWorker__joinOperator(t4)
; [eval] diz != null
(declare-const $t@2289 $Snap)
(declare-const $t@2290 $Snap)
(assert (= $t@2289 ($Snap.combine $t@2290 $Snap.unit)))
(declare-const $t@2291 $Snap)
(declare-const $t@2292 $Ref)
(assert (= $t@2290 ($Snap.combine $t@2291 ($SortWrappers.$RefTo$Snap $t@2292))))
(declare-const $t@2293 $Snap)
(assert (= $t@2291 ($Snap.combine $t@2293 $Snap.unit)))
(declare-const $t@2294 $Snap)
(declare-const $t@2295 $Ref)
(assert (= $t@2293 ($Snap.combine $t@2294 ($SortWrappers.$RefTo$Snap $t@2295))))
(declare-const $t@2296 $Snap)
(assert (= $t@2294 ($Snap.combine $t@2296 $Snap.unit)))
(declare-const $t@2297 $Snap)
(declare-const $t@2298 $Ref)
(assert (= $t@2296 ($Snap.combine $t@2297 ($SortWrappers.$RefTo$Snap $t@2298))))
(declare-const $t@2299 $Snap)
(assert (= $t@2297 ($Snap.combine $t@2299 $Snap.unit)))
(declare-const $t@2300 $Snap)
(declare-const $t@2301 $Ref)
(assert (= $t@2299 ($Snap.combine $t@2300 ($SortWrappers.$RefTo$Snap $t@2301))))
(declare-const $t@2302 $Snap)
(assert (= $t@2300 ($Snap.combine $t@2302 $Snap.unit)))
(declare-const $t@2303 $Snap)
(declare-const $t@2304 $Ref)
(assert (= $t@2302 ($Snap.combine $t@2303 ($SortWrappers.$RefTo$Snap $t@2304))))
(declare-const $t@2305 $Snap)
(assert (= $t@2303 ($Snap.combine $t@2305 $Snap.unit)))
(declare-const $t@2306 $Ref)
(declare-const $t@2307 Int)
(assert (=
  $t@2305
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2306)
    ($SortWrappers.IntTo$Snap $t@2307))))
(declare-const $k@2308 $Perm)
(assert ($Perm.isValidVar $k@2308))
(assert ($Perm.isReadVar $k@2308 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2130 $k@2195)) (= $t@2306 $t@2129)))
(push) ; 4
(assert (not (not (= (+ (- $k@2130 $k@2195) $k@2308) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2130 $k@2195) $k@2308) $Perm.No)))
(assert (not (= $t@2306 $Ref.null)))
(declare-const $k@2309 $Perm)
(assert ($Perm.isValidVar $k@2309))
(assert ($Perm.isReadVar $k@2309 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2131 $k@2196)) (= $t@2307 $t@2128)))
; [eval] diz.PutWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2131 $k@2196) $k@2309) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2131 $k@2196) $k@2309) $Perm.No)))
(assert (> $t@2307 0))
(declare-const $k@2310 $Perm)
(assert ($Perm.isValidVar $k@2310))
(assert ($Perm.isReadVar $k@2310 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2132 $k@2197)) (= $t@2304 $t@2125)))
; [eval] diz.PutWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2132 $k@2197) $k@2310) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2132 $k@2197) $k@2310) $Perm.No)))
(assert (not (= $t@2304 $Ref.null)))
(declare-const $k@2311 $Perm)
(assert ($Perm.isValidVar $k@2311))
(assert ($Perm.isReadVar $k@2311 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2133 $k@2198)) (= $t@2301 $t@2122)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2133 $k@2198) $k@2311) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2133 $k@2198) $k@2311) $Perm.No)))
(assert (not (= $t@2301 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2312 $Perm)
(assert ($Perm.isValidVar $k@2312))
(assert ($Perm.isReadVar $k@2312 $Perm.Write))
(push) ; 4
(assert (not (= $t@1989 $t@2301)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2301)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2134 $k@2199)) (= $t@2298 $t@2119)))
; [eval] diz.PutWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2301)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2156 $t@2301)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2020 $t@2301)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2301)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2301)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2301)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2134 $k@2199) $k@2312) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2134 $k@2199) $k@2312) $Perm.No)))
(assert (= $t@2298 $t@2306))
(declare-const $k@2313 $Perm)
(assert ($Perm.isValidVar $k@2313))
(assert ($Perm.isReadVar $k@2313 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2135 $k@2200)) (= $t@2295 $t@2116)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2135 $k@2200) $k@2313) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2135 $k@2200) $k@2313) $Perm.No)))
(assert (not (= $t@2295 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2314 $Perm)
(assert ($Perm.isValidVar $k@2314))
(assert ($Perm.isReadVar $k@2314 $Perm.Write))
(push) ; 4
(assert (not (= $t@1983 $t@2295)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2295)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2136 $k@2201)) (= $t@2292 $t@2113)))
; [eval] diz.PutWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.PutWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2306)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2306)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2295)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2150 $t@2295)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2014 $t@2295)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2295)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2295)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2295)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2136 $k@2201) $k@2314) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2136 $k@2201) $k@2314) $Perm.No)))
(assert (= $t@2292 $t@2306))
; [exec]
; TakeWorker__joinOperator(t5)
; [eval] diz != null
(declare-const $t@2315 $Snap)
(declare-const $t@2316 $Snap)
(assert (= $t@2315 ($Snap.combine $t@2316 $Snap.unit)))
(declare-const $t@2317 $Snap)
(declare-const $t@2318 $Ref)
(assert (= $t@2316 ($Snap.combine $t@2317 ($SortWrappers.$RefTo$Snap $t@2318))))
(declare-const $t@2319 $Snap)
(assert (= $t@2317 ($Snap.combine $t@2319 $Snap.unit)))
(declare-const $t@2320 $Snap)
(declare-const $t@2321 $Ref)
(assert (= $t@2319 ($Snap.combine $t@2320 ($SortWrappers.$RefTo$Snap $t@2321))))
(declare-const $t@2322 $Snap)
(assert (= $t@2320 ($Snap.combine $t@2322 $Snap.unit)))
(declare-const $t@2323 $Snap)
(declare-const $t@2324 $Ref)
(assert (= $t@2322 ($Snap.combine $t@2323 ($SortWrappers.$RefTo$Snap $t@2324))))
(declare-const $t@2325 $Snap)
(assert (= $t@2323 ($Snap.combine $t@2325 $Snap.unit)))
(declare-const $t@2326 $Snap)
(declare-const $t@2327 $Ref)
(assert (= $t@2325 ($Snap.combine $t@2326 ($SortWrappers.$RefTo$Snap $t@2327))))
(declare-const $t@2328 $Snap)
(assert (= $t@2326 ($Snap.combine $t@2328 $Snap.unit)))
(declare-const $t@2329 $Snap)
(declare-const $t@2330 $Ref)
(assert (= $t@2328 ($Snap.combine $t@2329 ($SortWrappers.$RefTo$Snap $t@2330))))
(declare-const $t@2331 $Snap)
(assert (= $t@2329 ($Snap.combine $t@2331 $Snap.unit)))
(declare-const $t@2332 $Ref)
(declare-const $t@2333 Int)
(assert (=
  $t@2331
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2332)
    ($SortWrappers.IntTo$Snap $t@2333))))
(declare-const $k@2334 $Perm)
(assert ($Perm.isValidVar $k@2334))
(assert ($Perm.isReadVar $k@2334 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2164 $k@2203)) (= $t@2332 $t@2163)))
(push) ; 4
(assert (not (not (= (+ (- $k@2164 $k@2203) $k@2334) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2164 $k@2203) $k@2334) $Perm.No)))
(assert (not (= $t@2332 $Ref.null)))
(declare-const $k@2335 $Perm)
(assert ($Perm.isValidVar $k@2335))
(assert ($Perm.isReadVar $k@2335 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2165 $k@2204)) (= $t@2333 $t@2162)))
; [eval] diz.TakeWorker__queue.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2165 $k@2204) $k@2335) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2165 $k@2204) $k@2335) $Perm.No)))
(assert (> $t@2333 0))
(declare-const $k@2336 $Perm)
(assert ($Perm.isValidVar $k@2336))
(assert ($Perm.isReadVar $k@2336 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2166 $k@2205)) (= $t@2330 $t@2159)))
; [eval] diz.TakeWorker__queue.BlockingQueue__count != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2166 $k@2205) $k@2336) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2166 $k@2205) $k@2336) $Perm.No)))
(assert (not (= $t@2330 $Ref.null)))
(declare-const $k@2337 $Perm)
(assert ($Perm.isValidVar $k@2337))
(assert ($Perm.isReadVar $k@2337 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2167 $k@2206)) (= $t@2327 $t@2156)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2167 $k@2206) $k@2337) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2167 $k@2206) $k@2337) $Perm.No)))
(assert (not (= $t@2327 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2338 $Perm)
(assert ($Perm.isValidVar $k@2338))
(assert ($Perm.isReadVar $k@2338 $Perm.Write))
(push) ; 4
(assert (not (= $t@1989 $t@2327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2156 $t@2327)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2168 $k@2207)) (= $t@2324 $t@2153)))
; [eval] diz.TakeWorker__queue.BlockingQueue__headLock.HeadLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1989 $t@2327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2020 $t@2327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2054 $t@2327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2088 $t@2327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2122 $t@2327)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2156 $t@2327)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2168 $k@2207) $k@2338) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2168 $k@2207) $k@2338) $Perm.No)))
(assert (= $t@2324 $t@2332))
(declare-const $k@2339 $Perm)
(assert ($Perm.isValidVar $k@2339))
(assert ($Perm.isReadVar $k@2339 $Perm.Write))
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2169 $k@2208)) (= $t@2321 $t@2150)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2169 $k@2208) $k@2339) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2169 $k@2208) $k@2339) $Perm.No)))
(assert (not (= $t@2321 $Ref.null)))
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(declare-const $k@2340 $Perm)
(assert ($Perm.isValidVar $k@2340))
(assert ($Perm.isReadVar $k@2340 $Perm.Write))
(push) ; 4
(assert (not (= $t@1983 $t@2321)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2150 $t@2321)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (implies (< $Perm.No (- $k@2170 $k@2209)) (= $t@2318 $t@2147)))
; [eval] diz.TakeWorker__queue.BlockingQueue__lastLock.LastLock__queue == diz.TakeWorker__queue
(push) ; 4
(assert (not (= sys__result@1975 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2027 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2061 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2095 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2129 $t@2332)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2163 $t@2332)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@1983 $t@2321)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2014 $t@2321)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2048 $t@2321)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2082 $t@2321)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2116 $t@2321)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= $t@2150 $t@2321)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (+ (- $k@2170 $k@2209) $k@2340) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ (- $k@2170 $k@2209) $k@2340) $Perm.No)))
(assert (= $t@2318 $t@2332))
(pop) ; 3
(pop) ; 2
; ---------- Test__Test ----------
(declare-const sys__result@2341 $Ref)
(declare-const diz@2342 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@2341 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new()
(declare-const diz@2343 $Ref)
(assert (not (= diz@2343 $Ref.null)))
(assert (not (= sys__result@2341 diz@2343)))
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- Node__Node ----------
(declare-const val@2344 $Ref)
(declare-const sys__result@2345 $Ref)
(declare-const diz@2346 $Ref)
(declare-const __flatten_78@2347 $Ref)
(declare-const __flatten_200@2348 $Ref)
(push) ; 2
; [eval] val != null
(push) ; 3
(assert (not (= val@2344 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= val@2344 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 1] val@2344 != Null
(assert (not (= val@2344 $Ref.null)))
(declare-const $k@2349 $Perm)
(assert ($Perm.isValidVar $k@2349))
(assert ($Perm.isReadVar $k@2349 $Perm.Write))
(declare-const $t@2350 Int)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2345 $Ref.null)))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@2351 $Ref)
(assert (not (= diz@2351 $Ref.null)))
(declare-const Node__next@2352 $Ref)
(declare-const Node__val@2353 $Ref)
(assert (and
  (not (= val@2344 diz@2351))
  (not (= sys__result@2345 diz@2351))
  (not (= __flatten_78@2347 diz@2351))
  (not (= __flatten_200@2348 diz@2351))
  (not (= Node__next@2352 diz@2351))
  (not (= Node__val@2353 diz@2351))))
; [exec]
; __flatten_78 := val
; [exec]
; __flatten_200 := __flatten_78
; [exec]
; diz.Node__val := __flatten_200
; [exec]
; diz.Node__next := null
; [exec]
; exhale acc(diz.Node__val, write) && ((diz.Node__val != null) ==> acc(diz.Node__val.Integer__val, wildcard)) && acc(diz.Node__next, write)
; [eval] diz.Node__val != null
(push) ; 5
(assert (not (= val@2344 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 2] val@2344 != Null
(declare-const $k@2354 $Perm)
(assert ($Perm.isValidVar $k@2354))
(assert ($Perm.isReadVar $k@2354 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2354 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2349 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2349 $Perm.No)))
(assert (< $k@2354 $k@2349))
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 2] val@2344 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 1] val@2344 == Null
(assert (= val@2344 $Ref.null))
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2345 $Ref.null)))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@2355 $Ref)
(assert (not (= diz@2355 $Ref.null)))
(declare-const Node__next@2356 $Ref)
(declare-const Node__val@2357 $Ref)
(assert (and
  (not (= val@2344 diz@2355))
  (not (= sys__result@2345 diz@2355))
  (not (= __flatten_78@2347 diz@2355))
  (not (= __flatten_200@2348 diz@2355))
  (not (= Node__next@2356 diz@2355))
  (not (= Node__val@2357 diz@2355))))
; [exec]
; __flatten_78 := val
; [exec]
; __flatten_200 := __flatten_78
; [exec]
; diz.Node__val := __flatten_200
; [exec]
; diz.Node__next := null
; [exec]
; exhale acc(diz.Node__val, write) && ((diz.Node__val != null) ==> acc(diz.Node__val.Integer__val, wildcard)) && acc(diz.Node__next, write)
; [eval] diz.Node__val != null
(push) ; 5
(assert (not (not (= val@2344 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 3] val@2344 != Null
(push) ; 5
; [else-branch 3] val@2344 == Null
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
; ---------- HeadLock__HeadLock ----------
(declare-const queue@2358 $Ref)
(declare-const sys__result@2359 $Ref)
(declare-const diz@2360 $Ref)
(declare-const __flatten_79@2361 $Ref)
(declare-const __flatten_201@2362 $Ref)
(push) ; 2
(assert (not (= queue@2358 $Ref.null)))
(declare-const $t@2363 $Ref)
; [eval] queue.BlockingQueue__head != null
(assert (not (= $t@2363 $Ref.null)))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@2359 $Ref.null)))
(declare-const $k@2364 $Perm)
(assert ($Perm.isValidVar $k@2364))
(assert ($Perm.isReadVar $k@2364 $Perm.Write))
(declare-const $t@2365 $Ref)
; [eval] sys__result.HeadLock__queue == queue
(push) ; 4
(assert (not (not (= $k@2364 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2364 $Perm.No)))
(assert (= $t@2365 queue@2358))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(HeadLock__queue)
(declare-const diz@2366 $Ref)
(assert (not (= diz@2366 $Ref.null)))
(declare-const HeadLock__queue@2367 $Ref)
(assert (and
  (not (= queue@2358 diz@2366))
  (not (= sys__result@2359 diz@2366))
  (not (= __flatten_79@2361 diz@2366))
  (not (= __flatten_201@2362 diz@2366))
  (not (= HeadLock__queue@2367 diz@2366))
  (not (= $t@2363 diz@2366))))
; [exec]
; __flatten_79 := queue
; [exec]
; __flatten_201 := __flatten_79
; [exec]
; diz.HeadLock__queue := __flatten_201
; [exec]
; exhale acc(diz.HeadLock__queue, wildcard) && acc(diz.HeadLock__queue.BlockingQueue__head, write) && (diz.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2368 $Perm)
(assert ($Perm.isValidVar $k@2368))
(assert ($Perm.isReadVar $k@2368 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2368 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2368 $Perm.Write))
; [eval] diz.HeadLock__queue.BlockingQueue__head != null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.HeadLock__queue, wildcard) && (sys__result.HeadLock__queue == queue)
; [eval] sys__result != null
(declare-const $k@2369 $Perm)
(assert ($Perm.isValidVar $k@2369))
(assert ($Perm.isReadVar $k@2369 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2369 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $Perm.Write $k@2368) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $Perm.Write $k@2368) $Perm.No)))
(assert (< $k@2369 (- $Perm.Write $k@2368)))
; [eval] sys__result.HeadLock__queue == queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LastLock__LastLock ----------
(declare-const queue@2370 $Ref)
(declare-const sys__result@2371 $Ref)
(declare-const diz@2372 $Ref)
(declare-const __flatten_80@2373 $Ref)
(declare-const __flatten_202@2374 $Ref)
(push) ; 2
(assert (not (= queue@2370 $Ref.null)))
(declare-const $t@2375 $Ref)
; [eval] queue.BlockingQueue__last != null
(assert (not (= $t@2375 $Ref.null)))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@2371 $Ref.null)))
(declare-const $k@2376 $Perm)
(assert ($Perm.isValidVar $k@2376))
(assert ($Perm.isReadVar $k@2376 $Perm.Write))
(declare-const $t@2377 $Ref)
; [eval] sys__result.LastLock__queue == queue
(push) ; 4
(assert (not (not (= $k@2376 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2376 $Perm.No)))
(assert (= $t@2377 queue@2370))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LastLock__queue)
(declare-const diz@2378 $Ref)
(assert (not (= diz@2378 $Ref.null)))
(declare-const LastLock__queue@2379 $Ref)
(assert (and
  (not (= queue@2370 diz@2378))
  (not (= sys__result@2371 diz@2378))
  (not (= __flatten_80@2373 diz@2378))
  (not (= __flatten_202@2374 diz@2378))
  (not (= LastLock__queue@2379 diz@2378))
  (not (= $t@2375 diz@2378))))
; [exec]
; __flatten_80 := queue
; [exec]
; __flatten_202 := __flatten_80
; [exec]
; diz.LastLock__queue := __flatten_202
; [exec]
; exhale acc(diz.LastLock__queue, wildcard) && acc(diz.LastLock__queue.BlockingQueue__last, write) && (diz.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2380 $Perm)
(assert ($Perm.isValidVar $k@2380))
(assert ($Perm.isReadVar $k@2380 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2380 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@2380 $Perm.Write))
; [eval] diz.LastLock__queue.BlockingQueue__last != null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LastLock__queue, wildcard) && (sys__result.LastLock__queue == queue)
; [eval] sys__result != null
(declare-const $k@2381 $Perm)
(assert ($Perm.isValidVar $k@2381))
(assert ($Perm.isReadVar $k@2381 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@2381 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= (- $Perm.Write $k@2380) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (- $Perm.Write $k@2380) $Perm.No)))
(assert (< $k@2381 (- $Perm.Write $k@2380)))
; [eval] sys__result.LastLock__queue == queue
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__BlockingQueue ----------
(declare-const capacity@2382 Int)
(declare-const sys__result@2383 $Ref)
(declare-const diz@2384 $Ref)
(declare-const __flatten_81@2385 Int)
(declare-const __flatten_82@2386 $Ref)
(declare-const __flatten_83@2387 $Ref)
(declare-const __flatten_84@2388 $Ref)
(declare-const __flatten_85@2389 $Ref)
(declare-const __flatten_86@2390 $Ref)
(declare-const __flatten_87@2391 $Ref)
(declare-const __flatten_88@2392 $Ref)
(declare-const __flatten_89@2393 $Ref)
(declare-const __flatten_90@2394 $Ref)
(declare-const __flatten_203@2395 Int)
(declare-const __flatten_205@2396 $Ref)
(declare-const __flatten_207@2397 $Ref)
(declare-const __flatten_208@2398 $Ref)
(declare-const __flatten_210@2399 $Ref)
(declare-const __flatten_212@2400 $Ref)
(push) ; 2
; [eval] capacity > 0
(assert (> capacity@2382 0))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@2383 $Ref.null)))
(declare-const $k@2401 $Perm)
(assert ($Perm.isValidVar $k@2401))
(assert ($Perm.isReadVar $k@2401 $Perm.Write))
(declare-const $t@2402 Int)
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2401 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2401 $Perm.No)))
(assert (> $t@2402 0))
(declare-const $k@2403 $Perm)
(assert ($Perm.isValidVar $k@2403))
(assert ($Perm.isReadVar $k@2403 $Perm.Write))
(declare-const $t@2404 $Ref)
; [eval] sys__result.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2403 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2403 $Perm.No)))
(assert (not (= $t@2404 $Ref.null)))
(declare-const $k@2405 $Perm)
(assert ($Perm.isValidVar $k@2405))
(assert ($Perm.isReadVar $k@2405 $Perm.Write))
(declare-const $t@2406 $Ref)
; [eval] sys__result.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2405 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2405 $Perm.No)))
(assert (not (= $t@2406 $Ref.null)))
(declare-const $k@2407 $Perm)
(assert ($Perm.isValidVar $k@2407))
(assert ($Perm.isReadVar $k@2407 $Perm.Write))
(declare-const $t@2408 $Ref)
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@2407 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2407 $Perm.No)))
(assert (= $t@2408 sys__result@2383))
(declare-const $k@2409 $Perm)
(assert ($Perm.isValidVar $k@2409))
(assert ($Perm.isReadVar $k@2409 $Perm.Write))
(declare-const $t@2410 $Ref)
; [eval] sys__result.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2409 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2409 $Perm.No)))
(assert (not (= $t@2410 $Ref.null)))
(declare-const $k@2411 $Perm)
(assert ($Perm.isValidVar $k@2411))
(assert ($Perm.isReadVar $k@2411 $Perm.Write))
(declare-const $t@2412 $Ref)
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
(push) ; 4
(assert (not (not (= $k@2411 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2411 $Perm.No)))
(assert (= $t@2412 sys__result@2383))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@2402 capacity@2382))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(BlockingQueue__capacity, BlockingQueue__count, BlockingQueue__head, BlockingQueue__last, BlockingQueue__headLock, BlockingQueue__lastLock)
(declare-const diz@2413 $Ref)
(assert (not (= diz@2413 $Ref.null)))
(declare-const BlockingQueue__capacity@2414 Int)
(declare-const BlockingQueue__count@2415 $Ref)
(declare-const BlockingQueue__head@2416 $Ref)
(declare-const BlockingQueue__last@2417 $Ref)
(declare-const BlockingQueue__headLock@2418 $Ref)
(declare-const BlockingQueue__lastLock@2419 $Ref)
(assert (and
  (not (= sys__result@2383 diz@2413))
  (not (= __flatten_82@2386 diz@2413))
  (not (= __flatten_83@2387 diz@2413))
  (not (= __flatten_84@2388 diz@2413))
  (not (= __flatten_85@2389 diz@2413))
  (not (= __flatten_86@2390 diz@2413))
  (not (= __flatten_87@2391 diz@2413))
  (not (= __flatten_88@2392 diz@2413))
  (not (= __flatten_89@2393 diz@2413))
  (not (= __flatten_90@2394 diz@2413))
  (not (= __flatten_205@2396 diz@2413))
  (not (= __flatten_207@2397 diz@2413))
  (not (= __flatten_208@2398 diz@2413))
  (not (= __flatten_210@2399 diz@2413))
  (not (= __flatten_212@2400 diz@2413))
  (not (= BlockingQueue__count@2415 diz@2413))
  (not (= BlockingQueue__head@2416 diz@2413))
  (not (= BlockingQueue__last@2417 diz@2413))
  (not (= BlockingQueue__headLock@2418 diz@2413))
  (not (= BlockingQueue__lastLock@2419 diz@2413))))
; [exec]
; __flatten_81 := capacity
; [exec]
; __flatten_203 := __flatten_81
; [exec]
; diz.BlockingQueue__capacity := __flatten_203
; [exec]
; __flatten_83 := AtomicInteger__AtomicInteger(0)
(declare-const sys__result@2420 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@2420 $Ref.null)))
; [exec]
; __flatten_82 := __flatten_83
; [exec]
; __flatten_205 := __flatten_82
; [exec]
; diz.BlockingQueue__count := __flatten_205
; [exec]
; __flatten_85 := Node__Node(null)
; [eval] val != null
(push) ; 4
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 4] False
(push) ; 4
; [else-branch 4] True
(declare-const sys__result@2421 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@2421 $Ref.null)))
; [exec]
; __flatten_84 := __flatten_85
; [exec]
; __flatten_207 := __flatten_84
; [exec]
; diz.BlockingQueue__head := __flatten_207
; [exec]
; __flatten_86 := diz.BlockingQueue__head
; [exec]
; __flatten_208 := __flatten_86
; [exec]
; diz.BlockingQueue__last := __flatten_208
; [exec]
; __flatten_88 := HeadLock__HeadLock(diz)
; [eval] queue.BlockingQueue__head != null
(declare-const sys__result@2422 $Ref)
(declare-const $t@2423 $Snap)
(declare-const $t@2424 $Ref)
(assert (= $t@2423 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2424) $Snap.unit)))
(declare-const $t@2425 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2424)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2425))))
; [eval] sys__result != null
(assert (not (= sys__result@2422 $Ref.null)))
(declare-const $k@2426 $Perm)
(assert ($Perm.isValidVar $k@2426))
(assert ($Perm.isReadVar $k@2426 $Perm.Write))
; [eval] sys__result.HeadLock__queue == queue
(push) ; 5
(assert (not (not (= $k@2426 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2426 $Perm.No)))
(assert (= $t@2425 diz@2413))
; [exec]
; __flatten_87 := __flatten_88
; [exec]
; __flatten_210 := __flatten_87
; [exec]
; diz.BlockingQueue__headLock := __flatten_210
; [exec]
; __flatten_90 := LastLock__LastLock(diz)
; [eval] queue.BlockingQueue__last != null
(declare-const sys__result@2427 $Ref)
(declare-const $t@2428 $Snap)
(declare-const $t@2429 $Ref)
(assert (= $t@2428 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2429) $Snap.unit)))
(declare-const $t@2430 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2429)
  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@2430))))
; [eval] sys__result != null
(assert (not (= sys__result@2427 $Ref.null)))
(declare-const $k@2431 $Perm)
(assert ($Perm.isValidVar $k@2431))
(assert ($Perm.isReadVar $k@2431 $Perm.Write))
; [eval] sys__result.LastLock__queue == queue
(push) ; 5
(assert (not (not (= $k@2431 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2431 $Perm.No)))
(assert (= $t@2430 diz@2413))
; [exec]
; __flatten_89 := __flatten_90
; [exec]
; __flatten_212 := __flatten_89
; [exec]
; diz.BlockingQueue__lastLock := __flatten_212
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.BlockingQueue__capacity, wildcard) && (sys__result.BlockingQueue__capacity > 0) && acc(sys__result.BlockingQueue__count, wildcard) && (sys__result.BlockingQueue__count != null) && acc(sys__result.BlockingQueue__headLock, wildcard) && (sys__result.BlockingQueue__headLock != null) && acc(sys__result.BlockingQueue__headLock.HeadLock__queue, wildcard) && (sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result) && acc(sys__result.BlockingQueue__lastLock, wildcard) && (sys__result.BlockingQueue__lastLock != null) && acc(sys__result.BlockingQueue__lastLock.LastLock__queue, wildcard) && (sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result) && (sys__result.BlockingQueue__capacity == capacity)
; [eval] sys__result != null
(declare-const $k@2432 $Perm)
(assert ($Perm.isValidVar $k@2432))
(assert ($Perm.isReadVar $k@2432 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2432 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2432 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(declare-const $k@2433 $Perm)
(assert ($Perm.isValidVar $k@2433))
(assert ($Perm.isReadVar $k@2433 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2433 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2433 $Perm.Write))
; [eval] sys__result.BlockingQueue__count != null
(declare-const $k@2434 $Perm)
(assert ($Perm.isValidVar $k@2434))
(assert ($Perm.isReadVar $k@2434 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2434 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2434 $Perm.Write))
; [eval] sys__result.BlockingQueue__headLock != null
(declare-const $k@2435 $Perm)
(assert ($Perm.isValidVar $k@2435))
(assert ($Perm.isReadVar $k@2435 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2435 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2435 $k@2426))
; [eval] sys__result.BlockingQueue__headLock.HeadLock__queue == sys__result
(declare-const $k@2436 $Perm)
(assert ($Perm.isValidVar $k@2436))
(assert ($Perm.isReadVar $k@2436 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2436 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2436 $Perm.Write))
; [eval] sys__result.BlockingQueue__lastLock != null
(declare-const $k@2437 $Perm)
(assert ($Perm.isValidVar $k@2437))
(assert ($Perm.isReadVar $k@2437 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2437 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2437 $k@2431))
; [eval] sys__result.BlockingQueue__lastLock.LastLock__queue == sys__result
; [eval] sys__result.BlockingQueue__capacity == capacity
; [exec]
; inhale false
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__take ----------
(declare-const diz@2438 $Ref)
(declare-const sys__result@2439 Int)
(declare-const currentCount@2440 Int)
(declare-const __flatten_91@2441 Int)
(declare-const __flatten_92@2442 Int)
(declare-const x@2443 Int)
(declare-const __flatten_93@2444 Int)
(declare-const c@2445 Int)
(declare-const __flatten_94@2446 Int)
(declare-const __flatten_95@2447 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2438 $Ref.null)))
(declare-const $k@2448 $Perm)
(assert ($Perm.isValidVar $k@2448))
(assert ($Perm.isReadVar $k@2448 $Perm.Write))
(declare-const $t@2449 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2448 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2448 $Perm.No)))
(assert (> $t@2449 0))
(declare-const $k@2450 $Perm)
(assert ($Perm.isValidVar $k@2450))
(assert ($Perm.isReadVar $k@2450 $Perm.Write))
(declare-const $t@2451 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@2450 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2450 $Perm.No)))
(assert (not (= $t@2451 $Ref.null)))
(declare-const $k@2452 $Perm)
(assert ($Perm.isValidVar $k@2452))
(assert ($Perm.isReadVar $k@2452 $Perm.Write))
(declare-const $t@2453 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@2452 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2452 $Perm.No)))
(assert (not (= $t@2453 $Ref.null)))
(declare-const $k@2454 $Perm)
(assert ($Perm.isValidVar $k@2454))
(assert ($Perm.isReadVar $k@2454 $Perm.Write))
(declare-const $t@2455 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2454 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2454 $Perm.No)))
(assert (= $t@2455 diz@2438))
(declare-const $k@2456 $Perm)
(assert ($Perm.isValidVar $k@2456))
(assert ($Perm.isReadVar $k@2456 $Perm.Write))
(declare-const $t@2457 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@2456 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2456 $Perm.No)))
(assert (not (= $t@2457 $Ref.null)))
(declare-const $k@2458 $Perm)
(assert ($Perm.isValidVar $k@2458))
(assert ($Perm.isReadVar $k@2458 $Perm.Write))
(declare-const $t@2459 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2458 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2458 $Perm.No)))
(assert (= $t@2459 diz@2438))
(push) ; 3
(declare-const $k@2460 $Perm)
(assert ($Perm.isValidVar $k@2460))
(assert ($Perm.isReadVar $k@2460 $Perm.Write))
(declare-const $t@2461 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2460 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2460 $Perm.No)))
(assert (> $t@2461 0))
(declare-const $k@2462 $Perm)
(assert ($Perm.isValidVar $k@2462))
(assert ($Perm.isReadVar $k@2462 $Perm.Write))
(declare-const $t@2463 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2462 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2462 $Perm.No)))
(assert (not (= $t@2463 $Ref.null)))
(declare-const $k@2464 $Perm)
(assert ($Perm.isValidVar $k@2464))
(assert ($Perm.isReadVar $k@2464 $Perm.Write))
(declare-const $t@2465 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2464 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2464 $Perm.No)))
(assert (not (= $t@2465 $Ref.null)))
(declare-const $k@2466 $Perm)
(assert ($Perm.isValidVar $k@2466))
(assert ($Perm.isReadVar $k@2466 $Perm.Write))
(declare-const $t@2467 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2466 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2466 $Perm.No)))
(assert (= $t@2467 diz@2438))
(declare-const $k@2468 $Perm)
(assert ($Perm.isValidVar $k@2468))
(assert ($Perm.isReadVar $k@2468 $Perm.Write))
(declare-const $t@2469 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2468 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2468 $Perm.No)))
(assert (not (= $t@2469 $Ref.null)))
(declare-const $k@2470 $Perm)
(assert ($Perm.isValidVar $k@2470))
(assert ($Perm.isReadVar $k@2470 $Perm.Write))
(declare-const $t@2471 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2470 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2470 $Perm.No)))
(assert (= $t@2471 diz@2438))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2472 $Snap)
(declare-const $t@2473 $Snap)
(assert (= $t@2472 ($Snap.combine $t@2473 $Snap.unit)))
(declare-const $t@2474 $Ref)
(declare-const $t@2475 $Ref)
(assert (=
  $t@2473
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2474)
    ($SortWrappers.$RefTo$Snap $t@2475))))
(declare-const $k@2476 $Perm)
(assert ($Perm.isValidVar $k@2476))
(assert ($Perm.isReadVar $k@2476 $Perm.Write))
(assert (= $t@2455 $t@2474))
(push) ; 4
(assert (not (not (= (+ $k@2454 $k@2476) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ $k@2454 $k@2476) $Perm.No)))
(assert (not (= $t@2455 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@2475 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@2477 $Snap)
; [exec]
; __flatten_91 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2478 Int)
; [exec]
; currentCount := __flatten_91
; loop at <no position>
(declare-const currentCount@2479 Int)
(declare-const __flatten_92@2480 Int)
(push) ; 4
; Verify loop body
(declare-const $t@2481 $Snap)
(declare-const $t@2482 $Snap)
(assert (= $t@2481 ($Snap.combine $t@2482 $Snap.unit)))
(declare-const $t@2483 $Snap)
(assert (= $t@2482 ($Snap.combine $t@2483 $Snap.unit)))
(declare-const $t@2484 $Snap)
(assert (= $t@2483 ($Snap.combine $t@2484 $Snap.unit)))
(declare-const $t@2485 $Snap)
(declare-const $t@2486 $Ref)
(assert (= $t@2484 ($Snap.combine $t@2485 ($SortWrappers.$RefTo$Snap $t@2486))))
(declare-const $t@2487 $Snap)
(assert (= $t@2485 ($Snap.combine $t@2487 $Snap.unit)))
(declare-const $t@2488 $Snap)
(declare-const $t@2489 $Ref)
(assert (= $t@2487 ($Snap.combine $t@2488 ($SortWrappers.$RefTo$Snap $t@2489))))
(declare-const $t@2490 $Snap)
(assert (= $t@2488 ($Snap.combine $t@2490 $Snap.unit)))
(declare-const $t@2491 $Snap)
(declare-const $t@2492 $Ref)
(assert (= $t@2490 ($Snap.combine $t@2491 ($SortWrappers.$RefTo$Snap $t@2492))))
(declare-const $t@2493 $Ref)
(declare-const $t@2494 $Snap)
(assert (= $t@2491 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2493) $t@2494)))
(declare-const $t@2495 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2493)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2495) $Snap.unit)))
(declare-const $k@2496 $Perm)
(assert ($Perm.isValidVar $k@2496))
(assert ($Perm.isReadVar $k@2496 $Perm.Write))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= $k@2496 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2496 $Perm.No)))
(assert (not (= $t@2495 $Ref.null)))
(declare-const $k@2497 $Perm)
(assert ($Perm.isValidVar $k@2497))
(assert ($Perm.isReadVar $k@2497 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= $k@2497 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2497 $Perm.No)))
(assert (not (= $t@2492 $Ref.null)))
(declare-const $k@2498 $Perm)
(assert ($Perm.isValidVar $k@2498))
(assert ($Perm.isReadVar $k@2498 $Perm.Write))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (not (= $k@2498 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2498 $Perm.No)))
(assert (= $t@2489 diz@2438))
(assert (not (= $t@2489 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@2486 $Ref.null)))
; [eval] currentCount == 0
(assert (= currentCount@2479 0))
(check-sat)
; unknown
; [exec]
; assert acc(diz.BlockingQueue__headLock, wildcard)
(declare-const $k@2499 $Perm)
(assert ($Perm.isValidVar $k@2499))
(assert ($Perm.isReadVar $k@2499 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2499 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2499 $k@2496))
; [exec]
; assert diz.BlockingQueue__headLock != null
; [eval] diz.BlockingQueue__headLock != null
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2500 $Perm)
(assert ($Perm.isValidVar $k@2500))
(assert ($Perm.isReadVar $k@2500 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2500 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2500 $k@2498))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2501 $Snap)
(declare-const $t@2502 $Snap)
(assert (= $t@2501 ($Snap.combine $t@2502 $Snap.unit)))
(declare-const $t@2503 $Ref)
(declare-const $t@2504 $Ref)
(assert (=
  $t@2502
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2503)
    ($SortWrappers.$RefTo$Snap $t@2504))))
(declare-const $k@2505 $Perm)
(assert ($Perm.isValidVar $k@2505))
(assert ($Perm.isReadVar $k@2505 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2498 $k@2500)) (= $t@2503 $t@2489)))
(push) ; 5
(assert (not (not (= (+ (- $k@2498 $k@2500) $k@2505) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2498 $k@2500) $k@2505) $Perm.No)))
(assert (not (= $t@2503 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@2504 $Ref.null)))
; [exec]
; __flatten_92 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2506 Int)
; [exec]
; currentCount := __flatten_92
(declare-const $k@2507 $Perm)
(assert ($Perm.isValidVar $k@2507))
(assert ($Perm.isReadVar $k@2507 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2507 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2507 $k@2496))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2508 $Perm)
(assert ($Perm.isValidVar $k@2508))
(assert ($Perm.isReadVar $k@2508 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2508 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2508 $k@2497))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2509 $Perm)
(assert ($Perm.isValidVar $k@2509))
(assert ($Perm.isReadVar $k@2509 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2509 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2509 (+ (- $k@2498 $k@2500) $k@2505)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@2503 diz@2438)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (= $t@2503 diz@2438))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
; [eval] diz.BlockingQueue__head != null
(pop) ; 4
(push) ; 4
; Establish loop invariant
(declare-const $k@2510 $Perm)
(assert ($Perm.isValidVar $k@2510))
(assert ($Perm.isReadVar $k@2510 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2510 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2510 $k@2452))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2511 $Perm)
(assert ($Perm.isValidVar $k@2511))
(assert ($Perm.isReadVar $k@2511 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2511 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2511 $k@2450))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2512 $Perm)
(assert ($Perm.isValidVar $k@2512))
(assert ($Perm.isReadVar $k@2512 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2512 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2512 (+ $k@2454 $k@2476)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
; [eval] diz.BlockingQueue__head != null
; Continue after loop
(declare-const $t@2513 $Snap)
(declare-const $t@2514 $Snap)
(assert (= $t@2513 ($Snap.combine $t@2514 $Snap.unit)))
(declare-const $t@2515 $Snap)
(assert (= $t@2514 ($Snap.combine $t@2515 $Snap.unit)))
(declare-const $t@2516 $Snap)
(assert (= $t@2515 ($Snap.combine $t@2516 $Snap.unit)))
(declare-const $t@2517 $Snap)
(declare-const $t@2518 $Ref)
(assert (= $t@2516 ($Snap.combine $t@2517 ($SortWrappers.$RefTo$Snap $t@2518))))
(declare-const $t@2519 $Snap)
(assert (= $t@2517 ($Snap.combine $t@2519 $Snap.unit)))
(declare-const $t@2520 $Snap)
(declare-const $t@2521 $Ref)
(assert (= $t@2519 ($Snap.combine $t@2520 ($SortWrappers.$RefTo$Snap $t@2521))))
(declare-const $t@2522 $Snap)
(assert (= $t@2520 ($Snap.combine $t@2522 $Snap.unit)))
(declare-const $t@2523 $Snap)
(declare-const $t@2524 $Ref)
(assert (= $t@2522 ($Snap.combine $t@2523 ($SortWrappers.$RefTo$Snap $t@2524))))
(declare-const $t@2525 $Ref)
(declare-const $t@2526 $Snap)
(assert (= $t@2523 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2525) $t@2526)))
(declare-const $t@2527 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2525)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2527) $Snap.unit)))
(declare-const $k@2528 $Perm)
(assert ($Perm.isValidVar $k@2528))
(assert ($Perm.isReadVar $k@2528 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2452 $k@2510)) (= $t@2527 $t@2453)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@2452 $k@2510) $k@2528) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2452 $k@2510) $k@2528) $Perm.No)))
(assert (not (= $t@2527 $Ref.null)))
(declare-const $k@2529 $Perm)
(assert ($Perm.isValidVar $k@2529))
(assert ($Perm.isReadVar $k@2529 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2450 $k@2511)) (= $t@2524 $t@2451)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- $k@2450 $k@2511) $k@2529) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2450 $k@2511) $k@2529) $Perm.No)))
(assert (not (= $t@2524 $Ref.null)))
(declare-const $k@2530 $Perm)
(assert ($Perm.isValidVar $k@2530))
(assert ($Perm.isReadVar $k@2530 $Perm.Write))
(push) ; 5
(assert (not (= $t@2453 $t@2527)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- (+ $k@2454 $k@2476) $k@2512)) (= $t@2521 $t@2455)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@2453 $t@2527)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $Perm.No)))
(assert (= $t@2521 diz@2438))
(push) ; 5
(assert (not (= $t@2453 $t@2527)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $t@2521 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head == diz.BlockingQueue__head
(push) ; 5
(assert (not (= $t@2453 $t@2527)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@2518 $Ref.null)))
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(assert (not (= currentCount@2479 0)))
(check-sat)
; unknown
; [exec]
; inhale diz.BlockingQueue__head != null
; [eval] diz.BlockingQueue__head != null
; [exec]
; __flatten_93 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@2531 $Perm)
(assert ($Perm.isValidVar $k@2531))
(assert ($Perm.isReadVar $k@2531 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2531 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2531 $k@2448))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2532 $Perm)
(assert ($Perm.isValidVar $k@2532))
(assert ($Perm.isReadVar $k@2532 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2532 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2532 (+ (- $k@2450 $k@2511) $k@2529)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2533 $Perm)
(assert ($Perm.isValidVar $k@2533))
(assert ($Perm.isReadVar $k@2533 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2533 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2533 (+ (- $k@2452 $k@2510) $k@2528)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2534 $Perm)
(assert ($Perm.isValidVar $k@2534))
(assert ($Perm.isReadVar $k@2534 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2534 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= $t@2453 $t@2527)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2534 (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@2453 $t@2527)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(declare-const $k@2535 $Perm)
(assert ($Perm.isValidVar $k@2535))
(assert ($Perm.isReadVar $k@2535 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2535 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2535 $k@2456))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2536 $Perm)
(assert ($Perm.isValidVar $k@2536))
(assert ($Perm.isReadVar $k@2536 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2536 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2536 $k@2458))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@2537 Int)
(declare-const $t@2538 $Snap)
(declare-const $t@2539 $Snap)
(assert (= $t@2538 ($Snap.combine $t@2539 $Snap.unit)))
(declare-const $t@2540 $Snap)
(declare-const $t@2541 $Ref)
(assert (= $t@2539 ($Snap.combine $t@2540 ($SortWrappers.$RefTo$Snap $t@2541))))
(declare-const $t@2542 $Snap)
(assert (= $t@2540 ($Snap.combine $t@2542 $Snap.unit)))
(declare-const $t@2543 $Snap)
(declare-const $t@2544 $Ref)
(assert (= $t@2542 ($Snap.combine $t@2543 ($SortWrappers.$RefTo$Snap $t@2544))))
(declare-const $t@2545 $Snap)
(assert (= $t@2543 ($Snap.combine $t@2545 $Snap.unit)))
(declare-const $t@2546 $Snap)
(declare-const $t@2547 $Ref)
(assert (= $t@2545 ($Snap.combine $t@2546 ($SortWrappers.$RefTo$Snap $t@2547))))
(declare-const $t@2548 $Snap)
(assert (= $t@2546 ($Snap.combine $t@2548 $Snap.unit)))
(declare-const $t@2549 $Snap)
(declare-const $t@2550 $Ref)
(assert (= $t@2548 ($Snap.combine $t@2549 ($SortWrappers.$RefTo$Snap $t@2550))))
(declare-const $t@2551 $Snap)
(assert (= $t@2549 ($Snap.combine $t@2551 $Snap.unit)))
(declare-const $t@2552 $Snap)
(declare-const $t@2553 $Ref)
(assert (= $t@2551 ($Snap.combine $t@2552 ($SortWrappers.$RefTo$Snap $t@2553))))
(declare-const $t@2554 $Snap)
(assert (= $t@2552 ($Snap.combine $t@2554 $Snap.unit)))
(declare-const $t@2555 Int)
(declare-const $t@2556 $Ref)
(assert (=
  $t@2554
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2555)
    ($SortWrappers.$RefTo$Snap $t@2556))))
(declare-const $t@2557 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2555)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2557) $Snap.unit)))
(declare-const $k@2558 $Perm)
(assert ($Perm.isValidVar $k@2558))
(assert ($Perm.isReadVar $k@2558 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2448 $k@2531)) (= $t@2557 $t@2449)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= (+ (- $k@2448 $k@2531) $k@2558) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2448 $k@2531) $k@2558) $Perm.No)))
(assert (> $t@2557 0))
(declare-const $k@2559 $Perm)
(assert ($Perm.isValidVar $k@2559))
(assert ($Perm.isReadVar $k@2559 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532))
  (= $t@2556 $t@2524)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532) $k@2559) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532) $k@2559) $Perm.No)))
(assert (not (= $t@2556 $Ref.null)))
(declare-const $k@2560 $Perm)
(assert ($Perm.isValidVar $k@2560))
(assert ($Perm.isReadVar $k@2560 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533))
  (= $t@2553 $t@2527)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533) $k@2560) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533) $k@2560) $Perm.No)))
(assert (not (= $t@2553 $Ref.null)))
(declare-const $k@2561 $Perm)
(assert ($Perm.isValidVar $k@2561))
(assert ($Perm.isReadVar $k@2561 $Perm.Write))
(push) ; 5
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies
  (< $Perm.No (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534))
  (= $t@2550 $t@2521)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not
  (=
    (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not
  (=
    (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
    $Perm.No)))
(assert (= $t@2550 diz@2438))
(declare-const $k@2562 $Perm)
(assert ($Perm.isValidVar $k@2562))
(assert ($Perm.isReadVar $k@2562 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2456 $k@2535)) (= $t@2547 $t@2457)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@2456 $k@2535) $k@2562) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2456 $k@2535) $k@2562) $Perm.No)))
(assert (not (= $t@2547 $Ref.null)))
(declare-const $k@2563 $Perm)
(assert ($Perm.isValidVar $k@2563))
(assert ($Perm.isReadVar $k@2563 $Perm.Write))
(push) ; 5
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- $k@2458 $k@2536)) (= $t@2544 $t@2459)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- $k@2458 $k@2536) $k@2563) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2458 $k@2536) $k@2563) $Perm.No)))
(assert (= $t@2544 diz@2438))
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@2541 $Ref.null)))
; [exec]
; x := __flatten_93
; [exec]
; __flatten_94 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2564 Int)
; [exec]
; c := __flatten_94
; [eval] c > 1
(push) ; 5
(assert (not (not (> sys__result@2564 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (> sys__result@2564 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 5] sys__result@2564 > 1
(assert (> sys__result@2564 1))
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 6
(assert (not (= $t@2527 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 6
(assert (not (= $t@2527 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2565 $Perm)
(assert ($Perm.isValidVar $k@2565))
(assert ($Perm.isReadVar $k@2565 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2565 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2565 (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)))
(push) ; 6
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2550 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2438 $t@2550)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 6
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2550 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2438 $t@2550)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= sys__result@2564 $t@2557))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@2564 $t@2557)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 6] sys__result@2564 == $t@2557
(assert (= sys__result@2564 $t@2557))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@2566 $Snap)
(declare-const $t@2567 $Snap)
(assert (= $t@2566 ($Snap.combine $t@2567 $Snap.unit)))
(declare-const $t@2568 $Ref)
(declare-const $t@2569 $Ref)
(assert (=
  $t@2567
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2568)
    ($SortWrappers.$RefTo$Snap $t@2569))))
(declare-const $k@2570 $Perm)
(assert ($Perm.isValidVar $k@2570))
(assert ($Perm.isReadVar $k@2570 $Perm.Write))
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@2458 $k@2536) $k@2563)) (= $t@2568 $t@2544)))
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2570) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2570) $Perm.No)))
(assert (not (= $t@2568 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@2569 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@2571 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2572 $Perm)
(assert ($Perm.isValidVar $k@2572))
(assert ($Perm.isReadVar $k@2572 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2572 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2572 (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2570)))
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; __flatten_95 := x
; [exec]
; sys__result := __flatten_95
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2573 $Perm)
(assert ($Perm.isValidVar $k@2573))
(assert ($Perm.isReadVar $k@2573 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2573 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2573 (+ (- $k@2448 $k@2531) $k@2558)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2574 $Perm)
(assert ($Perm.isValidVar $k@2574))
(assert ($Perm.isReadVar $k@2574 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2574 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2574 (+ (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532) $k@2559)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2575 $Perm)
(assert ($Perm.isValidVar $k@2575))
(assert ($Perm.isReadVar $k@2575 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2575 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2575 (+ (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533) $k@2560)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2576 $Perm)
(assert ($Perm.isValidVar $k@2576))
(assert ($Perm.isReadVar $k@2576 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2576 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2565)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2565)
    $Perm.No)))
(assert (<
  $k@2576
  (- (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561) $k@2565)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2577 $Perm)
(assert ($Perm.isValidVar $k@2577))
(assert ($Perm.isReadVar $k@2577 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2577 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2577 (+ (- $k@2456 $k@2535) $k@2562)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2578 $Perm)
(assert ($Perm.isValidVar $k@2578))
(assert ($Perm.isReadVar $k@2578 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2578 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2570) $k@2572) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2570) $k@2572) $Perm.No)))
(assert (< $k@2578 (- (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2570) $k@2572)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2568 diz@2438)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@2568 diz@2438))
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 6] sys__result@2564 != $t@2557
(assert (not (= sys__result@2564 $t@2557)))
(pop) ; 6
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (= sys__result@2564 $t@2557)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@2564 $t@2557))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 7] sys__result@2564 != $t@2557
(assert (not (= sys__result@2564 $t@2557)))
; [exec]
; __flatten_95 := x
; [exec]
; sys__result := __flatten_95
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2579 $Perm)
(assert ($Perm.isValidVar $k@2579))
(assert ($Perm.isReadVar $k@2579 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2579 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2579 (+ (- $k@2448 $k@2531) $k@2558)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2580 $Perm)
(assert ($Perm.isValidVar $k@2580))
(assert ($Perm.isReadVar $k@2580 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2580 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2580 (+ (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532) $k@2559)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2581 $Perm)
(assert ($Perm.isValidVar $k@2581))
(assert ($Perm.isReadVar $k@2581 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2581 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2581 (+ (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533) $k@2560)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2582 $Perm)
(assert ($Perm.isValidVar $k@2582))
(assert ($Perm.isReadVar $k@2582 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2582 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2565)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2565)
    $Perm.No)))
(assert (<
  $k@2582
  (- (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561) $k@2565)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2583 $Perm)
(assert ($Perm.isValidVar $k@2583))
(assert ($Perm.isReadVar $k@2583 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2583 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2583 (+ (- $k@2456 $k@2535) $k@2562)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2584 $Perm)
(assert ($Perm.isValidVar $k@2584))
(assert ($Perm.isReadVar $k@2584 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2584 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2584 (+ (- $k@2458 $k@2536) $k@2563)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 7] sys__result@2564 == $t@2557
(assert (= sys__result@2564 $t@2557))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 5] !sys__result@2564 > 1
(assert (not (> sys__result@2564 1)))
(pop) ; 5
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 5
(assert (not (> sys__result@2564 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (> sys__result@2564 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 8] !sys__result@2564 > 1
(assert (not (> sys__result@2564 1)))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 6
(assert (not (= $t@2527 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2585 $Perm)
(assert ($Perm.isValidVar $k@2585))
(assert ($Perm.isReadVar $k@2585 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2585 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2585 (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)))
(push) ; 6
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2550 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2438 $t@2550)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 6
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2550 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2438 $t@2550)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= sys__result@2564 $t@2557))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@2564 $t@2557)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 9] sys__result@2564 == $t@2557
(assert (= sys__result@2564 $t@2557))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@2586 $Snap)
(declare-const $t@2587 $Snap)
(assert (= $t@2586 ($Snap.combine $t@2587 $Snap.unit)))
(declare-const $t@2588 $Ref)
(declare-const $t@2589 $Ref)
(assert (=
  $t@2587
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2588)
    ($SortWrappers.$RefTo$Snap $t@2589))))
(declare-const $k@2590 $Perm)
(assert ($Perm.isValidVar $k@2590))
(assert ($Perm.isReadVar $k@2590 $Perm.Write))
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@2458 $k@2536) $k@2563)) (= $t@2588 $t@2544)))
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2590) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2590) $Perm.No)))
(assert (not (= $t@2588 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@2589 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@2591 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2592 $Perm)
(assert ($Perm.isValidVar $k@2592))
(assert ($Perm.isReadVar $k@2592 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2592 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2592 (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2590)))
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; __flatten_95 := x
; [exec]
; sys__result := __flatten_95
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2593 $Perm)
(assert ($Perm.isValidVar $k@2593))
(assert ($Perm.isReadVar $k@2593 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2593 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2593 (+ (- $k@2448 $k@2531) $k@2558)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2594 $Perm)
(assert ($Perm.isValidVar $k@2594))
(assert ($Perm.isReadVar $k@2594 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2594 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2594 (+ (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532) $k@2559)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2595 $Perm)
(assert ($Perm.isValidVar $k@2595))
(assert ($Perm.isReadVar $k@2595 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2595 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2595 (+ (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533) $k@2560)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2596 $Perm)
(assert ($Perm.isValidVar $k@2596))
(assert ($Perm.isReadVar $k@2596 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2596 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2585)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2585)
    $Perm.No)))
(assert (<
  $k@2596
  (- (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561) $k@2585)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2597 $Perm)
(assert ($Perm.isValidVar $k@2597))
(assert ($Perm.isReadVar $k@2597 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2597 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2597 (+ (- $k@2456 $k@2535) $k@2562)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2598 $Perm)
(assert ($Perm.isValidVar $k@2598))
(assert ($Perm.isReadVar $k@2598 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2598 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2590) $k@2592) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2590) $k@2592) $Perm.No)))
(assert (< $k@2598 (- (+ (+ (- $k@2458 $k@2536) $k@2563) $k@2590) $k@2592)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2588 diz@2438)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@2588 diz@2438))
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 9] sys__result@2564 != $t@2557
(assert (not (= sys__result@2564 $t@2557)))
(pop) ; 6
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (= sys__result@2564 $t@2557)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@2564 $t@2557))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 10] sys__result@2564 != $t@2557
(assert (not (= sys__result@2564 $t@2557)))
; [exec]
; __flatten_95 := x
; [exec]
; sys__result := __flatten_95
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2599 $Perm)
(assert ($Perm.isValidVar $k@2599))
(assert ($Perm.isReadVar $k@2599 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2599 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2599 (+ (- $k@2448 $k@2531) $k@2558)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2600 $Perm)
(assert ($Perm.isValidVar $k@2600))
(assert ($Perm.isReadVar $k@2600 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2600 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2600 (+ (- (+ (- $k@2450 $k@2511) $k@2529) $k@2532) $k@2559)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2601 $Perm)
(assert ($Perm.isValidVar $k@2601))
(assert ($Perm.isReadVar $k@2601 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2601 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2601 (+ (- (+ (- $k@2452 $k@2510) $k@2528) $k@2533) $k@2560)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2602 $Perm)
(assert ($Perm.isValidVar $k@2602))
(assert ($Perm.isReadVar $k@2602 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2602 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2585)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561)
      $k@2585)
    $Perm.No)))
(assert (<
  $k@2602
  (- (+ (- (+ (- (+ $k@2454 $k@2476) $k@2512) $k@2530) $k@2534) $k@2561) $k@2585)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2453 $t@2553)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2603 $Perm)
(assert ($Perm.isValidVar $k@2603))
(assert ($Perm.isReadVar $k@2603 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2603 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2603 (+ (- $k@2456 $k@2535) $k@2562)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2604 $Perm)
(assert ($Perm.isValidVar $k@2604))
(assert ($Perm.isReadVar $k@2604 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2604 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2604 (+ (- $k@2458 $k@2536) $k@2563)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2457 $t@2547)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; inhale false
(pop) ; 6
(push) ; 6
; [else-branch 10] sys__result@2564 == $t@2557
(assert (= sys__result@2564 $t@2557))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 8] sys__result@2564 > 1
(assert (> sys__result@2564 1))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__put ----------
(declare-const diz@2605 $Ref)
(declare-const val@2606 Int)
(declare-const currentCount@2607 Int)
(declare-const __flatten_96@2608 Int)
(declare-const __flatten_97@2609 Int)
(declare-const c@2610 Int)
(declare-const __flatten_99@2611 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2605 $Ref.null)))
(declare-const $k@2612 $Perm)
(assert ($Perm.isValidVar $k@2612))
(assert ($Perm.isReadVar $k@2612 $Perm.Write))
(declare-const $t@2613 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2612 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2612 $Perm.No)))
(assert (> $t@2613 0))
(declare-const $k@2614 $Perm)
(assert ($Perm.isValidVar $k@2614))
(assert ($Perm.isReadVar $k@2614 $Perm.Write))
(declare-const $t@2615 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@2614 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2614 $Perm.No)))
(assert (not (= $t@2615 $Ref.null)))
(declare-const $k@2616 $Perm)
(assert ($Perm.isValidVar $k@2616))
(assert ($Perm.isReadVar $k@2616 $Perm.Write))
(declare-const $t@2617 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@2616 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2616 $Perm.No)))
(assert (not (= $t@2617 $Ref.null)))
(declare-const $k@2618 $Perm)
(assert ($Perm.isValidVar $k@2618))
(assert ($Perm.isReadVar $k@2618 $Perm.Write))
(declare-const $t@2619 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2618 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2618 $Perm.No)))
(assert (= $t@2619 diz@2605))
(declare-const $k@2620 $Perm)
(assert ($Perm.isValidVar $k@2620))
(assert ($Perm.isReadVar $k@2620 $Perm.Write))
(declare-const $t@2621 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@2620 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2620 $Perm.No)))
(assert (not (= $t@2621 $Ref.null)))
(declare-const $k@2622 $Perm)
(assert ($Perm.isValidVar $k@2622))
(assert ($Perm.isReadVar $k@2622 $Perm.Write))
(declare-const $t@2623 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2622 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2622 $Perm.No)))
(assert (= $t@2623 diz@2605))
(push) ; 3
(declare-const $k@2624 $Perm)
(assert ($Perm.isValidVar $k@2624))
(assert ($Perm.isReadVar $k@2624 $Perm.Write))
(declare-const $t@2625 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2624 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2624 $Perm.No)))
(assert (> $t@2625 0))
(declare-const $k@2626 $Perm)
(assert ($Perm.isValidVar $k@2626))
(assert ($Perm.isReadVar $k@2626 $Perm.Write))
(declare-const $t@2627 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2626 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2626 $Perm.No)))
(assert (not (= $t@2627 $Ref.null)))
(declare-const $k@2628 $Perm)
(assert ($Perm.isValidVar $k@2628))
(assert ($Perm.isReadVar $k@2628 $Perm.Write))
(declare-const $t@2629 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2628 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2628 $Perm.No)))
(assert (not (= $t@2629 $Ref.null)))
(declare-const $k@2630 $Perm)
(assert ($Perm.isValidVar $k@2630))
(assert ($Perm.isReadVar $k@2630 $Perm.Write))
(declare-const $t@2631 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2630 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2630 $Perm.No)))
(assert (= $t@2631 diz@2605))
(declare-const $k@2632 $Perm)
(assert ($Perm.isValidVar $k@2632))
(assert ($Perm.isReadVar $k@2632 $Perm.Write))
(declare-const $t@2633 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2632 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2632 $Perm.No)))
(assert (not (= $t@2633 $Ref.null)))
(declare-const $k@2634 $Perm)
(assert ($Perm.isValidVar $k@2634))
(assert ($Perm.isReadVar $k@2634 $Perm.Write))
(declare-const $t@2635 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2634 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2634 $Perm.No)))
(assert (= $t@2635 diz@2605))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@2636 $Snap)
(declare-const $t@2637 $Snap)
(assert (= $t@2636 ($Snap.combine $t@2637 $Snap.unit)))
(declare-const $t@2638 $Ref)
(declare-const $t@2639 $Ref)
(assert (=
  $t@2637
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2638)
    ($SortWrappers.$RefTo$Snap $t@2639))))
(declare-const $k@2640 $Perm)
(assert ($Perm.isValidVar $k@2640))
(assert ($Perm.isReadVar $k@2640 $Perm.Write))
(assert (= $t@2623 $t@2638))
(push) ; 4
(assert (not (not (= (+ $k@2622 $k@2640) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= (+ $k@2622 $k@2640) $Perm.No)))
(assert (not (= $t@2623 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(assert (not (= $t@2639 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@2641 $Snap)
; [exec]
; __flatten_96 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2642 Int)
; [exec]
; currentCount := __flatten_96
; loop at <no position>
(declare-const currentCount@2643 Int)
(declare-const __flatten_97@2644 Int)
(push) ; 4
; Verify loop body
(declare-const $t@2645 $Snap)
(declare-const $t@2646 $Snap)
(assert (= $t@2645 ($Snap.combine $t@2646 $Snap.unit)))
(declare-const $t@2647 $Snap)
(assert (= $t@2646 ($Snap.combine $t@2647 $Snap.unit)))
(declare-const $t@2648 $Snap)
(assert (= $t@2647 ($Snap.combine $t@2648 $Snap.unit)))
(declare-const $t@2649 $Snap)
(declare-const $t@2650 $Ref)
(assert (= $t@2648 ($Snap.combine $t@2649 ($SortWrappers.$RefTo$Snap $t@2650))))
(declare-const $t@2651 $Snap)
(assert (= $t@2649 ($Snap.combine $t@2651 $Snap.unit)))
(declare-const $t@2652 $Snap)
(declare-const $t@2653 $Ref)
(assert (= $t@2651 ($Snap.combine $t@2652 ($SortWrappers.$RefTo$Snap $t@2653))))
(declare-const $t@2654 $Snap)
(assert (= $t@2652 ($Snap.combine $t@2654 $Snap.unit)))
(declare-const $t@2655 $Snap)
(declare-const $t@2656 $Ref)
(assert (= $t@2654 ($Snap.combine $t@2655 ($SortWrappers.$RefTo$Snap $t@2656))))
(declare-const $t@2657 $Snap)
(declare-const $t@2658 Int)
(assert (= $t@2655 ($Snap.combine $t@2657 ($SortWrappers.IntTo$Snap $t@2658))))
(declare-const $t@2659 $Ref)
(declare-const $t@2660 $Snap)
(assert (= $t@2657 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2659) $t@2660)))
(declare-const $t@2661 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2659)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2661) $Snap.unit)))
(declare-const $k@2662 $Perm)
(assert ($Perm.isValidVar $k@2662))
(assert ($Perm.isReadVar $k@2662 $Perm.Write))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= $k@2662 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2662 $Perm.No)))
(assert (not (= $t@2661 $Ref.null)))
(declare-const $k@2663 $Perm)
(assert ($Perm.isValidVar $k@2663))
(assert ($Perm.isReadVar $k@2663 $Perm.Write))
(declare-const $k@2664 $Perm)
(assert ($Perm.isValidVar $k@2664))
(assert ($Perm.isReadVar $k@2664 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= $k@2664 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2664 $Perm.No)))
(assert (not (= $t@2656 $Ref.null)))
(declare-const $k@2665 $Perm)
(assert ($Perm.isValidVar $k@2665))
(assert ($Perm.isReadVar $k@2665 $Perm.Write))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (not (= $k@2665 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2665 $Perm.No)))
(assert (= $t@2653 diz@2605))
(assert (not (= $t@2653 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@2650 $Ref.null)))
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (= $k@2663 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2663 $Perm.No)))
(assert (= currentCount@2643 $t@2658))
(check-sat)
; unknown
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2666 $Perm)
(assert ($Perm.isValidVar $k@2666))
(assert ($Perm.isReadVar $k@2666 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2666 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2666 $k@2665))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@2667 $Snap)
(declare-const $t@2668 $Snap)
(assert (= $t@2667 ($Snap.combine $t@2668 $Snap.unit)))
(declare-const $t@2669 $Ref)
(declare-const $t@2670 $Ref)
(assert (=
  $t@2668
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2669)
    ($SortWrappers.$RefTo$Snap $t@2670))))
(declare-const $k@2671 $Perm)
(assert ($Perm.isValidVar $k@2671))
(assert ($Perm.isReadVar $k@2671 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2665 $k@2666)) (= $t@2669 $t@2653)))
(push) ; 5
(assert (not (not (= (+ (- $k@2665 $k@2666) $k@2671) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2665 $k@2666) $k@2671) $Perm.No)))
(assert (not (= $t@2669 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(assert (not (= $t@2670 $Ref.null)))
; [exec]
; __flatten_97 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2672 Int)
; [exec]
; currentCount := __flatten_97
(declare-const $k@2673 $Perm)
(assert ($Perm.isValidVar $k@2673))
(assert ($Perm.isReadVar $k@2673 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2673 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2673 $k@2662))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2674 $Perm)
(assert ($Perm.isValidVar $k@2674))
(assert ($Perm.isReadVar $k@2674 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2674 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2674 $k@2663))
(declare-const $k@2675 $Perm)
(assert ($Perm.isValidVar $k@2675))
(assert ($Perm.isReadVar $k@2675 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2675 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2675 $k@2664))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2676 $Perm)
(assert ($Perm.isValidVar $k@2676))
(assert ($Perm.isReadVar $k@2676 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2676 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2676 (+ (- $k@2665 $k@2666) $k@2671)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@2669 diz@2605)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (= $t@2669 diz@2605))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
; [eval] diz.BlockingQueue__last != null
(pop) ; 4
(push) ; 4
; Establish loop invariant
(declare-const $k@2677 $Perm)
(assert ($Perm.isValidVar $k@2677))
(assert ($Perm.isReadVar $k@2677 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2677 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2677 $k@2620))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2678 $Perm)
(assert ($Perm.isValidVar $k@2678))
(assert ($Perm.isReadVar $k@2678 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2678 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2678 $k@2612))
(declare-const $k@2679 $Perm)
(assert ($Perm.isValidVar $k@2679))
(assert ($Perm.isReadVar $k@2679 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2679 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2679 $k@2614))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2680 $Perm)
(assert ($Perm.isValidVar $k@2680))
(assert ($Perm.isReadVar $k@2680 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2680 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2680 (+ $k@2622 $k@2640)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
; [eval] diz.BlockingQueue__last != null
; Continue after loop
(declare-const $t@2681 $Snap)
(declare-const $t@2682 $Snap)
(assert (= $t@2681 ($Snap.combine $t@2682 $Snap.unit)))
(declare-const $t@2683 $Snap)
(assert (= $t@2682 ($Snap.combine $t@2683 $Snap.unit)))
(declare-const $t@2684 $Snap)
(assert (= $t@2683 ($Snap.combine $t@2684 $Snap.unit)))
(declare-const $t@2685 $Snap)
(declare-const $t@2686 $Ref)
(assert (= $t@2684 ($Snap.combine $t@2685 ($SortWrappers.$RefTo$Snap $t@2686))))
(declare-const $t@2687 $Snap)
(assert (= $t@2685 ($Snap.combine $t@2687 $Snap.unit)))
(declare-const $t@2688 $Snap)
(declare-const $t@2689 $Ref)
(assert (= $t@2687 ($Snap.combine $t@2688 ($SortWrappers.$RefTo$Snap $t@2689))))
(declare-const $t@2690 $Snap)
(assert (= $t@2688 ($Snap.combine $t@2690 $Snap.unit)))
(declare-const $t@2691 $Snap)
(declare-const $t@2692 $Ref)
(assert (= $t@2690 ($Snap.combine $t@2691 ($SortWrappers.$RefTo$Snap $t@2692))))
(declare-const $t@2693 $Snap)
(declare-const $t@2694 Int)
(assert (= $t@2691 ($Snap.combine $t@2693 ($SortWrappers.IntTo$Snap $t@2694))))
(declare-const $t@2695 $Ref)
(declare-const $t@2696 $Snap)
(assert (= $t@2693 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2695) $t@2696)))
(declare-const $t@2697 $Ref)
(assert (=
  ($SortWrappers.$RefTo$Snap $t@2695)
  ($Snap.combine ($SortWrappers.$RefTo$Snap $t@2697) $Snap.unit)))
(declare-const $k@2698 $Perm)
(assert ($Perm.isValidVar $k@2698))
(assert ($Perm.isReadVar $k@2698 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2620 $k@2677)) (= $t@2697 $t@2621)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@2620 $k@2677) $k@2698) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2620 $k@2677) $k@2698) $Perm.No)))
(assert (not (= $t@2697 $Ref.null)))
(declare-const $k@2699 $Perm)
(assert ($Perm.isValidVar $k@2699))
(assert ($Perm.isReadVar $k@2699 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2612 $k@2678)) (= $t@2694 $t@2613)))
(declare-const $k@2700 $Perm)
(assert ($Perm.isValidVar $k@2700))
(assert ($Perm.isReadVar $k@2700 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2614 $k@2679)) (= $t@2692 $t@2615)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- $k@2614 $k@2679) $k@2700) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2614 $k@2679) $k@2700) $Perm.No)))
(assert (not (= $t@2692 $Ref.null)))
(declare-const $k@2701 $Perm)
(assert ($Perm.isValidVar $k@2701))
(assert ($Perm.isReadVar $k@2701 $Perm.Write))
(push) ; 5
(assert (not (= $t@2621 $t@2697)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- (+ $k@2622 $k@2640) $k@2680)) (= $t@2689 $t@2623)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@2621 $t@2697)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $Perm.No)))
(assert (= $t@2689 diz@2605))
(push) ; 5
(assert (not (= $t@2621 $t@2697)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $t@2689 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last == diz.BlockingQueue__last
(push) ; 5
(assert (not (= $t@2621 $t@2697)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@2686 $Ref.null)))
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (= (+ (- $k@2612 $k@2678) $k@2699) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2612 $k@2678) $k@2699) $Perm.No)))
(assert (not (= currentCount@2643 $t@2694)))
(check-sat)
; unknown
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@2702 $Perm)
(assert ($Perm.isValidVar $k@2702))
(assert ($Perm.isReadVar $k@2702 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2702 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2702 (+ (- $k@2612 $k@2678) $k@2699)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (> $t@2694 0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (> $t@2694 0))
(declare-const $k@2703 $Perm)
(assert ($Perm.isValidVar $k@2703))
(assert ($Perm.isReadVar $k@2703 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2703 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2703 (+ (- $k@2614 $k@2679) $k@2700)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2704 $Perm)
(assert ($Perm.isValidVar $k@2704))
(assert ($Perm.isReadVar $k@2704 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2704 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2704 $k@2616))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2705 $Perm)
(assert ($Perm.isValidVar $k@2705))
(assert ($Perm.isReadVar $k@2705 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2705 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2705 $k@2618))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@2706 $Perm)
(assert ($Perm.isValidVar $k@2706))
(assert ($Perm.isReadVar $k@2706 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2706 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2706 (+ (- $k@2620 $k@2677) $k@2698)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2707 $Perm)
(assert ($Perm.isValidVar $k@2707))
(assert ($Perm.isReadVar $k@2707 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2707 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= $t@2621 $t@2697)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2707 (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@2621 $t@2697)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(declare-const $t@2708 $Snap)
(declare-const $t@2709 $Snap)
(assert (= $t@2708 ($Snap.combine $t@2709 $Snap.unit)))
(declare-const $t@2710 $Snap)
(declare-const $t@2711 $Ref)
(assert (= $t@2709 ($Snap.combine $t@2710 ($SortWrappers.$RefTo$Snap $t@2711))))
(declare-const $t@2712 $Snap)
(assert (= $t@2710 ($Snap.combine $t@2712 $Snap.unit)))
(declare-const $t@2713 $Snap)
(declare-const $t@2714 $Ref)
(assert (= $t@2712 ($Snap.combine $t@2713 ($SortWrappers.$RefTo$Snap $t@2714))))
(declare-const $t@2715 $Snap)
(assert (= $t@2713 ($Snap.combine $t@2715 $Snap.unit)))
(declare-const $t@2716 $Snap)
(declare-const $t@2717 $Ref)
(assert (= $t@2715 ($Snap.combine $t@2716 ($SortWrappers.$RefTo$Snap $t@2717))))
(declare-const $t@2718 $Snap)
(assert (= $t@2716 ($Snap.combine $t@2718 $Snap.unit)))
(declare-const $t@2719 $Snap)
(declare-const $t@2720 $Ref)
(assert (= $t@2718 ($Snap.combine $t@2719 ($SortWrappers.$RefTo$Snap $t@2720))))
(declare-const $t@2721 $Snap)
(assert (= $t@2719 ($Snap.combine $t@2721 $Snap.unit)))
(declare-const $t@2722 $Snap)
(declare-const $t@2723 $Ref)
(assert (= $t@2721 ($Snap.combine $t@2722 ($SortWrappers.$RefTo$Snap $t@2723))))
(declare-const $t@2724 $Snap)
(assert (= $t@2722 ($Snap.combine $t@2724 $Snap.unit)))
(declare-const $t@2725 Int)
(declare-const $t@2726 $Ref)
(assert (=
  $t@2724
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2725)
    ($SortWrappers.$RefTo$Snap $t@2726))))
(declare-const $t@2727 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2725)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2727) $Snap.unit)))
(declare-const $k@2728 $Perm)
(assert ($Perm.isValidVar $k@2728))
(assert ($Perm.isReadVar $k@2728 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702))
  (= $t@2727 $t@2694)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702) $k@2728) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702) $k@2728) $Perm.No)))
(assert (> $t@2727 0))
(declare-const $k@2729 $Perm)
(assert ($Perm.isValidVar $k@2729))
(assert ($Perm.isReadVar $k@2729 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703))
  (= $t@2726 $t@2692)))
; [eval] diz.BlockingQueue__count != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703) $k@2729) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703) $k@2729) $Perm.No)))
(assert (not (= $t@2726 $Ref.null)))
(declare-const $k@2730 $Perm)
(assert ($Perm.isValidVar $k@2730))
(assert ($Perm.isReadVar $k@2730 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2616 $k@2704)) (= $t@2723 $t@2617)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 5
(assert (not (not (= (+ (- $k@2616 $k@2704) $k@2730) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2616 $k@2704) $k@2730) $Perm.No)))
(assert (not (= $t@2723 $Ref.null)))
(declare-const $k@2731 $Perm)
(assert ($Perm.isValidVar $k@2731))
(assert ($Perm.isReadVar $k@2731 $Perm.Write))
(push) ; 5
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies (< $Perm.No (- $k@2618 $k@2705)) (= $t@2720 $t@2619)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 5
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= (+ (- $k@2618 $k@2705) $k@2731) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- $k@2618 $k@2705) $k@2731) $Perm.No)))
(assert (= $t@2720 diz@2605))
(declare-const $k@2732 $Perm)
(assert ($Perm.isValidVar $k@2732))
(assert ($Perm.isReadVar $k@2732 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706))
  (= $t@2717 $t@2697)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 5
(assert (not (not (= (+ (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706) $k@2732) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706) $k@2732) $Perm.No)))
(assert (not (= $t@2717 $Ref.null)))
(declare-const $k@2733 $Perm)
(assert ($Perm.isValidVar $k@2733))
(assert ($Perm.isReadVar $k@2733 $Perm.Write))
(push) ; 5
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (implies
  (< $Perm.No (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707))
  (= $t@2714 $t@2689)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 5
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not
  (=
    (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not
  (=
    (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
    $Perm.No)))
(assert (= $t@2714 diz@2605))
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@2711 $Ref.null)))
; [exec]
; __flatten_99 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2734 Int)
; [exec]
; c := __flatten_99
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 5
(assert (not (not (< (+ sys__result@2734 1) $t@2727))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (< (+ sys__result@2734 1) $t@2727)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 11] sys__result@2734 + 1 < $t@2727
(assert (< (+ sys__result@2734 1) $t@2727))
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 6
(assert (not (= $t@2697 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 6
(assert (not (= $t@2697 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2735 $Perm)
(assert ($Perm.isValidVar $k@2735))
(assert ($Perm.isReadVar $k@2735 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2735 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2735 (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)))
(push) ; 6
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2714 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2605 $t@2714)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 6
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2714 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2605 $t@2714)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == 0
(push) ; 6
(assert (not (not (= sys__result@2734 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@2734 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 12] sys__result@2734 == 0
(assert (= sys__result@2734 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2736 $Snap)
(declare-const $t@2737 $Snap)
(assert (= $t@2736 ($Snap.combine $t@2737 $Snap.unit)))
(declare-const $t@2738 $Ref)
(declare-const $t@2739 $Ref)
(assert (=
  $t@2737
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2738)
    ($SortWrappers.$RefTo$Snap $t@2739))))
(declare-const $k@2740 $Perm)
(assert ($Perm.isValidVar $k@2740))
(assert ($Perm.isReadVar $k@2740 $Perm.Write))
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@2618 $k@2705) $k@2731)) (= $t@2738 $t@2720)))
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2740) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2740) $Perm.No)))
(assert (not (= $t@2738 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@2739 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@2741 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2742 $Perm)
(assert ($Perm.isValidVar $k@2742))
(assert ($Perm.isReadVar $k@2742 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2742 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2742 (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2740)))
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2743 $Perm)
(assert ($Perm.isValidVar $k@2743))
(assert ($Perm.isReadVar $k@2743 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2743 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2743 (+ (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702) $k@2728)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2744 $Perm)
(assert ($Perm.isValidVar $k@2744))
(assert ($Perm.isReadVar $k@2744 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2744 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2744 (+ (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703) $k@2729)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2745 $Perm)
(assert ($Perm.isValidVar $k@2745))
(assert ($Perm.isReadVar $k@2745 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2745 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2745 (+ (- $k@2616 $k@2704) $k@2730)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2746 $Perm)
(assert ($Perm.isValidVar $k@2746))
(assert ($Perm.isReadVar $k@2746 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2746 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2740) $k@2742) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2740) $k@2742) $Perm.No)))
(assert (< $k@2746 (- (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2740) $k@2742)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2738 diz@2605)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@2738 diz@2605))
(declare-const $k@2747 $Perm)
(assert ($Perm.isValidVar $k@2747))
(assert ($Perm.isReadVar $k@2747 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2747 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2747 (+ (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706) $k@2732)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2748 $Perm)
(assert ($Perm.isValidVar $k@2748))
(assert ($Perm.isReadVar $k@2748 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2748 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2735)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2735)
    $Perm.No)))
(assert (<
  $k@2748
  (- (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733) $k@2735)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 12] sys__result@2734 != 0
(assert (not (= sys__result@2734 0)))
(pop) ; 6
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 6
(assert (not (= sys__result@2734 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@2734 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 13] sys__result@2734 != 0
(assert (not (= sys__result@2734 0)))
(declare-const $k@2749 $Perm)
(assert ($Perm.isValidVar $k@2749))
(assert ($Perm.isReadVar $k@2749 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2749 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2749 (+ (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702) $k@2728)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2750 $Perm)
(assert ($Perm.isValidVar $k@2750))
(assert ($Perm.isReadVar $k@2750 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2750 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2750 (+ (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703) $k@2729)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2751 $Perm)
(assert ($Perm.isValidVar $k@2751))
(assert ($Perm.isReadVar $k@2751 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2751 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2751 (+ (- $k@2616 $k@2704) $k@2730)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2752 $Perm)
(assert ($Perm.isValidVar $k@2752))
(assert ($Perm.isReadVar $k@2752 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2752 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2752 (+ (- $k@2618 $k@2705) $k@2731)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2753 $Perm)
(assert ($Perm.isValidVar $k@2753))
(assert ($Perm.isReadVar $k@2753 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2753 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2753 (+ (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706) $k@2732)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2754 $Perm)
(assert ($Perm.isValidVar $k@2754))
(assert ($Perm.isReadVar $k@2754 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2754 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2735)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2735)
    $Perm.No)))
(assert (<
  $k@2754
  (- (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733) $k@2735)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 13] sys__result@2734 == 0
(assert (= sys__result@2734 0))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 11] !sys__result@2734 + 1 < $t@2727
(assert (not (< (+ sys__result@2734 1) $t@2727)))
(pop) ; 5
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 5
(assert (not (< (+ sys__result@2734 1) $t@2727)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (< (+ sys__result@2734 1) $t@2727))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 14] !sys__result@2734 + 1 < $t@2727
(assert (not (< (+ sys__result@2734 1) $t@2727)))
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 6
(assert (not (= $t@2697 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2755 $Perm)
(assert ($Perm.isValidVar $k@2755))
(assert ($Perm.isReadVar $k@2755 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2755 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2755 (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)))
(push) ; 6
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2714 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2605 $t@2714)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 6
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2714 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= diz@2605 $t@2714)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [eval] c == 0
(push) ; 6
(assert (not (not (= sys__result@2734 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= sys__result@2734 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 15] sys__result@2734 == 0
(assert (= sys__result@2734 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2756 $Snap)
(declare-const $t@2757 $Snap)
(assert (= $t@2756 ($Snap.combine $t@2757 $Snap.unit)))
(declare-const $t@2758 $Ref)
(declare-const $t@2759 $Ref)
(assert (=
  $t@2757
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2758)
    ($SortWrappers.$RefTo$Snap $t@2759))))
(declare-const $k@2760 $Perm)
(assert ($Perm.isValidVar $k@2760))
(assert ($Perm.isReadVar $k@2760 $Perm.Write))
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (implies (< $Perm.No (+ (- $k@2618 $k@2705) $k@2731)) (= $t@2758 $t@2720)))
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2760) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2760) $Perm.No)))
(assert (not (= $t@2758 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $t@2759 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@2761 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2762 $Perm)
(assert ($Perm.isValidVar $k@2762))
(assert ($Perm.isReadVar $k@2762 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2762 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2762 (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2760)))
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2763 $Perm)
(assert ($Perm.isValidVar $k@2763))
(assert ($Perm.isReadVar $k@2763 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2763 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2763 (+ (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702) $k@2728)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2764 $Perm)
(assert ($Perm.isValidVar $k@2764))
(assert ($Perm.isReadVar $k@2764 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2764 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2764 (+ (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703) $k@2729)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2765 $Perm)
(assert ($Perm.isValidVar $k@2765))
(assert ($Perm.isReadVar $k@2765 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2765 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2765 (+ (- $k@2616 $k@2704) $k@2730)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2766 $Perm)
(assert ($Perm.isValidVar $k@2766))
(assert ($Perm.isReadVar $k@2766 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2766 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2760) $k@2762) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2760) $k@2762) $Perm.No)))
(assert (< $k@2766 (- (+ (+ (- $k@2618 $k@2705) $k@2731) $k@2760) $k@2762)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2758 diz@2605)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (= $t@2758 diz@2605))
(declare-const $k@2767 $Perm)
(assert ($Perm.isValidVar $k@2767))
(assert ($Perm.isReadVar $k@2767 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2767 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2767 (+ (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706) $k@2732)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2768 $Perm)
(assert ($Perm.isValidVar $k@2768))
(assert ($Perm.isReadVar $k@2768 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2768 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2755)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2755)
    $Perm.No)))
(assert (<
  $k@2768
  (- (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733) $k@2755)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 15] sys__result@2734 != 0
(assert (not (= sys__result@2734 0)))
(pop) ; 6
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 6
(assert (not (= sys__result@2734 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= sys__result@2734 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 16] sys__result@2734 != 0
(assert (not (= sys__result@2734 0)))
(declare-const $k@2769 $Perm)
(assert ($Perm.isValidVar $k@2769))
(assert ($Perm.isReadVar $k@2769 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2769 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2769 (+ (- (+ (- $k@2612 $k@2678) $k@2699) $k@2702) $k@2728)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2770 $Perm)
(assert ($Perm.isValidVar $k@2770))
(assert ($Perm.isReadVar $k@2770 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2770 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2770 (+ (- (+ (- $k@2614 $k@2679) $k@2700) $k@2703) $k@2729)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2771 $Perm)
(assert ($Perm.isValidVar $k@2771))
(assert ($Perm.isReadVar $k@2771 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2771 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2771 (+ (- $k@2616 $k@2704) $k@2730)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2772 $Perm)
(assert ($Perm.isValidVar $k@2772))
(assert ($Perm.isReadVar $k@2772 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2772 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2772 (+ (- $k@2618 $k@2705) $k@2731)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 7
(assert (not (= $t@2617 $t@2723)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(declare-const $k@2773 $Perm)
(assert ($Perm.isValidVar $k@2773))
(assert ($Perm.isReadVar $k@2773 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2773 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2773 (+ (- (+ (- $k@2620 $k@2677) $k@2698) $k@2706) $k@2732)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2774 $Perm)
(assert ($Perm.isValidVar $k@2774))
(assert ($Perm.isReadVar $k@2774 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2774 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2755)
    $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not
  (=
    (-
      (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733)
      $k@2755)
    $Perm.No)))
(assert (<
  $k@2774
  (- (+ (- (+ (- (+ $k@2622 $k@2640) $k@2680) $k@2701) $k@2707) $k@2733) $k@2755)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 7
(assert (not (= $t@2621 $t@2717)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 16] sys__result@2734 == 0
(assert (= sys__result@2734 0))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 14] sys__result@2734 + 1 < $t@2727
(assert (< (+ sys__result@2734 1) $t@2727))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__offer ----------
(declare-const diz@2775 $Ref)
(declare-const val@2776 Int)
(declare-const sys__result@2777 Bool)
(declare-const currentCount@2778 Int)
(declare-const __flatten_100@2779 Int)
(declare-const __flatten_101@2780 Bool)
(declare-const c@2781 Int)
(declare-const __flatten_102@2782 Int)
(declare-const __flatten_104@2783 Int)
(declare-const __flatten_105@2784 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2775 $Ref.null)))
(declare-const $k@2785 $Perm)
(assert ($Perm.isValidVar $k@2785))
(assert ($Perm.isReadVar $k@2785 $Perm.Write))
(declare-const $t@2786 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2785 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2785 $Perm.No)))
(assert (> $t@2786 0))
(declare-const $k@2787 $Perm)
(assert ($Perm.isValidVar $k@2787))
(assert ($Perm.isReadVar $k@2787 $Perm.Write))
(declare-const $t@2788 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@2787 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2787 $Perm.No)))
(assert (not (= $t@2788 $Ref.null)))
(declare-const $k@2789 $Perm)
(assert ($Perm.isValidVar $k@2789))
(assert ($Perm.isReadVar $k@2789 $Perm.Write))
(declare-const $t@2790 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@2789 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2789 $Perm.No)))
(assert (not (= $t@2790 $Ref.null)))
(declare-const $k@2791 $Perm)
(assert ($Perm.isValidVar $k@2791))
(assert ($Perm.isReadVar $k@2791 $Perm.Write))
(declare-const $t@2792 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2791 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2791 $Perm.No)))
(assert (= $t@2792 diz@2775))
(declare-const $k@2793 $Perm)
(assert ($Perm.isValidVar $k@2793))
(assert ($Perm.isReadVar $k@2793 $Perm.Write))
(declare-const $t@2794 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@2793 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2793 $Perm.No)))
(assert (not (= $t@2794 $Ref.null)))
(declare-const $k@2795 $Perm)
(assert ($Perm.isValidVar $k@2795))
(assert ($Perm.isReadVar $k@2795 $Perm.Write))
(declare-const $t@2796 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2795 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2795 $Perm.No)))
(assert (= $t@2796 diz@2775))
(push) ; 3
(declare-const $k@2797 $Perm)
(assert ($Perm.isValidVar $k@2797))
(assert ($Perm.isReadVar $k@2797 $Perm.Write))
(declare-const $t@2798 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2797 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2797 $Perm.No)))
(assert (> $t@2798 0))
(declare-const $k@2799 $Perm)
(assert ($Perm.isValidVar $k@2799))
(assert ($Perm.isReadVar $k@2799 $Perm.Write))
(declare-const $t@2800 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2799 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2799 $Perm.No)))
(assert (not (= $t@2800 $Ref.null)))
(declare-const $k@2801 $Perm)
(assert ($Perm.isValidVar $k@2801))
(assert ($Perm.isReadVar $k@2801 $Perm.Write))
(declare-const $t@2802 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2801 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2801 $Perm.No)))
(assert (not (= $t@2802 $Ref.null)))
(declare-const $k@2803 $Perm)
(assert ($Perm.isValidVar $k@2803))
(assert ($Perm.isReadVar $k@2803 $Perm.Write))
(declare-const $t@2804 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2803 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2803 $Perm.No)))
(assert (= $t@2804 diz@2775))
(declare-const $k@2805 $Perm)
(assert ($Perm.isValidVar $k@2805))
(assert ($Perm.isReadVar $k@2805 $Perm.Write))
(declare-const $t@2806 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2805 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2805 $Perm.No)))
(assert (not (= $t@2806 $Ref.null)))
(declare-const $k@2807 $Perm)
(assert ($Perm.isValidVar $k@2807))
(assert ($Perm.isReadVar $k@2807 $Perm.Write))
(declare-const $t@2808 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2807 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2807 $Perm.No)))
(assert (= $t@2808 diz@2775))
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_100 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2809 Int)
; [exec]
; currentCount := __flatten_100
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 4
(assert (not (not (= sys__result@2809 $t@2786))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@2809 $t@2786)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 17] sys__result@2809 == $t@2786
(assert (= sys__result@2809 $t@2786))
; [exec]
; __flatten_101 := false
; [exec]
; sys__result := __flatten_101
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2810 $Perm)
(assert ($Perm.isValidVar $k@2810))
(assert ($Perm.isReadVar $k@2810 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2810 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2810 $k@2785))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2811 $Perm)
(assert ($Perm.isValidVar $k@2811))
(assert ($Perm.isReadVar $k@2811 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2811 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2811 $k@2787))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2812 $Perm)
(assert ($Perm.isValidVar $k@2812))
(assert ($Perm.isReadVar $k@2812 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2812 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2812 $k@2789))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2813 $Perm)
(assert ($Perm.isValidVar $k@2813))
(assert ($Perm.isReadVar $k@2813 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2813 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2813 $k@2791))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@2814 $Perm)
(assert ($Perm.isValidVar $k@2814))
(assert ($Perm.isReadVar $k@2814 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2814 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2814 $k@2793))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2815 $Perm)
(assert ($Perm.isValidVar $k@2815))
(assert ($Perm.isReadVar $k@2815 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2815 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2815 $k@2795))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 4
(push) ; 4
; [else-branch 17] sys__result@2809 != $t@2786
(assert (not (= sys__result@2809 $t@2786)))
(pop) ; 4
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 4
(assert (not (= sys__result@2809 $t@2786)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= sys__result@2809 $t@2786))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 18] sys__result@2809 != $t@2786
(assert (not (= sys__result@2809 $t@2786)))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@2816 $Snap)
(declare-const $t@2817 $Snap)
(assert (= $t@2816 ($Snap.combine $t@2817 $Snap.unit)))
(declare-const $t@2818 $Ref)
(declare-const $t@2819 $Ref)
(assert (=
  $t@2817
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2818)
    ($SortWrappers.$RefTo$Snap $t@2819))))
(declare-const $k@2820 $Perm)
(assert ($Perm.isValidVar $k@2820))
(assert ($Perm.isReadVar $k@2820 $Perm.Write))
(assert (= $t@2796 $t@2818))
(push) ; 5
(assert (not (not (= (+ $k@2795 $k@2820) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $k@2795 $k@2820) $Perm.No)))
(assert (not (= $t@2796 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(assert (not (= $t@2819 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@2821 $Snap)
; [exec]
; c := -1
; [eval] -1
; [exec]
; __flatten_102 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2822 Int)
; [exec]
; currentCount := __flatten_102
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (< sys__result@2822 $t@2786))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (< sys__result@2822 $t@2786)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 19] sys__result@2822 < $t@2786
(assert (< sys__result@2822 $t@2786))
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@2823 $Perm)
(assert ($Perm.isValidVar $k@2823))
(assert ($Perm.isReadVar $k@2823 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2823 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2823 $k@2785))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2824 $Perm)
(assert ($Perm.isValidVar $k@2824))
(assert ($Perm.isReadVar $k@2824 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2824 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2824 $k@2787))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2825 $Perm)
(assert ($Perm.isValidVar $k@2825))
(assert ($Perm.isReadVar $k@2825 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2825 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2825 $k@2789))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2826 $Perm)
(assert ($Perm.isValidVar $k@2826))
(assert ($Perm.isReadVar $k@2826 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2826 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2826 $k@2791))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@2827 $Perm)
(assert ($Perm.isValidVar $k@2827))
(assert ($Perm.isReadVar $k@2827 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2827 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2827 $k@2793))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2828 $Perm)
(assert ($Perm.isValidVar $k@2828))
(assert ($Perm.isReadVar $k@2828 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2828 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2828 (+ $k@2795 $k@2820)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const $t@2829 $Snap)
(declare-const $t@2830 $Snap)
(assert (= $t@2829 ($Snap.combine $t@2830 $Snap.unit)))
(declare-const $t@2831 $Snap)
(declare-const $t@2832 $Ref)
(assert (= $t@2830 ($Snap.combine $t@2831 ($SortWrappers.$RefTo$Snap $t@2832))))
(declare-const $t@2833 $Snap)
(assert (= $t@2831 ($Snap.combine $t@2833 $Snap.unit)))
(declare-const $t@2834 $Snap)
(declare-const $t@2835 $Ref)
(assert (= $t@2833 ($Snap.combine $t@2834 ($SortWrappers.$RefTo$Snap $t@2835))))
(declare-const $t@2836 $Snap)
(assert (= $t@2834 ($Snap.combine $t@2836 $Snap.unit)))
(declare-const $t@2837 $Snap)
(declare-const $t@2838 $Ref)
(assert (= $t@2836 ($Snap.combine $t@2837 ($SortWrappers.$RefTo$Snap $t@2838))))
(declare-const $t@2839 $Snap)
(assert (= $t@2837 ($Snap.combine $t@2839 $Snap.unit)))
(declare-const $t@2840 $Snap)
(declare-const $t@2841 $Ref)
(assert (= $t@2839 ($Snap.combine $t@2840 ($SortWrappers.$RefTo$Snap $t@2841))))
(declare-const $t@2842 $Snap)
(assert (= $t@2840 ($Snap.combine $t@2842 $Snap.unit)))
(declare-const $t@2843 $Snap)
(declare-const $t@2844 $Ref)
(assert (= $t@2842 ($Snap.combine $t@2843 ($SortWrappers.$RefTo$Snap $t@2844))))
(declare-const $t@2845 $Snap)
(assert (= $t@2843 ($Snap.combine $t@2845 $Snap.unit)))
(declare-const $t@2846 Int)
(declare-const $t@2847 $Ref)
(assert (=
  $t@2845
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2846)
    ($SortWrappers.$RefTo$Snap $t@2847))))
(declare-const $t@2848 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2846)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2848) $Snap.unit)))
(declare-const $k@2849 $Perm)
(assert ($Perm.isValidVar $k@2849))
(assert ($Perm.isReadVar $k@2849 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2785 $k@2823)) (= $t@2848 $t@2786)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2785 $k@2823) $k@2849) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2785 $k@2823) $k@2849) $Perm.No)))
(assert (> $t@2848 0))
(declare-const $k@2850 $Perm)
(assert ($Perm.isValidVar $k@2850))
(assert ($Perm.isReadVar $k@2850 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2787 $k@2824)) (= $t@2847 $t@2788)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@2787 $k@2824) $k@2850) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2787 $k@2824) $k@2850) $Perm.No)))
(assert (not (= $t@2847 $Ref.null)))
(declare-const $k@2851 $Perm)
(assert ($Perm.isValidVar $k@2851))
(assert ($Perm.isReadVar $k@2851 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2789 $k@2825)) (= $t@2844 $t@2790)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@2789 $k@2825) $k@2851) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2789 $k@2825) $k@2851) $Perm.No)))
(assert (not (= $t@2844 $Ref.null)))
(declare-const $k@2852 $Perm)
(assert ($Perm.isValidVar $k@2852))
(assert ($Perm.isReadVar $k@2852 $Perm.Write))
(push) ; 6
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- $k@2791 $k@2826)) (= $t@2841 $t@2792)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 6
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- $k@2791 $k@2826) $k@2852) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2791 $k@2826) $k@2852) $Perm.No)))
(assert (= $t@2841 diz@2775))
(declare-const $k@2853 $Perm)
(assert ($Perm.isValidVar $k@2853))
(assert ($Perm.isReadVar $k@2853 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2793 $k@2827)) (= $t@2838 $t@2794)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@2793 $k@2827) $k@2853) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2793 $k@2827) $k@2853) $Perm.No)))
(assert (not (= $t@2838 $Ref.null)))
(declare-const $k@2854 $Perm)
(assert ($Perm.isValidVar $k@2854))
(assert ($Perm.isReadVar $k@2854 $Perm.Write))
(push) ; 6
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- (+ $k@2795 $k@2820) $k@2828)) (= $t@2835 $t@2796)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 6
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $Perm.No)))
(assert (= $t@2835 diz@2775))
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@2832 $Ref.null)))
; [exec]
; __flatten_104 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2855 Int)
; [exec]
; c := __flatten_104
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 6
(assert (not (not (< (+ sys__result@2855 1) $t@2848))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (< (+ sys__result@2855 1) $t@2848)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 20] sys__result@2855 + 1 < $t@2848
(assert (< (+ sys__result@2855 1) $t@2848))
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2856 $Perm)
(assert ($Perm.isValidVar $k@2856))
(assert ($Perm.isReadVar $k@2856 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2856 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2856 (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854)))
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2835 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2775 $t@2835)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2835 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2775 $t@2835)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == 0
(push) ; 7
(assert (not (not (= sys__result@2855 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@2855 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 21] sys__result@2855 == 0
(assert (= sys__result@2855 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2857 $Snap)
(declare-const $t@2858 $Snap)
(assert (= $t@2857 ($Snap.combine $t@2858 $Snap.unit)))
(declare-const $t@2859 $Ref)
(declare-const $t@2860 $Ref)
(assert (=
  $t@2858
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2859)
    ($SortWrappers.$RefTo$Snap $t@2860))))
(declare-const $k@2861 $Perm)
(assert ($Perm.isValidVar $k@2861))
(assert ($Perm.isReadVar $k@2861 $Perm.Write))
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@2791 $k@2826) $k@2852)) (= $t@2859 $t@2841)))
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2861) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2861) $Perm.No)))
(assert (not (= $t@2859 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@2860 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@2862 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2863 $Perm)
(assert ($Perm.isValidVar $k@2863))
(assert ($Perm.isReadVar $k@2863 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2863 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2863 (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2861)))
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_105 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_105
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2864 $Perm)
(assert ($Perm.isValidVar $k@2864))
(assert ($Perm.isReadVar $k@2864 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2864 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2864 (+ (- $k@2785 $k@2823) $k@2849)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2865 $Perm)
(assert ($Perm.isValidVar $k@2865))
(assert ($Perm.isReadVar $k@2865 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2865 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2865 (+ (- $k@2787 $k@2824) $k@2850)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2866 $Perm)
(assert ($Perm.isValidVar $k@2866))
(assert ($Perm.isReadVar $k@2866 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2866 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2866 (+ (- $k@2789 $k@2825) $k@2851)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2867 $Perm)
(assert ($Perm.isValidVar $k@2867))
(assert ($Perm.isReadVar $k@2867 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2867 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2861) $k@2863) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2861) $k@2863) $Perm.No)))
(assert (< $k@2867 (- (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2861) $k@2863)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2859 diz@2775)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@2859 diz@2775))
(declare-const $k@2868 $Perm)
(assert ($Perm.isValidVar $k@2868))
(assert ($Perm.isReadVar $k@2868 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2868 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2868 (+ (- $k@2793 $k@2827) $k@2853)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2869 $Perm)
(assert ($Perm.isValidVar $k@2869))
(assert ($Perm.isReadVar $k@2869 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2869 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2856) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2856) $Perm.No)))
(assert (< $k@2869 (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2856)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 21] sys__result@2855 != 0
(assert (not (= sys__result@2855 0)))
(pop) ; 7
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 7
(assert (not (= sys__result@2855 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@2855 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 22] sys__result@2855 != 0
(assert (not (= sys__result@2855 0)))
; [exec]
; __flatten_105 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_105
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2870 $Perm)
(assert ($Perm.isValidVar $k@2870))
(assert ($Perm.isReadVar $k@2870 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2870 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2870 (+ (- $k@2785 $k@2823) $k@2849)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2871 $Perm)
(assert ($Perm.isValidVar $k@2871))
(assert ($Perm.isReadVar $k@2871 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2871 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2871 (+ (- $k@2787 $k@2824) $k@2850)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2872 $Perm)
(assert ($Perm.isValidVar $k@2872))
(assert ($Perm.isReadVar $k@2872 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2872 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2872 (+ (- $k@2789 $k@2825) $k@2851)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2873 $Perm)
(assert ($Perm.isValidVar $k@2873))
(assert ($Perm.isReadVar $k@2873 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2873 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2873 (+ (- $k@2791 $k@2826) $k@2852)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@2874 $Perm)
(assert ($Perm.isValidVar $k@2874))
(assert ($Perm.isReadVar $k@2874 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2874 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2874 (+ (- $k@2793 $k@2827) $k@2853)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2875 $Perm)
(assert ($Perm.isValidVar $k@2875))
(assert ($Perm.isReadVar $k@2875 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2875 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2856) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2856) $Perm.No)))
(assert (< $k@2875 (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2856)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 22] sys__result@2855 == 0
(assert (= sys__result@2855 0))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 20] !sys__result@2855 + 1 < $t@2848
(assert (not (< (+ sys__result@2855 1) $t@2848)))
(pop) ; 6
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 6
(assert (not (< (+ sys__result@2855 1) $t@2848)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (< (+ sys__result@2855 1) $t@2848))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 23] !sys__result@2855 + 1 < $t@2848
(assert (not (< (+ sys__result@2855 1) $t@2848)))
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2876 $Perm)
(assert ($Perm.isValidVar $k@2876))
(assert ($Perm.isReadVar $k@2876 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2876 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2876 (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854)))
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2835 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2775 $t@2835)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 7
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2835 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2775 $t@2835)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == 0
(push) ; 7
(assert (not (not (= sys__result@2855 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@2855 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 24] sys__result@2855 == 0
(assert (= sys__result@2855 0))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2877 $Snap)
(declare-const $t@2878 $Snap)
(assert (= $t@2877 ($Snap.combine $t@2878 $Snap.unit)))
(declare-const $t@2879 $Ref)
(declare-const $t@2880 $Ref)
(assert (=
  $t@2878
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2879)
    ($SortWrappers.$RefTo$Snap $t@2880))))
(declare-const $k@2881 $Perm)
(assert ($Perm.isValidVar $k@2881))
(assert ($Perm.isReadVar $k@2881 $Perm.Write))
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@2791 $k@2826) $k@2852)) (= $t@2879 $t@2841)))
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2881) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2881) $Perm.No)))
(assert (not (= $t@2879 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@2880 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@2882 $Snap)
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2883 $Perm)
(assert ($Perm.isValidVar $k@2883))
(assert ($Perm.isReadVar $k@2883 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2883 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2883 (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2881)))
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_105 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_105
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2884 $Perm)
(assert ($Perm.isValidVar $k@2884))
(assert ($Perm.isReadVar $k@2884 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2884 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2884 (+ (- $k@2785 $k@2823) $k@2849)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2885 $Perm)
(assert ($Perm.isValidVar $k@2885))
(assert ($Perm.isReadVar $k@2885 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2885 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2885 (+ (- $k@2787 $k@2824) $k@2850)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2886 $Perm)
(assert ($Perm.isValidVar $k@2886))
(assert ($Perm.isReadVar $k@2886 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2886 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2886 (+ (- $k@2789 $k@2825) $k@2851)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2887 $Perm)
(assert ($Perm.isValidVar $k@2887))
(assert ($Perm.isReadVar $k@2887 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2887 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2881) $k@2883) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2881) $k@2883) $Perm.No)))
(assert (< $k@2887 (- (+ (+ (- $k@2791 $k@2826) $k@2852) $k@2881) $k@2883)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2879 diz@2775)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@2879 diz@2775))
(declare-const $k@2888 $Perm)
(assert ($Perm.isValidVar $k@2888))
(assert ($Perm.isReadVar $k@2888 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2888 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2888 (+ (- $k@2793 $k@2827) $k@2853)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2889 $Perm)
(assert ($Perm.isValidVar $k@2889))
(assert ($Perm.isReadVar $k@2889 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2889 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2876) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2876) $Perm.No)))
(assert (< $k@2889 (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2876)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 24] sys__result@2855 != 0
(assert (not (= sys__result@2855 0)))
(pop) ; 7
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 7
(assert (not (= sys__result@2855 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@2855 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 25] sys__result@2855 != 0
(assert (not (= sys__result@2855 0)))
; [exec]
; __flatten_105 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_105
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2890 $Perm)
(assert ($Perm.isValidVar $k@2890))
(assert ($Perm.isReadVar $k@2890 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2890 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2890 (+ (- $k@2785 $k@2823) $k@2849)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2891 $Perm)
(assert ($Perm.isValidVar $k@2891))
(assert ($Perm.isReadVar $k@2891 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2891 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2891 (+ (- $k@2787 $k@2824) $k@2850)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2892 $Perm)
(assert ($Perm.isValidVar $k@2892))
(assert ($Perm.isReadVar $k@2892 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2892 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2892 (+ (- $k@2789 $k@2825) $k@2851)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2893 $Perm)
(assert ($Perm.isValidVar $k@2893))
(assert ($Perm.isReadVar $k@2893 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2893 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2893 (+ (- $k@2791 $k@2826) $k@2852)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2790 $t@2844)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@2894 $Perm)
(assert ($Perm.isValidVar $k@2894))
(assert ($Perm.isReadVar $k@2894 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2894 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2894 (+ (- $k@2793 $k@2827) $k@2853)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2895 $Perm)
(assert ($Perm.isValidVar $k@2895))
(assert ($Perm.isReadVar $k@2895 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2895 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2876) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2876) $Perm.No)))
(assert (< $k@2895 (- (+ (- (+ $k@2795 $k@2820) $k@2828) $k@2854) $k@2876)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2794 $t@2838)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 25] sys__result@2855 == 0
(assert (= sys__result@2855 0))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 23] sys__result@2855 + 1 < $t@2848
(assert (< (+ sys__result@2855 1) $t@2848))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 19] !sys__result@2822 < $t@2786
(assert (not (< sys__result@2822 $t@2786)))
(pop) ; 5
; [eval] !(currentCount < diz.BlockingQueue__capacity)
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 5
(assert (not (< sys__result@2822 $t@2786)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (< sys__result@2822 $t@2786))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 26] !sys__result@2822 < $t@2786
(assert (not (< sys__result@2822 $t@2786)))
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2896 $Perm)
(assert ($Perm.isValidVar $k@2896))
(assert ($Perm.isReadVar $k@2896 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2896 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2896 (+ $k@2795 $k@2820)))
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
; [dead then-branch 27] -1 == 0
(push) ; 6
; [else-branch 27] -1 != 0
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
; [then-branch 28] -1 != 0
(assert (not (= (- 0 1) 0)))
; [exec]
; __flatten_105 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_105
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2897 $Perm)
(assert ($Perm.isValidVar $k@2897))
(assert ($Perm.isReadVar $k@2897 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2897 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2897 $k@2785))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2898 $Perm)
(assert ($Perm.isValidVar $k@2898))
(assert ($Perm.isReadVar $k@2898 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2898 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2898 $k@2787))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2899 $Perm)
(assert ($Perm.isValidVar $k@2899))
(assert ($Perm.isReadVar $k@2899 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2899 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2899 $k@2789))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2900 $Perm)
(assert ($Perm.isValidVar $k@2900))
(assert ($Perm.isReadVar $k@2900 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2900 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2900 $k@2791))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@2901 $Perm)
(assert ($Perm.isValidVar $k@2901))
(assert ($Perm.isReadVar $k@2901 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2901 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2901 $k@2793))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2902 $Perm)
(assert ($Perm.isValidVar $k@2902))
(assert ($Perm.isReadVar $k@2902 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2902 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ $k@2795 $k@2820) $k@2896) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ $k@2795 $k@2820) $k@2896) $Perm.No)))
(assert (< $k@2902 (- (+ $k@2795 $k@2820) $k@2896)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 28] -1 == 0
(pop) ; 5
(push) ; 5
; [else-branch 26] sys__result@2822 < $t@2786
(assert (< sys__result@2822 $t@2786))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 18] sys__result@2809 == $t@2786
(assert (= sys__result@2809 $t@2786))
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__poll ----------
(declare-const diz@2903 $Ref)
(declare-const sys__result@2904 $Ref)
(declare-const x@2905 $Ref)
(declare-const currentCount@2906 Int)
(declare-const __flatten_106@2907 Int)
(declare-const __flatten_107@2908 $Ref)
(declare-const c@2909 Int)
(declare-const __flatten_108@2910 Int)
(declare-const __flatten_109@2911 Int)
(declare-const __flatten_110@2912 $Ref)
(declare-const __flatten_111@2913 Int)
(declare-const __flatten_112@2914 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2903 $Ref.null)))
(declare-const $k@2915 $Perm)
(assert ($Perm.isValidVar $k@2915))
(assert ($Perm.isReadVar $k@2915 $Perm.Write))
(declare-const $t@2916 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2915 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2915 $Perm.No)))
(assert (> $t@2916 0))
(declare-const $k@2917 $Perm)
(assert ($Perm.isValidVar $k@2917))
(assert ($Perm.isReadVar $k@2917 $Perm.Write))
(declare-const $t@2918 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@2917 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2917 $Perm.No)))
(assert (not (= $t@2918 $Ref.null)))
(declare-const $k@2919 $Perm)
(assert ($Perm.isValidVar $k@2919))
(assert ($Perm.isReadVar $k@2919 $Perm.Write))
(declare-const $t@2920 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@2919 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2919 $Perm.No)))
(assert (not (= $t@2920 $Ref.null)))
(declare-const $k@2921 $Perm)
(assert ($Perm.isValidVar $k@2921))
(assert ($Perm.isReadVar $k@2921 $Perm.Write))
(declare-const $t@2922 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2921 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2921 $Perm.No)))
(assert (= $t@2922 diz@2903))
(declare-const $k@2923 $Perm)
(assert ($Perm.isValidVar $k@2923))
(assert ($Perm.isReadVar $k@2923 $Perm.Write))
(declare-const $t@2924 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@2923 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2923 $Perm.No)))
(assert (not (= $t@2924 $Ref.null)))
(declare-const $k@2925 $Perm)
(assert ($Perm.isValidVar $k@2925))
(assert ($Perm.isReadVar $k@2925 $Perm.Write))
(declare-const $t@2926 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@2925 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2925 $Perm.No)))
(assert (= $t@2926 diz@2903))
(push) ; 3
(declare-const $k@2927 $Perm)
(assert ($Perm.isValidVar $k@2927))
(assert ($Perm.isReadVar $k@2927 $Perm.Write))
(declare-const $t@2928 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2927 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2927 $Perm.No)))
(assert (> $t@2928 0))
(declare-const $k@2929 $Perm)
(assert ($Perm.isValidVar $k@2929))
(assert ($Perm.isReadVar $k@2929 $Perm.Write))
(declare-const $t@2930 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@2929 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2929 $Perm.No)))
(assert (not (= $t@2930 $Ref.null)))
(declare-const $k@2931 $Perm)
(assert ($Perm.isValidVar $k@2931))
(assert ($Perm.isReadVar $k@2931 $Perm.Write))
(declare-const $t@2932 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@2931 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2931 $Perm.No)))
(assert (not (= $t@2932 $Ref.null)))
(declare-const $k@2933 $Perm)
(assert ($Perm.isValidVar $k@2933))
(assert ($Perm.isReadVar $k@2933 $Perm.Write))
(declare-const $t@2934 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2933 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2933 $Perm.No)))
(assert (= $t@2934 diz@2903))
(declare-const $k@2935 $Perm)
(assert ($Perm.isValidVar $k@2935))
(assert ($Perm.isReadVar $k@2935 $Perm.Write))
(declare-const $t@2936 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@2935 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2935 $Perm.No)))
(assert (not (= $t@2936 $Ref.null)))
(declare-const $k@2937 $Perm)
(assert ($Perm.isValidVar $k@2937))
(assert ($Perm.isReadVar $k@2937 $Perm.Write))
(declare-const $t@2938 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@2937 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2937 $Perm.No)))
(assert (= $t@2938 diz@2903))
(pop) ; 3
(push) ; 3
; [exec]
; x := null
; [exec]
; __flatten_106 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2939 Int)
; [exec]
; currentCount := __flatten_106
; [eval] currentCount == 0
(push) ; 4
(assert (not (not (= sys__result@2939 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@2939 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 29] sys__result@2939 == 0
(assert (= sys__result@2939 0))
; [exec]
; __flatten_107 := x
; [exec]
; sys__result := __flatten_107
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@2940 $Perm)
(assert ($Perm.isValidVar $k@2940))
(assert ($Perm.isReadVar $k@2940 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2940 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2940 $k@2915))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2941 $Perm)
(assert ($Perm.isValidVar $k@2941))
(assert ($Perm.isReadVar $k@2941 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2941 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2941 $k@2917))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2942 $Perm)
(assert ($Perm.isValidVar $k@2942))
(assert ($Perm.isReadVar $k@2942 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2942 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2942 $k@2919))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2943 $Perm)
(assert ($Perm.isValidVar $k@2943))
(assert ($Perm.isReadVar $k@2943 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2943 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2943 $k@2921))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@2944 $Perm)
(assert ($Perm.isValidVar $k@2944))
(assert ($Perm.isReadVar $k@2944 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2944 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2944 $k@2923))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2945 $Perm)
(assert ($Perm.isValidVar $k@2945))
(assert ($Perm.isReadVar $k@2945 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2945 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2945 $k@2925))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 4
(push) ; 4
; [else-branch 29] sys__result@2939 != 0
(assert (not (= sys__result@2939 0)))
(pop) ; 4
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 4
(assert (not (= sys__result@2939 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= sys__result@2939 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 30] sys__result@2939 != 0
(assert (not (= sys__result@2939 0)))
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@2946 $Snap)
(declare-const $t@2947 $Snap)
(assert (= $t@2946 ($Snap.combine $t@2947 $Snap.unit)))
(declare-const $t@2948 $Ref)
(declare-const $t@2949 $Ref)
(assert (=
  $t@2947
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2948)
    ($SortWrappers.$RefTo$Snap $t@2949))))
(declare-const $k@2950 $Perm)
(assert ($Perm.isValidVar $k@2950))
(assert ($Perm.isReadVar $k@2950 $Perm.Write))
(assert (= $t@2922 $t@2948))
(push) ; 5
(assert (not (not (= (+ $k@2921 $k@2950) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $k@2921 $k@2950) $Perm.No)))
(assert (not (= $t@2922 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@2949 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@2951 $Snap)
; [exec]
; __flatten_108 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2952 Int)
; [exec]
; currentCount := __flatten_108
; [eval] currentCount > 0
(push) ; 5
(assert (not (not (> sys__result@2952 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (> sys__result@2952 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 31] sys__result@2952 > 0
(assert (> sys__result@2952 0))
; [exec]
; inhale diz.BlockingQueue__head != null
; [eval] diz.BlockingQueue__head != null
; [exec]
; __flatten_109 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@2953 $Perm)
(assert ($Perm.isValidVar $k@2953))
(assert ($Perm.isReadVar $k@2953 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2953 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2953 $k@2915))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2954 $Perm)
(assert ($Perm.isValidVar $k@2954))
(assert ($Perm.isReadVar $k@2954 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2954 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2954 $k@2917))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@2955 $Perm)
(assert ($Perm.isValidVar $k@2955))
(assert ($Perm.isReadVar $k@2955 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2955 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2955 $k@2919))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@2956 $Perm)
(assert ($Perm.isValidVar $k@2956))
(assert ($Perm.isReadVar $k@2956 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2956 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2956 (+ $k@2921 $k@2950)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@2957 $Perm)
(assert ($Perm.isValidVar $k@2957))
(assert ($Perm.isReadVar $k@2957 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2957 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2957 $k@2923))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@2958 $Perm)
(assert ($Perm.isValidVar $k@2958))
(assert ($Perm.isReadVar $k@2958 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2958 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@2958 $k@2925))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(declare-const sys__result@2959 Int)
(declare-const $t@2960 $Snap)
(declare-const $t@2961 $Snap)
(assert (= $t@2960 ($Snap.combine $t@2961 $Snap.unit)))
(declare-const $t@2962 $Snap)
(declare-const $t@2963 $Ref)
(assert (= $t@2961 ($Snap.combine $t@2962 ($SortWrappers.$RefTo$Snap $t@2963))))
(declare-const $t@2964 $Snap)
(assert (= $t@2962 ($Snap.combine $t@2964 $Snap.unit)))
(declare-const $t@2965 $Snap)
(declare-const $t@2966 $Ref)
(assert (= $t@2964 ($Snap.combine $t@2965 ($SortWrappers.$RefTo$Snap $t@2966))))
(declare-const $t@2967 $Snap)
(assert (= $t@2965 ($Snap.combine $t@2967 $Snap.unit)))
(declare-const $t@2968 $Snap)
(declare-const $t@2969 $Ref)
(assert (= $t@2967 ($Snap.combine $t@2968 ($SortWrappers.$RefTo$Snap $t@2969))))
(declare-const $t@2970 $Snap)
(assert (= $t@2968 ($Snap.combine $t@2970 $Snap.unit)))
(declare-const $t@2971 $Snap)
(declare-const $t@2972 $Ref)
(assert (= $t@2970 ($Snap.combine $t@2971 ($SortWrappers.$RefTo$Snap $t@2972))))
(declare-const $t@2973 $Snap)
(assert (= $t@2971 ($Snap.combine $t@2973 $Snap.unit)))
(declare-const $t@2974 $Snap)
(declare-const $t@2975 $Ref)
(assert (= $t@2973 ($Snap.combine $t@2974 ($SortWrappers.$RefTo$Snap $t@2975))))
(declare-const $t@2976 $Snap)
(assert (= $t@2974 ($Snap.combine $t@2976 $Snap.unit)))
(declare-const $t@2977 Int)
(declare-const $t@2978 $Ref)
(assert (=
  $t@2976
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2977)
    ($SortWrappers.$RefTo$Snap $t@2978))))
(declare-const $t@2979 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2977)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2979) $Snap.unit)))
(declare-const $k@2980 $Perm)
(assert ($Perm.isValidVar $k@2980))
(assert ($Perm.isReadVar $k@2980 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2915 $k@2953)) (= $t@2979 $t@2916)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2915 $k@2953) $k@2980) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2915 $k@2953) $k@2980) $Perm.No)))
(assert (> $t@2979 0))
(declare-const $k@2981 $Perm)
(assert ($Perm.isValidVar $k@2981))
(assert ($Perm.isReadVar $k@2981 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2917 $k@2954)) (= $t@2978 $t@2918)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@2917 $k@2954) $k@2981) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2917 $k@2954) $k@2981) $Perm.No)))
(assert (not (= $t@2978 $Ref.null)))
(declare-const $k@2982 $Perm)
(assert ($Perm.isValidVar $k@2982))
(assert ($Perm.isReadVar $k@2982 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2919 $k@2955)) (= $t@2975 $t@2920)))
; [eval] diz.BlockingQueue__headLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@2919 $k@2955) $k@2982) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2919 $k@2955) $k@2982) $Perm.No)))
(assert (not (= $t@2975 $Ref.null)))
(declare-const $k@2983 $Perm)
(assert ($Perm.isValidVar $k@2983))
(assert ($Perm.isReadVar $k@2983 $Perm.Write))
(push) ; 6
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- (+ $k@2921 $k@2950) $k@2956)) (= $t@2972 $t@2922)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 6
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $Perm.No)))
(assert (= $t@2972 diz@2903))
(declare-const $k@2984 $Perm)
(assert ($Perm.isValidVar $k@2984))
(assert ($Perm.isReadVar $k@2984 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2923 $k@2957)) (= $t@2969 $t@2924)))
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 6
(assert (not (not (= (+ (- $k@2923 $k@2957) $k@2984) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2923 $k@2957) $k@2984) $Perm.No)))
(assert (not (= $t@2969 $Ref.null)))
(declare-const $k@2985 $Perm)
(assert ($Perm.isValidVar $k@2985))
(assert ($Perm.isReadVar $k@2985 $Perm.Write))
(push) ; 6
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (implies (< $Perm.No (- $k@2925 $k@2958)) (= $t@2966 $t@2926)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 6
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- $k@2925 $k@2958) $k@2985) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2925 $k@2958) $k@2985) $Perm.No)))
(assert (= $t@2966 diz@2903))
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@2963 $Ref.null)))
; [exec]
; __flatten_110 := Integer__Integer(__flatten_109)
(declare-const sys__result@2986 $Ref)
(declare-const $t@2987 $Snap)
(declare-const $t@2988 Int)
(assert (= $t@2987 ($Snap.combine ($SortWrappers.IntTo$Snap $t@2988) $Snap.unit)))
(declare-const $t@2989 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2988)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@2989))))
; [eval] sys__result != null
(assert (not (= sys__result@2986 $Ref.null)))
(declare-const $k@2990 $Perm)
(assert ($Perm.isValidVar $k@2990))
(assert ($Perm.isReadVar $k@2990 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 6
(assert (not (not (= $k@2990 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2990 $Perm.No)))
(assert (= $t@2989 sys__result@2959))
; [exec]
; x := __flatten_110
; [exec]
; __flatten_111 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@2991 Int)
; [exec]
; c := __flatten_111
; [eval] c > 1
(push) ; 6
(assert (not (not (> sys__result@2991 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (> sys__result@2991 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 32] sys__result@2991 > 1
(assert (> sys__result@2991 1))
; [exec]
; assert acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@2992 $Perm)
(assert ($Perm.isValidVar $k@2992))
(assert ($Perm.isReadVar $k@2992 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2992 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2992 (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983)))
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2972 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2903 $t@2972)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2972 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2903 $t@2972)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (not (= sys__result@2991 $t@2979))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@2991 $t@2979)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 33] sys__result@2991 == $t@2979
(assert (= sys__result@2991 $t@2979))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@2993 $Snap)
(declare-const $t@2994 $Snap)
(assert (= $t@2993 ($Snap.combine $t@2994 $Snap.unit)))
(declare-const $t@2995 $Ref)
(declare-const $t@2996 $Ref)
(assert (=
  $t@2994
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@2995)
    ($SortWrappers.$RefTo$Snap $t@2996))))
(declare-const $k@2997 $Perm)
(assert ($Perm.isValidVar $k@2997))
(assert ($Perm.isReadVar $k@2997 $Perm.Write))
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@2925 $k@2958) $k@2985)) (= $t@2995 $t@2966)))
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@2925 $k@2958) $k@2985) $k@2997) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@2925 $k@2958) $k@2985) $k@2997) $Perm.No)))
(assert (not (= $t@2995 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@2996 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@2998 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@2999 $Perm)
(assert ($Perm.isValidVar $k@2999))
(assert ($Perm.isReadVar $k@2999 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2999 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@2999 (+ (+ (- $k@2925 $k@2958) $k@2985) $k@2997)))
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_112 := x
; [exec]
; sys__result := __flatten_112
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3000 $Perm)
(assert ($Perm.isValidVar $k@3000))
(assert ($Perm.isReadVar $k@3000 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3000 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3000 (+ (- $k@2915 $k@2953) $k@2980)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3001 $Perm)
(assert ($Perm.isValidVar $k@3001))
(assert ($Perm.isReadVar $k@3001 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3001 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3001 (+ (- $k@2917 $k@2954) $k@2981)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3002 $Perm)
(assert ($Perm.isValidVar $k@3002))
(assert ($Perm.isReadVar $k@3002 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3002 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3002 (+ (- $k@2919 $k@2955) $k@2982)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3003 $Perm)
(assert ($Perm.isValidVar $k@3003))
(assert ($Perm.isReadVar $k@3003 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3003 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@2992) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@2992) $Perm.No)))
(assert (< $k@3003 (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@2992)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@3004 $Perm)
(assert ($Perm.isValidVar $k@3004))
(assert ($Perm.isReadVar $k@3004 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3004 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3004 (+ (- $k@2923 $k@2957) $k@2984)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3005 $Perm)
(assert ($Perm.isValidVar $k@3005))
(assert ($Perm.isReadVar $k@3005 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3005 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@2925 $k@2958) $k@2985) $k@2997) $k@2999) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@2925 $k@2958) $k@2985) $k@2997) $k@2999) $Perm.No)))
(assert (< $k@3005 (- (+ (+ (- $k@2925 $k@2958) $k@2985) $k@2997) $k@2999)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2995 diz@2903)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@2995 diz@2903))
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 33] sys__result@2991 != $t@2979
(assert (not (= sys__result@2991 $t@2979)))
(pop) ; 7
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (= sys__result@2991 $t@2979)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@2991 $t@2979))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 34] sys__result@2991 != $t@2979
(assert (not (= sys__result@2991 $t@2979)))
; [exec]
; __flatten_112 := x
; [exec]
; sys__result := __flatten_112
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3006 $Perm)
(assert ($Perm.isValidVar $k@3006))
(assert ($Perm.isReadVar $k@3006 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3006 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3006 (+ (- $k@2915 $k@2953) $k@2980)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3007 $Perm)
(assert ($Perm.isValidVar $k@3007))
(assert ($Perm.isReadVar $k@3007 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3007 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3007 (+ (- $k@2917 $k@2954) $k@2981)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3008 $Perm)
(assert ($Perm.isValidVar $k@3008))
(assert ($Perm.isReadVar $k@3008 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3008 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3008 (+ (- $k@2919 $k@2955) $k@2982)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3009 $Perm)
(assert ($Perm.isValidVar $k@3009))
(assert ($Perm.isReadVar $k@3009 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3009 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@2992) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@2992) $Perm.No)))
(assert (< $k@3009 (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@2992)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@3010 $Perm)
(assert ($Perm.isValidVar $k@3010))
(assert ($Perm.isReadVar $k@3010 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3010 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3010 (+ (- $k@2923 $k@2957) $k@2984)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3011 $Perm)
(assert ($Perm.isValidVar $k@3011))
(assert ($Perm.isReadVar $k@3011 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3011 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3011 (+ (- $k@2925 $k@2958) $k@2985)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 34] sys__result@2991 == $t@2979
(assert (= sys__result@2991 $t@2979))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 32] !sys__result@2991 > 1
(assert (not (> sys__result@2991 1)))
(pop) ; 6
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 6
(assert (not (> sys__result@2991 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (> sys__result@2991 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 35] !sys__result@2991 > 1
(assert (not (> sys__result@2991 1)))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@3012 $Perm)
(assert ($Perm.isValidVar $k@3012))
(assert ($Perm.isReadVar $k@3012 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3012 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3012 (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983)))
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2972 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2903 $t@2972)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(push) ; 7
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@2972 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= diz@2903 $t@2972)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (not (= sys__result@2991 $t@2979))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= sys__result@2991 $t@2979)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 36] sys__result@2991 == $t@2979
(assert (= sys__result@2991 $t@2979))
; [exec]
; inhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $t@3013 $Snap)
(declare-const $t@3014 $Snap)
(assert (= $t@3013 ($Snap.combine $t@3014 $Snap.unit)))
(declare-const $t@3015 $Ref)
(declare-const $t@3016 $Ref)
(assert (=
  $t@3014
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3015)
    ($SortWrappers.$RefTo$Snap $t@3016))))
(declare-const $k@3017 $Perm)
(assert ($Perm.isValidVar $k@3017))
(assert ($Perm.isReadVar $k@3017 $Perm.Write))
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies (< $Perm.No (+ (- $k@2925 $k@2958) $k@2985)) (= $t@3015 $t@2966)))
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (+ (- $k@2925 $k@2958) $k@2985) $k@3017) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (+ (- $k@2925 $k@2958) $k@2985) $k@3017) $Perm.No)))
(assert (not (= $t@3015 $Ref.null)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $t@3016 $Ref.null)))
; [exec]
; inhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
(declare-const $t@3018 $Snap)
; [exec]
; assert acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(LastLock__lock_held(diz.BlockingQueue__lastLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && acc(diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last, write) && (diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null)
(declare-const $k@3019 $Perm)
(assert ($Perm.isValidVar $k@3019))
(assert ($Perm.isReadVar $k@3019 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3019 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3019 (+ (+ (- $k@2925 $k@2958) $k@2985) $k@3017)))
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [eval] diz.BlockingQueue__lastLock.LastLock__queue.BlockingQueue__last != null
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; __flatten_112 := x
; [exec]
; sys__result := __flatten_112
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3020 $Perm)
(assert ($Perm.isValidVar $k@3020))
(assert ($Perm.isReadVar $k@3020 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3020 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3020 (+ (- $k@2915 $k@2953) $k@2980)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3021 $Perm)
(assert ($Perm.isValidVar $k@3021))
(assert ($Perm.isReadVar $k@3021 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3021 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3021 (+ (- $k@2917 $k@2954) $k@2981)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3022 $Perm)
(assert ($Perm.isValidVar $k@3022))
(assert ($Perm.isReadVar $k@3022 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3022 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3022 (+ (- $k@2919 $k@2955) $k@2982)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3023 $Perm)
(assert ($Perm.isValidVar $k@3023))
(assert ($Perm.isReadVar $k@3023 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3023 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@3012) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@3012) $Perm.No)))
(assert (< $k@3023 (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@3012)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@3024 $Perm)
(assert ($Perm.isValidVar $k@3024))
(assert ($Perm.isReadVar $k@3024 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3024 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3024 (+ (- $k@2923 $k@2957) $k@2984)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3025 $Perm)
(assert ($Perm.isValidVar $k@3025))
(assert ($Perm.isReadVar $k@3025 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3025 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (+ (- $k@2925 $k@2958) $k@2985) $k@3017) $k@3019) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (+ (- $k@2925 $k@2958) $k@2985) $k@3017) $k@3019) $Perm.No)))
(assert (< $k@3025 (- (+ (+ (- $k@2925 $k@2958) $k@2985) $k@3017) $k@3019)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@3015 diz@2903)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (= $t@3015 diz@2903))
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 36] sys__result@2991 != $t@2979
(assert (not (= sys__result@2991 $t@2979)))
(pop) ; 7
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (= sys__result@2991 $t@2979)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= sys__result@2991 $t@2979))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 37] sys__result@2991 != $t@2979
(assert (not (= sys__result@2991 $t@2979)))
; [exec]
; __flatten_112 := x
; [exec]
; sys__result := __flatten_112
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3026 $Perm)
(assert ($Perm.isValidVar $k@3026))
(assert ($Perm.isReadVar $k@3026 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3026 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3026 (+ (- $k@2915 $k@2953) $k@2980)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3027 $Perm)
(assert ($Perm.isValidVar $k@3027))
(assert ($Perm.isReadVar $k@3027 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3027 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3027 (+ (- $k@2917 $k@2954) $k@2981)))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3028 $Perm)
(assert ($Perm.isValidVar $k@3028))
(assert ($Perm.isReadVar $k@3028 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3028 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3028 (+ (- $k@2919 $k@2955) $k@2982)))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3029 $Perm)
(assert ($Perm.isValidVar $k@3029))
(assert ($Perm.isReadVar $k@3029 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3029 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@3012) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@3012) $Perm.No)))
(assert (< $k@3029 (- (+ (- (+ $k@2921 $k@2950) $k@2956) $k@2983) $k@3012)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 8
(assert (not (= $t@2920 $t@2975)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(declare-const $k@3030 $Perm)
(assert ($Perm.isValidVar $k@3030))
(assert ($Perm.isReadVar $k@3030 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3030 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3030 (+ (- $k@2923 $k@2957) $k@2984)))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3031 $Perm)
(assert ($Perm.isValidVar $k@3031))
(assert ($Perm.isReadVar $k@3031 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3031 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3031 (+ (- $k@2925 $k@2958) $k@2985)))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 8
(assert (not (= $t@2924 $t@2969)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [exec]
; inhale false
(pop) ; 7
(push) ; 7
; [else-branch 37] sys__result@2991 == $t@2979
(assert (= sys__result@2991 $t@2979))
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 35] sys__result@2991 > 1
(assert (> sys__result@2991 1))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 31] !sys__result@2952 > 0
(assert (not (> sys__result@2952 0)))
(pop) ; 5
; [eval] !(currentCount > 0)
; [eval] currentCount > 0
(push) ; 5
(assert (not (> sys__result@2952 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (> sys__result@2952 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 38] !sys__result@2952 > 0
(assert (not (> sys__result@2952 0)))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@3032 $Perm)
(assert ($Perm.isValidVar $k@3032))
(assert ($Perm.isReadVar $k@3032 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@3032 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@3032 (+ $k@2921 $k@2950)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= (- 0 1) $t@2916))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= (- 0 1) $t@2916)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 39] -1 == $t@2916
(push) ; 6
; [else-branch 39] -1 != $t@2916
(assert (not (= (- 0 1) $t@2916)))
(pop) ; 6
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (= (- 0 1) $t@2916)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (- 0 1) $t@2916))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 40] -1 != $t@2916
(assert (not (= (- 0 1) $t@2916)))
; [exec]
; __flatten_112 := x
; [exec]
; sys__result := __flatten_112
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3033 $Perm)
(assert ($Perm.isValidVar $k@3033))
(assert ($Perm.isReadVar $k@3033 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3033 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3033 $k@2915))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3034 $Perm)
(assert ($Perm.isValidVar $k@3034))
(assert ($Perm.isReadVar $k@3034 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3034 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3034 $k@2917))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3035 $Perm)
(assert ($Perm.isValidVar $k@3035))
(assert ($Perm.isReadVar $k@3035 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3035 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3035 $k@2919))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3036 $Perm)
(assert ($Perm.isValidVar $k@3036))
(assert ($Perm.isReadVar $k@3036 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3036 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- (+ $k@2921 $k@2950) $k@3032) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (- (+ $k@2921 $k@2950) $k@3032) $Perm.No)))
(assert (< $k@3036 (- (+ $k@2921 $k@2950) $k@3032)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3037 $Perm)
(assert ($Perm.isValidVar $k@3037))
(assert ($Perm.isReadVar $k@3037 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3037 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3037 $k@2923))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3038 $Perm)
(assert ($Perm.isValidVar $k@3038))
(assert ($Perm.isReadVar $k@3038 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3038 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3038 $k@2925))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 40] -1 == $t@2916
(pop) ; 5
(push) ; 5
; [else-branch 38] sys__result@2952 > 0
(assert (> sys__result@2952 0))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 30] sys__result@2939 == 0
(assert (= sys__result@2939 0))
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__peek ----------
(declare-const diz@3039 $Ref)
(declare-const sys__result@3040 $Ref)
(declare-const x@3041 $Ref)
(declare-const currentCount@3042 Int)
(declare-const __flatten_113@3043 Int)
(declare-const __flatten_114@3044 $Ref)
(declare-const __flatten_115@3045 $Ref)
(declare-const __flatten_116@3046 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@3039 $Ref.null)))
(declare-const $k@3047 $Perm)
(assert ($Perm.isValidVar $k@3047))
(assert ($Perm.isReadVar $k@3047 $Perm.Write))
(declare-const $t@3048 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@3047 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3047 $Perm.No)))
(assert (> $t@3048 0))
(declare-const $k@3049 $Perm)
(assert ($Perm.isValidVar $k@3049))
(assert ($Perm.isReadVar $k@3049 $Perm.Write))
(declare-const $t@3050 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@3049 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3049 $Perm.No)))
(assert (not (= $t@3050 $Ref.null)))
(declare-const $k@3051 $Perm)
(assert ($Perm.isValidVar $k@3051))
(assert ($Perm.isReadVar $k@3051 $Perm.Write))
(declare-const $t@3052 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@3051 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3051 $Perm.No)))
(assert (not (= $t@3052 $Ref.null)))
(declare-const $k@3053 $Perm)
(assert ($Perm.isValidVar $k@3053))
(assert ($Perm.isReadVar $k@3053 $Perm.Write))
(declare-const $t@3054 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@3053 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3053 $Perm.No)))
(assert (= $t@3054 diz@3039))
(declare-const $k@3055 $Perm)
(assert ($Perm.isValidVar $k@3055))
(assert ($Perm.isReadVar $k@3055 $Perm.Write))
(declare-const $t@3056 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@3055 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3055 $Perm.No)))
(assert (not (= $t@3056 $Ref.null)))
(declare-const $k@3057 $Perm)
(assert ($Perm.isValidVar $k@3057))
(assert ($Perm.isReadVar $k@3057 $Perm.Write))
(declare-const $t@3058 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@3057 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3057 $Perm.No)))
(assert (= $t@3058 diz@3039))
(push) ; 3
(declare-const $k@3059 $Perm)
(assert ($Perm.isValidVar $k@3059))
(assert ($Perm.isReadVar $k@3059 $Perm.Write))
(declare-const $t@3060 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@3059 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3059 $Perm.No)))
(assert (> $t@3060 0))
(declare-const $k@3061 $Perm)
(assert ($Perm.isValidVar $k@3061))
(assert ($Perm.isReadVar $k@3061 $Perm.Write))
(declare-const $t@3062 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@3061 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3061 $Perm.No)))
(assert (not (= $t@3062 $Ref.null)))
(declare-const $k@3063 $Perm)
(assert ($Perm.isValidVar $k@3063))
(assert ($Perm.isReadVar $k@3063 $Perm.Write))
(declare-const $t@3064 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@3063 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3063 $Perm.No)))
(assert (not (= $t@3064 $Ref.null)))
(declare-const $k@3065 $Perm)
(assert ($Perm.isValidVar $k@3065))
(assert ($Perm.isReadVar $k@3065 $Perm.Write))
(declare-const $t@3066 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@3065 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3065 $Perm.No)))
(assert (= $t@3066 diz@3039))
(declare-const $k@3067 $Perm)
(assert ($Perm.isValidVar $k@3067))
(assert ($Perm.isReadVar $k@3067 $Perm.Write))
(declare-const $t@3068 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@3067 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3067 $Perm.No)))
(assert (not (= $t@3068 $Ref.null)))
(declare-const $k@3069 $Perm)
(assert ($Perm.isValidVar $k@3069))
(assert ($Perm.isReadVar $k@3069 $Perm.Write))
(declare-const $t@3070 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@3069 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3069 $Perm.No)))
(assert (= $t@3070 diz@3039))
(pop) ; 3
(push) ; 3
; [exec]
; x := null
; [exec]
; __flatten_113 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@3071 Int)
; [exec]
; currentCount := __flatten_113
; [eval] currentCount == 0
(push) ; 4
(assert (not (not (= sys__result@3071 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (= sys__result@3071 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 41] sys__result@3071 == 0
(assert (= sys__result@3071 0))
; [exec]
; __flatten_114 := x
; [exec]
; sys__result := __flatten_114
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3072 $Perm)
(assert ($Perm.isValidVar $k@3072))
(assert ($Perm.isReadVar $k@3072 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@3072 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@3072 $k@3047))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3073 $Perm)
(assert ($Perm.isValidVar $k@3073))
(assert ($Perm.isReadVar $k@3073 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@3073 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@3073 $k@3049))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3074 $Perm)
(assert ($Perm.isValidVar $k@3074))
(assert ($Perm.isReadVar $k@3074 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@3074 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@3074 $k@3051))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3075 $Perm)
(assert ($Perm.isValidVar $k@3075))
(assert ($Perm.isReadVar $k@3075 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@3075 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@3075 $k@3053))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3076 $Perm)
(assert ($Perm.isValidVar $k@3076))
(assert ($Perm.isReadVar $k@3076 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@3076 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@3076 $k@3055))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3077 $Perm)
(assert ($Perm.isValidVar $k@3077))
(assert ($Perm.isReadVar $k@3077 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@3077 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@3077 $k@3057))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 4
(push) ; 4
; [else-branch 41] sys__result@3071 != 0
(assert (not (= sys__result@3071 0)))
(pop) ; 4
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 4
(assert (not (= sys__result@3071 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= sys__result@3071 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 42] sys__result@3071 != 0
(assert (not (= sys__result@3071 0)))
; [exec]
; inhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $t@3078 $Snap)
(declare-const $t@3079 $Snap)
(assert (= $t@3078 ($Snap.combine $t@3079 $Snap.unit)))
(declare-const $t@3080 $Ref)
(declare-const $t@3081 $Ref)
(assert (=
  $t@3079
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3080)
    ($SortWrappers.$RefTo$Snap $t@3081))))
(declare-const $k@3082 $Perm)
(assert ($Perm.isValidVar $k@3082))
(assert ($Perm.isReadVar $k@3082 $Perm.Write))
(assert (= $t@3054 $t@3080))
(push) ; 5
(assert (not (not (= (+ $k@3053 $k@3082) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $k@3053 $k@3082) $Perm.No)))
(assert (not (= $t@3054 $Ref.null)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
(assert (not (= $t@3081 $Ref.null)))
; [exec]
; inhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
(declare-const $t@3083 $Snap)
; [eval] diz.BlockingQueue__head != null
(push) ; 5
(assert (not (= $t@3081 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 43] $t@3081 != Null
; [exec]
; inhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
(declare-const $t@3084 $Snap)
(declare-const $t@3085 $Snap)
(declare-const $t@3086 $Ref)
(assert (= $t@3084 ($Snap.combine $t@3085 ($SortWrappers.$RefTo$Snap $t@3086))))
(declare-const $t@3087 $Ref)
(declare-const $t@3088 Int)
(assert (=
  $t@3085
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3087)
    ($SortWrappers.IntTo$Snap $t@3088))))
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 6
(assert (not (= $t@3087 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@3087 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 44] $t@3087 != Null
(assert (not (= $t@3087 $Ref.null)))
(declare-const $k@3089 $Perm)
(assert ($Perm.isValidVar $k@3089))
(assert ($Perm.isReadVar $k@3089 $Perm.Write))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@3090 $Snap)
; [exec]
; __flatten_115 := diz.BlockingQueue__head
; [exec]
; x := __flatten_115.Node__val
; [exec]
; exhale acc(Node__lock_held(diz.BlockingQueue__head), write)
; [exec]
; exhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 7
(assert (not (= $t@3087 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 45] $t@3087 != Null
(declare-const $k@3091 $Perm)
(assert ($Perm.isValidVar $k@3091))
(assert ($Perm.isReadVar $k@3091 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3091 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@3089 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@3089 $Perm.No)))
(assert (< $k@3091 $k@3089))
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@3092 $Perm)
(assert ($Perm.isValidVar $k@3092))
(assert ($Perm.isReadVar $k@3092 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3092 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3092 (+ $k@3053 $k@3082)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [exec]
; __flatten_116 := x
; [exec]
; sys__result := __flatten_116
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3093 $Perm)
(assert ($Perm.isValidVar $k@3093))
(assert ($Perm.isReadVar $k@3093 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3093 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3093 $k@3047))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3094 $Perm)
(assert ($Perm.isValidVar $k@3094))
(assert ($Perm.isReadVar $k@3094 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3094 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3094 $k@3049))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3095 $Perm)
(assert ($Perm.isValidVar $k@3095))
(assert ($Perm.isReadVar $k@3095 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3095 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3095 $k@3051))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3096 $Perm)
(assert ($Perm.isValidVar $k@3096))
(assert ($Perm.isReadVar $k@3096 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3096 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ $k@3053 $k@3082) $k@3092) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ $k@3053 $k@3082) $k@3092) $Perm.No)))
(assert (< $k@3096 (- (+ $k@3053 $k@3082) $k@3092)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3097 $Perm)
(assert ($Perm.isValidVar $k@3097))
(assert ($Perm.isReadVar $k@3097 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3097 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3097 $k@3055))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3098 $Perm)
(assert ($Perm.isValidVar $k@3098))
(assert ($Perm.isReadVar $k@3098 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3098 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3098 $k@3057))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 7
; [dead else-branch 45] $t@3087 == Null
(pop) ; 6
(push) ; 6
; [else-branch 44] $t@3087 == Null
(assert (= $t@3087 $Ref.null))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@3099 $Snap)
; [exec]
; __flatten_115 := diz.BlockingQueue__head
; [exec]
; x := __flatten_115.Node__val
; [exec]
; exhale acc(Node__lock_held(diz.BlockingQueue__head), write)
; [exec]
; exhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 7
(assert (not (not (= $t@3087 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 46] $t@3087 != Null
(push) ; 7
; [else-branch 46] $t@3087 == Null
; [exec]
; exhale acc(HeadLock__lock_held(diz.BlockingQueue__headLock), write)
; [exec]
; exhale acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && acc(diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head, write) && (diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null)
(declare-const $k@3100 $Perm)
(assert ($Perm.isValidVar $k@3100))
(assert ($Perm.isReadVar $k@3100 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3100 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3100 (+ $k@3053 $k@3082)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue.BlockingQueue__head != null
; [exec]
; __flatten_116 := x
; [exec]
; sys__result := __flatten_116
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz)
(declare-const $k@3101 $Perm)
(assert ($Perm.isValidVar $k@3101))
(assert ($Perm.isReadVar $k@3101 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3101 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3101 $k@3047))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3102 $Perm)
(assert ($Perm.isValidVar $k@3102))
(assert ($Perm.isReadVar $k@3102 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3102 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3102 $k@3049))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3103 $Perm)
(assert ($Perm.isValidVar $k@3103))
(assert ($Perm.isReadVar $k@3103 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3103 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3103 $k@3051))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3104 $Perm)
(assert ($Perm.isValidVar $k@3104))
(assert ($Perm.isReadVar $k@3104 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3104 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (- (+ $k@3053 $k@3082) $k@3100) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (- (+ $k@3053 $k@3082) $k@3100) $Perm.No)))
(assert (< $k@3104 (- (+ $k@3053 $k@3082) $k@3100)))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3105 $Perm)
(assert ($Perm.isValidVar $k@3105))
(assert ($Perm.isReadVar $k@3105 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3105 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3105 $k@3055))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3106 $Perm)
(assert ($Perm.isValidVar $k@3106))
(assert ($Perm.isReadVar $k@3106 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3106 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3106 $k@3057))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [exec]
; inhale false
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 43] $t@3081 == Null
; [eval] !(diz.BlockingQueue__head != null)
; [eval] diz.BlockingQueue__head != null
(push) ; 5
(assert (not (= $t@3081 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 47] $t@3081 == Null
(push) ; 5
; [else-branch 47] $t@3081 != Null
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 42] sys__result@3071 == 0
(assert (= sys__result@3071 0))
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__linkLast ----------
(declare-const diz@3107 $Ref)
(declare-const val@3108 Int)
(declare-const oldLast@3109 $Ref)
(declare-const __flatten_117@3110 $Ref)
(declare-const __flatten_118@3111 $Ref)
(declare-const __flatten_119@3112 $Ref)
(declare-const __flatten_120@3113 $Ref)
(declare-const __flatten_121@3114 $Ref)
(declare-const __flatten_122@3115 $Ref)
(declare-const __flatten_233@3116 $Ref)
(declare-const __flatten_234@3117 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@3107 $Ref.null)))
(declare-const $k@3118 $Perm)
(assert ($Perm.isValidVar $k@3118))
(assert ($Perm.isReadVar $k@3118 $Perm.Write))
(declare-const $t@3119 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@3118 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3118 $Perm.No)))
(assert (> $t@3119 0))
(declare-const $k@3120 $Perm)
(assert ($Perm.isValidVar $k@3120))
(assert ($Perm.isReadVar $k@3120 $Perm.Write))
(declare-const $t@3121 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@3120 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3120 $Perm.No)))
(assert (not (= $t@3121 $Ref.null)))
(declare-const $k@3122 $Perm)
(assert ($Perm.isValidVar $k@3122))
(assert ($Perm.isReadVar $k@3122 $Perm.Write))
(declare-const $t@3123 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@3122 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3122 $Perm.No)))
(assert (not (= $t@3123 $Ref.null)))
(declare-const $k@3124 $Perm)
(assert ($Perm.isValidVar $k@3124))
(assert ($Perm.isReadVar $k@3124 $Perm.Write))
(declare-const $t@3125 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@3124 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3124 $Perm.No)))
(assert (= $t@3125 diz@3107))
(declare-const $k@3126 $Perm)
(assert ($Perm.isValidVar $k@3126))
(assert ($Perm.isReadVar $k@3126 $Perm.Write))
(declare-const $t@3127 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@3126 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3126 $Perm.No)))
(assert (not (= $t@3127 $Ref.null)))
(declare-const $k@3128 $Perm)
(assert ($Perm.isValidVar $k@3128))
(assert ($Perm.isReadVar $k@3128 $Perm.Write))
(declare-const $t@3129 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@3128 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3128 $Perm.No)))
(assert (= $t@3129 diz@3107))
(declare-const $t@3130 $Ref)
(push) ; 3
(declare-const $k@3131 $Perm)
(assert ($Perm.isValidVar $k@3131))
(assert ($Perm.isReadVar $k@3131 $Perm.Write))
(declare-const $t@3132 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@3131 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3131 $Perm.No)))
(assert (> $t@3132 0))
(declare-const $k@3133 $Perm)
(assert ($Perm.isValidVar $k@3133))
(assert ($Perm.isReadVar $k@3133 $Perm.Write))
(declare-const $t@3134 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@3133 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3133 $Perm.No)))
(assert (not (= $t@3134 $Ref.null)))
(declare-const $k@3135 $Perm)
(assert ($Perm.isValidVar $k@3135))
(assert ($Perm.isReadVar $k@3135 $Perm.Write))
(declare-const $t@3136 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@3135 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3135 $Perm.No)))
(assert (not (= $t@3136 $Ref.null)))
(declare-const $k@3137 $Perm)
(assert ($Perm.isValidVar $k@3137))
(assert ($Perm.isReadVar $k@3137 $Perm.Write))
(declare-const $t@3138 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@3137 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3137 $Perm.No)))
(assert (= $t@3138 diz@3107))
(declare-const $k@3139 $Perm)
(assert ($Perm.isValidVar $k@3139))
(assert ($Perm.isReadVar $k@3139 $Perm.Write))
(declare-const $t@3140 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@3139 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3139 $Perm.No)))
(assert (not (= $t@3140 $Ref.null)))
(declare-const $k@3141 $Perm)
(assert ($Perm.isValidVar $k@3141))
(assert ($Perm.isReadVar $k@3141 $Perm.Write))
(declare-const $t@3142 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@3141 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3141 $Perm.No)))
(assert (= $t@3142 diz@3107))
(declare-const $t@3143 $Ref)
; [eval] diz.BlockingQueue__last != null
(assert (not (= $t@3143 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__last.Node__val, write) && ((diz.BlockingQueue__last.Node__val != null) ==> acc(diz.BlockingQueue__last.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__last.Node__next, write)
(declare-const $t@3144 $Snap)
(declare-const $t@3145 $Snap)
(declare-const $t@3146 $Ref)
(assert (= $t@3144 ($Snap.combine $t@3145 ($SortWrappers.$RefTo$Snap $t@3146))))
(declare-const $t@3147 $Ref)
(declare-const $t@3148 Int)
(assert (=
  $t@3145
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3147)
    ($SortWrappers.IntTo$Snap $t@3148))))
(assert (not (= $t@3130 $Ref.null)))
; [eval] diz.BlockingQueue__last.Node__val != null
(push) ; 4
(assert (not (= $t@3147 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@3147 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 48] $t@3147 != Null
(assert (not (= $t@3147 $Ref.null)))
(declare-const $k@3149 $Perm)
(assert ($Perm.isValidVar $k@3149))
(assert ($Perm.isReadVar $k@3149 $Perm.Write))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__last), write)
(declare-const $t@3150 $Snap)
; [exec]
; oldLast := diz.BlockingQueue__last
; [exec]
; __flatten_117 := diz.BlockingQueue__last
; [exec]
; __flatten_119 := Integer__Integer(val)
(declare-const sys__result@3151 $Ref)
(declare-const $t@3152 $Snap)
(declare-const $t@3153 Int)
(assert (= $t@3152 ($Snap.combine ($SortWrappers.IntTo$Snap $t@3153) $Snap.unit)))
(declare-const $t@3154 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@3153)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@3154))))
; [eval] sys__result != null
(assert (not (= sys__result@3151 $Ref.null)))
(declare-const $k@3155 $Perm)
(assert ($Perm.isValidVar $k@3155))
(assert ($Perm.isReadVar $k@3155 $Perm.Write))
(push) ; 5
(assert (not (= $t@3147 sys__result@3151)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] sys__result.Integer__val == val
(push) ; 5
(assert (not (not (= $k@3155 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@3155 $Perm.No)))
(assert (= $t@3154 val@3108))
; [exec]
; __flatten_120 := Node__Node(__flatten_119)
; [eval] val != null
(push) ; 5
(assert (not (= sys__result@3151 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 49] sys__result@3151 != Null
(declare-const $k@3156 $Perm)
(assert ($Perm.isValidVar $k@3156))
(assert ($Perm.isReadVar $k@3156 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@3156 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@3156 $k@3155))
(declare-const sys__result@3157 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@3157 $Ref.null)))
; [exec]
; __flatten_118 := __flatten_120
; [exec]
; __flatten_233 := __flatten_118
; [exec]
; __flatten_117.Node__next := __flatten_233
; [exec]
; __flatten_122 := diz.BlockingQueue__last
; [exec]
; __flatten_121 := __flatten_122.Node__next
; [exec]
; __flatten_234 := __flatten_121
; [exec]
; diz.BlockingQueue__last := __flatten_234
; [exec]
; exhale acc(Node__lock_held(oldLast), write)
; [exec]
; exhale acc(oldLast.Node__val, write) && ((oldLast.Node__val != null) ==> acc(oldLast.Node__val.Integer__val, wildcard)) && acc(oldLast.Node__next, write)
; [eval] oldLast.Node__val != null
(push) ; 6
(assert (not (= $t@3147 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 50] $t@3147 != Null
(declare-const $k@3158 $Perm)
(assert ($Perm.isValidVar $k@3158))
(assert ($Perm.isReadVar $k@3158 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3158 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@3149 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@3149 $Perm.No)))
(assert (< $k@3158 $k@3149))
(declare-const $k@3159 $Perm)
(assert ($Perm.isValidVar $k@3159))
(assert ($Perm.isReadVar $k@3159 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3159 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3159 $k@3118))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3160 $Perm)
(assert ($Perm.isValidVar $k@3160))
(assert ($Perm.isReadVar $k@3160 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3160 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3160 $k@3120))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3161 $Perm)
(assert ($Perm.isValidVar $k@3161))
(assert ($Perm.isReadVar $k@3161 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3161 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3161 $k@3122))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3162 $Perm)
(assert ($Perm.isValidVar $k@3162))
(assert ($Perm.isReadVar $k@3162 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3162 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3162 $k@3124))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3163 $Perm)
(assert ($Perm.isValidVar $k@3163))
(assert ($Perm.isReadVar $k@3163 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3163 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3163 $k@3126))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3164 $Perm)
(assert ($Perm.isValidVar $k@3164))
(assert ($Perm.isReadVar $k@3164 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3164 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3164 $k@3128))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__last != null
(pop) ; 6
; [dead else-branch 50] $t@3147 == Null
(pop) ; 5
; [dead else-branch 49] sys__result@3151 == Null
(pop) ; 4
(push) ; 4
; [else-branch 48] $t@3147 == Null
(assert (= $t@3147 $Ref.null))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__last), write)
(declare-const $t@3165 $Snap)
; [exec]
; oldLast := diz.BlockingQueue__last
; [exec]
; __flatten_117 := diz.BlockingQueue__last
; [exec]
; __flatten_119 := Integer__Integer(val)
(declare-const sys__result@3166 $Ref)
(declare-const $t@3167 $Snap)
(declare-const $t@3168 Int)
(assert (= $t@3167 ($Snap.combine ($SortWrappers.IntTo$Snap $t@3168) $Snap.unit)))
(declare-const $t@3169 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@3168)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@3169))))
; [eval] sys__result != null
(assert (not (= sys__result@3166 $Ref.null)))
(declare-const $k@3170 $Perm)
(assert ($Perm.isValidVar $k@3170))
(assert ($Perm.isReadVar $k@3170 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 5
(assert (not (not (= $k@3170 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@3170 $Perm.No)))
(assert (= $t@3169 val@3108))
; [exec]
; __flatten_120 := Node__Node(__flatten_119)
; [eval] val != null
(push) ; 5
(assert (not (= sys__result@3166 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 51] sys__result@3166 != Null
(declare-const $k@3171 $Perm)
(assert ($Perm.isValidVar $k@3171))
(assert ($Perm.isReadVar $k@3171 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@3171 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@3171 $k@3170))
(declare-const sys__result@3172 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@3172 $Ref.null)))
; [exec]
; __flatten_118 := __flatten_120
; [exec]
; __flatten_233 := __flatten_118
; [exec]
; __flatten_117.Node__next := __flatten_233
; [exec]
; __flatten_122 := diz.BlockingQueue__last
; [exec]
; __flatten_121 := __flatten_122.Node__next
; [exec]
; __flatten_234 := __flatten_121
; [exec]
; diz.BlockingQueue__last := __flatten_234
; [exec]
; exhale acc(Node__lock_held(oldLast), write)
; [exec]
; exhale acc(oldLast.Node__val, write) && ((oldLast.Node__val != null) ==> acc(oldLast.Node__val.Integer__val, wildcard)) && acc(oldLast.Node__next, write)
; [eval] oldLast.Node__val != null
(push) ; 6
(assert (not (not (= $t@3147 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 52] $t@3147 != Null
(push) ; 6
; [else-branch 52] $t@3147 == Null
(declare-const $k@3173 $Perm)
(assert ($Perm.isValidVar $k@3173))
(assert ($Perm.isReadVar $k@3173 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3173 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3173 $k@3118))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3174 $Perm)
(assert ($Perm.isValidVar $k@3174))
(assert ($Perm.isReadVar $k@3174 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3174 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3174 $k@3120))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3175 $Perm)
(assert ($Perm.isValidVar $k@3175))
(assert ($Perm.isReadVar $k@3175 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3175 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3175 $k@3122))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3176 $Perm)
(assert ($Perm.isValidVar $k@3176))
(assert ($Perm.isReadVar $k@3176 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3176 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3176 $k@3124))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3177 $Perm)
(assert ($Perm.isValidVar $k@3177))
(assert ($Perm.isReadVar $k@3177 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3177 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3177 $k@3126))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3178 $Perm)
(assert ($Perm.isValidVar $k@3178))
(assert ($Perm.isReadVar $k@3178 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@3178 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@3178 $k@3128))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__last != null
(pop) ; 6
(pop) ; 5
; [dead else-branch 51] sys__result@3166 == Null
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__unlinkFirst ----------
(declare-const diz@3179 $Ref)
(declare-const sys__result@3180 Int)
(declare-const oldHead@3181 $Ref)
(declare-const first@3182 $Ref)
(declare-const __flatten_123@3183 $Ref)
(declare-const __flatten_124@3184 $Ref)
(declare-const value@3185 $Ref)
(declare-const __flatten_125@3186 Int)
(declare-const __flatten_235@3187 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@3179 $Ref.null)))
(declare-const $k@3188 $Perm)
(assert ($Perm.isValidVar $k@3188))
(assert ($Perm.isReadVar $k@3188 $Perm.Write))
(declare-const $t@3189 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@3188 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3188 $Perm.No)))
(assert (> $t@3189 0))
(declare-const $k@3190 $Perm)
(assert ($Perm.isValidVar $k@3190))
(assert ($Perm.isReadVar $k@3190 $Perm.Write))
(declare-const $t@3191 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 3
(assert (not (not (= $k@3190 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3190 $Perm.No)))
(assert (not (= $t@3191 $Ref.null)))
(declare-const $k@3192 $Perm)
(assert ($Perm.isValidVar $k@3192))
(assert ($Perm.isReadVar $k@3192 $Perm.Write))
(declare-const $t@3193 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 3
(assert (not (not (= $k@3192 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3192 $Perm.No)))
(assert (not (= $t@3193 $Ref.null)))
(declare-const $k@3194 $Perm)
(assert ($Perm.isValidVar $k@3194))
(assert ($Perm.isReadVar $k@3194 $Perm.Write))
(declare-const $t@3195 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 3
(assert (not (not (= $k@3194 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3194 $Perm.No)))
(assert (= $t@3195 diz@3179))
(declare-const $k@3196 $Perm)
(assert ($Perm.isValidVar $k@3196))
(assert ($Perm.isReadVar $k@3196 $Perm.Write))
(declare-const $t@3197 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 3
(assert (not (not (= $k@3196 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3196 $Perm.No)))
(assert (not (= $t@3197 $Ref.null)))
(declare-const $k@3198 $Perm)
(assert ($Perm.isValidVar $k@3198))
(assert ($Perm.isReadVar $k@3198 $Perm.Write))
(declare-const $t@3199 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 3
(assert (not (not (= $k@3198 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@3198 $Perm.No)))
(assert (= $t@3199 diz@3179))
(declare-const $t@3200 $Ref)
(push) ; 3
(declare-const $k@3201 $Perm)
(assert ($Perm.isValidVar $k@3201))
(assert ($Perm.isReadVar $k@3201 $Perm.Write))
(declare-const $t@3202 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@3201 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3201 $Perm.No)))
(assert (> $t@3202 0))
(declare-const $k@3203 $Perm)
(assert ($Perm.isValidVar $k@3203))
(assert ($Perm.isReadVar $k@3203 $Perm.Write))
(declare-const $t@3204 $Ref)
; [eval] diz.BlockingQueue__count != null
(push) ; 4
(assert (not (not (= $k@3203 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3203 $Perm.No)))
(assert (not (= $t@3204 $Ref.null)))
(declare-const $k@3205 $Perm)
(assert ($Perm.isValidVar $k@3205))
(assert ($Perm.isReadVar $k@3205 $Perm.Write))
(declare-const $t@3206 $Ref)
; [eval] diz.BlockingQueue__headLock != null
(push) ; 4
(assert (not (not (= $k@3205 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3205 $Perm.No)))
(assert (not (= $t@3206 $Ref.null)))
(declare-const $k@3207 $Perm)
(assert ($Perm.isValidVar $k@3207))
(assert ($Perm.isReadVar $k@3207 $Perm.Write))
(declare-const $t@3208 $Ref)
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(push) ; 4
(assert (not (not (= $k@3207 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3207 $Perm.No)))
(assert (= $t@3208 diz@3179))
(declare-const $k@3209 $Perm)
(assert ($Perm.isValidVar $k@3209))
(assert ($Perm.isReadVar $k@3209 $Perm.Write))
(declare-const $t@3210 $Ref)
; [eval] diz.BlockingQueue__lastLock != null
(push) ; 4
(assert (not (not (= $k@3209 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3209 $Perm.No)))
(assert (not (= $t@3210 $Ref.null)))
(declare-const $k@3211 $Perm)
(assert ($Perm.isValidVar $k@3211))
(assert ($Perm.isReadVar $k@3211 $Perm.Write))
(declare-const $t@3212 $Ref)
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
(push) ; 4
(assert (not (not (= $k@3211 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@3211 $Perm.No)))
(assert (= $t@3212 diz@3179))
(declare-const $t@3213 $Ref)
; [eval] diz.BlockingQueue__head != null
(assert (not (= $t@3213 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.BlockingQueue__head.Node__val, write) && ((diz.BlockingQueue__head.Node__val != null) ==> acc(diz.BlockingQueue__head.Node__val.Integer__val, wildcard)) && acc(diz.BlockingQueue__head.Node__next, write)
(declare-const $t@3214 $Snap)
(declare-const $t@3215 $Snap)
(declare-const $t@3216 $Ref)
(assert (= $t@3214 ($Snap.combine $t@3215 ($SortWrappers.$RefTo$Snap $t@3216))))
(declare-const $t@3217 $Ref)
(declare-const $t@3218 Int)
(assert (=
  $t@3215
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3217)
    ($SortWrappers.IntTo$Snap $t@3218))))
(assert (not (= $t@3200 $Ref.null)))
; [eval] diz.BlockingQueue__head.Node__val != null
(push) ; 4
(assert (not (= $t@3217 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@3217 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 53] $t@3217 != Null
(assert (not (= $t@3217 $Ref.null)))
(declare-const $k@3219 $Perm)
(assert ($Perm.isValidVar $k@3219))
(assert ($Perm.isReadVar $k@3219 $Perm.Write))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@3220 $Snap)
; [exec]
; oldHead := diz.BlockingQueue__head
; [exec]
; __flatten_123 := diz.BlockingQueue__head
; [exec]
; first := __flatten_123.Node__next
; [exec]
; inhale first != null
; [eval] first != null
(assert (not (= $t@3216 $Ref.null)))
; [exec]
; __flatten_124 := first
; [exec]
; __flatten_235 := __flatten_124
; [exec]
; diz.BlockingQueue__head := __flatten_235
; [exec]
; inhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
(declare-const $t@3221 $Snap)
(declare-const $t@3222 $Snap)
(declare-const $t@3223 $Ref)
(assert (= $t@3221 ($Snap.combine $t@3222 ($SortWrappers.$RefTo$Snap $t@3223))))
(declare-const $t@3224 $Ref)
(declare-const $t@3225 Int)
(assert (=
  $t@3222
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3224)
    ($SortWrappers.IntTo$Snap $t@3225))))
(push) ; 5
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] first.Node__val != null
(push) ; 5
(assert (not (= $t@3224 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@3224 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 54] $t@3224 != Null
(assert (not (= $t@3224 $Ref.null)))
(declare-const $k@3226 $Perm)
(assert ($Perm.isValidVar $k@3226))
(assert ($Perm.isReadVar $k@3226 $Perm.Write))
(push) ; 6
(assert (not (= $t@3217 $t@3224)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@3227 $Snap)
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
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
; [dead then-branch 55] False
(push) ; 6
; [else-branch 55] True
; [exec]
; exhale acc(Node__lock_held(oldHead), write)
; [exec]
; exhale acc(oldHead.Node__val, write) && ((oldHead.Node__val != null) ==> acc(oldHead.Node__val.Integer__val, wildcard)) && acc(oldHead.Node__next, write)
; [eval] oldHead.Node__val != null
(push) ; 7
(assert (not (= $t@3217 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 56] $t@3217 != Null
(declare-const $k@3228 $Perm)
(assert ($Perm.isValidVar $k@3228))
(assert ($Perm.isReadVar $k@3228 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3228 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@3219 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@3219 $Perm.No)))
(assert (< $k@3228 $k@3219))
; [exec]
; __flatten_125 := value.Integer__val
(push) ; 8
(assert (not (not (= $k@3226 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@3226 $Perm.No)))
; [exec]
; sys__result := __flatten_125
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz) && acc(diz.BlockingQueue__head, write) && (diz.BlockingQueue__head != null)
(declare-const $k@3229 $Perm)
(assert ($Perm.isValidVar $k@3229))
(assert ($Perm.isReadVar $k@3229 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3229 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3229 $k@3188))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3230 $Perm)
(assert ($Perm.isValidVar $k@3230))
(assert ($Perm.isReadVar $k@3230 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3230 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3230 $k@3190))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3231 $Perm)
(assert ($Perm.isValidVar $k@3231))
(assert ($Perm.isReadVar $k@3231 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3231 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3231 $k@3192))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3232 $Perm)
(assert ($Perm.isValidVar $k@3232))
(assert ($Perm.isReadVar $k@3232 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3232 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3232 $k@3194))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3233 $Perm)
(assert ($Perm.isValidVar $k@3233))
(assert ($Perm.isReadVar $k@3233 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3233 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3233 $k@3196))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3234 $Perm)
(assert ($Perm.isValidVar $k@3234))
(assert ($Perm.isReadVar $k@3234 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3234 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3234 $k@3198))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__head != null
; [exec]
; inhale false
(pop) ; 7
; [dead else-branch 56] $t@3217 == Null
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 54] $t@3224 == Null
(assert (= $t@3224 $Ref.null))
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@3235 $Snap)
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; value := first.Node__val
; [exec]
; inhale value != null
; [eval] value != null
(assert (not (= $t@3224 $Ref.null)))
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
; [dead then-branch 57] False
; [dead else-branch 57] True
(pop) ; 5
(pop) ; 4
(push) ; 4
; [else-branch 53] $t@3217 == Null
(assert (= $t@3217 $Ref.null))
; [exec]
; inhale acc(Node__lock_held(diz.BlockingQueue__head), write)
(declare-const $t@3236 $Snap)
; [exec]
; oldHead := diz.BlockingQueue__head
; [exec]
; __flatten_123 := diz.BlockingQueue__head
; [exec]
; first := __flatten_123.Node__next
; [exec]
; inhale first != null
; [eval] first != null
(assert (not (= $t@3216 $Ref.null)))
; [exec]
; __flatten_124 := first
; [exec]
; __flatten_235 := __flatten_124
; [exec]
; diz.BlockingQueue__head := __flatten_235
; [exec]
; inhale acc(first.Node__val, write) && ((first.Node__val != null) ==> acc(first.Node__val.Integer__val, wildcard)) && acc(first.Node__next, write)
(declare-const $t@3237 $Snap)
(declare-const $t@3238 $Snap)
(declare-const $t@3239 $Ref)
(assert (= $t@3237 ($Snap.combine $t@3238 ($SortWrappers.$RefTo$Snap $t@3239))))
(declare-const $t@3240 $Ref)
(declare-const $t@3241 Int)
(assert (=
  $t@3238
  ($Snap.combine
    ($SortWrappers.$RefTo$Snap $t@3240)
    ($SortWrappers.IntTo$Snap $t@3241))))
(push) ; 5
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] first.Node__val != null
(push) ; 5
(assert (not (= $t@3240 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@3240 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 58] $t@3240 != Null
(assert (not (= $t@3240 $Ref.null)))
(declare-const $k@3242 $Perm)
(assert ($Perm.isValidVar $k@3242))
(assert ($Perm.isReadVar $k@3242 $Perm.Write))
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@3243 $Snap)
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
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
; [dead then-branch 59] False
(push) ; 6
; [else-branch 59] True
; [exec]
; exhale acc(Node__lock_held(oldHead), write)
; [exec]
; exhale acc(oldHead.Node__val, write) && ((oldHead.Node__val != null) ==> acc(oldHead.Node__val.Integer__val, wildcard)) && acc(oldHead.Node__next, write)
; [eval] oldHead.Node__val != null
(push) ; 7
(assert (not (not (= $t@3217 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 60] $t@3217 != Null
(push) ; 7
; [else-branch 60] $t@3217 == Null
; [exec]
; __flatten_125 := value.Integer__val
(push) ; 8
(assert (not (not (= $k@3242 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@3242 $Perm.No)))
; [exec]
; sys__result := __flatten_125
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && (diz.BlockingQueue__count != null) && acc(diz.BlockingQueue__headLock, wildcard) && (diz.BlockingQueue__headLock != null) && acc(diz.BlockingQueue__headLock.HeadLock__queue, wildcard) && (diz.BlockingQueue__headLock.HeadLock__queue == diz) && acc(diz.BlockingQueue__lastLock, wildcard) && (diz.BlockingQueue__lastLock != null) && acc(diz.BlockingQueue__lastLock.LastLock__queue, wildcard) && (diz.BlockingQueue__lastLock.LastLock__queue == diz) && acc(diz.BlockingQueue__head, write) && (diz.BlockingQueue__head != null)
(declare-const $k@3244 $Perm)
(assert ($Perm.isValidVar $k@3244))
(assert ($Perm.isReadVar $k@3244 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3244 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3244 $k@3188))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@3245 $Perm)
(assert ($Perm.isValidVar $k@3245))
(assert ($Perm.isReadVar $k@3245 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3245 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3245 $k@3190))
; [eval] diz.BlockingQueue__count != null
(declare-const $k@3246 $Perm)
(assert ($Perm.isValidVar $k@3246))
(assert ($Perm.isReadVar $k@3246 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3246 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3246 $k@3192))
; [eval] diz.BlockingQueue__headLock != null
(declare-const $k@3247 $Perm)
(assert ($Perm.isValidVar $k@3247))
(assert ($Perm.isReadVar $k@3247 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3247 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3247 $k@3194))
; [eval] diz.BlockingQueue__headLock.HeadLock__queue == diz
(declare-const $k@3248 $Perm)
(assert ($Perm.isValidVar $k@3248))
(assert ($Perm.isReadVar $k@3248 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3248 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3248 $k@3196))
; [eval] diz.BlockingQueue__lastLock != null
(declare-const $k@3249 $Perm)
(assert ($Perm.isValidVar $k@3249))
(assert ($Perm.isReadVar $k@3249 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@3249 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@3249 $k@3198))
; [eval] diz.BlockingQueue__lastLock.LastLock__queue == diz
; [eval] diz.BlockingQueue__head != null
; [exec]
; inhale false
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 58] $t@3240 == Null
(assert (= $t@3240 $Ref.null))
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; inhale acc(Node__lock_held(first), write)
(declare-const $t@3250 $Snap)
(push) ; 6
(assert (not (= $t@3200 $t@3216)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [exec]
; value := first.Node__val
; [exec]
; inhale value != null
; [eval] value != null
(assert (not (= $t@3240 $Ref.null)))
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
; [dead then-branch 61] False
; [dead else-branch 61] True
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
