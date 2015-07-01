(get-info :version)
; (:version "4.3.2")
; Input file is <unknown>
; Started: 2015-07-01 14:21:22
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
(declare-sort $Seq<Int>)
; /dafny_axioms/sequences_declarations_dafny.smt2 [Int]
(declare-fun $Seq.length ($Seq<Int>) Int)
(declare-fun $Seq.empty<Int> () $Seq<Int>)
(declare-fun $Seq.singleton (Int) $Seq<Int>)
(declare-fun $Seq.build ($Seq<Int> Int) $Seq<Int>)
(declare-fun $Seq.index ($Seq<Int> Int) Int)
(declare-fun $Seq.append ($Seq<Int> $Seq<Int>) $Seq<Int>)
(declare-fun $Seq.update ($Seq<Int> Int Int) $Seq<Int>)
(declare-fun $Seq.contains ($Seq<Int> Int) Bool)
(declare-fun $Seq.take ($Seq<Int> Int) $Seq<Int>)
(declare-fun $Seq.drop ($Seq<Int> Int) $Seq<Int>)
(declare-fun $Seq.equal ($Seq<Int> $Seq<Int>) Bool)
(declare-fun $Seq.sameuntil ($Seq<Int> $Seq<Int> Int) Bool)
; /dafny_axioms/sequences_int_declarations_dafny.smt2
(declare-fun $Seq.range (Int Int) $Seq<Int>)
(assert true)
; /dafny_axioms/sequences_axioms_dafny.smt2 [Int]
(assert (forall ((s $Seq<Int>) ) (! (<= 0 ($Seq.length s))
  :pattern ( ($Seq.length s))
  )))
(assert (= ($Seq.length $Seq.empty<Int>) 0))
(assert (forall ((s $Seq<Int>) ) (! (=> (= ($Seq.length s) 0) (= s $Seq.empty<Int>))
  :pattern ( ($Seq.length s))
  )))
(assert (forall ((t Int) ) (! (= ($Seq.length ($Seq.singleton t)) 1)
  :pattern ( ($Seq.length ($Seq.singleton t)))
  )))
(assert (forall ((s $Seq<Int>) (v Int) ) (! (= ($Seq.length ($Seq.build s v)) (+ 1 ($Seq.length s)))
  :pattern ( ($Seq.length ($Seq.build s v)))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) ) (! (and
  (=> (= i ($Seq.length s)) (= ($Seq.index ($Seq.build s v) i) v))
  (=> (not (= i ($Seq.length s))) (= ($Seq.index ($Seq.build s v) i) ($Seq.index s i))))
  :pattern ( ($Seq.index ($Seq.build s v) i))
  )))
(assert (forall ((s0 $Seq<Int>) (s1 $Seq<Int>) ) (! (= ($Seq.length ($Seq.append s0 s1)) (+ ($Seq.length s0) ($Seq.length s1)))
  :pattern ( ($Seq.length ($Seq.append s0 s1)))
  )))
(assert (forall ((t Int) ) (! (= ($Seq.index ($Seq.singleton t) 0) t)
  :pattern ( ($Seq.index ($Seq.singleton t) 0))
  )))
(assert (forall ((s0 $Seq<Int>) (s1 $Seq<Int>) (n Int) ) (! (and
  (=> (< n ($Seq.length s0)) (= ($Seq.index ($Seq.append s0 s1) n) ($Seq.index s0 n)))
  (=> (<= ($Seq.length s0) n) (= ($Seq.index ($Seq.append s0 s1) n) ($Seq.index s1 (- n ($Seq.length s0))))))
  :pattern ( ($Seq.index ($Seq.append s0 s1) n))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) ) (! (=> (and
  (<= 0 i)
  (< i ($Seq.length s))) (= ($Seq.length ($Seq.update s i v)) ($Seq.length s)))
  :pattern ( ($Seq.length ($Seq.update s i v)))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) (n Int) ) (! (=> (and
  (<= 0 n)
  (< n ($Seq.length s))) (and
  (=> (= i n) (= ($Seq.index ($Seq.update s i v) n) v))
  (=> (not (= i n)) (= ($Seq.index ($Seq.update s i v) n) ($Seq.index s n)))))
  :pattern ( ($Seq.index ($Seq.update s i v) n))
  )))
(assert (forall ((s $Seq<Int>) (x Int) ) (! (and
  (=> ($Seq.contains s x) (exists ((i Int) ) (! (and
  (<= 0 i)
  (< i ($Seq.length s))
  (= ($Seq.index s i) x))
  :pattern ( ($Seq.index s i))
  )))
  (=> (exists ((i Int) ) (! (and
  (<= 0 i)
  (< i ($Seq.length s))
  (= ($Seq.index s i) x))
  :pattern ( ($Seq.index s i))
  )) ($Seq.contains s x)))
  :pattern ( ($Seq.contains s x))
  )))
(assert (forall ((x Int) ) (! (not ($Seq.contains $Seq.empty<Int> x))
  :pattern ( ($Seq.contains $Seq.empty<Int> x))
  )))
(assert (forall ((s0 $Seq<Int>) (s1 $Seq<Int>) (x Int) ) (! (and
  (=> ($Seq.contains ($Seq.append s0 s1) x) (or
  ($Seq.contains s0 x)
  ($Seq.contains s1 x)))
  (=> (or
  ($Seq.contains s0 x)
  ($Seq.contains s1 x)) ($Seq.contains ($Seq.append s0 s1) x)))
  :pattern ( ($Seq.contains ($Seq.append s0 s1) x))
  )))
(assert (forall ((s $Seq<Int>) (v Int) (x Int) ) (! (and
  (=> ($Seq.contains ($Seq.build s v) x) (or
  (= v x)
  ($Seq.contains s x)))
  (=> (or
  (= v x)
  ($Seq.contains s x)) ($Seq.contains ($Seq.build s v) x)))
  :pattern ( ($Seq.contains ($Seq.build s v) x))
  )))
(assert (forall ((s $Seq<Int>) (n Int) (x Int) ) (! (and
  (=> ($Seq.contains ($Seq.take s n) x) (exists ((i Int) ) (! (and
  (<= 0 i)
  (< i n)
  (< i ($Seq.length s))
  (= ($Seq.index s i) x))
  :pattern ( ($Seq.index s i))
  )))
  (=> (exists ((i Int) ) (! (and
  (<= 0 i)
  (< i n)
  (< i ($Seq.length s))
  (= ($Seq.index s i) x))
  :pattern ( ($Seq.index s i))
  )) ($Seq.contains ($Seq.take s n) x)))
  :pattern ( ($Seq.contains ($Seq.take s n) x))
  )))
(assert (forall ((s $Seq<Int>) (n Int) (x Int) ) (! (and
  (=> ($Seq.contains ($Seq.drop s n) x) (exists ((i Int) ) (! (and
  (<= 0 n)
  (<= n i)
  (< i ($Seq.length s))
  (= ($Seq.index s i) x))
  :pattern ( ($Seq.index s i))
  )))
  (=> (exists ((i Int) ) (! (and
  (<= 0 n)
  (<= n i)
  (< i ($Seq.length s))
  (= ($Seq.index s i) x))
  :pattern ( ($Seq.index s i))
  )) ($Seq.contains ($Seq.drop s n) x)))
  :pattern ( ($Seq.contains ($Seq.drop s n) x))
  )))
(assert (forall ((s0 $Seq<Int>) (s1 $Seq<Int>) ) (! (and
  (=> ($Seq.equal s0 s1) (and
  (= ($Seq.length s0) ($Seq.length s1))
  (forall ((j Int) ) (! (=> (and
  (<= 0 j)
  (< j ($Seq.length s0))) (= ($Seq.index s0 j) ($Seq.index s1 j)))
  :pattern ( ($Seq.index s0 j))
  :pattern ( ($Seq.index s1 j))
  ))))
  (=> (and
  (= ($Seq.length s0) ($Seq.length s1))
  (forall ((j Int) ) (! (=> (and
  (<= 0 j)
  (< j ($Seq.length s0))) (= ($Seq.index s0 j) ($Seq.index s1 j)))
  :pattern ( ($Seq.index s0 j))
  :pattern ( ($Seq.index s1 j))
  ))) ($Seq.equal s0 s1)))
  :pattern ( ($Seq.equal s0 s1))
  )))
(assert (forall ((a $Seq<Int>) (b $Seq<Int>) ) (! (=> ($Seq.equal a b) (= a b))
  :pattern ( ($Seq.equal a b))
  )))
(assert (forall ((s0 $Seq<Int>) (s1 $Seq<Int>) (n Int) ) (! (and
  (=> ($Seq.sameuntil s0 s1 n) (forall ((j Int) ) (! (=> (and
  (<= 0 j)
  (< j n)) (= ($Seq.index s0 j) ($Seq.index s1 j)))
  :pattern ( ($Seq.index s0 j))
  :pattern ( ($Seq.index s1 j))
  )))
  (=> (forall ((j Int) ) (! (=> (and
  (<= 0 j)
  (< j n)) (= ($Seq.index s0 j) ($Seq.index s1 j)))
  :pattern ( ($Seq.index s0 j))
  :pattern ( ($Seq.index s1 j))
  )) ($Seq.sameuntil s0 s1 n)))
  :pattern ( ($Seq.sameuntil s0 s1 n))
  )))
(assert (forall ((s $Seq<Int>) (n Int) ) (! (=> (<= 0 n) (and
  (=> (<= n ($Seq.length s)) (= ($Seq.length ($Seq.take s n)) n))
  (=> (< ($Seq.length s) n) (= ($Seq.length ($Seq.take s n)) ($Seq.length s)))))
  :pattern ( ($Seq.length ($Seq.take s n)))
  )))
(assert (forall ((s $Seq<Int>) (n Int) (j Int) ) (! (=> (and
  (<= 0 j)
  (< j n)
  (< j ($Seq.length s))) (= ($Seq.index ($Seq.take s n) j) ($Seq.index s j)))
  :pattern ( ($Seq.index ($Seq.take s n) j))
  )))
(assert (forall ((s $Seq<Int>) (n Int) ) (! (=> (<= 0 n) (and
  (=> (<= n ($Seq.length s)) (= ($Seq.length ($Seq.drop s n)) (- ($Seq.length s) n)))
  (=> (< ($Seq.length s) n) (= ($Seq.length ($Seq.drop s n)) 0))))
  :pattern ( ($Seq.length ($Seq.drop s n)))
  )))
(assert (forall ((s $Seq<Int>) (n Int) (j Int) ) (! (=> (and
  (<= 0 n)
  (<= 0 j)
  (< j (- ($Seq.length s) n))) (= ($Seq.index ($Seq.drop s n) j) ($Seq.index s (+ j n))))
  :pattern ( ($Seq.index ($Seq.drop s n) j))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) (n Int) ) (! (=> (and
  (<= 0 i)
  (< i n)
  (<= n ($Seq.length s))) (= ($Seq.take ($Seq.update s i v) n) ($Seq.update ($Seq.take s n) i v)))
  :pattern ( ($Seq.take ($Seq.update s i v) n))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) (n Int) ) (! (=> (and
  (<= n i)
  (< i ($Seq.length s))) (= ($Seq.take ($Seq.update s i v) n) ($Seq.take s n)))
  :pattern ( ($Seq.take ($Seq.update s i v) n))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) (n Int) ) (! (=> (and
  (<= 0 n)
  (<= n i)
  (< i ($Seq.length s))) (= ($Seq.drop ($Seq.update s i v) n) ($Seq.update ($Seq.drop s n) (- i n) v)))
  :pattern ( ($Seq.drop ($Seq.update s i v) n))
  )))
(assert (forall ((s $Seq<Int>) (i Int) (v Int) (n Int) ) (! (=> (and
  (<= 0 i)
  (< i n)
  (< n ($Seq.length s))) (= ($Seq.drop ($Seq.update s i v) n) ($Seq.drop s n)))
  :pattern ( ($Seq.drop ($Seq.update s i v) n))
  )))
(assert (forall ((s $Seq<Int>) (v Int) (n Int) ) (! (=> (and
  (<= 0 n)
  (<= n ($Seq.length s))) (= ($Seq.drop ($Seq.build s v) n) ($Seq.build ($Seq.drop s n) v)))
  :pattern ( ($Seq.drop ($Seq.build s v) n))
  )))
(assert (forall ((s $Seq<Int>) (n Int) ) (! (=> (= n 0) (= ($Seq.drop s n) s))
  :pattern ( ($Seq.drop s n))
  )))
(assert (forall ((s $Seq<Int>) (n Int) ) (! (=> (= n 0) (= ($Seq.take s n) $Seq.empty<Int>))
  :pattern ( ($Seq.take s n))
  )))
(assert (forall ((s $Seq<Int>) (m Int) (n Int) ) (! (=> (and
  (<= 0 m)
  (<= 0 n)
  (<= (+ m n) ($Seq.length s))) (= ($Seq.drop ($Seq.drop s m) n) ($Seq.drop s (+ m n))))
  :pattern ( ($Seq.drop ($Seq.drop s m) n))
  )))
(assert (forall ((x Int) (y Int)) (!
  (iff
    ($Seq.contains ($Seq.singleton x) y)
    (= x y))
  :pattern (($Seq.contains ($Seq.singleton x) y))
  )))
; /dafny_axioms/sequences_int_axioms_dafny.smt2
(assert (forall ((min Int) (max Int) ) (! (and
  (=> (< min max) (= ($Seq.length ($Seq.range min max)) (- max min)))
  (=> (<= max min) (= ($Seq.length ($Seq.range min max)) 0)))
   :pattern ( ($Seq.length ($Seq.range min max)))
  )))
(assert (forall ((min Int) (max Int) (j Int) ) (! (=> (and
  (<= 0 j)
  (< j (- max min))) (= ($Seq.index ($Seq.range min max) j) (+ min j)))
   :pattern ( ($Seq.index ($Seq.range min max) j))
  )))
(assert (forall ((min Int) (max Int) (v Int) ) (! (and
  (=> ($Seq.contains ($Seq.range min max) v) (and
  (<= min v)
  (< v max)))
  (=> (and
  (<= min v)
  (< v max)) ($Seq.contains ($Seq.range min max) v)))
   :pattern ( ($Seq.contains ($Seq.range min max) v))
  )))
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
; Declaring additional sort wrappers
(declare-fun $SortWrappers.$Seq<Int>To$Snap ($Seq<Int>) $Snap)
(declare-fun $SortWrappers.$SnapTo$Seq<Int> ($Snap) $Seq<Int>)
(assert (forall ((x $Seq<Int>)) (!
    (= x ($SortWrappers.$SnapTo$Seq<Int>($SortWrappers.$Seq<Int>To$Snap x)))
    :pattern (($SortWrappers.$Seq<Int>To$Snap x))
    )))
; Preamble end
; ------------------------------------------------------------
(declare-const diz@1 $Ref)
(declare-const diz@2 $Ref)
; ------------------------------------------------------------
; Declaring program functions
(declare-const s@$ $Snap)
(declare-fun $Node__contents ($Snap $Ref) $Seq<Int>)
(declare-fun $Node__contents$ ($Snap $Ref) $Seq<Int>)
(declare-fun $BlockingQueue__contents ($Snap $Ref) $Seq<Int>)
(declare-fun $BlockingQueue__contents$ ($Snap $Ref) $Seq<Int>)
; ---------- FUNCTION Node__contents (specs well-defined) ----------
(declare-const result@3 $Seq<Int>)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1 $Ref.null)))
(pop) ; 2
(assert (forall ((s@$ $Snap) (diz@1 $Ref)) (!
  ($Seq.equal ($Node__contents$ s@$ diz@1) ($Node__contents s@$ diz@1))
  :pattern (($Node__contents s@$ diz@1)))))
(assert true)
; ---------- FUNCTION Node__contents----------
(declare-const result@4 $Seq<Int>)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1 $Ref.null)))
; [eval] (unfolding acc(Node__state(diz), write) in (diz.Node__next == null ? Seq(diz.Node__val) : Seq(diz.Node__val) ++ Node__contents(diz.Node__next)))
(declare-const $k@5 $Perm)
(assert ($Perm.isValidVar $k@5))
(assert ($Perm.isReadVar $k@5 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 3
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 1] Second(First(Second(s@$))) != Null
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
    $Ref.null)))
; [eval] (diz.Node__next == null ? Seq(diz.Node__val) : Seq(diz.Node__val) ++ Node__contents(diz.Node__next))
; [eval] diz.Node__next == null
(push) ; 4
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 2] Second(First(Second(s@$))) == Null
(push) ; 4
; [else-branch 2] Second(First(Second(s@$))) != Null
; [eval] Seq(diz.Node__val) ++ Node__contents(diz.Node__next)
; [eval] Seq(diz.Node__val)
(push) ; 5
(assert (not (not (= $k@5 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@5 $Perm.No)))
(assert (=
  ($Seq.length
    ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$))))))
  1))
; [eval] Node__contents(diz.Node__next)
; [eval] diz.Node__next != null
(pop) ; 4
(assert (ite
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
    $Ref.null)
  true
  (and
    (=
      ($Seq.length
        ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$))))))
      1)
    (not (= $k@5 $Perm.No)))))
(declare-const $deadThen@6 $Seq<Int>)
(pop) ; 3
(push) ; 3
; [else-branch 1] Second(First(Second(s@$))) == Null
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
  $Ref.null))
; [eval] (diz.Node__next == null ? Seq(diz.Node__val) : Seq(diz.Node__val) ++ Node__contents(diz.Node__next))
; [eval] diz.Node__next == null
(push) ; 4
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 3] Second(First(Second(s@$))) == Null
; [eval] Seq(diz.Node__val)
(push) ; 5
(assert (not (not (= $k@5 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@5 $Perm.No)))
(assert (=
  ($Seq.length
    ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$))))))
  1))
(pop) ; 4
; [dead else-branch 3] Second(First(Second(s@$))) != Null
(assert (ite
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
    $Ref.null)
  (and
    (=
      ($Seq.length
        ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$))))))
      1)
    (not (= $k@5 $Perm.No)))
  true))
(declare-const $deadElse@7 $Seq<Int>)
(pop) ; 3
(declare-fun joinedIn@8 () $Seq<Int>)
(assert (implies
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
    $Ref.null)
  (and
    (ite
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
        $Ref.null)
      (and
        (=
          ($Seq.length
            ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$))))))
          1)
        (not (= $k@5 $Perm.No)))
      true)
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
      $Ref.null)
    ($Perm.isReadVar $k@5 $Perm.Write)
    ($Perm.isValidVar $k@5))))
(assert (implies
  (not
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
      $Ref.null))
  (and
    (ite
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
        $Ref.null)
      true
      (and
        (=
          ($Seq.length
            ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$))))))
          1)
        (not (= $k@5 $Perm.No))))
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
        $Ref.null))
    ($Perm.isReadVar $k@5 $Perm.Write)
    ($Perm.isValidVar $k@5))))
(assert (and
  (implies
    (=
      ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
      $Ref.null)
    ($Seq.equal
      joinedIn@8
      (ite
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
          $Ref.null)
        ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$)))))
        $deadElse@7)))
  (implies
    (not
      (=
        ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
        $Ref.null))
    ($Seq.equal
      joinedIn@8
      (ite
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
          $Ref.null)
        $deadThen@6
        ($Seq.append
          ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$)))))
          ($Node__contents ($Snap.combine
            $Snap.unit
            ($Snap.second ($Snap.second s@$))) ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$)))))))))))
(pop) ; 2
(assert (forall ((s@$ $Snap) (diz@1 $Ref)) (!
  (implies
    (not (= diz@1 $Ref.null))
    ($Seq.equal
      ($Node__contents s@$ diz@1)
      (ite
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$))))
          $Ref.null)
        ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$)))))
        ($Seq.append
          ($Seq.singleton ($SortWrappers.$SnapToInt ($Snap.first ($Snap.first ($Snap.second s@$)))))
          ($Node__contents$ ($Snap.combine
            $Snap.unit
            ($Snap.second ($Snap.second s@$))) ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.second s@$)))))))))
  :pattern (($Node__contents s@$ diz@1)))))
; ---------- FUNCTION BlockingQueue__contents (specs well-defined) ----------
(declare-const result@9 $Seq<Int>)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2 $Ref.null)))
(declare-const $k@10 $Perm)
(assert ($Perm.isValidVar $k@10))
(assert ($Perm.isReadVar $k@10 $Perm.Write))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@10 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@10 $Perm.No)))
(assert (>
  ($SortWrappers.$SnapToInt ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$)))))))))
  0))
(declare-const $k@11 $Perm)
(assert ($Perm.isValidVar $k@11))
(assert ($Perm.isReadVar $k@11 $Perm.Write))
(push) ; 3
(assert (not (not (= $k@11 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@11 $Perm.No)))
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$)))))))
    $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 4] Second(First(First(First(s@$)))) != Null
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null)))
(declare-const $k@12 $Perm)
(assert ($Perm.isValidVar $k@12))
(assert ($Perm.isReadVar $k@12 $Perm.Write))
(declare-const $k@13 $Perm)
(assert ($Perm.isValidVar $k@13))
(assert ($Perm.isReadVar $k@13 $Perm.Write))
(pop) ; 3
(push) ; 3
; [else-branch 4] Second(First(First(First(s@$)))) == Null
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
  $Ref.null))
(declare-const $k@14 $Perm)
(assert ($Perm.isValidVar $k@14))
(assert ($Perm.isReadVar $k@14 $Perm.Write))
(declare-const $k@15 $Perm)
(assert ($Perm.isValidVar $k@15))
(assert ($Perm.isReadVar $k@15 $Perm.Write))
(pop) ; 3
(pop) ; 2
(assert (forall ((s@$ $Snap) (diz@2 $Ref)) (!
  ($Seq.equal
    ($BlockingQueue__contents$ s@$ diz@2)
    ($BlockingQueue__contents s@$ diz@2))
  :pattern (($BlockingQueue__contents s@$ diz@2)))))
(assert true)
; ---------- FUNCTION BlockingQueue__contents----------
(declare-const result@16 $Seq<Int>)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2 $Ref.null)))
(declare-const $k@17 $Perm)
(assert ($Perm.isValidVar $k@17))
(assert ($Perm.isReadVar $k@17 $Perm.Write))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@17 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@17 $Perm.No)))
(assert (>
  ($SortWrappers.$SnapToInt ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$)))))))))
  0))
(declare-const $k@18 $Perm)
(assert ($Perm.isValidVar $k@18))
(assert ($Perm.isReadVar $k@18 $Perm.Write))
(push) ; 3
(assert (not (not (= $k@18 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@18 $Perm.No)))
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$)))))))
    $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 5] Second(First(First(First(s@$)))) != Null
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null)))
(declare-const $k@19 $Perm)
(assert ($Perm.isValidVar $k@19))
(assert ($Perm.isReadVar $k@19 $Perm.Write))
(declare-const $k@20 $Perm)
(assert ($Perm.isValidVar $k@20))
(assert ($Perm.isReadVar $k@20 $Perm.Write))
; [eval] (diz.BlockingQueue__first == null ? Seq[Int]() : Node__contents(diz.BlockingQueue__first))
; [eval] diz.BlockingQueue__first == null
(push) ; 4
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 6] Second(First(First(First(s@$)))) == Null
(push) ; 4
; [else-branch 6] Second(First(First(First(s@$)))) != Null
; [eval] Node__contents(diz.BlockingQueue__first)
; [eval] diz.BlockingQueue__first != null
(pop) ; 4
(declare-const $deadThen@21 $Seq<Int>)
(pop) ; 3
(push) ; 3
; [else-branch 5] Second(First(First(First(s@$)))) == Null
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
  $Ref.null))
(declare-const $k@22 $Perm)
(assert ($Perm.isValidVar $k@22))
(assert ($Perm.isReadVar $k@22 $Perm.Write))
(declare-const $k@23 $Perm)
(assert ($Perm.isValidVar $k@23))
(assert ($Perm.isReadVar $k@23 $Perm.Write))
; [eval] (diz.BlockingQueue__first == null ? Seq[Int]() : Node__contents(diz.BlockingQueue__first))
; [eval] diz.BlockingQueue__first == null
(push) ; 4
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 7] Second(First(First(First(s@$)))) == Null
; [eval] Seq[Int]()
(pop) ; 4
; [dead else-branch 7] Second(First(First(First(s@$)))) != Null
(declare-const $deadElse@24 $Seq<Int>)
(pop) ; 3
(pop) ; 2
(assert (forall ((s@$ $Snap) (diz@2 $Ref)) (!
  (implies
    (and
      (not (= diz@2 $Ref.null))
      (>
        ($SortWrappers.$SnapToInt ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$)))))))))
        0))
    ($Seq.equal
      ($BlockingQueue__contents s@$ diz@2)
      (ite
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
          $Ref.null)
        $Seq.empty<Int>
        ($Node__contents ($Snap.combine
          $Snap.unit
          ($Snap.second ($Snap.first ($Snap.first s@$)))) ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))))))
  :pattern (($BlockingQueue__contents s@$ diz@2)))))
; ---------- AtomicInteger__lock_held ----------
(declare-const diz@25 $Ref)
; ---------- Node__state ----------
(declare-const diz@26 $Ref)
(push) ; 2
(declare-const $t@27 $Snap)
(declare-const $t@28 $Snap)
(declare-const $t@29 $Snap)
(assert (= $t@27 ($Snap.combine $t@28 $t@29)))
(declare-const $t@30 Int)
(declare-const $t@31 $Ref)
(assert (=
  $t@28
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@30)
    ($SortWrappers.$RefTo$Snap $t@31))))
(assert (not (= diz@26 $Ref.null)))
(declare-const $k@32 $Perm)
(assert ($Perm.isValidVar $k@32))
(assert ($Perm.isReadVar $k@32 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 3
(assert (not (= $t@31 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@31 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 8] $t@31 != Null
(assert (not (= $t@31 $Ref.null)))
(pop) ; 3
(push) ; 3
; [else-branch 8] $t@31 == Null
(assert (= $t@31 $Ref.null))
(pop) ; 3
(pop) ; 2
; ---------- Lock__lock_held ----------
(declare-const diz@33 $Ref)
; ---------- AtomicInteger__AtomicInteger ----------
(declare-const val@34 Int)
(declare-const sys__result@35 $Ref)
(declare-const diz@36 $Ref)
(declare-const __flatten_1@37 Int)
(declare-const __flatten_2@38 Int)
(declare-const __flatten_38@39 Int)
(declare-const __flatten_39@40 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@35 $Ref.null)))
(declare-const $t@41 Int)
; [eval] sys__result.AtomicInteger__ghostVal == val
(assert (= $t@41 val@34))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(AtomicInteger__val, AtomicInteger__ghostVal)
(declare-const diz@42 $Ref)
(assert (not (= diz@42 $Ref.null)))
(declare-const AtomicInteger__val@43 Int)
(declare-const AtomicInteger__ghostVal@44 Int)
(assert (not (= sys__result@35 diz@42)))
; [exec]
; __flatten_1 := val
; [exec]
; __flatten_38 := __flatten_1
; [exec]
; diz.AtomicInteger__val := __flatten_38
; [exec]
; __flatten_2 := diz.AtomicInteger__val
; [exec]
; __flatten_39 := __flatten_2
; [exec]
; diz.AtomicInteger__ghostVal := __flatten_39
; [exec]
; exhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.AtomicInteger__ghostVal, write) && (sys__result.AtomicInteger__ghostVal == val)
; [eval] sys__result != null
; [eval] sys__result.AtomicInteger__ghostVal == val
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- AtomicInteger__get ----------
(declare-const diz@45 $Ref)
(declare-const sys__result@46 Int)
(declare-const res@47 Int)
(declare-const __flatten_3@48 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@45 $Ref.null)))
(declare-const $t@49 Int)
(push) ; 3
(declare-const $t@50 Int)
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@46 $t@50))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
(declare-const $t@51 $Snap)
(declare-const $t@52 Int)
(assert (= $t@51 ($Snap.combine ($SortWrappers.IntTo$Snap $t@52) $Snap.unit)))
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
(assert (= $t@52 $t@49))
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@53 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; exhale acc(AtomicInteger__lock_held(diz), write)
; [exec]
; exhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
; [exec]
; __flatten_3 := res
; [exec]
; sys__result := __flatten_3
; [exec]
; assert acc(diz.AtomicInteger__ghostVal, write) && (sys__result == diz.AtomicInteger__ghostVal)
; [eval] sys__result == diz.AtomicInteger__ghostVal
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- AtomicInteger__getAndIncrement ----------
(declare-const diz@54 $Ref)
(declare-const sys__result@55 Int)
(declare-const res@56 Int)
(declare-const __flatten_4@57 Int)
(declare-const __flatten_5@58 Int)
(declare-const __flatten_6@59 Int)
(declare-const __flatten_40@60 Int)
(declare-const __flatten_41@61 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@54 $Ref.null)))
(declare-const $t@62 Int)
(push) ; 3
(declare-const $t@63 Int)
; [eval] sys__result == diz.AtomicInteger__ghostVal - 1
; [eval] diz.AtomicInteger__ghostVal - 1
(assert (= sys__result@55 (- $t@63 1)))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
(declare-const $t@64 $Snap)
(declare-const $t@65 Int)
(assert (= $t@64 ($Snap.combine ($SortWrappers.IntTo$Snap $t@65) $Snap.unit)))
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
(assert (= $t@65 $t@62))
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@66 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; __flatten_4 := diz.AtomicInteger__val + 1
; [eval] diz.AtomicInteger__val + 1
; [exec]
; __flatten_40 := __flatten_4
; [exec]
; diz.AtomicInteger__val := __flatten_40
; [exec]
; __flatten_5 := diz.AtomicInteger__val
; [exec]
; __flatten_41 := __flatten_5
; [exec]
; diz.AtomicInteger__ghostVal := __flatten_41
; [exec]
; exhale acc(AtomicInteger__lock_held(diz), write)
; [exec]
; exhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
; [exec]
; __flatten_6 := res
; [exec]
; sys__result := __flatten_6
; [exec]
; assert acc(diz.AtomicInteger__ghostVal, write) && (sys__result == diz.AtomicInteger__ghostVal - 1)
; [eval] sys__result == diz.AtomicInteger__ghostVal - 1
; [eval] diz.AtomicInteger__ghostVal - 1
(push) ; 4
(assert (not (= $t@65 (- (+ $t@65 1) 1))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (= $t@65 (- (+ $t@65 1) 1)))
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- AtomicInteger__getAndDecrement ----------
(declare-const diz@67 $Ref)
(declare-const sys__result@68 Int)
(declare-const res@69 Int)
(declare-const __flatten_7@70 Int)
(declare-const __flatten_8@71 Int)
(declare-const __flatten_9@72 Int)
(declare-const __flatten_42@73 Int)
(declare-const __flatten_43@74 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@67 $Ref.null)))
(declare-const $t@75 Int)
(push) ; 3
(declare-const $t@76 Int)
; [eval] sys__result == diz.AtomicInteger__ghostVal + 1
; [eval] diz.AtomicInteger__ghostVal + 1
(assert (= sys__result@68 (+ $t@76 1)))
(pop) ; 3
(push) ; 3
; [exec]
; inhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
(declare-const $t@77 $Snap)
(declare-const $t@78 Int)
(assert (= $t@77 ($Snap.combine ($SortWrappers.IntTo$Snap $t@78) $Snap.unit)))
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
(assert (= $t@78 $t@75))
; [exec]
; inhale acc(AtomicInteger__lock_held(diz), write)
(declare-const $t@79 $Snap)
; [exec]
; res := diz.AtomicInteger__val
; [exec]
; __flatten_7 := diz.AtomicInteger__val - 1
; [eval] diz.AtomicInteger__val - 1
; [exec]
; __flatten_42 := __flatten_7
; [exec]
; diz.AtomicInteger__val := __flatten_42
; [exec]
; __flatten_8 := diz.AtomicInteger__val
; [exec]
; __flatten_43 := __flatten_8
; [exec]
; diz.AtomicInteger__ghostVal := __flatten_43
; [exec]
; exhale acc(AtomicInteger__lock_held(diz), write)
; [exec]
; exhale acc(diz.AtomicInteger__val, write) && (diz.AtomicInteger__val == diz.AtomicInteger__ghostVal)
; [eval] diz.AtomicInteger__val == diz.AtomicInteger__ghostVal
; [exec]
; __flatten_9 := res
; [exec]
; sys__result := __flatten_9
; [exec]
; assert acc(diz.AtomicInteger__ghostVal, write) && (sys__result == diz.AtomicInteger__ghostVal + 1)
; [eval] sys__result == diz.AtomicInteger__ghostVal + 1
; [eval] diz.AtomicInteger__ghostVal + 1
(push) ; 4
(assert (not (= $t@78 (+ (- $t@78 1) 1))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (= $t@78 (+ (- $t@78 1) 1)))
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- Node__Node ----------
(declare-const val@80 Int)
(declare-const next@81 $Ref)
(declare-const sys__result@82 $Ref)
(declare-const diz@83 $Ref)
(declare-const __flatten_10@84 Int)
(declare-const __flatten_11@85 $Ref)
(declare-const __flatten_44@86 Int)
(declare-const __flatten_45@87 $Ref)
(push) ; 2
; [eval] next != null
(push) ; 3
(assert (not (= next@81 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= next@81 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 9] next@81 != Null
(assert (not (= next@81 $Ref.null)))
(declare-const $t@88 $Snap)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@82 $Ref.null)))
(declare-const $t@89 $Snap)
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@90 $Snap)
(declare-const $t@91 $Snap)
(assert (= $t@89 ($Snap.combine $t@90 $t@91)))
(declare-const $t@92 Int)
(declare-const $t@93 $Ref)
(assert (=
  $t@90
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@92)
    ($SortWrappers.$RefTo$Snap $t@93))))
(declare-const $k@94 $Perm)
(assert ($Perm.isValidVar $k@94))
(assert ($Perm.isReadVar $k@94 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 5
(assert (not (= $t@93 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@93 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 10] $t@93 != Null
(assert (not (= $t@93 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@94 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@94 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@92 val@80))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@92 val@80)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 11] $t@92 == val@80
(assert (= $t@92 val@80))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 11] $t@92 != val@80
(assert (not (= $t@92 val@80)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 10] $t@93 == Null
(assert (= $t@93 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@94 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@94 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@92 val@80))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@92 val@80)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 12] $t@92 == val@80
(assert (= $t@92 val@80))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 12] $t@92 != val@80
(assert (not (= $t@92 val@80)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(declare-fun joinedIn@95 () Bool)
(assert (implies
  (= $t@93 $Ref.null)
  (and
    (not (= $k@94 $Perm.No))
    (= $t@93 $Ref.null)
    ($Perm.isReadVar $k@94 $Perm.Write)
    ($Perm.isValidVar $k@94)
    (=
      $t@90
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@92)
        ($SortWrappers.$RefTo$Snap $t@93)))
    (= $t@89 ($Snap.combine $t@90 $t@91)))))
(assert (implies
  (not (= $t@93 $Ref.null))
  (and
    (not (= $k@94 $Perm.No))
    (not (= $t@93 $Ref.null))
    ($Perm.isReadVar $k@94 $Perm.Write)
    ($Perm.isValidVar $k@94)
    (=
      $t@90
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@92)
        ($SortWrappers.$RefTo$Snap $t@93)))
    (= $t@89 ($Snap.combine $t@90 $t@91)))))
(assert (and
  (implies
    (= $t@93 $Ref.null)
    (= joinedIn@95 (and (= $t@92 val@80) (= $t@93 next@81))))
  (implies
    (not (= $t@93 $Ref.null))
    (= joinedIn@95 (and (= $t@92 val@80) (= $t@93 next@81))))))
(assert joinedIn@95)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@80)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 5
(assert (not (= next@81 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 13] next@81 == Null
(push) ; 5
; [else-branch 13] next@81 != Null
; [eval] old(Node__contents(next))
; [eval] Node__contents(next)
; [eval] next != null
(pop) ; 5
(declare-const $deadThen@96 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@89) sys__result@82)
  ($Seq.append
    ($Seq.singleton val@80)
    (ite
      (= next@81 $Ref.null)
      $deadThen@96
      ($Node__contents ($Snap.combine $Snap.unit $t@88) next@81)))))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@97 $Ref)
(assert (not (= diz@97 $Ref.null)))
(declare-const Node__next@98 $Ref)
(declare-const Node__val@99 Int)
(assert (and
  (not (= next@81 diz@97))
  (not (= sys__result@82 diz@97))
  (not (= __flatten_11@85 diz@97))
  (not (= __flatten_45@87 diz@97))
  (not (= Node__next@98 diz@97))))
; [exec]
; __flatten_10 := val
; [exec]
; __flatten_44 := __flatten_10
; [exec]
; diz.Node__val := __flatten_44
; [exec]
; __flatten_11 := next
; [exec]
; __flatten_45 := __flatten_11
; [exec]
; diz.Node__next := __flatten_45
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@100 $Perm)
(assert ($Perm.isValidVar $k@100))
(assert ($Perm.isReadVar $k@100 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@100 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@100 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 5
(assert (not (= next@81 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 14] next@81 != Null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(Node__state(sys__result), write) && (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next)) && (Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next))))
; [eval] sys__result != null
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@101 $Snap)
(declare-const $t@102 $Snap)
(assert (=
  ($Snap.combine
    ($Snap.combine
      ($SortWrappers.IntTo$Snap val@80)
      ($SortWrappers.$RefTo$Snap next@81))
    $t@88)
  ($Snap.combine $t@101 $t@102)))
(declare-const $t@103 Int)
(declare-const $t@104 $Ref)
(assert (=
  $t@101
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@103)
    ($SortWrappers.$RefTo$Snap $t@104))))
(declare-const $k@105 $Perm)
(assert ($Perm.isValidVar $k@105))
(assert ($Perm.isReadVar $k@105 $Perm.Write))
(assert (implies (< $Perm.No (- $Perm.Write $k@100)) (= $t@103 val@80)))
; [eval] sys__result.Node__next != null
(push) ; 6
(assert (not (= $t@104 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@104 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 15] $t@104 != Null
(assert (not (= $t@104 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 7
(assert (not (not (= (+ (- $Perm.Write $k@100) $k@105) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- $Perm.Write $k@100) $k@105) $Perm.No)))
(push) ; 7
(push) ; 8
(assert (not (not (= $t@103 val@80))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@103 val@80)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 16] $t@103 == val@80
(assert (= $t@103 val@80))
; [eval] sys__result.Node__next == next
(pop) ; 8
; [dead else-branch 16] $t@103 != val@80
(pop) ; 7
(pop) ; 6
; [dead else-branch 15] $t@104 == Null
(assert (not (= $t@104 $Ref.null)))
(assert (not (= (+ (- $Perm.Write $k@100) $k@105) $Perm.No)))
(push) ; 6
(assert (not (and (= $t@103 val@80) (= $t@104 next@81))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (and (= $t@103 val@80) (= $t@104 next@81)))
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@80)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 6
(assert (not (= next@81 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 17] next@81 == Null
(push) ; 6
; [else-branch 17] next@81 != Null
; [eval] old(Node__contents(next))
; [eval] Node__contents(next)
; [eval] next != null
(pop) ; 6
(declare-const $deadThen@106 $Seq<Int>)
(push) ; 6
(assert (not ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@80)
        ($SortWrappers.$RefTo$Snap next@81))
      $t@88)) diz@97)
  ($Seq.append
    ($Seq.singleton val@80)
    (ite
      (= next@81 $Ref.null)
      $deadThen@106
      ($Node__contents ($Snap.combine $Snap.unit $t@88) next@81))))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@80)
        ($SortWrappers.$RefTo$Snap next@81))
      $t@88)) diz@97)
  ($Seq.append
    ($Seq.singleton val@80)
    (ite
      (= next@81 $Ref.null)
      $deadThen@106
      ($Node__contents ($Snap.combine $Snap.unit $t@88) next@81)))))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 14] next@81 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 9] next@81 == Null
(assert (= next@81 $Ref.null))
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@82 $Ref.null)))
(declare-const $t@107 $Snap)
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@108 $Snap)
(declare-const $t@109 $Snap)
(assert (= $t@107 ($Snap.combine $t@108 $t@109)))
(declare-const $t@110 Int)
(declare-const $t@111 $Ref)
(assert (=
  $t@108
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@110)
    ($SortWrappers.$RefTo$Snap $t@111))))
(declare-const $k@112 $Perm)
(assert ($Perm.isValidVar $k@112))
(assert ($Perm.isReadVar $k@112 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 5
(assert (not (= $t@111 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@111 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 18] $t@111 != Null
(assert (not (= $t@111 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@112 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@112 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@110 val@80))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@110 val@80)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 19] $t@110 == val@80
(assert (= $t@110 val@80))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 19] $t@110 != val@80
(assert (not (= $t@110 val@80)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 18] $t@111 == Null
(assert (= $t@111 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@112 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@112 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@110 val@80))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@110 val@80)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 20] $t@110 == val@80
(assert (= $t@110 val@80))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 20] $t@110 != val@80
(assert (not (= $t@110 val@80)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(declare-fun joinedIn@113 () Bool)
(assert (implies
  (= $t@111 $Ref.null)
  (and
    (not (= $k@112 $Perm.No))
    (= $t@111 $Ref.null)
    ($Perm.isReadVar $k@112 $Perm.Write)
    ($Perm.isValidVar $k@112)
    (=
      $t@108
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@110)
        ($SortWrappers.$RefTo$Snap $t@111)))
    (= $t@107 ($Snap.combine $t@108 $t@109)))))
(assert (implies
  (not (= $t@111 $Ref.null))
  (and
    (not (= $k@112 $Perm.No))
    (not (= $t@111 $Ref.null))
    ($Perm.isReadVar $k@112 $Perm.Write)
    ($Perm.isValidVar $k@112)
    (=
      $t@108
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@110)
        ($SortWrappers.$RefTo$Snap $t@111)))
    (= $t@107 ($Snap.combine $t@108 $t@109)))))
(assert (and
  (implies
    (= $t@111 $Ref.null)
    (= joinedIn@113 (and (= $t@110 val@80) (= $t@111 next@81))))
  (implies
    (not (= $t@111 $Ref.null))
    (= joinedIn@113 (and (= $t@110 val@80) (= $t@111 next@81))))))
(assert joinedIn@113)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@80)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 5
(assert (not (not (= next@81 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 21] next@81 == Null
; [eval] Seq[Int]()
(pop) ; 5
; [dead else-branch 21] next@81 != Null
(declare-const $deadElse@114 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@107) sys__result@82)
  ($Seq.append
    ($Seq.singleton val@80)
    (ite (= next@81 $Ref.null) $Seq.empty<Int> $deadElse@114))))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@115 $Ref)
(assert (not (= diz@115 $Ref.null)))
(declare-const Node__next@116 $Ref)
(declare-const Node__val@117 Int)
(assert (and
  (not (= next@81 diz@115))
  (not (= sys__result@82 diz@115))
  (not (= __flatten_11@85 diz@115))
  (not (= __flatten_45@87 diz@115))
  (not (= Node__next@116 diz@115))))
; [exec]
; __flatten_10 := val
; [exec]
; __flatten_44 := __flatten_10
; [exec]
; diz.Node__val := __flatten_44
; [exec]
; __flatten_11 := next
; [exec]
; __flatten_45 := __flatten_11
; [exec]
; diz.Node__next := __flatten_45
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@118 $Perm)
(assert ($Perm.isValidVar $k@118))
(assert ($Perm.isReadVar $k@118 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@118 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@118 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 5
(assert (not (not (= next@81 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 22] next@81 != Null
(push) ; 5
; [else-branch 22] next@81 == Null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(Node__state(sys__result), write) && (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next)) && (Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next))))
; [eval] sys__result != null
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@119 $Snap)
(declare-const $t@120 $Snap)
(assert (=
  ($Snap.combine
    ($Snap.combine
      ($SortWrappers.IntTo$Snap val@80)
      ($SortWrappers.$RefTo$Snap next@81))
    $Snap.unit)
  ($Snap.combine $t@119 $t@120)))
(declare-const $t@121 Int)
(declare-const $t@122 $Ref)
(assert (=
  $t@119
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@121)
    ($SortWrappers.$RefTo$Snap $t@122))))
(declare-const $k@123 $Perm)
(assert ($Perm.isValidVar $k@123))
(assert ($Perm.isReadVar $k@123 $Perm.Write))
(assert (implies (< $Perm.No (- $Perm.Write $k@118)) (= $t@121 val@80)))
; [eval] sys__result.Node__next != null
(push) ; 6
(assert (not (= $t@122 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@122 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 23] $t@122 != Null
(push) ; 6
; [else-branch 23] $t@122 == Null
(assert (= $t@122 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 7
(assert (not (not (= (+ (- $Perm.Write $k@118) $k@123) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- $Perm.Write $k@118) $k@123) $Perm.No)))
(push) ; 7
(push) ; 8
(assert (not (not (= $t@121 val@80))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@121 val@80)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 24] $t@121 == val@80
(assert (= $t@121 val@80))
; [eval] sys__result.Node__next == next
(pop) ; 8
; [dead else-branch 24] $t@121 != val@80
(pop) ; 7
(pop) ; 6
(assert (= $t@122 $Ref.null))
(assert (not (= (+ (- $Perm.Write $k@118) $k@123) $Perm.No)))
(push) ; 6
(assert (not (and (= $t@121 val@80) (= $t@122 next@81))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (and (= $t@121 val@80) (= $t@122 next@81)))
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@80)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 6
(assert (not (not (= next@81 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 25] next@81 == Null
; [eval] Seq[Int]()
(pop) ; 6
; [dead else-branch 25] next@81 != Null
(declare-const $deadElse@124 $Seq<Int>)
(push) ; 6
(assert (not ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@80)
        ($SortWrappers.$RefTo$Snap next@81))
      $Snap.unit)) diz@115)
  ($Seq.append
    ($Seq.singleton val@80)
    (ite (= next@81 $Ref.null) $Seq.empty<Int> $deadElse@124)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@80)
        ($SortWrappers.$RefTo$Snap next@81))
      $Snap.unit)) diz@115)
  ($Seq.append
    ($Seq.singleton val@80)
    (ite (= next@81 $Ref.null) $Seq.empty<Int> $deadElse@124))))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Node__append ----------
(declare-const diz@125 $Ref)
(declare-const n@126 $Ref)
(declare-const __flatten_12@127 $Ref)
(declare-const __flatten_46@128 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@125 $Ref.null)))
(declare-const $t@129 $Snap)
; [eval] n != null
(assert (not (= n@126 $Ref.null)))
(declare-const $t@130 $Snap)
(push) ; 3
(assert (not (= diz@125 n@126)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(declare-const $t@131 $Snap)
; [eval] Node__contents(diz) == old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] old(Node__contents(diz))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(n))
; [eval] Node__contents(n)
; [eval] n != null
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@131) diz@125)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@129) diz@125)
    ($Node__contents ($Snap.combine $Snap.unit $t@130) n@126))))
(pop) ; 3
(push) ; 3
; [exec]
; unfold acc(Node__state(diz), write)
(declare-const $t@132 $Snap)
(declare-const $t@133 $Snap)
(assert (= $t@129 ($Snap.combine $t@132 $t@133)))
(declare-const $t@134 Int)
(declare-const $t@135 $Ref)
(assert (=
  $t@132
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@134)
    ($SortWrappers.$RefTo$Snap $t@135))))
(declare-const $k@136 $Perm)
(assert ($Perm.isValidVar $k@136))
(assert ($Perm.isReadVar $k@136 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 4
(assert (not (= $t@135 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@135 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 26] $t@135 != Null
(assert (not (= $t@135 $Ref.null)))
(push) ; 5
(assert (not (= n@126 $t@135)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (= $t@135 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 27] $t@135 == Null
(push) ; 5
; [else-branch 27] $t@135 != Null
(pop) ; 5
; [eval] !(diz.Node__next == null)
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (= $t@135 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 28] $t@135 != Null
; [exec]
; Node__append(diz.Node__next, n)
; [eval] diz != null
; [eval] n != null
(declare-const $t@137 $Snap)
(declare-const $t@138 $Snap)
(assert (= $t@137 ($Snap.combine $t@138 $Snap.unit)))
; [eval] Node__contents(diz) == old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] old(Node__contents(diz))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(n))
; [eval] Node__contents(n)
; [eval] n != null
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@138) $t@135)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@133) $t@135)
    ($Node__contents ($Snap.combine $Snap.unit $t@130) n@126))))
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@139 $Perm)
(assert ($Perm.isValidVar $k@139))
(assert ($Perm.isReadVar $k@139 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@139 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@136 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@136 $Perm.No)))
(assert (< $k@139 $k@136))
; [eval] diz.Node__next != null
(push) ; 6
(assert (not (= $t@135 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 29] $t@135 != Null
; [eval] Node__contents(diz) == old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] old(Node__contents(diz))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(n))
; [eval] Node__contents(n)
; [eval] n != null
(push) ; 7
(assert (not ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@134)
        ($SortWrappers.$RefTo$Snap $t@135))
      $t@138)) diz@125)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@129) diz@125)
    ($Node__contents ($Snap.combine $Snap.unit $t@130) n@126)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@134)
        ($SortWrappers.$RefTo$Snap $t@135))
      $t@138)) diz@125)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@129) diz@125)
    ($Node__contents ($Snap.combine $Snap.unit $t@130) n@126))))
(pop) ; 6
; [dead else-branch 29] $t@135 == Null
(pop) ; 5
; [dead else-branch 28] $t@135 == Null
(pop) ; 4
(push) ; 4
; [else-branch 26] $t@135 == Null
(assert (= $t@135 $Ref.null))
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (not (= $t@135 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 30] $t@135 == Null
; [exec]
; __flatten_12 := n
; [exec]
; __flatten_46 := __flatten_12
; [exec]
; diz.Node__next := __flatten_46
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@140 $Perm)
(assert ($Perm.isValidVar $k@140))
(assert ($Perm.isReadVar $k@140 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@140 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@136 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@136 $Perm.No)))
(assert (< $k@140 $k@136))
; [eval] diz.Node__next != null
(push) ; 6
(assert (not (= n@126 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 31] n@126 != Null
; [eval] Node__contents(diz) == old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] old(Node__contents(diz))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(n))
; [eval] Node__contents(n)
; [eval] n != null
(push) ; 7
(assert (not ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@134)
        ($SortWrappers.$RefTo$Snap n@126))
      $t@130)) diz@125)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@129) diz@125)
    ($Node__contents ($Snap.combine $Snap.unit $t@130) n@126)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@134)
        ($SortWrappers.$RefTo$Snap n@126))
      $t@130)) diz@125)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@129) diz@125)
    ($Node__contents ($Snap.combine $Snap.unit $t@130) n@126))))
(pop) ; 6
; [dead else-branch 31] n@126 == Null
(pop) ; 5
; [dead else-branch 30] $t@135 != Null
; [eval] !(diz.Node__next == null)
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (not (= $t@135 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 32] $t@135 != Null
(push) ; 5
; [else-branch 32] $t@135 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Lock__Lock ----------
(declare-const sys__result@141 $Ref)
(declare-const diz@142 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@141 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new()
(declare-const diz@143 $Ref)
(assert (not (= diz@143 $Ref.null)))
(assert (not (= sys__result@141 diz@143)))
; [exec]
; exhale true
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__BlockingQueue ----------
(declare-const capacity@144 Int)
(declare-const sys__result@145 $Ref)
(declare-const diz@146 $Ref)
(declare-const __flatten_14@147 $Ref)
(declare-const __flatten_15@148 $Ref)
(declare-const __flatten_16@149 $Ref)
(declare-const __flatten_17@150 $Ref)
(declare-const __flatten_18@151 Int)
(declare-const __flatten_19@152 $Ref)
(declare-const __flatten_20@153 $Ref)
(declare-const __flatten_49@154 $Ref)
(declare-const __flatten_51@155 $Ref)
(declare-const __flatten_52@156 Int)
(declare-const __flatten_54@157 $Ref)
(push) ; 2
; [eval] capacity > 0
(assert (> capacity@144 0))
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@145 $Ref.null)))
(declare-const $k@158 $Perm)
(assert ($Perm.isValidVar $k@158))
(assert ($Perm.isReadVar $k@158 $Perm.Write))
(declare-const $t@159 Int)
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@158 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@158 $Perm.No)))
(assert (> $t@159 0))
(declare-const $k@160 $Perm)
(assert ($Perm.isValidVar $k@160))
(assert ($Perm.isReadVar $k@160 $Perm.Write))
(declare-const $t@161 $Ref)
(push) ; 4
(assert (not (not (= $k@160 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@160 $Perm.No)))
(assert (not (= $t@161 $Ref.null)))
(declare-const $t@162 Int)
(declare-const $t@163 $Ref)
; [eval] sys__result.BlockingQueue__first != null
(push) ; 4
(assert (not (= $t@163 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@163 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 33] $t@163 != Null
(assert (not (= $t@163 $Ref.null)))
(declare-const $t@164 $Snap)
(declare-const $k@165 $Perm)
(assert ($Perm.isValidVar $k@165))
(assert ($Perm.isReadVar $k@165 $Perm.Write))
(declare-const $t@166 $Ref)
(declare-const $k@167 $Perm)
(assert ($Perm.isValidVar $k@167))
(assert ($Perm.isReadVar $k@167 $Perm.Write))
(declare-const $t@168 $Ref)
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@159 capacity@144))
; [eval] sys__result.BlockingQueue__first == null
(assert (= $t@163 $Ref.null))
; [eval] sys__result.BlockingQueue__count.AtomicInteger__ghostVal == 0
(assert (= $t@162 0))
(pop) ; 4
(push) ; 4
; [else-branch 33] $t@163 == Null
(assert (= $t@163 $Ref.null))
(declare-const $k@169 $Perm)
(assert ($Perm.isValidVar $k@169))
(assert ($Perm.isReadVar $k@169 $Perm.Write))
(declare-const $t@170 $Ref)
(declare-const $k@171 $Perm)
(assert ($Perm.isValidVar $k@171))
(assert ($Perm.isReadVar $k@171 $Perm.Write))
(declare-const $t@172 $Ref)
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@159 capacity@144))
; [eval] sys__result.BlockingQueue__first == null
; [eval] sys__result.BlockingQueue__count.AtomicInteger__ghostVal == 0
(assert (= $t@162 0))
(pop) ; 4
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(BlockingQueue__capacity, BlockingQueue__count, BlockingQueue__first, BlockingQueue__putLock, BlockingQueue__takeLock)
(declare-const diz@173 $Ref)
(assert (not (= diz@173 $Ref.null)))
(declare-const BlockingQueue__capacity@174 Int)
(declare-const BlockingQueue__count@175 $Ref)
(declare-const BlockingQueue__first@176 $Ref)
(declare-const BlockingQueue__putLock@177 $Ref)
(declare-const BlockingQueue__takeLock@178 $Ref)
(assert (and
  (not (= sys__result@145 diz@173))
  (not (= __flatten_14@147 diz@173))
  (not (= __flatten_15@148 diz@173))
  (not (= __flatten_16@149 diz@173))
  (not (= __flatten_17@150 diz@173))
  (not (= __flatten_19@152 diz@173))
  (not (= __flatten_20@153 diz@173))
  (not (= __flatten_49@154 diz@173))
  (not (= __flatten_51@155 diz@173))
  (not (= __flatten_54@157 diz@173))
  (not (= BlockingQueue__count@175 diz@173))
  (not (= BlockingQueue__first@176 diz@173))
  (not (= BlockingQueue__putLock@177 diz@173))
  (not (= BlockingQueue__takeLock@178 diz@173))))
; [exec]
; __flatten_15 := Lock__Lock()
(declare-const sys__result@179 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@179 $Ref.null)))
; [exec]
; __flatten_14 := __flatten_15
; [exec]
; __flatten_49 := __flatten_14
; [exec]
; diz.BlockingQueue__putLock := __flatten_49
; [exec]
; __flatten_17 := Lock__Lock()
(declare-const sys__result@180 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@180 $Ref.null)))
; [exec]
; __flatten_16 := __flatten_17
; [exec]
; __flatten_51 := __flatten_16
; [exec]
; diz.BlockingQueue__takeLock := __flatten_51
; [exec]
; __flatten_18 := capacity
; [exec]
; __flatten_52 := __flatten_18
; [exec]
; diz.BlockingQueue__capacity := __flatten_52
; [exec]
; diz.BlockingQueue__first := null
; [exec]
; __flatten_20 := AtomicInteger__AtomicInteger(0)
(declare-const sys__result@181 $Ref)
(declare-const $t@182 $Snap)
(declare-const $t@183 Int)
(assert (= $t@182 ($Snap.combine ($SortWrappers.IntTo$Snap $t@183) $Snap.unit)))
(declare-const $t@184 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@183)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@184))))
; [eval] sys__result != null
(assert (not (= sys__result@181 $Ref.null)))
; [eval] sys__result.AtomicInteger__ghostVal == val
(assert (= $t@184 0))
; [exec]
; __flatten_19 := __flatten_20
; [exec]
; __flatten_54 := __flatten_19
; [exec]
; diz.BlockingQueue__count := __flatten_54
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.BlockingQueue__capacity, wildcard) && (sys__result.BlockingQueue__capacity > 0) && acc(sys__result.BlockingQueue__count, wildcard) && acc(sys__result.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.BlockingQueue__first, write) && ((sys__result.BlockingQueue__first != null) ==> acc(Node__state(sys__result.BlockingQueue__first), write)) && acc(sys__result.BlockingQueue__putLock, wildcard) && acc(sys__result.BlockingQueue__takeLock, wildcard) && (sys__result.BlockingQueue__capacity == capacity) && (sys__result.BlockingQueue__first == null) && (sys__result.BlockingQueue__count.AtomicInteger__ghostVal == 0)
; [eval] sys__result != null
(declare-const $k@185 $Perm)
(assert ($Perm.isValidVar $k@185))
(assert ($Perm.isReadVar $k@185 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@185 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@185 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(declare-const $k@186 $Perm)
(assert ($Perm.isValidVar $k@186))
(assert ($Perm.isReadVar $k@186 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@186 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@186 $Perm.Write))
; [eval] sys__result.BlockingQueue__first != null
(push) ; 4
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 34] False
(push) ; 4
; [else-branch 34] True
(declare-const $k@187 $Perm)
(assert ($Perm.isValidVar $k@187))
(assert ($Perm.isReadVar $k@187 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@187 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@187 $Perm.Write))
(declare-const $k@188 $Perm)
(assert ($Perm.isValidVar $k@188))
(assert ($Perm.isReadVar $k@188 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@188 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@188 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity == capacity
; [eval] sys__result.BlockingQueue__first == null
; [eval] sys__result.BlockingQueue__count.AtomicInteger__ghostVal == 0
; [exec]
; inhale false
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__unlinkFirst ----------
(declare-const diz@189 $Ref)
(declare-const sys__result@190 Int)
(declare-const value@191 Int)
(declare-const __flatten_21@192 $Ref)
(declare-const __flatten_22@193 $Ref)
(declare-const __flatten_23@194 $Ref)
(declare-const __flatten_24@195 Int)
(declare-const __flatten_55@196 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@189 $Ref.null)))
(declare-const $k@197 $Perm)
(assert ($Perm.isValidVar $k@197))
(assert ($Perm.isReadVar $k@197 $Perm.Write))
(declare-const $t@198 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@197 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@197 $Perm.No)))
(assert (> $t@198 0))
(declare-const $k@199 $Perm)
(assert ($Perm.isValidVar $k@199))
(assert ($Perm.isReadVar $k@199 $Perm.Write))
(declare-const $t@200 $Ref)
(push) ; 3
(assert (not (not (= $k@199 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@199 $Perm.No)))
(assert (not (= $t@200 $Ref.null)))
(declare-const $t@201 Int)
(declare-const $t@202 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@202 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 35] $t@202 != Null
(assert (not (= $t@202 $Ref.null)))
(declare-const $t@203 $Snap)
(declare-const $k@204 $Perm)
(assert ($Perm.isValidVar $k@204))
(assert ($Perm.isReadVar $k@204 $Perm.Write))
(declare-const $t@205 $Ref)
(declare-const $k@206 $Perm)
(assert ($Perm.isValidVar $k@206))
(assert ($Perm.isReadVar $k@206 $Perm.Write))
(declare-const $t@207 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 4
(declare-const $k@208 $Perm)
(assert ($Perm.isValidVar $k@208))
(assert ($Perm.isReadVar $k@208 $Perm.Write))
(declare-const $t@209 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@208 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@208 $Perm.No)))
(assert (> $t@209 0))
(declare-const $k@210 $Perm)
(assert ($Perm.isValidVar $k@210))
(assert ($Perm.isReadVar $k@210 $Perm.Write))
(declare-const $t@211 $Ref)
(push) ; 5
(assert (not (not (= $k@210 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@210 $Perm.No)))
(assert (not (= $t@211 $Ref.null)))
(declare-const $t@212 Int)
(declare-const $t@213 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@213 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@213 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 36] $t@213 != Null
(assert (not (= $t@213 $Ref.null)))
(declare-const $t@214 $Snap)
(declare-const $k@215 $Perm)
(assert ($Perm.isValidVar $k@215))
(assert ($Perm.isReadVar $k@215 $Perm.Write))
(declare-const $t@216 $Ref)
(declare-const $k@217 $Perm)
(assert ($Perm.isValidVar $k@217))
(assert ($Perm.isReadVar $k@217 $Perm.Write))
(declare-const $t@218 $Ref)
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@219 $Perm)
(assert ($Perm.isValidVar $k@219))
(assert ($Perm.isReadVar $k@219 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@219 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@219 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@220 $Perm)
(assert ($Perm.isValidVar $k@220))
(assert ($Perm.isReadVar $k@220 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@220 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@220 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 37] $t@202 != Null
(declare-const $k@221 $Perm)
(assert ($Perm.isValidVar $k@221))
(assert ($Perm.isReadVar $k@221 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@221 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@204 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@204 $Perm.No)))
(assert (< $k@221 $k@204))
(declare-const $k@222 $Perm)
(assert ($Perm.isValidVar $k@222))
(assert ($Perm.isReadVar $k@222 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@222 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@206 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@206 $Perm.No)))
(assert (< $k@222 $k@206))
(pop) ; 6
; [dead else-branch 37] $t@202 == Null
(assert ($Perm.isValidVar $k@221))
(assert ($Perm.isReadVar $k@221 $Perm.Write))
(assert (not (= $k@204 $Perm.No)))
(assert (< $k@221 $k@204))
(assert ($Perm.isValidVar $k@222))
(assert ($Perm.isReadVar $k@222 $Perm.Write))
(assert (not (= $k@206 $Perm.No)))
(assert (< $k@222 $k@206))
(assert (=
  sys__result@190
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@223 $Perm)
(assert ($Perm.isValidVar $k@223))
(assert ($Perm.isReadVar $k@223 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@223 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@223 $k@208))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@224 $Perm)
(assert ($Perm.isValidVar $k@224))
(assert ($Perm.isReadVar $k@224 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@224 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@224 $k@210))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@213 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 38] $t@213 != Null
(declare-const $k@225 $Perm)
(assert ($Perm.isValidVar $k@225))
(assert ($Perm.isReadVar $k@225 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@225 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@215 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@215 $Perm.No)))
(assert (< $k@225 $k@215))
(declare-const $k@226 $Perm)
(assert ($Perm.isValidVar $k@226))
(assert ($Perm.isReadVar $k@226 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@226 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@217 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@217 $Perm.No)))
(assert (< $k@226 $k@217))
(pop) ; 6
; [dead else-branch 38] $t@213 == Null
(assert ($Perm.isValidVar $k@225))
(assert ($Perm.isReadVar $k@225 $Perm.Write))
(assert (not (= $k@215 $Perm.No)))
(assert (< $k@225 $k@215))
(assert ($Perm.isValidVar $k@226))
(assert ($Perm.isReadVar $k@226 $Perm.Write))
(assert (not (= $k@217 $Perm.No)))
(assert (< $k@226 $k@217))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@227 $Perm)
(assert ($Perm.isValidVar $k@227))
(assert ($Perm.isReadVar $k@227 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@227 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@227 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@228 $Perm)
(assert ($Perm.isValidVar $k@228))
(assert ($Perm.isReadVar $k@228 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@228 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@228 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 39] $t@202 != Null
(declare-const $k@229 $Perm)
(assert ($Perm.isValidVar $k@229))
(assert ($Perm.isReadVar $k@229 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@229 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@229 $k@204))
(declare-const $k@230 $Perm)
(assert ($Perm.isValidVar $k@230))
(assert ($Perm.isReadVar $k@230 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@230 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@230 $k@206))
(pop) ; 6
; [dead else-branch 39] $t@202 == Null
(assert ($Perm.isValidVar $k@229))
(assert ($Perm.isReadVar $k@229 $Perm.Write))
(assert (< $k@229 $k@204))
(assert ($Perm.isValidVar $k@230))
(assert ($Perm.isReadVar $k@230 $Perm.Write))
(assert (< $k@230 $k@206))
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@209))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@211))
            ($SortWrappers.IntTo$Snap $t@212))
          ($SortWrappers.$RefTo$Snap $t@213))
        $t@214)
      ($SortWrappers.$RefTo$Snap $t@216))
    ($SortWrappers.$RefTo$Snap $t@218)) diz@189)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    1)))
(pop) ; 5
(push) ; 5
; [else-branch 36] $t@213 == Null
(assert (= $t@213 $Ref.null))
(declare-const $k@231 $Perm)
(assert ($Perm.isValidVar $k@231))
(assert ($Perm.isReadVar $k@231 $Perm.Write))
(declare-const $t@232 $Ref)
(declare-const $k@233 $Perm)
(assert ($Perm.isValidVar $k@233))
(assert ($Perm.isReadVar $k@233 $Perm.Write))
(declare-const $t@234 $Ref)
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@235 $Perm)
(assert ($Perm.isValidVar $k@235))
(assert ($Perm.isReadVar $k@235 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@235 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@235 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@236 $Perm)
(assert ($Perm.isValidVar $k@236))
(assert ($Perm.isReadVar $k@236 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@236 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@236 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 40] $t@202 != Null
(declare-const $k@237 $Perm)
(assert ($Perm.isValidVar $k@237))
(assert ($Perm.isReadVar $k@237 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@237 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@204 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@204 $Perm.No)))
(assert (< $k@237 $k@204))
(declare-const $k@238 $Perm)
(assert ($Perm.isValidVar $k@238))
(assert ($Perm.isReadVar $k@238 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@238 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@206 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@206 $Perm.No)))
(assert (< $k@238 $k@206))
(pop) ; 6
; [dead else-branch 40] $t@202 == Null
(assert ($Perm.isValidVar $k@237))
(assert ($Perm.isReadVar $k@237 $Perm.Write))
(assert (not (= $k@204 $Perm.No)))
(assert (< $k@237 $k@204))
(assert ($Perm.isValidVar $k@238))
(assert ($Perm.isReadVar $k@238 $Perm.Write))
(assert (not (= $k@206 $Perm.No)))
(assert (< $k@238 $k@206))
(assert (=
  sys__result@190
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@239 $Perm)
(assert ($Perm.isValidVar $k@239))
(assert ($Perm.isReadVar $k@239 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@239 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@239 $k@208))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@240 $Perm)
(assert ($Perm.isValidVar $k@240))
(assert ($Perm.isReadVar $k@240 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@240 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@240 $k@210))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@213 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 41] $t@213 != Null
(push) ; 6
; [else-branch 41] $t@213 == Null
(declare-const $k@241 $Perm)
(assert ($Perm.isValidVar $k@241))
(assert ($Perm.isReadVar $k@241 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@241 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@231 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@231 $Perm.No)))
(assert (< $k@241 $k@231))
(declare-const $k@242 $Perm)
(assert ($Perm.isValidVar $k@242))
(assert ($Perm.isReadVar $k@242 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@242 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@233 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@233 $Perm.No)))
(assert (< $k@242 $k@233))
(pop) ; 6
(assert ($Perm.isValidVar $k@241))
(assert ($Perm.isReadVar $k@241 $Perm.Write))
(assert (not (= $k@231 $Perm.No)))
(assert (< $k@241 $k@231))
(assert ($Perm.isValidVar $k@242))
(assert ($Perm.isReadVar $k@242 $Perm.Write))
(assert (not (= $k@233 $Perm.No)))
(assert (< $k@242 $k@233))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@243 $Perm)
(assert ($Perm.isValidVar $k@243))
(assert ($Perm.isReadVar $k@243 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@243 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@243 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@244 $Perm)
(assert ($Perm.isValidVar $k@244))
(assert ($Perm.isReadVar $k@244 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@244 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@244 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 42] $t@202 != Null
(declare-const $k@245 $Perm)
(assert ($Perm.isValidVar $k@245))
(assert ($Perm.isReadVar $k@245 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@245 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@245 $k@204))
(declare-const $k@246 $Perm)
(assert ($Perm.isValidVar $k@246))
(assert ($Perm.isReadVar $k@246 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@246 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@246 $k@206))
(pop) ; 6
; [dead else-branch 42] $t@202 == Null
(assert ($Perm.isValidVar $k@245))
(assert ($Perm.isReadVar $k@245 $Perm.Write))
(assert (< $k@245 $k@204))
(assert ($Perm.isValidVar $k@246))
(assert ($Perm.isReadVar $k@246 $Perm.Write))
(assert (< $k@246 $k@206))
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@209))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@211))
            ($SortWrappers.IntTo$Snap $t@212))
          ($SortWrappers.$RefTo$Snap $t@213))
        $Snap.unit)
      ($SortWrappers.$RefTo$Snap $t@232))
    ($SortWrappers.$RefTo$Snap $t@234)) diz@189)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    1)))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; unfold acc(Node__state(diz.BlockingQueue__first), write)
(declare-const $t@247 $Snap)
(declare-const $t@248 $Snap)
(assert (= $t@203 ($Snap.combine $t@247 $t@248)))
(declare-const $t@249 Int)
(declare-const $t@250 $Ref)
(assert (=
  $t@247
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@249)
    ($SortWrappers.$RefTo$Snap $t@250))))
(declare-const $k@251 $Perm)
(assert ($Perm.isValidVar $k@251))
(assert ($Perm.isReadVar $k@251 $Perm.Write))
; [eval] diz.BlockingQueue__first.Node__next != null
(push) ; 5
(assert (not (= $t@250 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@250 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 43] $t@250 != Null
(assert (not (= $t@250 $Ref.null)))
; [exec]
; __flatten_21 := diz.BlockingQueue__first
; [exec]
; value := __flatten_21.Node__val
(push) ; 6
(assert (not (not (= $k@251 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@251 $Perm.No)))
; [exec]
; __flatten_23 := diz.BlockingQueue__first
; [exec]
; __flatten_22 := __flatten_23.Node__next
; [exec]
; __flatten_55 := __flatten_22
; [exec]
; diz.BlockingQueue__first := __flatten_55
; [exec]
; __flatten_24 := value
; [exec]
; sys__result := __flatten_24
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard) && (sys__result == old(BlockingQueue__contents(diz)[0])) && (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..]))
(declare-const $k@252 $Perm)
(assert ($Perm.isValidVar $k@252))
(assert ($Perm.isReadVar $k@252 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@252 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@252 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@253 $Perm)
(assert ($Perm.isValidVar $k@253))
(assert ($Perm.isReadVar $k@253 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@253 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@253 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@250 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 44] $t@250 != Null
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
(assert (not (not (= $k@204 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@204 $Perm.No)))
(assert (< $k@254 $k@204))
(declare-const $k@255 $Perm)
(assert ($Perm.isValidVar $k@255))
(assert ($Perm.isReadVar $k@255 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@255 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@206 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@206 $Perm.No)))
(assert (< $k@255 $k@206))
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@256 $Perm)
(assert ($Perm.isValidVar $k@256))
(assert ($Perm.isReadVar $k@256 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@256 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@256 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@257 $Perm)
(assert ($Perm.isValidVar $k@257))
(assert ($Perm.isReadVar $k@257 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@257 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@257 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 45] $t@202 != Null
(declare-const $k@258 $Perm)
(assert ($Perm.isValidVar $k@258))
(assert ($Perm.isReadVar $k@258 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@258 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@258 $k@204))
(declare-const $k@259 $Perm)
(assert ($Perm.isValidVar $k@259))
(assert ($Perm.isReadVar $k@259 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@259 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@259 $k@206))
(pop) ; 7
; [dead else-branch 45] $t@202 == Null
(assert ($Perm.isValidVar $k@258))
(assert ($Perm.isReadVar $k@258 $Perm.Write))
(assert (< $k@258 $k@204))
(assert ($Perm.isValidVar $k@259))
(assert ($Perm.isReadVar $k@259 $Perm.Write))
(assert (< $k@259 $k@206))
(push) ; 7
(assert (not (=
  $t@249
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (=
  $t@249
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@260 $Perm)
(assert ($Perm.isValidVar $k@260))
(assert ($Perm.isReadVar $k@260 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@260 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@260 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@261 $Perm)
(assert ($Perm.isValidVar $k@261))
(assert ($Perm.isReadVar $k@261 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@261 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@261 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@250 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 46] $t@250 != Null
(declare-const $k@262 $Perm)
(assert ($Perm.isValidVar $k@262))
(assert ($Perm.isReadVar $k@262 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@262 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@262 $k@204))
(declare-const $k@263 $Perm)
(assert ($Perm.isValidVar $k@263))
(assert ($Perm.isReadVar $k@263 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@263 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@263 $k@206))
(pop) ; 7
; [dead else-branch 46] $t@250 == Null
(assert ($Perm.isValidVar $k@262))
(assert ($Perm.isReadVar $k@262 $Perm.Write))
(assert (< $k@262 $k@204))
(assert ($Perm.isValidVar $k@263))
(assert ($Perm.isReadVar $k@263 $Perm.Write))
(assert (< $k@263 $k@206))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@264 $Perm)
(assert ($Perm.isValidVar $k@264))
(assert ($Perm.isReadVar $k@264 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@264 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@264 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@265 $Perm)
(assert ($Perm.isValidVar $k@265))
(assert ($Perm.isReadVar $k@265 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@265 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@265 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 47] $t@202 != Null
(declare-const $k@266 $Perm)
(assert ($Perm.isValidVar $k@266))
(assert ($Perm.isReadVar $k@266 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@266 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@266 $k@204))
(declare-const $k@267 $Perm)
(assert ($Perm.isValidVar $k@267))
(assert ($Perm.isReadVar $k@267 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@267 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@267 $k@206))
(pop) ; 7
; [dead else-branch 47] $t@202 == Null
(assert ($Perm.isValidVar $k@266))
(assert ($Perm.isReadVar $k@266 $Perm.Write))
(assert (< $k@266 $k@204))
(assert ($Perm.isValidVar $k@267))
(assert ($Perm.isReadVar $k@267 $Perm.Write))
(assert (< $k@267 $k@206))
(push) ; 7
(assert (not ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@200))
            ($SortWrappers.IntTo$Snap $t@201))
          ($SortWrappers.$RefTo$Snap $t@250))
        $t@248)
      ($SortWrappers.$RefTo$Snap $t@205))
    ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    1))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@200))
            ($SortWrappers.IntTo$Snap $t@201))
          ($SortWrappers.$RefTo$Snap $t@250))
        $t@248)
      ($SortWrappers.$RefTo$Snap $t@205))
    ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    1)))
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 44] $t@250 == Null
(pop) ; 5
(push) ; 5
; [else-branch 43] $t@250 == Null
(assert (= $t@250 $Ref.null))
; [exec]
; __flatten_21 := diz.BlockingQueue__first
; [exec]
; value := __flatten_21.Node__val
(push) ; 6
(assert (not (not (= $k@251 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@251 $Perm.No)))
; [exec]
; __flatten_23 := diz.BlockingQueue__first
; [exec]
; __flatten_22 := __flatten_23.Node__next
; [exec]
; __flatten_55 := __flatten_22
; [exec]
; diz.BlockingQueue__first := __flatten_55
; [exec]
; __flatten_24 := value
; [exec]
; sys__result := __flatten_24
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard) && (sys__result == old(BlockingQueue__contents(diz)[0])) && (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..]))
(declare-const $k@268 $Perm)
(assert ($Perm.isValidVar $k@268))
(assert ($Perm.isReadVar $k@268 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@268 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@268 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@269 $Perm)
(assert ($Perm.isValidVar $k@269))
(assert ($Perm.isReadVar $k@269 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@269 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@269 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@250 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 48] $t@250 != Null
(push) ; 6
; [else-branch 48] $t@250 == Null
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
(assert (not (not (= $k@204 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@204 $Perm.No)))
(assert (< $k@270 $k@204))
(declare-const $k@271 $Perm)
(assert ($Perm.isValidVar $k@271))
(assert ($Perm.isReadVar $k@271 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@271 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@206 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@206 $Perm.No)))
(assert (< $k@271 $k@206))
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@272 $Perm)
(assert ($Perm.isValidVar $k@272))
(assert ($Perm.isReadVar $k@272 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@272 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@272 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@273 $Perm)
(assert ($Perm.isValidVar $k@273))
(assert ($Perm.isReadVar $k@273 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@273 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@273 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 49] $t@202 != Null
(declare-const $k@274 $Perm)
(assert ($Perm.isValidVar $k@274))
(assert ($Perm.isReadVar $k@274 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@274 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@274 $k@204))
(declare-const $k@275 $Perm)
(assert ($Perm.isValidVar $k@275))
(assert ($Perm.isReadVar $k@275 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@275 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@275 $k@206))
(pop) ; 7
; [dead else-branch 49] $t@202 == Null
(assert ($Perm.isValidVar $k@274))
(assert ($Perm.isReadVar $k@274 $Perm.Write))
(assert (< $k@274 $k@204))
(assert ($Perm.isValidVar $k@275))
(assert ($Perm.isReadVar $k@275 $Perm.Write))
(assert (< $k@275 $k@206))
(push) ; 7
(assert (not (=
  $t@249
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (=
  $t@249
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@276 $Perm)
(assert ($Perm.isValidVar $k@276))
(assert ($Perm.isReadVar $k@276 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@276 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@276 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@277 $Perm)
(assert ($Perm.isValidVar $k@277))
(assert ($Perm.isReadVar $k@277 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@277 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@277 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@250 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 50] $t@250 != Null
(push) ; 7
; [else-branch 50] $t@250 == Null
(declare-const $k@278 $Perm)
(assert ($Perm.isValidVar $k@278))
(assert ($Perm.isReadVar $k@278 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@278 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@278 $k@204))
(declare-const $k@279 $Perm)
(assert ($Perm.isValidVar $k@279))
(assert ($Perm.isReadVar $k@279 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@279 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@279 $k@206))
(pop) ; 7
(assert ($Perm.isValidVar $k@278))
(assert ($Perm.isReadVar $k@278 $Perm.Write))
(assert (< $k@278 $k@204))
(assert ($Perm.isValidVar $k@279))
(assert ($Perm.isReadVar $k@279 $Perm.Write))
(assert (< $k@279 $k@206))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@280 $Perm)
(assert ($Perm.isValidVar $k@280))
(assert ($Perm.isReadVar $k@280 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@280 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@280 $k@197))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@281 $Perm)
(assert ($Perm.isValidVar $k@281))
(assert ($Perm.isReadVar $k@281 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@281 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@281 $k@199))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@202 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 51] $t@202 != Null
(declare-const $k@282 $Perm)
(assert ($Perm.isValidVar $k@282))
(assert ($Perm.isReadVar $k@282 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@282 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@282 $k@204))
(declare-const $k@283 $Perm)
(assert ($Perm.isValidVar $k@283))
(assert ($Perm.isReadVar $k@283 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@283 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@283 $k@206))
(pop) ; 7
; [dead else-branch 51] $t@202 == Null
(assert ($Perm.isValidVar $k@282))
(assert ($Perm.isReadVar $k@282 $Perm.Write))
(assert (< $k@282 $k@204))
(assert ($Perm.isValidVar $k@283))
(assert ($Perm.isReadVar $k@283 $Perm.Write))
(assert (< $k@283 $k@206))
(push) ; 7
(assert (not ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@200))
            ($SortWrappers.IntTo$Snap $t@201))
          ($SortWrappers.$RefTo$Snap $t@250))
        $Snap.unit)
      ($SortWrappers.$RefTo$Snap $t@205))
    ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    1))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@200))
            ($SortWrappers.IntTo$Snap $t@201))
          ($SortWrappers.$RefTo$Snap $t@250))
        $Snap.unit)
      ($SortWrappers.$RefTo$Snap $t@205))
    ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@198))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@200))
              ($SortWrappers.IntTo$Snap $t@201))
            ($SortWrappers.$RefTo$Snap $t@202))
          $t@203)
        ($SortWrappers.$RefTo$Snap $t@205))
      ($SortWrappers.$RefTo$Snap $t@207)) diz@189)
    1)))
; [exec]
; inhale false
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 35] $t@202 == Null
(assert (= $t@202 $Ref.null))
(declare-const $k@284 $Perm)
(assert ($Perm.isValidVar $k@284))
(assert ($Perm.isReadVar $k@284 $Perm.Write))
(declare-const $t@285 $Ref)
(declare-const $k@286 $Perm)
(assert ($Perm.isValidVar $k@286))
(assert ($Perm.isReadVar $k@286 $Perm.Write))
(declare-const $t@287 $Ref)
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@202 $Ref.null)))
(push) ; 4
(declare-const $k@288 $Perm)
(assert ($Perm.isValidVar $k@288))
(assert ($Perm.isReadVar $k@288 $Perm.Write))
(declare-const $t@289 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@288 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@288 $Perm.No)))
(assert (> $t@289 0))
(declare-const $k@290 $Perm)
(assert ($Perm.isValidVar $k@290))
(assert ($Perm.isReadVar $k@290 $Perm.Write))
(declare-const $t@291 $Ref)
(push) ; 5
(assert (not (not (= $k@290 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@290 $Perm.No)))
(assert (not (= $t@291 $Ref.null)))
(declare-const $t@292 Int)
(declare-const $t@293 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@293 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@293 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
; [dead then-branch 52] $t@293 != Null
; [dead else-branch 52] $t@293 == Null
(pop) ; 4
(push) ; 4
; [exec]
; unfold acc(Node__state(diz.BlockingQueue__first), write)
(check-sat)
; unsat
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__take ----------
(declare-const diz@294 $Ref)
(declare-const sys__result@295 Int)
(declare-const c@296 Int)
(declare-const currentCount@297 Int)
(declare-const __flatten_25@298 Int)
(declare-const __flatten_26@299 Int)
(declare-const x@300 Int)
(declare-const __flatten_27@301 Int)
(declare-const __flatten_28@302 Int)
(declare-const __flatten_29@303 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@294 $Ref.null)))
(declare-const $k@304 $Perm)
(assert ($Perm.isValidVar $k@304))
(assert ($Perm.isReadVar $k@304 $Perm.Write))
(declare-const $t@305 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@304 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@304 $Perm.No)))
(assert (> $t@305 0))
(declare-const $k@306 $Perm)
(assert ($Perm.isValidVar $k@306))
(assert ($Perm.isReadVar $k@306 $Perm.Write))
(declare-const $t@307 $Ref)
(push) ; 3
(assert (not (not (= $k@306 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@306 $Perm.No)))
(assert (not (= $t@307 $Ref.null)))
(declare-const $t@308 Int)
(declare-const $t@309 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@309 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@309 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 53] $t@309 != Null
(assert (not (= $t@309 $Ref.null)))
(declare-const $t@310 $Snap)
(declare-const $k@311 $Perm)
(assert ($Perm.isValidVar $k@311))
(assert ($Perm.isReadVar $k@311 $Perm.Write))
(declare-const $t@312 $Ref)
(declare-const $k@313 $Perm)
(assert ($Perm.isValidVar $k@313))
(assert ($Perm.isReadVar $k@313 $Perm.Write))
(declare-const $t@314 $Ref)
(push) ; 4
(declare-const $k@315 $Perm)
(assert ($Perm.isValidVar $k@315))
(assert ($Perm.isReadVar $k@315 $Perm.Write))
(declare-const $t@316 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@315 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@315 $Perm.No)))
(assert (> $t@316 0))
(declare-const $k@317 $Perm)
(assert ($Perm.isValidVar $k@317))
(assert ($Perm.isReadVar $k@317 $Perm.Write))
(declare-const $t@318 $Ref)
(push) ; 5
(assert (not (not (= $k@317 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@317 $Perm.No)))
(assert (not (= $t@318 $Ref.null)))
(declare-const $t@319 Int)
(declare-const $t@320 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@320 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@320 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 54] $t@320 != Null
(assert (not (= $t@320 $Ref.null)))
(declare-const $t@321 $Snap)
(declare-const $k@322 $Perm)
(assert ($Perm.isValidVar $k@322))
(assert ($Perm.isReadVar $k@322 $Perm.Write))
(declare-const $t@323 $Ref)
(declare-const $k@324 $Perm)
(assert ($Perm.isValidVar $k@324))
(assert ($Perm.isReadVar $k@324 $Perm.Write))
(declare-const $t@325 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 54] $t@320 == Null
(assert (= $t@320 $Ref.null))
(declare-const $k@326 $Perm)
(assert ($Perm.isValidVar $k@326))
(assert ($Perm.isReadVar $k@326 $Perm.Write))
(declare-const $t@327 $Ref)
(declare-const $k@328 $Perm)
(assert ($Perm.isValidVar $k@328))
(assert ($Perm.isReadVar $k@328 $Perm.Write))
(declare-const $t@329 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 5
(assert (not (not (= $k@313 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@313 $Perm.No)))
(declare-const $t@330 $Snap)
; [exec]
; __flatten_25 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@331 Int)
(declare-const $t@332 $Snap)
(declare-const $t@333 Int)
(assert (= $t@332 ($Snap.combine ($SortWrappers.IntTo$Snap $t@333) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@331 $t@333))
; [exec]
; currentCount := __flatten_25
; loop at <no position>
(declare-const currentCount@334 Int)
(declare-const __flatten_26@335 Int)
(push) ; 5
; Verify loop body
(declare-const $t@336 $Snap)
(declare-const $t@337 $Snap)
(assert (= $t@336 ($Snap.combine $t@337 $Snap.unit)))
(declare-const $t@338 $Snap)
(declare-const $t@339 Int)
(assert (= $t@337 ($Snap.combine $t@338 ($SortWrappers.IntTo$Snap $t@339))))
(declare-const $t@340 $Snap)
(assert (= $t@338 ($Snap.combine $t@340 $Snap.unit)))
(declare-const $t@341 $Snap)
(declare-const $t@342 $Ref)
(assert (= $t@340 ($Snap.combine $t@341 ($SortWrappers.$RefTo$Snap $t@342))))
(declare-const $t@343 $Snap)
(declare-const $t@344 Int)
(assert (= $t@341 ($Snap.combine $t@343 ($SortWrappers.IntTo$Snap $t@344))))
(declare-const $t@345 $Ref)
(declare-const $t@346 $Snap)
(assert (= $t@343 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@345) $t@346)))
(declare-const $k@347 $Perm)
(assert ($Perm.isValidVar $k@347))
(assert ($Perm.isReadVar $k@347 $Perm.Write))
(push) ; 6
(assert (not (not (= $k@347 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@347 $Perm.No)))
(declare-const $k@348 $Perm)
(assert ($Perm.isValidVar $k@348))
(assert ($Perm.isReadVar $k@348 $Perm.Write))
(declare-const $k@349 $Perm)
(assert ($Perm.isValidVar $k@349))
(assert ($Perm.isReadVar $k@349 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= $k@349 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@349 $Perm.No)))
(assert (not (= $t@342 $Ref.null)))
; [eval] currentCount == 0
(assert (= currentCount@334 0))
(check-sat)
; unknown
; [exec]
; exhale true
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; inhale true
; [exec]
; __flatten_26 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@350 Int)
(declare-const $t@351 $Snap)
(declare-const $t@352 Int)
(assert (= $t@351 ($Snap.combine ($SortWrappers.IntTo$Snap $t@352) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@350 $t@352))
; [exec]
; currentCount := __flatten_26
(declare-const $k@353 $Perm)
(assert ($Perm.isValidVar $k@353))
(assert ($Perm.isReadVar $k@353 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@353 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@353 $k@347))
(declare-const $k@354 $Perm)
(assert ($Perm.isValidVar $k@354))
(assert ($Perm.isReadVar $k@354 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@354 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@348 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@348 $Perm.No)))
(assert (< $k@354 $k@348))
(declare-const $k@355 $Perm)
(assert ($Perm.isValidVar $k@355))
(assert ($Perm.isReadVar $k@355 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@355 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@355 $k@349))
; [eval] diz.BlockingQueue__count != null
(pop) ; 5
(push) ; 5
; Establish loop invariant
(declare-const $k@356 $Perm)
(assert ($Perm.isValidVar $k@356))
(assert ($Perm.isReadVar $k@356 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@356 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@356 $k@313))
(declare-const $k@357 $Perm)
(assert ($Perm.isValidVar $k@357))
(assert ($Perm.isReadVar $k@357 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@357 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@357 $k@304))
(declare-const $k@358 $Perm)
(assert ($Perm.isValidVar $k@358))
(assert ($Perm.isReadVar $k@358 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@358 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@358 $k@306))
; [eval] diz.BlockingQueue__count != null
; Continue after loop
(declare-const $t@359 $Snap)
(declare-const $t@360 $Snap)
(assert (= $t@359 ($Snap.combine $t@360 $Snap.unit)))
(declare-const $t@361 $Snap)
(declare-const $t@362 Int)
(assert (= $t@360 ($Snap.combine $t@361 ($SortWrappers.IntTo$Snap $t@362))))
(declare-const $t@363 $Snap)
(assert (= $t@361 ($Snap.combine $t@363 $Snap.unit)))
(declare-const $t@364 $Snap)
(declare-const $t@365 $Ref)
(assert (= $t@363 ($Snap.combine $t@364 ($SortWrappers.$RefTo$Snap $t@365))))
(declare-const $t@366 $Snap)
(declare-const $t@367 Int)
(assert (= $t@364 ($Snap.combine $t@366 ($SortWrappers.IntTo$Snap $t@367))))
(declare-const $t@368 $Ref)
(declare-const $t@369 $Snap)
(assert (= $t@366 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@368) $t@369)))
(declare-const $k@370 $Perm)
(assert ($Perm.isValidVar $k@370))
(assert ($Perm.isReadVar $k@370 $Perm.Write))
(assert (implies (< $Perm.No (- $k@313 $k@356)) (= $t@368 $t@314)))
(push) ; 6
(assert (not (not (= (+ (- $k@313 $k@356) $k@370) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@313 $k@356) $k@370) $Perm.No)))
(declare-const $k@371 $Perm)
(assert ($Perm.isValidVar $k@371))
(assert ($Perm.isReadVar $k@371 $Perm.Write))
(assert (implies (< $Perm.No (- $k@304 $k@357)) (= $t@367 $t@305)))
(declare-const $k@372 $Perm)
(assert ($Perm.isValidVar $k@372))
(assert ($Perm.isReadVar $k@372 $Perm.Write))
(assert (implies (< $Perm.No (- $k@306 $k@358)) (= $t@365 $t@307)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@306 $k@358) $k@372) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@306 $k@358) $k@372) $Perm.No)))
(assert (not (= $t@365 $Ref.null)))
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(assert (not (= currentCount@334 0)))
(check-sat)
; unknown
; [exec]
; inhale diz.BlockingQueue__first != null
; [eval] diz.BlockingQueue__first != null
; [exec]
; __flatten_27 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@373 $Perm)
(assert ($Perm.isValidVar $k@373))
(assert ($Perm.isReadVar $k@373 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@373 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- $k@304 $k@357) $k@371) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@304 $k@357) $k@371) $Perm.No)))
(assert (< $k@373 (+ (- $k@304 $k@357) $k@371)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (> $t@367 0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (> $t@367 0))
(declare-const $k@374 $Perm)
(assert ($Perm.isValidVar $k@374))
(assert ($Perm.isReadVar $k@374 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@374 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@374 (+ (- $k@306 $k@358) $k@372)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@309 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 55] $t@309 != Null
(declare-const $k@375 $Perm)
(assert ($Perm.isValidVar $k@375))
(assert ($Perm.isReadVar $k@375 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@375 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@311 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@311 $Perm.No)))
(assert (< $k@375 $k@311))
(declare-const $k@376 $Perm)
(assert ($Perm.isValidVar $k@376))
(assert ($Perm.isReadVar $k@376 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@376 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@376 (+ (- $k@313 $k@356) $k@370)))
; [eval] diz.BlockingQueue__first != null
(declare-const sys__result@377 Int)
(declare-const $t@378 $Snap)
(declare-const $t@379 $Snap)
(assert (= $t@378 ($Snap.combine $t@379 $Snap.unit)))
(declare-const $t@380 $Snap)
(assert (= $t@379 ($Snap.combine $t@380 $Snap.unit)))
(declare-const $t@381 $Snap)
(declare-const $t@382 $Ref)
(assert (= $t@380 ($Snap.combine $t@381 ($SortWrappers.$RefTo$Snap $t@382))))
(declare-const $t@383 $Snap)
(declare-const $t@384 $Ref)
(assert (= $t@381 ($Snap.combine $t@383 ($SortWrappers.$RefTo$Snap $t@384))))
(declare-const $t@385 $Snap)
(declare-const $t@386 $Snap)
(assert (= $t@383 ($Snap.combine $t@385 $t@386)))
(declare-const $t@387 $Snap)
(declare-const $t@388 $Ref)
(assert (= $t@385 ($Snap.combine $t@387 ($SortWrappers.$RefTo$Snap $t@388))))
(declare-const $t@389 $Snap)
(declare-const $t@390 Int)
(assert (= $t@387 ($Snap.combine $t@389 ($SortWrappers.IntTo$Snap $t@390))))
(declare-const $t@391 Int)
(declare-const $t@392 $Ref)
(assert (=
  $t@389
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@391)
    ($SortWrappers.$RefTo$Snap $t@392))))
(declare-const $t@393 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@391)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@393) $Snap.unit)))
(declare-const $k@394 $Perm)
(assert ($Perm.isValidVar $k@394))
(assert ($Perm.isReadVar $k@394 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@304 $k@357) $k@371) $k@373)) (= $t@393 $t@367)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 7
(assert (not (not (= (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394) $Perm.No)))
(assert (> $t@393 0))
(declare-const $k@395 $Perm)
(assert ($Perm.isValidVar $k@395))
(assert ($Perm.isReadVar $k@395 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@306 $k@358) $k@372) $k@374)) (= $t@392 $t@365)))
(push) ; 7
(assert (not (not (= (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395) $Perm.No)))
(assert (not (= $t@392 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@388 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@388 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 56] $t@388 != Null
(assert (not (= $t@388 $Ref.null)))
(declare-const $k@396 $Perm)
(assert ($Perm.isValidVar $k@396))
(assert ($Perm.isReadVar $k@396 $Perm.Write))
(assert (implies (< $Perm.No (- $k@311 $k@375)) (= $t@384 $t@312)))
(declare-const $k@397 $Perm)
(assert ($Perm.isValidVar $k@397))
(assert ($Perm.isReadVar $k@397 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@313 $k@356) $k@370) $k@376)) (= $t@382 $t@368)))
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@398 $Perm)
(assert ($Perm.isValidVar $k@398))
(assert ($Perm.isReadVar $k@398 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@398 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@398 (+ (- $k@304 $k@357) $k@371)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@399 $Perm)
(assert ($Perm.isValidVar $k@399))
(assert ($Perm.isReadVar $k@399 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@399 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@399 (+ (- $k@306 $k@358) $k@372)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@309 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 57] $t@309 != Null
(declare-const $k@400 $Perm)
(assert ($Perm.isValidVar $k@400))
(assert ($Perm.isReadVar $k@400 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@400 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@400 $k@311))
(declare-const $k@401 $Perm)
(assert ($Perm.isValidVar $k@401))
(assert ($Perm.isReadVar $k@401 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@401 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@401 (+ (- $k@313 $k@356) $k@370)))
(pop) ; 8
; [dead else-branch 57] $t@309 == Null
(assert ($Perm.isValidVar $k@400))
(assert ($Perm.isReadVar $k@400 $Perm.Write))
(assert (< $k@400 $k@311))
(assert ($Perm.isValidVar $k@401))
(assert ($Perm.isReadVar $k@401 $Perm.Write))
(assert (< $k@401 (+ (- $k@313 $k@356) $k@370)))
(assert (=
  sys__result@377
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@367))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@365))
              ($SortWrappers.IntTo$Snap $t@362))
            ($SortWrappers.$RefTo$Snap $t@309))
          $t@310)
        ($SortWrappers.$RefTo$Snap $t@312))
      ($SortWrappers.$RefTo$Snap $t@368)) diz@294)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@402 $Perm)
(assert ($Perm.isValidVar $k@402))
(assert ($Perm.isReadVar $k@402 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@402 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@402 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@403 $Perm)
(assert ($Perm.isValidVar $k@403))
(assert ($Perm.isReadVar $k@403 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@403 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@403 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@388 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 58] $t@388 != Null
(declare-const $k@404 $Perm)
(assert ($Perm.isValidVar $k@404))
(assert ($Perm.isReadVar $k@404 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@404 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= (+ (- $k@311 $k@375) $k@396) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= (+ (- $k@311 $k@375) $k@396) $Perm.No)))
(assert (< $k@404 (+ (- $k@311 $k@375) $k@396)))
(declare-const $k@405 $Perm)
(assert ($Perm.isValidVar $k@405))
(assert ($Perm.isReadVar $k@405 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@405 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397) $Perm.No)))
(assert (< $k@405 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397)))
(pop) ; 8
; [dead else-branch 58] $t@388 == Null
(assert ($Perm.isValidVar $k@404))
(assert ($Perm.isReadVar $k@404 $Perm.Write))
(assert (not (= (+ (- $k@311 $k@375) $k@396) $Perm.No)))
(assert (< $k@404 (+ (- $k@311 $k@375) $k@396)))
(assert ($Perm.isValidVar $k@405))
(assert ($Perm.isReadVar $k@405 $Perm.Write))
(assert (not (= (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397) $Perm.No)))
(assert (< $k@405 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397)))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@406 $Perm)
(assert ($Perm.isValidVar $k@406))
(assert ($Perm.isReadVar $k@406 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@406 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@406 (+ (- $k@304 $k@357) $k@371)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@407 $Perm)
(assert ($Perm.isValidVar $k@407))
(assert ($Perm.isReadVar $k@407 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@407 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@407 (+ (- $k@306 $k@358) $k@372)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@309 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 59] $t@309 != Null
(declare-const $k@408 $Perm)
(assert ($Perm.isValidVar $k@408))
(assert ($Perm.isReadVar $k@408 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@408 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@408 $k@311))
(declare-const $k@409 $Perm)
(assert ($Perm.isValidVar $k@409))
(assert ($Perm.isReadVar $k@409 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@409 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@409 (+ (- $k@313 $k@356) $k@370)))
(pop) ; 8
; [dead else-branch 59] $t@309 == Null
(assert ($Perm.isValidVar $k@408))
(assert ($Perm.isReadVar $k@408 $Perm.Write))
(assert (< $k@408 $k@311))
(assert ($Perm.isValidVar $k@409))
(assert ($Perm.isReadVar $k@409 $Perm.Write))
(assert (< $k@409 (+ (- $k@313 $k@356) $k@370)))
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@393))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@392))
            ($SortWrappers.IntTo$Snap $t@390))
          ($SortWrappers.$RefTo$Snap $t@388))
        $t@386)
      ($SortWrappers.$RefTo$Snap $t@384))
    ($SortWrappers.$RefTo$Snap $t@382)) diz@294)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@367))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@365))
              ($SortWrappers.IntTo$Snap $t@362))
            ($SortWrappers.$RefTo$Snap $t@309))
          $t@310)
        ($SortWrappers.$RefTo$Snap $t@312))
      ($SortWrappers.$RefTo$Snap $t@368)) diz@294)
    1)))
; [exec]
; x := __flatten_27
; [exec]
; __flatten_28 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@410 Int)
(declare-const $t@411 $Snap)
(declare-const $t@412 Int)
(assert (= $t@411 ($Snap.combine ($SortWrappers.IntTo$Snap $t@412) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal + 1
; [eval] diz.AtomicInteger__ghostVal + 1
(assert (= sys__result@410 (+ $t@412 1)))
; [exec]
; c := __flatten_28
; [eval] c > 1
(push) ; 8
(assert (not (not (> sys__result@410 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (> sys__result@410 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 60] sys__result@410 > 1
(assert (> sys__result@410 1))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 9
(assert (not (= $t@368 $t@382)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 9
(assert (not (= $t@368 $t@382)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (not (= sys__result@410 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@410 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 61] sys__result@410 == $t@393
(assert (= sys__result@410 $t@393))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@413 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@414 $Perm)
(assert ($Perm.isValidVar $k@414))
(assert ($Perm.isReadVar $k@414 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@414 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@414 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@415 $Perm)
(assert ($Perm.isValidVar $k@415))
(assert ($Perm.isReadVar $k@415 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@415 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@415 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@388 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 62] $t@388 != Null
(declare-const $k@416 $Perm)
(assert ($Perm.isValidVar $k@416))
(assert ($Perm.isReadVar $k@416 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@416 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@416 (+ (- $k@311 $k@375) $k@396)))
(declare-const $k@417 $Perm)
(assert ($Perm.isValidVar $k@417))
(assert ($Perm.isReadVar $k@417 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@417 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@417 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397)))
; [exec]
; inhale false
(pop) ; 10
; [dead else-branch 62] $t@388 == Null
(pop) ; 9
(push) ; 9
; [else-branch 61] sys__result@410 != $t@393
(assert (not (= sys__result@410 $t@393)))
(pop) ; 9
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (= sys__result@410 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@410 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 63] sys__result@410 != $t@393
(assert (not (= sys__result@410 $t@393)))
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@418 $Perm)
(assert ($Perm.isValidVar $k@418))
(assert ($Perm.isReadVar $k@418 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@418 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@418 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@419 $Perm)
(assert ($Perm.isValidVar $k@419))
(assert ($Perm.isReadVar $k@419 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@419 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@419 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@388 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 64] $t@388 != Null
(declare-const $k@420 $Perm)
(assert ($Perm.isValidVar $k@420))
(assert ($Perm.isReadVar $k@420 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@420 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@420 (+ (- $k@311 $k@375) $k@396)))
(declare-const $k@421 $Perm)
(assert ($Perm.isValidVar $k@421))
(assert ($Perm.isReadVar $k@421 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@421 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@421 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397)))
; [exec]
; inhale false
(pop) ; 10
; [dead else-branch 64] $t@388 == Null
(pop) ; 9
(push) ; 9
; [else-branch 63] sys__result@410 == $t@393
(assert (= sys__result@410 $t@393))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 60] !sys__result@410 > 1
(assert (not (> sys__result@410 1)))
(pop) ; 8
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 8
(assert (not (> sys__result@410 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (> sys__result@410 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 65] !sys__result@410 > 1
(assert (not (> sys__result@410 1)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 9
(assert (not (= $t@368 $t@382)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (not (= sys__result@410 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@410 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 66] sys__result@410 == $t@393
(assert (= sys__result@410 $t@393))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@422 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@423 $Perm)
(assert ($Perm.isValidVar $k@423))
(assert ($Perm.isReadVar $k@423 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@423 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@423 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@424 $Perm)
(assert ($Perm.isValidVar $k@424))
(assert ($Perm.isReadVar $k@424 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@424 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@424 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@388 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 67] $t@388 != Null
(declare-const $k@425 $Perm)
(assert ($Perm.isValidVar $k@425))
(assert ($Perm.isReadVar $k@425 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@425 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@425 (+ (- $k@311 $k@375) $k@396)))
(declare-const $k@426 $Perm)
(assert ($Perm.isValidVar $k@426))
(assert ($Perm.isReadVar $k@426 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@426 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@426 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397)))
; [exec]
; inhale false
(pop) ; 10
; [dead else-branch 67] $t@388 == Null
(pop) ; 9
(push) ; 9
; [else-branch 66] sys__result@410 != $t@393
(assert (not (= sys__result@410 $t@393)))
(pop) ; 9
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (= sys__result@410 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@410 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 68] sys__result@410 != $t@393
(assert (not (= sys__result@410 $t@393)))
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@427 $Perm)
(assert ($Perm.isValidVar $k@427))
(assert ($Perm.isReadVar $k@427 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@427 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@427 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@428 $Perm)
(assert ($Perm.isValidVar $k@428))
(assert ($Perm.isReadVar $k@428 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@428 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@428 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@388 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 69] $t@388 != Null
(declare-const $k@429 $Perm)
(assert ($Perm.isValidVar $k@429))
(assert ($Perm.isReadVar $k@429 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@429 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@429 (+ (- $k@311 $k@375) $k@396)))
(declare-const $k@430 $Perm)
(assert ($Perm.isValidVar $k@430))
(assert ($Perm.isReadVar $k@430 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@430 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@430 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@397)))
; [exec]
; inhale false
(pop) ; 10
; [dead else-branch 69] $t@388 == Null
(pop) ; 9
(push) ; 9
; [else-branch 68] sys__result@410 == $t@393
(assert (= sys__result@410 $t@393))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 65] sys__result@410 > 1
(assert (> sys__result@410 1))
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 56] $t@388 == Null
(assert (= $t@388 $Ref.null))
(declare-const $k@431 $Perm)
(assert ($Perm.isValidVar $k@431))
(assert ($Perm.isReadVar $k@431 $Perm.Write))
(assert (implies (< $Perm.No (- $k@311 $k@375)) (= $t@384 $t@312)))
(declare-const $k@432 $Perm)
(assert ($Perm.isValidVar $k@432))
(assert ($Perm.isReadVar $k@432 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@313 $k@356) $k@370) $k@376)) (= $t@382 $t@368)))
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@433 $Perm)
(assert ($Perm.isValidVar $k@433))
(assert ($Perm.isReadVar $k@433 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@433 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@433 (+ (- $k@304 $k@357) $k@371)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@434 $Perm)
(assert ($Perm.isValidVar $k@434))
(assert ($Perm.isReadVar $k@434 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@434 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@434 (+ (- $k@306 $k@358) $k@372)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@309 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 70] $t@309 != Null
(declare-const $k@435 $Perm)
(assert ($Perm.isValidVar $k@435))
(assert ($Perm.isReadVar $k@435 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@435 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@435 $k@311))
(declare-const $k@436 $Perm)
(assert ($Perm.isValidVar $k@436))
(assert ($Perm.isReadVar $k@436 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@436 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@436 (+ (- $k@313 $k@356) $k@370)))
(pop) ; 8
; [dead else-branch 70] $t@309 == Null
(assert ($Perm.isValidVar $k@435))
(assert ($Perm.isReadVar $k@435 $Perm.Write))
(assert (< $k@435 $k@311))
(assert ($Perm.isValidVar $k@436))
(assert ($Perm.isReadVar $k@436 $Perm.Write))
(assert (< $k@436 (+ (- $k@313 $k@356) $k@370)))
(assert (=
  sys__result@377
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@367))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@365))
              ($SortWrappers.IntTo$Snap $t@362))
            ($SortWrappers.$RefTo$Snap $t@309))
          $t@310)
        ($SortWrappers.$RefTo$Snap $t@312))
      ($SortWrappers.$RefTo$Snap $t@368)) diz@294)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@437 $Perm)
(assert ($Perm.isValidVar $k@437))
(assert ($Perm.isReadVar $k@437 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@437 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@437 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@438 $Perm)
(assert ($Perm.isValidVar $k@438))
(assert ($Perm.isReadVar $k@438 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@438 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@438 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@388 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 71] $t@388 != Null
(push) ; 8
; [else-branch 71] $t@388 == Null
(declare-const $k@439 $Perm)
(assert ($Perm.isValidVar $k@439))
(assert ($Perm.isReadVar $k@439 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@439 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= (+ (- $k@311 $k@375) $k@431) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= (+ (- $k@311 $k@375) $k@431) $Perm.No)))
(assert (< $k@439 (+ (- $k@311 $k@375) $k@431)))
(declare-const $k@440 $Perm)
(assert ($Perm.isValidVar $k@440))
(assert ($Perm.isReadVar $k@440 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@440 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432) $Perm.No)))
(assert (< $k@440 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432)))
(pop) ; 8
(assert ($Perm.isValidVar $k@439))
(assert ($Perm.isReadVar $k@439 $Perm.Write))
(assert (not (= (+ (- $k@311 $k@375) $k@431) $Perm.No)))
(assert (< $k@439 (+ (- $k@311 $k@375) $k@431)))
(assert ($Perm.isValidVar $k@440))
(assert ($Perm.isReadVar $k@440 $Perm.Write))
(assert (not (= (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432) $Perm.No)))
(assert (< $k@440 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432)))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@441 $Perm)
(assert ($Perm.isValidVar $k@441))
(assert ($Perm.isReadVar $k@441 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@441 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@441 (+ (- $k@304 $k@357) $k@371)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@442 $Perm)
(assert ($Perm.isValidVar $k@442))
(assert ($Perm.isReadVar $k@442 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@442 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@442 (+ (- $k@306 $k@358) $k@372)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@309 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 72] $t@309 != Null
(declare-const $k@443 $Perm)
(assert ($Perm.isValidVar $k@443))
(assert ($Perm.isReadVar $k@443 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@443 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@443 $k@311))
(declare-const $k@444 $Perm)
(assert ($Perm.isValidVar $k@444))
(assert ($Perm.isReadVar $k@444 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@444 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@444 (+ (- $k@313 $k@356) $k@370)))
(pop) ; 8
; [dead else-branch 72] $t@309 == Null
(assert ($Perm.isValidVar $k@443))
(assert ($Perm.isReadVar $k@443 $Perm.Write))
(assert (< $k@443 $k@311))
(assert ($Perm.isValidVar $k@444))
(assert ($Perm.isReadVar $k@444 $Perm.Write))
(assert (< $k@444 (+ (- $k@313 $k@356) $k@370)))
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@393))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@392))
            ($SortWrappers.IntTo$Snap $t@390))
          ($SortWrappers.$RefTo$Snap $t@388))
        $Snap.unit)
      ($SortWrappers.$RefTo$Snap $t@384))
    ($SortWrappers.$RefTo$Snap $t@382)) diz@294)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@367))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@365))
              ($SortWrappers.IntTo$Snap $t@362))
            ($SortWrappers.$RefTo$Snap $t@309))
          $t@310)
        ($SortWrappers.$RefTo$Snap $t@312))
      ($SortWrappers.$RefTo$Snap $t@368)) diz@294)
    1)))
; [exec]
; x := __flatten_27
; [exec]
; __flatten_28 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@445 Int)
(declare-const $t@446 $Snap)
(declare-const $t@447 Int)
(assert (= $t@446 ($Snap.combine ($SortWrappers.IntTo$Snap $t@447) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal + 1
; [eval] diz.AtomicInteger__ghostVal + 1
(assert (= sys__result@445 (+ $t@447 1)))
; [exec]
; c := __flatten_28
; [eval] c > 1
(push) ; 8
(assert (not (not (> sys__result@445 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (> sys__result@445 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 73] sys__result@445 > 1
(assert (> sys__result@445 1))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 9
(assert (not (= $t@368 $t@382)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 9
(assert (not (= $t@368 $t@382)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (not (= sys__result@445 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@445 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 74] sys__result@445 == $t@393
(assert (= sys__result@445 $t@393))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@448 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@449 $Perm)
(assert ($Perm.isValidVar $k@449))
(assert ($Perm.isReadVar $k@449 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@449 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@449 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@450 $Perm)
(assert ($Perm.isValidVar $k@450))
(assert ($Perm.isReadVar $k@450 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@450 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@450 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (not (= $t@388 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
; [dead then-branch 75] $t@388 != Null
(push) ; 10
; [else-branch 75] $t@388 == Null
(declare-const $k@451 $Perm)
(assert ($Perm.isValidVar $k@451))
(assert ($Perm.isReadVar $k@451 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@451 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@451 (+ (- $k@311 $k@375) $k@431)))
(declare-const $k@452 $Perm)
(assert ($Perm.isValidVar $k@452))
(assert ($Perm.isReadVar $k@452 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@452 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@452 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432)))
; [exec]
; inhale false
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 74] sys__result@445 != $t@393
(assert (not (= sys__result@445 $t@393)))
(pop) ; 9
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (= sys__result@445 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@445 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 76] sys__result@445 != $t@393
(assert (not (= sys__result@445 $t@393)))
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@453 $Perm)
(assert ($Perm.isValidVar $k@453))
(assert ($Perm.isReadVar $k@453 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@453 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@453 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@454 $Perm)
(assert ($Perm.isValidVar $k@454))
(assert ($Perm.isReadVar $k@454 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@454 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@454 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (not (= $t@388 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
; [dead then-branch 77] $t@388 != Null
(push) ; 10
; [else-branch 77] $t@388 == Null
(declare-const $k@455 $Perm)
(assert ($Perm.isValidVar $k@455))
(assert ($Perm.isReadVar $k@455 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@455 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@455 (+ (- $k@311 $k@375) $k@431)))
(declare-const $k@456 $Perm)
(assert ($Perm.isValidVar $k@456))
(assert ($Perm.isReadVar $k@456 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@456 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@456 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432)))
; [exec]
; inhale false
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 76] sys__result@445 == $t@393
(assert (= sys__result@445 $t@393))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 73] !sys__result@445 > 1
(assert (not (> sys__result@445 1)))
(pop) ; 8
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 8
(assert (not (> sys__result@445 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (> sys__result@445 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 78] !sys__result@445 > 1
(assert (not (> sys__result@445 1)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 9
(assert (not (= $t@368 $t@382)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (not (= sys__result@445 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@445 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 79] sys__result@445 == $t@393
(assert (= sys__result@445 $t@393))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@457 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@458 $Perm)
(assert ($Perm.isValidVar $k@458))
(assert ($Perm.isReadVar $k@458 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@458 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@458 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@459 $Perm)
(assert ($Perm.isValidVar $k@459))
(assert ($Perm.isReadVar $k@459 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@459 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@459 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (not (= $t@388 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
; [dead then-branch 80] $t@388 != Null
(push) ; 10
; [else-branch 80] $t@388 == Null
(declare-const $k@460 $Perm)
(assert ($Perm.isValidVar $k@460))
(assert ($Perm.isReadVar $k@460 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@460 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@460 (+ (- $k@311 $k@375) $k@431)))
(declare-const $k@461 $Perm)
(assert ($Perm.isValidVar $k@461))
(assert ($Perm.isReadVar $k@461 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@461 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@461 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432)))
; [exec]
; inhale false
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 79] sys__result@445 != $t@393
(assert (not (= sys__result@445 $t@393)))
(pop) ; 9
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 9
(assert (not (= sys__result@445 $t@393)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@445 $t@393))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 81] sys__result@445 != $t@393
(assert (not (= sys__result@445 $t@393)))
; [exec]
; __flatten_29 := x
; [exec]
; sys__result := __flatten_29
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@462 $Perm)
(assert ($Perm.isValidVar $k@462))
(assert ($Perm.isReadVar $k@462 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@462 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@462 (+ (- (+ (- $k@304 $k@357) $k@371) $k@373) $k@394)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@463 $Perm)
(assert ($Perm.isValidVar $k@463))
(assert ($Perm.isReadVar $k@463 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@463 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@463 (+ (- (+ (- $k@306 $k@358) $k@372) $k@374) $k@395)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (not (= $t@388 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
; [dead then-branch 82] $t@388 != Null
(push) ; 10
; [else-branch 82] $t@388 == Null
(declare-const $k@464 $Perm)
(assert ($Perm.isValidVar $k@464))
(assert ($Perm.isReadVar $k@464 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@464 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@464 (+ (- $k@311 $k@375) $k@431)))
(declare-const $k@465 $Perm)
(assert ($Perm.isValidVar $k@465))
(assert ($Perm.isReadVar $k@465 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@465 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@465 (+ (- (+ (- $k@313 $k@356) $k@370) $k@376) $k@432)))
; [exec]
; inhale false
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 81] sys__result@445 == $t@393
(assert (= sys__result@445 $t@393))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 78] sys__result@445 > 1
(assert (> sys__result@445 1))
(pop) ; 8
(pop) ; 7
(pop) ; 6
; [dead else-branch 55] $t@309 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 53] $t@309 == Null
(assert (= $t@309 $Ref.null))
(declare-const $k@466 $Perm)
(assert ($Perm.isValidVar $k@466))
(assert ($Perm.isReadVar $k@466 $Perm.Write))
(declare-const $t@467 $Ref)
(declare-const $k@468 $Perm)
(assert ($Perm.isValidVar $k@468))
(assert ($Perm.isReadVar $k@468 $Perm.Write))
(declare-const $t@469 $Ref)
(push) ; 4
(declare-const $k@470 $Perm)
(assert ($Perm.isValidVar $k@470))
(assert ($Perm.isReadVar $k@470 $Perm.Write))
(declare-const $t@471 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@470 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@470 $Perm.No)))
(assert (> $t@471 0))
(declare-const $k@472 $Perm)
(assert ($Perm.isValidVar $k@472))
(assert ($Perm.isReadVar $k@472 $Perm.Write))
(declare-const $t@473 $Ref)
(push) ; 5
(assert (not (not (= $k@472 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@472 $Perm.No)))
(assert (not (= $t@473 $Ref.null)))
(declare-const $t@474 Int)
(declare-const $t@475 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@475 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@475 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 83] $t@475 != Null
(assert (not (= $t@475 $Ref.null)))
(declare-const $t@476 $Snap)
(declare-const $k@477 $Perm)
(assert ($Perm.isValidVar $k@477))
(assert ($Perm.isReadVar $k@477 $Perm.Write))
(declare-const $t@478 $Ref)
(declare-const $k@479 $Perm)
(assert ($Perm.isValidVar $k@479))
(assert ($Perm.isReadVar $k@479 $Perm.Write))
(declare-const $t@480 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 83] $t@475 == Null
(assert (= $t@475 $Ref.null))
(declare-const $k@481 $Perm)
(assert ($Perm.isValidVar $k@481))
(assert ($Perm.isReadVar $k@481 $Perm.Write))
(declare-const $t@482 $Ref)
(declare-const $k@483 $Perm)
(assert ($Perm.isValidVar $k@483))
(assert ($Perm.isReadVar $k@483 $Perm.Write))
(declare-const $t@484 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 5
(assert (not (not (= $k@468 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@468 $Perm.No)))
(declare-const $t@485 $Snap)
; [exec]
; __flatten_25 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@486 Int)
(declare-const $t@487 $Snap)
(declare-const $t@488 Int)
(assert (= $t@487 ($Snap.combine ($SortWrappers.IntTo$Snap $t@488) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@486 $t@488))
; [exec]
; currentCount := __flatten_25
; loop at <no position>
(declare-const currentCount@489 Int)
(declare-const __flatten_26@490 Int)
(push) ; 5
; Verify loop body
(declare-const $t@491 $Snap)
(declare-const $t@492 $Snap)
(assert (= $t@491 ($Snap.combine $t@492 $Snap.unit)))
(declare-const $t@493 $Snap)
(declare-const $t@494 Int)
(assert (= $t@492 ($Snap.combine $t@493 ($SortWrappers.IntTo$Snap $t@494))))
(declare-const $t@495 $Snap)
(assert (= $t@493 ($Snap.combine $t@495 $Snap.unit)))
(declare-const $t@496 $Snap)
(declare-const $t@497 $Ref)
(assert (= $t@495 ($Snap.combine $t@496 ($SortWrappers.$RefTo$Snap $t@497))))
(declare-const $t@498 $Snap)
(declare-const $t@499 Int)
(assert (= $t@496 ($Snap.combine $t@498 ($SortWrappers.IntTo$Snap $t@499))))
(declare-const $t@500 $Ref)
(declare-const $t@501 $Snap)
(assert (= $t@498 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@500) $t@501)))
(declare-const $k@502 $Perm)
(assert ($Perm.isValidVar $k@502))
(assert ($Perm.isReadVar $k@502 $Perm.Write))
(push) ; 6
(assert (not (not (= $k@502 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@502 $Perm.No)))
(declare-const $k@503 $Perm)
(assert ($Perm.isValidVar $k@503))
(assert ($Perm.isReadVar $k@503 $Perm.Write))
(declare-const $k@504 $Perm)
(assert ($Perm.isValidVar $k@504))
(assert ($Perm.isReadVar $k@504 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= $k@504 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@504 $Perm.No)))
(assert (not (= $t@497 $Ref.null)))
; [eval] currentCount == 0
(assert (= currentCount@489 0))
(check-sat)
; unknown
; [exec]
; exhale true
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; inhale true
; [exec]
; __flatten_26 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@505 Int)
(declare-const $t@506 $Snap)
(declare-const $t@507 Int)
(assert (= $t@506 ($Snap.combine ($SortWrappers.IntTo$Snap $t@507) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@505 $t@507))
; [exec]
; currentCount := __flatten_26
(declare-const $k@508 $Perm)
(assert ($Perm.isValidVar $k@508))
(assert ($Perm.isReadVar $k@508 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@508 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@508 $k@502))
(declare-const $k@509 $Perm)
(assert ($Perm.isValidVar $k@509))
(assert ($Perm.isReadVar $k@509 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@509 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@503 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@503 $Perm.No)))
(assert (< $k@509 $k@503))
(declare-const $k@510 $Perm)
(assert ($Perm.isValidVar $k@510))
(assert ($Perm.isReadVar $k@510 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@510 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@510 $k@504))
; [eval] diz.BlockingQueue__count != null
(pop) ; 5
(push) ; 5
; Establish loop invariant
(declare-const $k@511 $Perm)
(assert ($Perm.isValidVar $k@511))
(assert ($Perm.isReadVar $k@511 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@511 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@511 $k@468))
(declare-const $k@512 $Perm)
(assert ($Perm.isValidVar $k@512))
(assert ($Perm.isReadVar $k@512 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@512 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@512 $k@304))
(declare-const $k@513 $Perm)
(assert ($Perm.isValidVar $k@513))
(assert ($Perm.isReadVar $k@513 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@513 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@513 $k@306))
; [eval] diz.BlockingQueue__count != null
; Continue after loop
(declare-const $t@514 $Snap)
(declare-const $t@515 $Snap)
(assert (= $t@514 ($Snap.combine $t@515 $Snap.unit)))
(declare-const $t@516 $Snap)
(declare-const $t@517 Int)
(assert (= $t@515 ($Snap.combine $t@516 ($SortWrappers.IntTo$Snap $t@517))))
(declare-const $t@518 $Snap)
(assert (= $t@516 ($Snap.combine $t@518 $Snap.unit)))
(declare-const $t@519 $Snap)
(declare-const $t@520 $Ref)
(assert (= $t@518 ($Snap.combine $t@519 ($SortWrappers.$RefTo$Snap $t@520))))
(declare-const $t@521 $Snap)
(declare-const $t@522 Int)
(assert (= $t@519 ($Snap.combine $t@521 ($SortWrappers.IntTo$Snap $t@522))))
(declare-const $t@523 $Ref)
(declare-const $t@524 $Snap)
(assert (= $t@521 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@523) $t@524)))
(declare-const $k@525 $Perm)
(assert ($Perm.isValidVar $k@525))
(assert ($Perm.isReadVar $k@525 $Perm.Write))
(assert (implies (< $Perm.No (- $k@468 $k@511)) (= $t@523 $t@469)))
(push) ; 6
(assert (not (not (= (+ (- $k@468 $k@511) $k@525) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@468 $k@511) $k@525) $Perm.No)))
(declare-const $k@526 $Perm)
(assert ($Perm.isValidVar $k@526))
(assert ($Perm.isReadVar $k@526 $Perm.Write))
(assert (implies (< $Perm.No (- $k@304 $k@512)) (= $t@522 $t@305)))
(declare-const $k@527 $Perm)
(assert ($Perm.isValidVar $k@527))
(assert ($Perm.isReadVar $k@527 $Perm.Write))
(assert (implies (< $Perm.No (- $k@306 $k@513)) (= $t@520 $t@307)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@306 $k@513) $k@527) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@306 $k@513) $k@527) $Perm.No)))
(assert (not (= $t@520 $Ref.null)))
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(assert (not (= currentCount@489 0)))
(check-sat)
; unknown
; [exec]
; inhale diz.BlockingQueue__first != null
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@309 $Ref.null)))
; [exec]
; __flatten_27 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@528 $Perm)
(assert ($Perm.isValidVar $k@528))
(assert ($Perm.isReadVar $k@528 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@528 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= (+ (- $k@304 $k@512) $k@526) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@304 $k@512) $k@526) $Perm.No)))
(assert (< $k@528 (+ (- $k@304 $k@512) $k@526)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (> $t@522 0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (> $t@522 0))
(declare-const $k@529 $Perm)
(assert ($Perm.isValidVar $k@529))
(assert ($Perm.isReadVar $k@529 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@529 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@529 (+ (- $k@306 $k@513) $k@527)))
; [eval] diz.BlockingQueue__first != null
; [dead then-branch 84] $t@309 != Null
; [dead else-branch 84] $t@309 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__put ----------
(declare-const diz@530 $Ref)
(declare-const val@531 Int)
(declare-const c@532 Int)
(declare-const currentCount@533 Int)
(declare-const __flatten_30@534 Int)
(declare-const __flatten_31@535 Int)
(declare-const __flatten_33@536 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@530 $Ref.null)))
(declare-const $k@537 $Perm)
(assert ($Perm.isValidVar $k@537))
(assert ($Perm.isReadVar $k@537 $Perm.Write))
(declare-const $t@538 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@537 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@537 $Perm.No)))
(assert (> $t@538 0))
(declare-const $k@539 $Perm)
(assert ($Perm.isValidVar $k@539))
(assert ($Perm.isReadVar $k@539 $Perm.Write))
(declare-const $t@540 $Ref)
(push) ; 3
(assert (not (not (= $k@539 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@539 $Perm.No)))
(assert (not (= $t@540 $Ref.null)))
(declare-const $t@541 Int)
(declare-const $t@542 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@542 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@542 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 85] $t@542 != Null
(assert (not (= $t@542 $Ref.null)))
(declare-const $t@543 $Snap)
(declare-const $k@544 $Perm)
(assert ($Perm.isValidVar $k@544))
(assert ($Perm.isReadVar $k@544 $Perm.Write))
(declare-const $t@545 $Ref)
(declare-const $k@546 $Perm)
(assert ($Perm.isValidVar $k@546))
(assert ($Perm.isReadVar $k@546 $Perm.Write))
(declare-const $t@547 $Ref)
(push) ; 4
(declare-const $k@548 $Perm)
(assert ($Perm.isValidVar $k@548))
(assert ($Perm.isReadVar $k@548 $Perm.Write))
(declare-const $t@549 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@548 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@548 $Perm.No)))
(assert (> $t@549 0))
(declare-const $k@550 $Perm)
(assert ($Perm.isValidVar $k@550))
(assert ($Perm.isReadVar $k@550 $Perm.Write))
(declare-const $t@551 $Ref)
(push) ; 5
(assert (not (not (= $k@550 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@550 $Perm.No)))
(assert (not (= $t@551 $Ref.null)))
(declare-const $t@552 Int)
(declare-const $t@553 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@553 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@553 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 86] $t@553 != Null
(assert (not (= $t@553 $Ref.null)))
(declare-const $t@554 $Snap)
(declare-const $k@555 $Perm)
(assert ($Perm.isValidVar $k@555))
(assert ($Perm.isReadVar $k@555 $Perm.Write))
(declare-const $t@556 $Ref)
(declare-const $k@557 $Perm)
(assert ($Perm.isValidVar $k@557))
(assert ($Perm.isReadVar $k@557 $Perm.Write))
(declare-const $t@558 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 86] $t@553 == Null
(assert (= $t@553 $Ref.null))
(declare-const $k@559 $Perm)
(assert ($Perm.isValidVar $k@559))
(assert ($Perm.isReadVar $k@559 $Perm.Write))
(declare-const $t@560 $Ref)
(declare-const $k@561 $Perm)
(assert ($Perm.isValidVar $k@561))
(assert ($Perm.isReadVar $k@561 $Perm.Write))
(declare-const $t@562 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 5
(assert (not (not (= $k@544 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@544 $Perm.No)))
(declare-const $t@563 $Snap)
; [exec]
; __flatten_30 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@564 Int)
(declare-const $t@565 $Snap)
(declare-const $t@566 Int)
(assert (= $t@565 ($Snap.combine ($SortWrappers.IntTo$Snap $t@566) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@564 $t@566))
; [exec]
; currentCount := __flatten_30
; loop at <no position>
(declare-const currentCount@567 Int)
(declare-const __flatten_31@568 Int)
(push) ; 5
; Verify loop body
(declare-const $t@569 $Snap)
(declare-const $t@570 $Snap)
(assert (= $t@569 ($Snap.combine $t@570 $Snap.unit)))
(declare-const $t@571 $Snap)
(declare-const $t@572 Int)
(assert (= $t@570 ($Snap.combine $t@571 ($SortWrappers.IntTo$Snap $t@572))))
(declare-const $t@573 $Snap)
(assert (= $t@571 ($Snap.combine $t@573 $Snap.unit)))
(declare-const $t@574 $Snap)
(declare-const $t@575 $Ref)
(assert (= $t@573 ($Snap.combine $t@574 ($SortWrappers.$RefTo$Snap $t@575))))
(declare-const $t@576 $Snap)
(declare-const $t@577 Int)
(assert (= $t@574 ($Snap.combine $t@576 ($SortWrappers.IntTo$Snap $t@577))))
(declare-const $t@578 $Ref)
(declare-const $t@579 $Snap)
(assert (= $t@576 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@578) $t@579)))
(declare-const $k@580 $Perm)
(assert ($Perm.isValidVar $k@580))
(assert ($Perm.isReadVar $k@580 $Perm.Write))
(push) ; 6
(assert (not (not (= $k@580 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@580 $Perm.No)))
(declare-const $k@581 $Perm)
(assert ($Perm.isValidVar $k@581))
(assert ($Perm.isReadVar $k@581 $Perm.Write))
(declare-const $k@582 $Perm)
(assert ($Perm.isValidVar $k@582))
(assert ($Perm.isReadVar $k@582 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= $k@582 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@582 $Perm.No)))
(assert (not (= $t@575 $Ref.null)))
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= $k@581 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@581 $Perm.No)))
(assert (= currentCount@567 $t@577))
(check-sat)
; unknown
; [exec]
; exhale true
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; inhale true
; [exec]
; __flatten_31 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@583 Int)
(declare-const $t@584 $Snap)
(declare-const $t@585 Int)
(assert (= $t@584 ($Snap.combine ($SortWrappers.IntTo$Snap $t@585) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@583 $t@585))
; [exec]
; currentCount := __flatten_31
(declare-const $k@586 $Perm)
(assert ($Perm.isValidVar $k@586))
(assert ($Perm.isReadVar $k@586 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@586 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@586 $k@580))
(declare-const $k@587 $Perm)
(assert ($Perm.isValidVar $k@587))
(assert ($Perm.isReadVar $k@587 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@587 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@587 $k@581))
(declare-const $k@588 $Perm)
(assert ($Perm.isValidVar $k@588))
(assert ($Perm.isReadVar $k@588 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@588 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@588 $k@582))
; [eval] diz.BlockingQueue__count != null
(pop) ; 5
(push) ; 5
; Establish loop invariant
(declare-const $k@589 $Perm)
(assert ($Perm.isValidVar $k@589))
(assert ($Perm.isReadVar $k@589 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@589 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@589 $k@544))
(declare-const $k@590 $Perm)
(assert ($Perm.isValidVar $k@590))
(assert ($Perm.isReadVar $k@590 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@590 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@590 $k@537))
(declare-const $k@591 $Perm)
(assert ($Perm.isValidVar $k@591))
(assert ($Perm.isReadVar $k@591 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@591 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@591 $k@539))
; [eval] diz.BlockingQueue__count != null
; Continue after loop
(declare-const $t@592 $Snap)
(declare-const $t@593 $Snap)
(assert (= $t@592 ($Snap.combine $t@593 $Snap.unit)))
(declare-const $t@594 $Snap)
(declare-const $t@595 Int)
(assert (= $t@593 ($Snap.combine $t@594 ($SortWrappers.IntTo$Snap $t@595))))
(declare-const $t@596 $Snap)
(assert (= $t@594 ($Snap.combine $t@596 $Snap.unit)))
(declare-const $t@597 $Snap)
(declare-const $t@598 $Ref)
(assert (= $t@596 ($Snap.combine $t@597 ($SortWrappers.$RefTo$Snap $t@598))))
(declare-const $t@599 $Snap)
(declare-const $t@600 Int)
(assert (= $t@597 ($Snap.combine $t@599 ($SortWrappers.IntTo$Snap $t@600))))
(declare-const $t@601 $Ref)
(declare-const $t@602 $Snap)
(assert (= $t@599 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@601) $t@602)))
(declare-const $k@603 $Perm)
(assert ($Perm.isValidVar $k@603))
(assert ($Perm.isReadVar $k@603 $Perm.Write))
(assert (implies (< $Perm.No (- $k@544 $k@589)) (= $t@601 $t@545)))
(push) ; 6
(assert (not (not (= (+ (- $k@544 $k@589) $k@603) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@544 $k@589) $k@603) $Perm.No)))
(declare-const $k@604 $Perm)
(assert ($Perm.isValidVar $k@604))
(assert ($Perm.isReadVar $k@604 $Perm.Write))
(assert (implies (< $Perm.No (- $k@537 $k@590)) (= $t@600 $t@538)))
(declare-const $k@605 $Perm)
(assert ($Perm.isValidVar $k@605))
(assert ($Perm.isReadVar $k@605 $Perm.Write))
(assert (implies (< $Perm.No (- $k@539 $k@591)) (= $t@598 $t@540)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@539 $k@591) $k@605) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@539 $k@591) $k@605) $Perm.No)))
(assert (not (= $t@598 $Ref.null)))
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= (+ (- $k@537 $k@590) $k@604) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@537 $k@590) $k@604) $Perm.No)))
(assert (not (= currentCount@567 $t@600)))
(check-sat)
; unknown
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@606 $Perm)
(assert ($Perm.isValidVar $k@606))
(assert ($Perm.isReadVar $k@606 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@606 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@606 (+ (- $k@537 $k@590) $k@604)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (> $t@600 0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (> $t@600 0))
(declare-const $k@607 $Perm)
(assert ($Perm.isValidVar $k@607))
(assert ($Perm.isReadVar $k@607 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@607 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@607 (+ (- $k@539 $k@591) $k@605)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@542 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 87] $t@542 != Null
(declare-const $k@608 $Perm)
(assert ($Perm.isValidVar $k@608))
(assert ($Perm.isReadVar $k@608 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@608 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@608 (+ (- $k@544 $k@589) $k@603)))
(declare-const $k@609 $Perm)
(assert ($Perm.isValidVar $k@609))
(assert ($Perm.isReadVar $k@609 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@609 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@546 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@546 $Perm.No)))
(assert (< $k@609 $k@546))
(declare-const $t@610 $Snap)
(declare-const $t@611 $Snap)
(assert (= $t@610 ($Snap.combine $t@611 $Snap.unit)))
(declare-const $t@612 $Snap)
(assert (= $t@611 ($Snap.combine $t@612 $Snap.unit)))
(declare-const $t@613 $Snap)
(assert (= $t@612 ($Snap.combine $t@613 $Snap.unit)))
(declare-const $t@614 $Snap)
(declare-const $t@615 $Ref)
(assert (= $t@613 ($Snap.combine $t@614 ($SortWrappers.$RefTo$Snap $t@615))))
(declare-const $t@616 $Snap)
(declare-const $t@617 $Ref)
(assert (= $t@614 ($Snap.combine $t@616 ($SortWrappers.$RefTo$Snap $t@617))))
(declare-const $t@618 $Snap)
(declare-const $t@619 $Snap)
(assert (= $t@616 ($Snap.combine $t@618 $t@619)))
(declare-const $t@620 $Snap)
(declare-const $t@621 $Ref)
(assert (= $t@618 ($Snap.combine $t@620 ($SortWrappers.$RefTo$Snap $t@621))))
(declare-const $t@622 $Snap)
(declare-const $t@623 Int)
(assert (= $t@620 ($Snap.combine $t@622 ($SortWrappers.IntTo$Snap $t@623))))
(declare-const $t@624 Int)
(declare-const $t@625 $Ref)
(assert (=
  $t@622
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@624)
    ($SortWrappers.$RefTo$Snap $t@625))))
(declare-const $t@626 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@624)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@626) $Snap.unit)))
(declare-const $k@627 $Perm)
(assert ($Perm.isValidVar $k@627))
(assert ($Perm.isReadVar $k@627 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@537 $k@590) $k@604) $k@606)) (= $t@626 $t@600)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 7
(assert (not (not (= (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627) $Perm.No)))
(assert (> $t@626 0))
(declare-const $k@628 $Perm)
(assert ($Perm.isValidVar $k@628))
(assert ($Perm.isReadVar $k@628 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@539 $k@591) $k@605) $k@607)) (= $t@625 $t@598)))
(push) ; 7
(assert (not (not (= (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628) $Perm.No)))
(assert (not (= $t@625 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@621 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@621 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 88] $t@621 != Null
(assert (not (= $t@621 $Ref.null)))
(declare-const $k@629 $Perm)
(assert ($Perm.isValidVar $k@629))
(assert ($Perm.isReadVar $k@629 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@544 $k@589) $k@603) $k@608)) (= $t@617 $t@601)))
(declare-const $k@630 $Perm)
(assert ($Perm.isValidVar $k@630))
(assert ($Perm.isReadVar $k@630 $Perm.Write))
(assert (implies (< $Perm.No (- $k@546 $k@609)) (= $t@615 $t@547)))
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@631 $Perm)
(assert ($Perm.isValidVar $k@631))
(assert ($Perm.isReadVar $k@631 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@631 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@631 (+ (- $k@537 $k@590) $k@604)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@632 $Perm)
(assert ($Perm.isValidVar $k@632))
(assert ($Perm.isReadVar $k@632 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@632 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@632 (+ (- $k@539 $k@591) $k@605)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@542 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 89] $t@542 != Null
(declare-const $k@633 $Perm)
(assert ($Perm.isValidVar $k@633))
(assert ($Perm.isReadVar $k@633 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@633 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@633 (+ (- $k@544 $k@589) $k@603)))
(declare-const $k@634 $Perm)
(assert ($Perm.isValidVar $k@634))
(assert ($Perm.isReadVar $k@634 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@634 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@634 $k@546))
(pop) ; 8
; [dead else-branch 89] $t@542 == Null
(assert ($Perm.isValidVar $k@633))
(assert ($Perm.isReadVar $k@633 $Perm.Write))
(assert (< $k@633 (+ (- $k@544 $k@589) $k@603)))
(assert ($Perm.isValidVar $k@634))
(assert ($Perm.isReadVar $k@634 $Perm.Write))
(assert (< $k@634 $k@546))
(push) ; 8
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@598))
                ($SortWrappers.IntTo$Snap $t@595))
              ($SortWrappers.$RefTo$Snap $t@542))
            $t@543)
          ($SortWrappers.$RefTo$Snap $t@601))
        ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@598))
              ($SortWrappers.IntTo$Snap $t@595))
            ($SortWrappers.$RefTo$Snap $t@542))
          $t@543)
        ($SortWrappers.$RefTo$Snap $t@601))
      ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 90] |BlockingQueue__contents(diz@530;((((((((_, $t@600), _), $t@598), $t@595), $t@542), $t@543), $t@601), $t@547))| == 0
(push) ; 9
; [else-branch 90] |BlockingQueue__contents(diz@530;((((((((_, $t@600), _), $t@598), $t@595), $t@542), $t@543), $t@601), $t@547))| != 0
(assert (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@598))
                ($SortWrappers.IntTo$Snap $t@595))
              ($SortWrappers.$RefTo$Snap $t@542))
            $t@543)
          ($SortWrappers.$RefTo$Snap $t@601))
        ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
    0)))
(pop) ; 9
(pop) ; 8
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@635 $Perm)
(assert ($Perm.isValidVar $k@635))
(assert ($Perm.isReadVar $k@635 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@635 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@635 (+ (- $k@537 $k@590) $k@604)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@636 $Perm)
(assert ($Perm.isValidVar $k@636))
(assert ($Perm.isReadVar $k@636 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@636 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@636 (+ (- $k@539 $k@591) $k@605)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@542 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 91] $t@542 != Null
(declare-const $k@637 $Perm)
(assert ($Perm.isValidVar $k@637))
(assert ($Perm.isReadVar $k@637 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@637 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@637 (+ (- $k@544 $k@589) $k@603)))
(declare-const $k@638 $Perm)
(assert ($Perm.isValidVar $k@638))
(assert ($Perm.isReadVar $k@638 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@638 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@638 $k@546))
(pop) ; 8
; [dead else-branch 91] $t@542 == Null
(assert ($Perm.isValidVar $k@637))
(assert ($Perm.isReadVar $k@637 $Perm.Write))
(assert (< $k@637 (+ (- $k@544 $k@589) $k@603)))
(assert ($Perm.isValidVar $k@638))
(assert ($Perm.isReadVar $k@638 $Perm.Write))
(assert (< $k@638 $k@546))
(push) ; 8
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@598))
              ($SortWrappers.IntTo$Snap $t@595))
            ($SortWrappers.$RefTo$Snap $t@542))
          $t@543)
        ($SortWrappers.$RefTo$Snap $t@601))
      ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@598))
                ($SortWrappers.IntTo$Snap $t@595))
              ($SortWrappers.$RefTo$Snap $t@542))
            $t@543)
          ($SortWrappers.$RefTo$Snap $t@601))
        ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 92] |BlockingQueue__contents(diz@530;((((((((_, $t@600), _), $t@598), $t@595), $t@542), $t@543), $t@601), $t@547))| != 0
(assert (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@598))
                ($SortWrappers.IntTo$Snap $t@595))
              ($SortWrappers.$RefTo$Snap $t@542))
            $t@543)
          ($SortWrappers.$RefTo$Snap $t@601))
        ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@639 $Perm)
(assert ($Perm.isValidVar $k@639))
(assert ($Perm.isReadVar $k@639 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@639 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@639 (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@640 $Perm)
(assert ($Perm.isValidVar $k@640))
(assert ($Perm.isReadVar $k@640 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@640 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@640 (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@621 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 93] $t@621 != Null
(declare-const $k@641 $Perm)
(assert ($Perm.isValidVar $k@641))
(assert ($Perm.isReadVar $k@641 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@641 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(push) ; 11
(assert (not (not (= (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (not (= (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629) $Perm.No)))
(assert (< $k@641 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(declare-const $k@642 $Perm)
(assert ($Perm.isValidVar $k@642))
(assert ($Perm.isReadVar $k@642 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@642 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(push) ; 11
(assert (not (not (= (+ (- $k@546 $k@609) $k@630) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (not (= (+ (- $k@546 $k@609) $k@630) $Perm.No)))
(assert (< $k@642 (+ (- $k@546 $k@609) $k@630)))
(pop) ; 10
; [dead else-branch 93] $t@621 == Null
(assert ($Perm.isValidVar $k@641))
(assert ($Perm.isReadVar $k@641 $Perm.Write))
(assert (not (= (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629) $Perm.No)))
(assert (< $k@641 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(assert ($Perm.isValidVar $k@642))
(assert ($Perm.isReadVar $k@642 $Perm.Write))
(assert (not (= (+ (- $k@546 $k@609) $k@630) $Perm.No)))
(assert (< $k@642 (+ (- $k@546 $k@609) $k@630)))
; [eval] old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] old(BlockingQueue__contents(diz))
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@643 $Perm)
(assert ($Perm.isValidVar $k@643))
(assert ($Perm.isReadVar $k@643 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@643 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@643 (+ (- $k@537 $k@590) $k@604)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@644 $Perm)
(assert ($Perm.isValidVar $k@644))
(assert ($Perm.isReadVar $k@644 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@644 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@644 (+ (- $k@539 $k@591) $k@605)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@542 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 94] $t@542 != Null
(declare-const $k@645 $Perm)
(assert ($Perm.isValidVar $k@645))
(assert ($Perm.isReadVar $k@645 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@645 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@645 (+ (- $k@544 $k@589) $k@603)))
(declare-const $k@646 $Perm)
(assert ($Perm.isValidVar $k@646))
(assert ($Perm.isReadVar $k@646 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@646 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@646 $k@546))
(pop) ; 10
; [dead else-branch 94] $t@542 == Null
(assert ($Perm.isValidVar $k@645))
(assert ($Perm.isReadVar $k@645 $Perm.Write))
(assert (< $k@645 (+ (- $k@544 $k@589) $k@603)))
(assert ($Perm.isValidVar $k@646))
(assert ($Perm.isReadVar $k@646 $Perm.Write))
(assert (< $k@646 $k@546))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@531)) 1))
(pop) ; 9
; [dead else-branch 92] |BlockingQueue__contents(diz@530;((((((((_, $t@600), _), $t@598), $t@595), $t@542), $t@543), $t@601), $t@547))| == 0
(pop) ; 8
(assert ($Perm.isValidVar $k@639))
(assert ($Perm.isReadVar $k@639 $Perm.Write))
(assert (< $k@639 (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627)))
(assert ($Perm.isValidVar $k@640))
(assert ($Perm.isReadVar $k@640 $Perm.Write))
(assert (< $k@640 (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628)))
(assert ($Perm.isValidVar $k@641))
(assert ($Perm.isReadVar $k@641 $Perm.Write))
(assert (not (= (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629) $Perm.No)))
(assert (< $k@641 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(assert ($Perm.isValidVar $k@642))
(assert ($Perm.isReadVar $k@642 $Perm.Write))
(assert (not (= (+ (- $k@546 $k@609) $k@630) $Perm.No)))
(assert (< $k@642 (+ (- $k@546 $k@609) $k@630)))
(assert ($Perm.isValidVar $k@643))
(assert ($Perm.isReadVar $k@643 $Perm.Write))
(assert (< $k@643 (+ (- $k@537 $k@590) $k@604)))
(assert ($Perm.isValidVar $k@644))
(assert ($Perm.isReadVar $k@644 $Perm.Write))
(assert (< $k@644 (+ (- $k@539 $k@591) $k@605)))
(assert ($Perm.isValidVar $k@645))
(assert ($Perm.isReadVar $k@645 $Perm.Write))
(assert (< $k@645 (+ (- $k@544 $k@589) $k@603)))
(assert ($Perm.isValidVar $k@646))
(assert ($Perm.isReadVar $k@646 $Perm.Write))
(assert (< $k@646 $k@546))
(assert (= ($Seq.length ($Seq.singleton val@531)) 1))
(assert (implies
  (not
    (=
      ($Seq.length
        ($BlockingQueue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine
                      ($Snap.combine
                        $Snap.unit
                        ($SortWrappers.IntTo$Snap $t@600))
                      $Snap.unit)
                    ($SortWrappers.$RefTo$Snap $t@598))
                  ($SortWrappers.IntTo$Snap $t@595))
                ($SortWrappers.$RefTo$Snap $t@542))
              $t@543)
            ($SortWrappers.$RefTo$Snap $t@601))
          ($SortWrappers.$RefTo$Snap $t@547)) diz@530))
      0))
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@626))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@625))
              ($SortWrappers.IntTo$Snap $t@623))
            ($SortWrappers.$RefTo$Snap $t@621))
          $t@619)
        ($SortWrappers.$RefTo$Snap $t@617))
      ($SortWrappers.$RefTo$Snap $t@615)) diz@530)
    ($Seq.append
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@600))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@598))
                ($SortWrappers.IntTo$Snap $t@595))
              ($SortWrappers.$RefTo$Snap $t@542))
            $t@543)
          ($SortWrappers.$RefTo$Snap $t@601))
        ($SortWrappers.$RefTo$Snap $t@547)) diz@530)
      ($Seq.singleton val@531)))))
; [exec]
; __flatten_33 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@647 Int)
(declare-const $t@648 $Snap)
(declare-const $t@649 Int)
(assert (= $t@648 ($Snap.combine ($SortWrappers.IntTo$Snap $t@649) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal - 1
; [eval] diz.AtomicInteger__ghostVal - 1
(assert (= sys__result@647 (- $t@649 1)))
; [exec]
; c := __flatten_33
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 8
(assert (not (not (< (+ sys__result@647 1) $t@626))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (< (+ sys__result@647 1) $t@626)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 95] sys__result@647 + 1 < $t@626
(assert (< (+ sys__result@647 1) $t@626))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 9
(assert (not (= $t@601 $t@617)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 9
(assert (not (= $t@601 $t@617)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == 0
(push) ; 9
(assert (not (not (= sys__result@647 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@647 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 96] sys__result@647 == 0
(assert (= sys__result@647 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@650 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
(declare-const $k@651 $Perm)
(assert ($Perm.isValidVar $k@651))
(assert ($Perm.isReadVar $k@651 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@651 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@651 (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@652 $Perm)
(assert ($Perm.isValidVar $k@652))
(assert ($Perm.isReadVar $k@652 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@652 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@652 (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@621 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 97] $t@621 != Null
(declare-const $k@653 $Perm)
(assert ($Perm.isValidVar $k@653))
(assert ($Perm.isReadVar $k@653 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@653 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@653 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(declare-const $k@654 $Perm)
(assert ($Perm.isValidVar $k@654))
(assert ($Perm.isReadVar $k@654 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@654 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@654 (+ (- $k@546 $k@609) $k@630)))
(pop) ; 10
; [dead else-branch 97] $t@621 == Null
(pop) ; 9
(push) ; 9
; [else-branch 96] sys__result@647 != 0
(assert (not (= sys__result@647 0)))
(pop) ; 9
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 9
(assert (not (= sys__result@647 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@647 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 98] sys__result@647 != 0
(assert (not (= sys__result@647 0)))
(declare-const $k@655 $Perm)
(assert ($Perm.isValidVar $k@655))
(assert ($Perm.isReadVar $k@655 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@655 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@655 (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@656 $Perm)
(assert ($Perm.isValidVar $k@656))
(assert ($Perm.isReadVar $k@656 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@656 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@656 (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@621 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 99] $t@621 != Null
(declare-const $k@657 $Perm)
(assert ($Perm.isValidVar $k@657))
(assert ($Perm.isReadVar $k@657 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@657 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@657 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(declare-const $k@658 $Perm)
(assert ($Perm.isValidVar $k@658))
(assert ($Perm.isReadVar $k@658 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@658 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@658 (+ (- $k@546 $k@609) $k@630)))
(pop) ; 10
; [dead else-branch 99] $t@621 == Null
(pop) ; 9
(push) ; 9
; [else-branch 98] sys__result@647 == 0
(assert (= sys__result@647 0))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 95] !sys__result@647 + 1 < $t@626
(assert (not (< (+ sys__result@647 1) $t@626)))
(pop) ; 8
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 8
(assert (not (< (+ sys__result@647 1) $t@626)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (< (+ sys__result@647 1) $t@626))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 100] !sys__result@647 + 1 < $t@626
(assert (not (< (+ sys__result@647 1) $t@626)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 9
(assert (not (= $t@601 $t@617)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == 0
(push) ; 9
(assert (not (not (= sys__result@647 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@647 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 101] sys__result@647 == 0
(assert (= sys__result@647 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@659 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
(declare-const $k@660 $Perm)
(assert ($Perm.isValidVar $k@660))
(assert ($Perm.isReadVar $k@660 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@660 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@660 (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@661 $Perm)
(assert ($Perm.isValidVar $k@661))
(assert ($Perm.isReadVar $k@661 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@661 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@661 (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@621 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 102] $t@621 != Null
(declare-const $k@662 $Perm)
(assert ($Perm.isValidVar $k@662))
(assert ($Perm.isReadVar $k@662 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@662 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@662 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(declare-const $k@663 $Perm)
(assert ($Perm.isValidVar $k@663))
(assert ($Perm.isReadVar $k@663 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@663 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@663 (+ (- $k@546 $k@609) $k@630)))
(pop) ; 10
; [dead else-branch 102] $t@621 == Null
(pop) ; 9
(push) ; 9
; [else-branch 101] sys__result@647 != 0
(assert (not (= sys__result@647 0)))
(pop) ; 9
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 9
(assert (not (= sys__result@647 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@647 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 103] sys__result@647 != 0
(assert (not (= sys__result@647 0)))
(declare-const $k@664 $Perm)
(assert ($Perm.isValidVar $k@664))
(assert ($Perm.isReadVar $k@664 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@664 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@664 (+ (- (+ (- $k@537 $k@590) $k@604) $k@606) $k@627)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@665 $Perm)
(assert ($Perm.isValidVar $k@665))
(assert ($Perm.isReadVar $k@665 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@665 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@665 (+ (- (+ (- $k@539 $k@591) $k@605) $k@607) $k@628)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@621 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 104] $t@621 != Null
(declare-const $k@666 $Perm)
(assert ($Perm.isValidVar $k@666))
(assert ($Perm.isReadVar $k@666 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@666 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@666 (+ (- (+ (- $k@544 $k@589) $k@603) $k@608) $k@629)))
(declare-const $k@667 $Perm)
(assert ($Perm.isValidVar $k@667))
(assert ($Perm.isReadVar $k@667 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@667 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@667 (+ (- $k@546 $k@609) $k@630)))
(pop) ; 10
; [dead else-branch 104] $t@621 == Null
(pop) ; 9
(push) ; 9
; [else-branch 103] sys__result@647 == 0
(assert (= sys__result@647 0))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 100] sys__result@647 + 1 < $t@626
(assert (< (+ sys__result@647 1) $t@626))
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 88] $t@621 == Null
(assert (= $t@621 $Ref.null))
(declare-const $k@668 $Perm)
(assert ($Perm.isValidVar $k@668))
(assert ($Perm.isReadVar $k@668 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@544 $k@589) $k@603) $k@608)) (= $t@617 $t@601)))
(declare-const $k@669 $Perm)
(assert ($Perm.isValidVar $k@669))
(assert ($Perm.isReadVar $k@669 $Perm.Write))
(assert (implies (< $Perm.No (- $k@546 $k@609)) (= $t@615 $t@547)))
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@621 $Ref.null)))
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@670 $Perm)
(assert ($Perm.isValidVar $k@670))
(assert ($Perm.isReadVar $k@670 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@670 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@670 (+ (- $k@537 $k@590) $k@604)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@671 $Perm)
(assert ($Perm.isValidVar $k@671))
(assert ($Perm.isReadVar $k@671 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@671 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@671 (+ (- $k@539 $k@591) $k@605)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@542 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [dead then-branch 105] $t@542 != Null
; [dead else-branch 105] $t@542 == Null
(pop) ; 7
(pop) ; 6
; [dead else-branch 87] $t@542 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 85] $t@542 == Null
(assert (= $t@542 $Ref.null))
(declare-const $k@672 $Perm)
(assert ($Perm.isValidVar $k@672))
(assert ($Perm.isReadVar $k@672 $Perm.Write))
(declare-const $t@673 $Ref)
(declare-const $k@674 $Perm)
(assert ($Perm.isValidVar $k@674))
(assert ($Perm.isReadVar $k@674 $Perm.Write))
(declare-const $t@675 $Ref)
(push) ; 4
(declare-const $k@676 $Perm)
(assert ($Perm.isValidVar $k@676))
(assert ($Perm.isReadVar $k@676 $Perm.Write))
(declare-const $t@677 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@676 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@676 $Perm.No)))
(assert (> $t@677 0))
(declare-const $k@678 $Perm)
(assert ($Perm.isValidVar $k@678))
(assert ($Perm.isReadVar $k@678 $Perm.Write))
(declare-const $t@679 $Ref)
(push) ; 5
(assert (not (not (= $k@678 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@678 $Perm.No)))
(assert (not (= $t@679 $Ref.null)))
(declare-const $t@680 Int)
(declare-const $t@681 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@681 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@681 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 106] $t@681 != Null
(assert (not (= $t@681 $Ref.null)))
(declare-const $t@682 $Snap)
(declare-const $k@683 $Perm)
(assert ($Perm.isValidVar $k@683))
(assert ($Perm.isReadVar $k@683 $Perm.Write))
(declare-const $t@684 $Ref)
(declare-const $k@685 $Perm)
(assert ($Perm.isValidVar $k@685))
(assert ($Perm.isReadVar $k@685 $Perm.Write))
(declare-const $t@686 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 106] $t@681 == Null
(assert (= $t@681 $Ref.null))
(declare-const $k@687 $Perm)
(assert ($Perm.isValidVar $k@687))
(assert ($Perm.isReadVar $k@687 $Perm.Write))
(declare-const $t@688 $Ref)
(declare-const $k@689 $Perm)
(assert ($Perm.isValidVar $k@689))
(assert ($Perm.isReadVar $k@689 $Perm.Write))
(declare-const $t@690 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 5
(assert (not (not (= $k@672 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@672 $Perm.No)))
(declare-const $t@691 $Snap)
; [exec]
; __flatten_30 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@692 Int)
(declare-const $t@693 $Snap)
(declare-const $t@694 Int)
(assert (= $t@693 ($Snap.combine ($SortWrappers.IntTo$Snap $t@694) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@692 $t@694))
; [exec]
; currentCount := __flatten_30
; loop at <no position>
(declare-const currentCount@695 Int)
(declare-const __flatten_31@696 Int)
(push) ; 5
; Verify loop body
(declare-const $t@697 $Snap)
(declare-const $t@698 $Snap)
(assert (= $t@697 ($Snap.combine $t@698 $Snap.unit)))
(declare-const $t@699 $Snap)
(declare-const $t@700 Int)
(assert (= $t@698 ($Snap.combine $t@699 ($SortWrappers.IntTo$Snap $t@700))))
(declare-const $t@701 $Snap)
(assert (= $t@699 ($Snap.combine $t@701 $Snap.unit)))
(declare-const $t@702 $Snap)
(declare-const $t@703 $Ref)
(assert (= $t@701 ($Snap.combine $t@702 ($SortWrappers.$RefTo$Snap $t@703))))
(declare-const $t@704 $Snap)
(declare-const $t@705 Int)
(assert (= $t@702 ($Snap.combine $t@704 ($SortWrappers.IntTo$Snap $t@705))))
(declare-const $t@706 $Ref)
(declare-const $t@707 $Snap)
(assert (= $t@704 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@706) $t@707)))
(declare-const $k@708 $Perm)
(assert ($Perm.isValidVar $k@708))
(assert ($Perm.isReadVar $k@708 $Perm.Write))
(push) ; 6
(assert (not (not (= $k@708 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@708 $Perm.No)))
(declare-const $k@709 $Perm)
(assert ($Perm.isValidVar $k@709))
(assert ($Perm.isReadVar $k@709 $Perm.Write))
(declare-const $k@710 $Perm)
(assert ($Perm.isValidVar $k@710))
(assert ($Perm.isReadVar $k@710 $Perm.Write))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= $k@710 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@710 $Perm.No)))
(assert (not (= $t@703 $Ref.null)))
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= $k@709 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@709 $Perm.No)))
(assert (= currentCount@695 $t@705))
(check-sat)
; unknown
; [exec]
; exhale true
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; inhale true
; [exec]
; __flatten_31 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@711 Int)
(declare-const $t@712 $Snap)
(declare-const $t@713 Int)
(assert (= $t@712 ($Snap.combine ($SortWrappers.IntTo$Snap $t@713) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@711 $t@713))
; [exec]
; currentCount := __flatten_31
(declare-const $k@714 $Perm)
(assert ($Perm.isValidVar $k@714))
(assert ($Perm.isReadVar $k@714 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@714 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@714 $k@708))
(declare-const $k@715 $Perm)
(assert ($Perm.isValidVar $k@715))
(assert ($Perm.isReadVar $k@715 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@715 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@715 $k@709))
(declare-const $k@716 $Perm)
(assert ($Perm.isValidVar $k@716))
(assert ($Perm.isReadVar $k@716 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@716 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@716 $k@710))
; [eval] diz.BlockingQueue__count != null
(pop) ; 5
(push) ; 5
; Establish loop invariant
(declare-const $k@717 $Perm)
(assert ($Perm.isValidVar $k@717))
(assert ($Perm.isReadVar $k@717 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@717 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@717 $k@672))
(declare-const $k@718 $Perm)
(assert ($Perm.isValidVar $k@718))
(assert ($Perm.isReadVar $k@718 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@718 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@718 $k@537))
(declare-const $k@719 $Perm)
(assert ($Perm.isValidVar $k@719))
(assert ($Perm.isReadVar $k@719 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@719 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@719 $k@539))
; [eval] diz.BlockingQueue__count != null
; Continue after loop
(declare-const $t@720 $Snap)
(declare-const $t@721 $Snap)
(assert (= $t@720 ($Snap.combine $t@721 $Snap.unit)))
(declare-const $t@722 $Snap)
(declare-const $t@723 Int)
(assert (= $t@721 ($Snap.combine $t@722 ($SortWrappers.IntTo$Snap $t@723))))
(declare-const $t@724 $Snap)
(assert (= $t@722 ($Snap.combine $t@724 $Snap.unit)))
(declare-const $t@725 $Snap)
(declare-const $t@726 $Ref)
(assert (= $t@724 ($Snap.combine $t@725 ($SortWrappers.$RefTo$Snap $t@726))))
(declare-const $t@727 $Snap)
(declare-const $t@728 Int)
(assert (= $t@725 ($Snap.combine $t@727 ($SortWrappers.IntTo$Snap $t@728))))
(declare-const $t@729 $Ref)
(declare-const $t@730 $Snap)
(assert (= $t@727 ($Snap.combine ($SortWrappers.$RefTo$Snap $t@729) $t@730)))
(declare-const $k@731 $Perm)
(assert ($Perm.isValidVar $k@731))
(assert ($Perm.isReadVar $k@731 $Perm.Write))
(assert (implies (< $Perm.No (- $k@672 $k@717)) (= $t@729 $t@673)))
(push) ; 6
(assert (not (not (= (+ (- $k@672 $k@717) $k@731) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@672 $k@717) $k@731) $Perm.No)))
(declare-const $k@732 $Perm)
(assert ($Perm.isValidVar $k@732))
(assert ($Perm.isReadVar $k@732 $Perm.Write))
(assert (implies (< $Perm.No (- $k@537 $k@718)) (= $t@728 $t@538)))
(declare-const $k@733 $Perm)
(assert ($Perm.isValidVar $k@733))
(assert ($Perm.isReadVar $k@733 $Perm.Write))
(assert (implies (< $Perm.No (- $k@539 $k@719)) (= $t@726 $t@540)))
; [eval] diz.BlockingQueue__count != null
(push) ; 6
(assert (not (not (= (+ (- $k@539 $k@719) $k@733) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@539 $k@719) $k@733) $Perm.No)))
(assert (not (= $t@726 $Ref.null)))
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (= (+ (- $k@537 $k@718) $k@732) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@537 $k@718) $k@732) $Perm.No)))
(assert (not (= currentCount@695 $t@728)))
(check-sat)
; unknown
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@734 $Perm)
(assert ($Perm.isValidVar $k@734))
(assert ($Perm.isReadVar $k@734 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@734 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@734 (+ (- $k@537 $k@718) $k@732)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (> $t@728 0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (> $t@728 0))
(declare-const $k@735 $Perm)
(assert ($Perm.isValidVar $k@735))
(assert ($Perm.isReadVar $k@735 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@735 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@735 (+ (- $k@539 $k@719) $k@733)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@542 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 107] $t@542 != Null
(push) ; 6
; [else-branch 107] $t@542 == Null
(declare-const $k@736 $Perm)
(assert ($Perm.isValidVar $k@736))
(assert ($Perm.isReadVar $k@736 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@736 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@736 (+ (- $k@672 $k@717) $k@731)))
(declare-const $k@737 $Perm)
(assert ($Perm.isValidVar $k@737))
(assert ($Perm.isReadVar $k@737 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@737 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@674 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@674 $Perm.No)))
(assert (< $k@737 $k@674))
(declare-const $t@738 $Snap)
(declare-const $t@739 $Snap)
(assert (= $t@738 ($Snap.combine $t@739 $Snap.unit)))
(declare-const $t@740 $Snap)
(assert (= $t@739 ($Snap.combine $t@740 $Snap.unit)))
(declare-const $t@741 $Snap)
(assert (= $t@740 ($Snap.combine $t@741 $Snap.unit)))
(declare-const $t@742 $Snap)
(declare-const $t@743 $Ref)
(assert (= $t@741 ($Snap.combine $t@742 ($SortWrappers.$RefTo$Snap $t@743))))
(declare-const $t@744 $Snap)
(declare-const $t@745 $Ref)
(assert (= $t@742 ($Snap.combine $t@744 ($SortWrappers.$RefTo$Snap $t@745))))
(declare-const $t@746 $Snap)
(declare-const $t@747 $Snap)
(assert (= $t@744 ($Snap.combine $t@746 $t@747)))
(declare-const $t@748 $Snap)
(declare-const $t@749 $Ref)
(assert (= $t@746 ($Snap.combine $t@748 ($SortWrappers.$RefTo$Snap $t@749))))
(declare-const $t@750 $Snap)
(declare-const $t@751 Int)
(assert (= $t@748 ($Snap.combine $t@750 ($SortWrappers.IntTo$Snap $t@751))))
(declare-const $t@752 Int)
(declare-const $t@753 $Ref)
(assert (=
  $t@750
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@752)
    ($SortWrappers.$RefTo$Snap $t@753))))
(declare-const $t@754 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@752)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@754) $Snap.unit)))
(declare-const $k@755 $Perm)
(assert ($Perm.isValidVar $k@755))
(assert ($Perm.isReadVar $k@755 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@537 $k@718) $k@732) $k@734)) (= $t@754 $t@728)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 7
(assert (not (not (= (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755) $Perm.No)))
(assert (> $t@754 0))
(declare-const $k@756 $Perm)
(assert ($Perm.isValidVar $k@756))
(assert ($Perm.isReadVar $k@756 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@539 $k@719) $k@733) $k@735)) (= $t@753 $t@726)))
(push) ; 7
(assert (not (not (= (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756) $Perm.No)))
(assert (not (= $t@753 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@749 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@749 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 108] $t@749 != Null
(assert (not (= $t@749 $Ref.null)))
(declare-const $k@757 $Perm)
(assert ($Perm.isValidVar $k@757))
(assert ($Perm.isReadVar $k@757 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@672 $k@717) $k@731) $k@736)) (= $t@745 $t@729)))
(declare-const $k@758 $Perm)
(assert ($Perm.isValidVar $k@758))
(assert ($Perm.isReadVar $k@758 $Perm.Write))
(assert (implies (< $Perm.No (- $k@674 $k@737)) (= $t@743 $t@675)))
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@759 $Perm)
(assert ($Perm.isValidVar $k@759))
(assert ($Perm.isReadVar $k@759 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@759 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@759 (+ (- $k@537 $k@718) $k@732)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@760 $Perm)
(assert ($Perm.isValidVar $k@760))
(assert ($Perm.isReadVar $k@760 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@760 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@760 (+ (- $k@539 $k@719) $k@733)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@542 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 109] $t@542 != Null
(push) ; 8
; [else-branch 109] $t@542 == Null
(declare-const $k@761 $Perm)
(assert ($Perm.isValidVar $k@761))
(assert ($Perm.isReadVar $k@761 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@761 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@761 (+ (- $k@672 $k@717) $k@731)))
(declare-const $k@762 $Perm)
(assert ($Perm.isValidVar $k@762))
(assert ($Perm.isReadVar $k@762 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@762 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@762 $k@674))
(pop) ; 8
(assert ($Perm.isValidVar $k@761))
(assert ($Perm.isReadVar $k@761 $Perm.Write))
(assert (< $k@761 (+ (- $k@672 $k@717) $k@731)))
(assert ($Perm.isValidVar $k@762))
(assert ($Perm.isReadVar $k@762 $Perm.Write))
(assert (< $k@762 $k@674))
(push) ; 8
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@726))
                ($SortWrappers.IntTo$Snap $t@723))
              ($SortWrappers.$RefTo$Snap $t@542))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@729))
        ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@726))
              ($SortWrappers.IntTo$Snap $t@723))
            ($SortWrappers.$RefTo$Snap $t@542))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@729))
      ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 110] |BlockingQueue__contents(diz@530;((((((((_, $t@728), _), $t@726), $t@723), $t@542), _), $t@729), $t@675))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@726))
              ($SortWrappers.IntTo$Snap $t@723))
            ($SortWrappers.$RefTo$Snap $t@542))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@729))
      ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
  0))
; [eval] BlockingQueue__contents(diz) == Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@763 $Perm)
(assert ($Perm.isValidVar $k@763))
(assert ($Perm.isReadVar $k@763 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@763 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@763 (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@764 $Perm)
(assert ($Perm.isValidVar $k@764))
(assert ($Perm.isReadVar $k@764 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@764 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@764 (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@749 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 111] $t@749 != Null
(declare-const $k@765 $Perm)
(assert ($Perm.isValidVar $k@765))
(assert ($Perm.isReadVar $k@765 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@765 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(push) ; 11
(assert (not (not (= (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (not (= (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757) $Perm.No)))
(assert (< $k@765 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(declare-const $k@766 $Perm)
(assert ($Perm.isValidVar $k@766))
(assert ($Perm.isReadVar $k@766 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@766 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(push) ; 11
(assert (not (not (= (+ (- $k@674 $k@737) $k@758) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (not (= (+ (- $k@674 $k@737) $k@758) $Perm.No)))
(assert (< $k@766 (+ (- $k@674 $k@737) $k@758)))
(pop) ; 10
; [dead else-branch 111] $t@749 == Null
(assert ($Perm.isValidVar $k@765))
(assert ($Perm.isReadVar $k@765 $Perm.Write))
(assert (not (= (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757) $Perm.No)))
(assert (< $k@765 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(assert ($Perm.isValidVar $k@766))
(assert ($Perm.isReadVar $k@766 $Perm.Write))
(assert (not (= (+ (- $k@674 $k@737) $k@758) $Perm.No)))
(assert (< $k@766 (+ (- $k@674 $k@737) $k@758)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@531)) 1))
(pop) ; 9
; [dead else-branch 110] |BlockingQueue__contents(diz@530;((((((((_, $t@728), _), $t@726), $t@723), $t@542), _), $t@729), $t@675))| != 0
(pop) ; 8
(assert ($Perm.isValidVar $k@763))
(assert ($Perm.isReadVar $k@763 $Perm.Write))
(assert (< $k@763 (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755)))
(assert ($Perm.isValidVar $k@764))
(assert ($Perm.isReadVar $k@764 $Perm.Write))
(assert (< $k@764 (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756)))
(assert ($Perm.isValidVar $k@765))
(assert ($Perm.isReadVar $k@765 $Perm.Write))
(assert (not (= (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757) $Perm.No)))
(assert (< $k@765 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(assert ($Perm.isValidVar $k@766))
(assert ($Perm.isReadVar $k@766 $Perm.Write))
(assert (not (= (+ (- $k@674 $k@737) $k@758) $Perm.No)))
(assert (< $k@766 (+ (- $k@674 $k@737) $k@758)))
(assert (= ($Seq.length ($Seq.singleton val@531)) 1))
(assert (implies
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@726))
                ($SortWrappers.IntTo$Snap $t@723))
              ($SortWrappers.$RefTo$Snap $t@542))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@729))
        ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
    0)
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@754))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@753))
              ($SortWrappers.IntTo$Snap $t@751))
            ($SortWrappers.$RefTo$Snap $t@749))
          $t@747)
        ($SortWrappers.$RefTo$Snap $t@745))
      ($SortWrappers.$RefTo$Snap $t@743)) diz@530)
    ($Seq.singleton val@531))))
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@767 $Perm)
(assert ($Perm.isValidVar $k@767))
(assert ($Perm.isReadVar $k@767 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@767 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@767 (+ (- $k@537 $k@718) $k@732)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@768 $Perm)
(assert ($Perm.isValidVar $k@768))
(assert ($Perm.isReadVar $k@768 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@768 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@768 (+ (- $k@539 $k@719) $k@733)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@542 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 112] $t@542 != Null
(push) ; 8
; [else-branch 112] $t@542 == Null
(declare-const $k@769 $Perm)
(assert ($Perm.isValidVar $k@769))
(assert ($Perm.isReadVar $k@769 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@769 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@769 (+ (- $k@672 $k@717) $k@731)))
(declare-const $k@770 $Perm)
(assert ($Perm.isValidVar $k@770))
(assert ($Perm.isReadVar $k@770 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@770 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@770 $k@674))
(pop) ; 8
(assert ($Perm.isValidVar $k@769))
(assert ($Perm.isReadVar $k@769 $Perm.Write))
(assert (< $k@769 (+ (- $k@672 $k@717) $k@731)))
(assert ($Perm.isValidVar $k@770))
(assert ($Perm.isReadVar $k@770 $Perm.Write))
(assert (< $k@770 $k@674))
(push) ; 8
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@726))
              ($SortWrappers.IntTo$Snap $t@723))
            ($SortWrappers.$RefTo$Snap $t@542))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@729))
      ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@726))
                ($SortWrappers.IntTo$Snap $t@723))
              ($SortWrappers.$RefTo$Snap $t@542))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@729))
        ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 113] |BlockingQueue__contents(diz@530;((((((((_, $t@728), _), $t@726), $t@723), $t@542), _), $t@729), $t@675))| != 0
(push) ; 9
; [else-branch 113] |BlockingQueue__contents(diz@530;((((((((_, $t@728), _), $t@726), $t@723), $t@542), _), $t@729), $t@675))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@728))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@726))
              ($SortWrappers.IntTo$Snap $t@723))
            ($SortWrappers.$RefTo$Snap $t@542))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@729))
      ($SortWrappers.$RefTo$Snap $t@675)) diz@530))
  0))
(pop) ; 9
(pop) ; 8
; [exec]
; __flatten_33 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@771 Int)
(declare-const $t@772 $Snap)
(declare-const $t@773 Int)
(assert (= $t@772 ($Snap.combine ($SortWrappers.IntTo$Snap $t@773) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal - 1
; [eval] diz.AtomicInteger__ghostVal - 1
(assert (= sys__result@771 (- $t@773 1)))
; [exec]
; c := __flatten_33
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 8
(assert (not (not (< (+ sys__result@771 1) $t@754))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (< (+ sys__result@771 1) $t@754)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 114] sys__result@771 + 1 < $t@754
(assert (< (+ sys__result@771 1) $t@754))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 9
(assert (not (= $t@729 $t@745)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 9
(assert (not (= $t@729 $t@745)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == 0
(push) ; 9
(assert (not (not (= sys__result@771 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@771 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 115] sys__result@771 == 0
(assert (= sys__result@771 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@774 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
(declare-const $k@775 $Perm)
(assert ($Perm.isValidVar $k@775))
(assert ($Perm.isReadVar $k@775 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@775 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@775 (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@776 $Perm)
(assert ($Perm.isValidVar $k@776))
(assert ($Perm.isReadVar $k@776 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@776 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@776 (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@749 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 116] $t@749 != Null
(declare-const $k@777 $Perm)
(assert ($Perm.isValidVar $k@777))
(assert ($Perm.isReadVar $k@777 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@777 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@777 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(declare-const $k@778 $Perm)
(assert ($Perm.isValidVar $k@778))
(assert ($Perm.isReadVar $k@778 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@778 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@778 (+ (- $k@674 $k@737) $k@758)))
(pop) ; 10
; [dead else-branch 116] $t@749 == Null
(pop) ; 9
(push) ; 9
; [else-branch 115] sys__result@771 != 0
(assert (not (= sys__result@771 0)))
(pop) ; 9
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 9
(assert (not (= sys__result@771 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@771 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 117] sys__result@771 != 0
(assert (not (= sys__result@771 0)))
(declare-const $k@779 $Perm)
(assert ($Perm.isValidVar $k@779))
(assert ($Perm.isReadVar $k@779 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@779 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@779 (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@780 $Perm)
(assert ($Perm.isValidVar $k@780))
(assert ($Perm.isReadVar $k@780 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@780 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@780 (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@749 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 118] $t@749 != Null
(declare-const $k@781 $Perm)
(assert ($Perm.isValidVar $k@781))
(assert ($Perm.isReadVar $k@781 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@781 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@781 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(declare-const $k@782 $Perm)
(assert ($Perm.isValidVar $k@782))
(assert ($Perm.isReadVar $k@782 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@782 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@782 (+ (- $k@674 $k@737) $k@758)))
(pop) ; 10
; [dead else-branch 118] $t@749 == Null
(pop) ; 9
(push) ; 9
; [else-branch 117] sys__result@771 == 0
(assert (= sys__result@771 0))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 114] !sys__result@771 + 1 < $t@754
(assert (not (< (+ sys__result@771 1) $t@754)))
(pop) ; 8
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 8
(assert (not (< (+ sys__result@771 1) $t@754)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (< (+ sys__result@771 1) $t@754))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 119] !sys__result@771 + 1 < $t@754
(assert (not (< (+ sys__result@771 1) $t@754)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 9
(assert (not (= $t@729 $t@745)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [exec]
; exhale true
; [eval] c == 0
(push) ; 9
(assert (not (not (= sys__result@771 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= sys__result@771 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 120] sys__result@771 == 0
(assert (= sys__result@771 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@783 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
(declare-const $k@784 $Perm)
(assert ($Perm.isValidVar $k@784))
(assert ($Perm.isReadVar $k@784 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@784 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@784 (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@785 $Perm)
(assert ($Perm.isValidVar $k@785))
(assert ($Perm.isReadVar $k@785 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@785 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@785 (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@749 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 121] $t@749 != Null
(declare-const $k@786 $Perm)
(assert ($Perm.isValidVar $k@786))
(assert ($Perm.isReadVar $k@786 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@786 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@786 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(declare-const $k@787 $Perm)
(assert ($Perm.isValidVar $k@787))
(assert ($Perm.isReadVar $k@787 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@787 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@787 (+ (- $k@674 $k@737) $k@758)))
(pop) ; 10
; [dead else-branch 121] $t@749 == Null
(pop) ; 9
(push) ; 9
; [else-branch 120] sys__result@771 != 0
(assert (not (= sys__result@771 0)))
(pop) ; 9
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 9
(assert (not (= sys__result@771 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= sys__result@771 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 122] sys__result@771 != 0
(assert (not (= sys__result@771 0)))
(declare-const $k@788 $Perm)
(assert ($Perm.isValidVar $k@788))
(assert ($Perm.isReadVar $k@788 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@788 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@788 (+ (- (+ (- $k@537 $k@718) $k@732) $k@734) $k@755)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@789 $Perm)
(assert ($Perm.isValidVar $k@789))
(assert ($Perm.isReadVar $k@789 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@789 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@789 (+ (- (+ (- $k@539 $k@719) $k@733) $k@735) $k@756)))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@749 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 123] $t@749 != Null
(declare-const $k@790 $Perm)
(assert ($Perm.isValidVar $k@790))
(assert ($Perm.isReadVar $k@790 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@790 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@790 (+ (- (+ (- $k@672 $k@717) $k@731) $k@736) $k@757)))
(declare-const $k@791 $Perm)
(assert ($Perm.isValidVar $k@791))
(assert ($Perm.isReadVar $k@791 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@791 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@791 (+ (- $k@674 $k@737) $k@758)))
(pop) ; 10
; [dead else-branch 123] $t@749 == Null
(pop) ; 9
(push) ; 9
; [else-branch 122] sys__result@771 == 0
(assert (= sys__result@771 0))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 119] sys__result@771 + 1 < $t@754
(assert (< (+ sys__result@771 1) $t@754))
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 108] $t@749 == Null
(assert (= $t@749 $Ref.null))
(declare-const $k@792 $Perm)
(assert ($Perm.isValidVar $k@792))
(assert ($Perm.isReadVar $k@792 $Perm.Write))
(assert (implies (< $Perm.No (- (+ (- $k@672 $k@717) $k@731) $k@736)) (= $t@745 $t@729)))
(declare-const $k@793 $Perm)
(assert ($Perm.isValidVar $k@793))
(assert ($Perm.isReadVar $k@793 $Perm.Write))
(assert (implies (< $Perm.No (- $k@674 $k@737)) (= $t@743 $t@675)))
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@749 $Ref.null)))
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@794 $Perm)
(assert ($Perm.isValidVar $k@794))
(assert ($Perm.isReadVar $k@794 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@794 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@794 (+ (- $k@537 $k@718) $k@732)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@795 $Perm)
(assert ($Perm.isValidVar $k@795))
(assert ($Perm.isReadVar $k@795 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@795 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@795 (+ (- $k@539 $k@719) $k@733)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@542 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
; [dead then-branch 124] $t@542 != Null
; [dead else-branch 124] $t@542 == Null
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__linkLast ----------
(declare-const diz@796 $Ref)
(declare-const val@797 Int)
(declare-const __flatten_34@798 $Ref)
(declare-const __flatten_35@799 $Ref)
(declare-const __flatten_36@800 $Ref)
(declare-const __flatten_65@801 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@796 $Ref.null)))
(declare-const $k@802 $Perm)
(assert ($Perm.isValidVar $k@802))
(assert ($Perm.isReadVar $k@802 $Perm.Write))
(declare-const $t@803 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@802 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@802 $Perm.No)))
(assert (> $t@803 0))
(declare-const $k@804 $Perm)
(assert ($Perm.isValidVar $k@804))
(assert ($Perm.isReadVar $k@804 $Perm.Write))
(declare-const $t@805 $Ref)
(push) ; 3
(assert (not (not (= $k@804 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@804 $Perm.No)))
(assert (not (= $t@805 $Ref.null)))
(declare-const $t@806 Int)
(declare-const $t@807 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 125] $t@807 != Null
(assert (not (= $t@807 $Ref.null)))
(declare-const $t@808 $Snap)
(declare-const $k@809 $Perm)
(assert ($Perm.isValidVar $k@809))
(assert ($Perm.isReadVar $k@809 $Perm.Write))
(declare-const $t@810 $Ref)
(declare-const $k@811 $Perm)
(assert ($Perm.isValidVar $k@811))
(assert ($Perm.isReadVar $k@811 $Perm.Write))
(declare-const $t@812 $Ref)
(push) ; 4
(declare-const $k@813 $Perm)
(assert ($Perm.isValidVar $k@813))
(assert ($Perm.isReadVar $k@813 $Perm.Write))
(declare-const $t@814 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@813 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@813 $Perm.No)))
(assert (> $t@814 0))
(declare-const $k@815 $Perm)
(assert ($Perm.isValidVar $k@815))
(assert ($Perm.isReadVar $k@815 $Perm.Write))
(declare-const $t@816 $Ref)
(push) ; 5
(assert (not (not (= $k@815 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@815 $Perm.No)))
(assert (not (= $t@816 $Ref.null)))
(declare-const $t@817 Int)
(declare-const $t@818 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@818 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@818 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 126] $t@818 != Null
(assert (not (= $t@818 $Ref.null)))
(declare-const $t@819 $Snap)
(declare-const $k@820 $Perm)
(assert ($Perm.isValidVar $k@820))
(assert ($Perm.isReadVar $k@820 $Perm.Write))
(declare-const $t@821 $Ref)
(declare-const $k@822 $Perm)
(assert ($Perm.isValidVar $k@822))
(assert ($Perm.isReadVar $k@822 $Perm.Write))
(declare-const $t@823 $Ref)
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@824 $Perm)
(assert ($Perm.isValidVar $k@824))
(assert ($Perm.isReadVar $k@824 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@824 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@824 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@825 $Perm)
(assert ($Perm.isValidVar $k@825))
(assert ($Perm.isReadVar $k@825 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@825 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@825 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 127] $t@807 != Null
(declare-const $k@826 $Perm)
(assert ($Perm.isValidVar $k@826))
(assert ($Perm.isReadVar $k@826 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@826 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@809 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@809 $Perm.No)))
(assert (< $k@826 $k@809))
(declare-const $k@827 $Perm)
(assert ($Perm.isValidVar $k@827))
(assert ($Perm.isReadVar $k@827 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@827 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@811 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@811 $Perm.No)))
(assert (< $k@827 $k@811))
(pop) ; 6
; [dead else-branch 127] $t@807 == Null
(assert ($Perm.isValidVar $k@826))
(assert ($Perm.isReadVar $k@826 $Perm.Write))
(assert (not (= $k@809 $Perm.No)))
(assert (< $k@826 $k@809))
(assert ($Perm.isValidVar $k@827))
(assert ($Perm.isReadVar $k@827 $Perm.Write))
(assert (not (= $k@811 $Perm.No)))
(assert (< $k@827 $k@811))
(push) ; 6
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $t@808)
        ($SortWrappers.$RefTo$Snap $t@810))
      ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 128] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| == 0
(push) ; 7
; [else-branch 128] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| != 0
(assert (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0)))
(pop) ; 7
(pop) ; 6
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@828 $Perm)
(assert ($Perm.isValidVar $k@828))
(assert ($Perm.isReadVar $k@828 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@828 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@828 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@829 $Perm)
(assert ($Perm.isValidVar $k@829))
(assert ($Perm.isReadVar $k@829 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@829 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@829 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 129] $t@807 != Null
(declare-const $k@830 $Perm)
(assert ($Perm.isValidVar $k@830))
(assert ($Perm.isReadVar $k@830 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@830 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@830 $k@809))
(declare-const $k@831 $Perm)
(assert ($Perm.isValidVar $k@831))
(assert ($Perm.isReadVar $k@831 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@831 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@831 $k@811))
(pop) ; 6
; [dead else-branch 129] $t@807 == Null
(assert ($Perm.isValidVar $k@830))
(assert ($Perm.isReadVar $k@830 $Perm.Write))
(assert (< $k@830 $k@809))
(assert ($Perm.isValidVar $k@831))
(assert ($Perm.isReadVar $k@831 $Perm.Write))
(assert (< $k@831 $k@811))
(push) ; 6
(push) ; 7
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $t@808)
        ($SortWrappers.$RefTo$Snap $t@810))
      ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 130] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| != 0
(assert (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@832 $Perm)
(assert ($Perm.isValidVar $k@832))
(assert ($Perm.isReadVar $k@832 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@832 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@832 $k@813))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@833 $Perm)
(assert ($Perm.isValidVar $k@833))
(assert ($Perm.isReadVar $k@833 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@833 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@833 $k@815))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@818 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 131] $t@818 != Null
(declare-const $k@834 $Perm)
(assert ($Perm.isValidVar $k@834))
(assert ($Perm.isReadVar $k@834 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@834 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@820 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@820 $Perm.No)))
(assert (< $k@834 $k@820))
(declare-const $k@835 $Perm)
(assert ($Perm.isValidVar $k@835))
(assert ($Perm.isReadVar $k@835 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@835 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@822 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@822 $Perm.No)))
(assert (< $k@835 $k@822))
(pop) ; 8
; [dead else-branch 131] $t@818 == Null
(assert ($Perm.isValidVar $k@834))
(assert ($Perm.isReadVar $k@834 $Perm.Write))
(assert (not (= $k@820 $Perm.No)))
(assert (< $k@834 $k@820))
(assert ($Perm.isValidVar $k@835))
(assert ($Perm.isReadVar $k@835 $Perm.Write))
(assert (not (= $k@822 $Perm.No)))
(assert (< $k@835 $k@822))
; [eval] old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] old(BlockingQueue__contents(diz))
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@836 $Perm)
(assert ($Perm.isValidVar $k@836))
(assert ($Perm.isReadVar $k@836 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@836 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@836 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@837 $Perm)
(assert ($Perm.isValidVar $k@837))
(assert ($Perm.isReadVar $k@837 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@837 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@837 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 132] $t@807 != Null
(declare-const $k@838 $Perm)
(assert ($Perm.isValidVar $k@838))
(assert ($Perm.isReadVar $k@838 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@838 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@838 $k@809))
(declare-const $k@839 $Perm)
(assert ($Perm.isValidVar $k@839))
(assert ($Perm.isReadVar $k@839 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@839 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@839 $k@811))
(pop) ; 8
; [dead else-branch 132] $t@807 == Null
(assert ($Perm.isValidVar $k@838))
(assert ($Perm.isReadVar $k@838 $Perm.Write))
(assert (< $k@838 $k@809))
(assert ($Perm.isValidVar $k@839))
(assert ($Perm.isReadVar $k@839 $Perm.Write))
(assert (< $k@839 $k@811))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@797)) 1))
(pop) ; 7
; [dead else-branch 130] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| == 0
(pop) ; 6
(assert ($Perm.isValidVar $k@832))
(assert ($Perm.isReadVar $k@832 $Perm.Write))
(assert (< $k@832 $k@813))
(assert ($Perm.isValidVar $k@833))
(assert ($Perm.isReadVar $k@833 $Perm.Write))
(assert (< $k@833 $k@815))
(assert ($Perm.isValidVar $k@834))
(assert ($Perm.isReadVar $k@834 $Perm.Write))
(assert (not (= $k@820 $Perm.No)))
(assert (< $k@834 $k@820))
(assert ($Perm.isValidVar $k@835))
(assert ($Perm.isReadVar $k@835 $Perm.Write))
(assert (not (= $k@822 $Perm.No)))
(assert (< $k@835 $k@822))
(assert ($Perm.isValidVar $k@836))
(assert ($Perm.isReadVar $k@836 $Perm.Write))
(assert (< $k@836 $k@802))
(assert ($Perm.isValidVar $k@837))
(assert ($Perm.isReadVar $k@837 $Perm.Write))
(assert (< $k@837 $k@804))
(assert ($Perm.isValidVar $k@838))
(assert ($Perm.isReadVar $k@838 $Perm.Write))
(assert (< $k@838 $k@809))
(assert ($Perm.isValidVar $k@839))
(assert ($Perm.isReadVar $k@839 $Perm.Write))
(assert (< $k@839 $k@811))
(assert (= ($Seq.length ($Seq.singleton val@797)) 1))
(assert (implies
  (not
    (=
      ($Seq.length
        ($BlockingQueue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine
                      ($Snap.combine
                        $Snap.unit
                        ($SortWrappers.IntTo$Snap $t@803))
                      $Snap.unit)
                    ($SortWrappers.$RefTo$Snap $t@805))
                  ($SortWrappers.IntTo$Snap $t@806))
                ($SortWrappers.$RefTo$Snap $t@807))
              $t@808)
            ($SortWrappers.$RefTo$Snap $t@810))
          ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
      0))
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@814))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@816))
              ($SortWrappers.IntTo$Snap $t@817))
            ($SortWrappers.$RefTo$Snap $t@818))
          $t@819)
        ($SortWrappers.$RefTo$Snap $t@821))
      ($SortWrappers.$RefTo$Snap $t@823)) diz@796)
    ($Seq.append
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796)
      ($Seq.singleton val@797)))))
(pop) ; 5
(push) ; 5
; [else-branch 126] $t@818 == Null
(assert (= $t@818 $Ref.null))
(declare-const $k@840 $Perm)
(assert ($Perm.isValidVar $k@840))
(assert ($Perm.isReadVar $k@840 $Perm.Write))
(declare-const $t@841 $Ref)
(declare-const $k@842 $Perm)
(assert ($Perm.isValidVar $k@842))
(assert ($Perm.isReadVar $k@842 $Perm.Write))
(declare-const $t@843 $Ref)
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@818 $Ref.null)))
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@844 $Perm)
(assert ($Perm.isValidVar $k@844))
(assert ($Perm.isReadVar $k@844 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@844 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@844 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@845 $Perm)
(assert ($Perm.isValidVar $k@845))
(assert ($Perm.isReadVar $k@845 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@845 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@845 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [dead then-branch 133] $t@807 != Null
; [dead else-branch 133] $t@807 == Null
(pop) ; 5
(pop) ; 4
(push) ; 4
; [eval] diz.BlockingQueue__first == null
(push) ; 5
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 134] $t@807 == Null
(push) ; 5
; [else-branch 134] $t@807 != Null
(pop) ; 5
; [eval] !(diz.BlockingQueue__first == null)
; [eval] diz.BlockingQueue__first == null
(push) ; 5
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 135] $t@807 != Null
; [exec]
; __flatten_36 := Node__Node(val, null)
; [eval] next != null
(push) ; 6
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 136] False
(push) ; 6
; [else-branch 136] True
(declare-const sys__result@846 $Ref)
(declare-const $t@847 $Snap)
(declare-const $t@848 $Snap)
(assert (= $t@847 ($Snap.combine $t@848 $Snap.unit)))
(declare-const $t@849 $Snap)
(assert (= $t@848 ($Snap.combine $t@849 $Snap.unit)))
(declare-const $t@850 $Snap)
(assert (= $t@849 ($Snap.combine $Snap.unit $t@850)))
; [eval] sys__result != null
(assert (not (= sys__result@846 $Ref.null)))
(push) ; 7
(assert (not (= $t@807 sys__result@846)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@851 $Snap)
(declare-const $t@852 $Snap)
(assert (= $t@850 ($Snap.combine $t@851 $t@852)))
(declare-const $t@853 Int)
(declare-const $t@854 $Ref)
(assert (=
  $t@851
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@853)
    ($SortWrappers.$RefTo$Snap $t@854))))
(declare-const $k@855 $Perm)
(assert ($Perm.isValidVar $k@855))
(assert ($Perm.isReadVar $k@855 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 7
(assert (not (= $t@854 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@854 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 137] $t@854 != Null
(assert (not (= $t@854 $Ref.null)))
(push) ; 8
(assert (not (= $t@807 $t@854)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@855 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@855 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@853 val@797))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@853 val@797)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 138] $t@853 == val@797
(assert (= $t@853 val@797))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 138] $t@853 != val@797
(assert (not (= $t@853 val@797)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 137] $t@854 == Null
(assert (= $t@854 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@855 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@855 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@853 val@797))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@853 val@797)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 139] $t@853 == val@797
(assert (= $t@853 val@797))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 139] $t@853 != val@797
(assert (not (= $t@853 val@797)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(declare-fun joinedIn@856 () Bool)
(assert (implies
  (= $t@854 $Ref.null)
  (and
    (not (= $k@855 $Perm.No))
    (= $t@854 $Ref.null)
    ($Perm.isReadVar $k@855 $Perm.Write)
    ($Perm.isValidVar $k@855)
    (=
      $t@851
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@853)
        ($SortWrappers.$RefTo$Snap $t@854)))
    (= $t@850 ($Snap.combine $t@851 $t@852)))))
(assert (implies
  (not (= $t@854 $Ref.null))
  (and
    (not (= $k@855 $Perm.No))
    (not (= $t@854 $Ref.null))
    ($Perm.isReadVar $k@855 $Perm.Write)
    ($Perm.isValidVar $k@855)
    (=
      $t@851
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@853)
        ($SortWrappers.$RefTo$Snap $t@854)))
    (= $t@850 ($Snap.combine $t@851 $t@852)))))
(assert (and
  (implies
    (= $t@854 $Ref.null)
    (= joinedIn@856 (and (= $t@853 val@797) (= $t@854 $Ref.null))))
  (implies
    (not (= $t@854 $Ref.null))
    (= joinedIn@856 (and (= $t@853 val@797) (= $t@854 $Ref.null))))))
(assert joinedIn@856)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@797)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 7
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 140] True
; [eval] Seq[Int]()
(pop) ; 7
; [dead else-branch 140] False
(declare-const $deadElse@857 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@850) sys__result@846)
  ($Seq.append ($Seq.singleton val@797) $Seq.empty<Int>)))
; [exec]
; Node__append(diz.BlockingQueue__first, __flatten_36)
; [eval] diz != null
; [eval] n != null
(declare-const $t@858 $Snap)
(declare-const $t@859 $Snap)
(assert (= $t@858 ($Snap.combine $t@859 $Snap.unit)))
; [eval] Node__contents(diz) == old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(diz)) ++ old(Node__contents(n))
; [eval] old(Node__contents(diz))
; [eval] Node__contents(diz)
; [eval] diz != null
; [eval] old(Node__contents(n))
; [eval] Node__contents(n)
; [eval] n != null
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@859) $t@807)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@808) $t@807)
    ($Node__contents ($Snap.combine $Snap.unit $t@850) sys__result@846))))
(declare-const $k@860 $Perm)
(assert ($Perm.isValidVar $k@860))
(assert ($Perm.isReadVar $k@860 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@860 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@860 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@861 $Perm)
(assert ($Perm.isValidVar $k@861))
(assert ($Perm.isReadVar $k@861 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@861 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@861 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 141] $t@807 != Null
(declare-const $k@862 $Perm)
(assert ($Perm.isValidVar $k@862))
(assert ($Perm.isReadVar $k@862 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@862 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@809 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@809 $Perm.No)))
(assert (< $k@862 $k@809))
(declare-const $k@863 $Perm)
(assert ($Perm.isValidVar $k@863))
(assert ($Perm.isReadVar $k@863 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@863 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@811 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@811 $Perm.No)))
(assert (< $k@863 $k@811))
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@864 $Perm)
(assert ($Perm.isValidVar $k@864))
(assert ($Perm.isReadVar $k@864 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@864 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@864 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@865 $Perm)
(assert ($Perm.isValidVar $k@865))
(assert ($Perm.isReadVar $k@865 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@865 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@865 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 142] $t@807 != Null
(declare-const $k@866 $Perm)
(assert ($Perm.isValidVar $k@866))
(assert ($Perm.isReadVar $k@866 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@866 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@866 $k@809))
(declare-const $k@867 $Perm)
(assert ($Perm.isValidVar $k@867))
(assert ($Perm.isReadVar $k@867 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@867 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@867 $k@811))
(pop) ; 8
; [dead else-branch 142] $t@807 == Null
(assert ($Perm.isValidVar $k@866))
(assert ($Perm.isReadVar $k@866 $Perm.Write))
(assert (< $k@866 $k@809))
(assert ($Perm.isValidVar $k@867))
(assert ($Perm.isReadVar $k@867 $Perm.Write))
(assert (< $k@867 $k@811))
(push) ; 8
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $t@808)
        ($SortWrappers.$RefTo$Snap $t@810))
      ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 143] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| == 0
(push) ; 9
; [else-branch 143] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| != 0
(assert (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0)))
(pop) ; 9
(pop) ; 8
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@868 $Perm)
(assert ($Perm.isValidVar $k@868))
(assert ($Perm.isReadVar $k@868 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@868 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@868 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@869 $Perm)
(assert ($Perm.isValidVar $k@869))
(assert ($Perm.isReadVar $k@869 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@869 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@869 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 144] $t@807 != Null
(declare-const $k@870 $Perm)
(assert ($Perm.isValidVar $k@870))
(assert ($Perm.isReadVar $k@870 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@870 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@870 $k@809))
(declare-const $k@871 $Perm)
(assert ($Perm.isValidVar $k@871))
(assert ($Perm.isReadVar $k@871 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@871 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@871 $k@811))
(pop) ; 8
; [dead else-branch 144] $t@807 == Null
(assert ($Perm.isValidVar $k@870))
(assert ($Perm.isReadVar $k@870 $Perm.Write))
(assert (< $k@870 $k@809))
(assert ($Perm.isValidVar $k@871))
(assert ($Perm.isReadVar $k@871 $Perm.Write))
(assert (< $k@871 $k@811))
(push) ; 8
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $t@808)
        ($SortWrappers.$RefTo$Snap $t@810))
      ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 145] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| != 0
(assert (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@872 $Perm)
(assert ($Perm.isValidVar $k@872))
(assert ($Perm.isReadVar $k@872 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@872 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@872 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@873 $Perm)
(assert ($Perm.isValidVar $k@873))
(assert ($Perm.isReadVar $k@873 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@873 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@873 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 146] $t@807 != Null
(declare-const $k@874 $Perm)
(assert ($Perm.isValidVar $k@874))
(assert ($Perm.isReadVar $k@874 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@874 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@874 $k@809))
(declare-const $k@875 $Perm)
(assert ($Perm.isValidVar $k@875))
(assert ($Perm.isReadVar $k@875 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@875 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@875 $k@811))
(pop) ; 10
; [dead else-branch 146] $t@807 == Null
(assert ($Perm.isValidVar $k@874))
(assert ($Perm.isReadVar $k@874 $Perm.Write))
(assert (< $k@874 $k@809))
(assert ($Perm.isValidVar $k@875))
(assert ($Perm.isReadVar $k@875 $Perm.Write))
(assert (< $k@875 $k@811))
; [eval] old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] old(BlockingQueue__contents(diz))
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@876 $Perm)
(assert ($Perm.isValidVar $k@876))
(assert ($Perm.isReadVar $k@876 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@876 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@876 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@877 $Perm)
(assert ($Perm.isValidVar $k@877))
(assert ($Perm.isReadVar $k@877 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@877 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@877 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= $t@807 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 147] $t@807 != Null
(declare-const $k@878 $Perm)
(assert ($Perm.isValidVar $k@878))
(assert ($Perm.isReadVar $k@878 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@878 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@878 $k@809))
(declare-const $k@879 $Perm)
(assert ($Perm.isValidVar $k@879))
(assert ($Perm.isReadVar $k@879 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@879 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@879 $k@811))
(pop) ; 10
; [dead else-branch 147] $t@807 == Null
(assert ($Perm.isValidVar $k@878))
(assert ($Perm.isReadVar $k@878 $Perm.Write))
(assert (< $k@878 $k@809))
(assert ($Perm.isValidVar $k@879))
(assert ($Perm.isReadVar $k@879 $Perm.Write))
(assert (< $k@879 $k@811))
; [eval] Seq(val)
(pop) ; 9
; [dead else-branch 145] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), $t@808), $t@810), $t@812))| == 0
(pop) ; 8
(assert ($Perm.isValidVar $k@872))
(assert ($Perm.isReadVar $k@872 $Perm.Write))
(assert (< $k@872 $k@802))
(assert ($Perm.isValidVar $k@873))
(assert ($Perm.isReadVar $k@873 $Perm.Write))
(assert (< $k@873 $k@804))
(assert ($Perm.isValidVar $k@874))
(assert ($Perm.isReadVar $k@874 $Perm.Write))
(assert (< $k@874 $k@809))
(assert ($Perm.isValidVar $k@875))
(assert ($Perm.isReadVar $k@875 $Perm.Write))
(assert (< $k@875 $k@811))
(assert ($Perm.isValidVar $k@876))
(assert ($Perm.isReadVar $k@876 $Perm.Write))
(assert (< $k@876 $k@802))
(assert ($Perm.isValidVar $k@877))
(assert ($Perm.isReadVar $k@877 $Perm.Write))
(assert (< $k@877 $k@804))
(assert ($Perm.isValidVar $k@878))
(assert ($Perm.isReadVar $k@878 $Perm.Write))
(assert (< $k@878 $k@809))
(assert ($Perm.isValidVar $k@879))
(assert ($Perm.isReadVar $k@879 $Perm.Write))
(assert (< $k@879 $k@811))
(push) ; 8
(assert (not (implies
  (not
    (=
      ($Seq.length
        ($BlockingQueue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine
                      ($Snap.combine
                        $Snap.unit
                        ($SortWrappers.IntTo$Snap $t@803))
                      $Snap.unit)
                    ($SortWrappers.$RefTo$Snap $t@805))
                  ($SortWrappers.IntTo$Snap $t@806))
                ($SortWrappers.$RefTo$Snap $t@807))
              $t@808)
            ($SortWrappers.$RefTo$Snap $t@810))
          ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
      0))
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $t@859)
        ($SortWrappers.$RefTo$Snap $t@810))
      ($SortWrappers.$RefTo$Snap $t@812)) diz@796)
    ($Seq.append
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796)
      ($Seq.singleton val@797))))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies
  (not
    (=
      ($Seq.length
        ($BlockingQueue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine
                      ($Snap.combine
                        $Snap.unit
                        ($SortWrappers.IntTo$Snap $t@803))
                      $Snap.unit)
                    ($SortWrappers.$RefTo$Snap $t@805))
                  ($SortWrappers.IntTo$Snap $t@806))
                ($SortWrappers.$RefTo$Snap $t@807))
              $t@808)
            ($SortWrappers.$RefTo$Snap $t@810))
          ($SortWrappers.$RefTo$Snap $t@812)) diz@796))
      0))
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $t@859)
        ($SortWrappers.$RefTo$Snap $t@810))
      ($SortWrappers.$RefTo$Snap $t@812)) diz@796)
    ($Seq.append
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $t@808)
          ($SortWrappers.$RefTo$Snap $t@810))
        ($SortWrappers.$RefTo$Snap $t@812)) diz@796)
      ($Seq.singleton val@797)))))
(pop) ; 7
; [dead else-branch 141] $t@807 == Null
(pop) ; 6
(pop) ; 5
; [dead else-branch 135] $t@807 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 125] $t@807 == Null
(assert (= $t@807 $Ref.null))
(declare-const $k@880 $Perm)
(assert ($Perm.isValidVar $k@880))
(assert ($Perm.isReadVar $k@880 $Perm.Write))
(declare-const $t@881 $Ref)
(declare-const $k@882 $Perm)
(assert ($Perm.isValidVar $k@882))
(assert ($Perm.isReadVar $k@882 $Perm.Write))
(declare-const $t@883 $Ref)
(push) ; 4
(declare-const $k@884 $Perm)
(assert ($Perm.isValidVar $k@884))
(assert ($Perm.isReadVar $k@884 $Perm.Write))
(declare-const $t@885 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@884 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@884 $Perm.No)))
(assert (> $t@885 0))
(declare-const $k@886 $Perm)
(assert ($Perm.isValidVar $k@886))
(assert ($Perm.isReadVar $k@886 $Perm.Write))
(declare-const $t@887 $Ref)
(push) ; 5
(assert (not (not (= $k@886 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@886 $Perm.No)))
(assert (not (= $t@887 $Ref.null)))
(declare-const $t@888 Int)
(declare-const $t@889 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@889 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@889 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 148] $t@889 != Null
(assert (not (= $t@889 $Ref.null)))
(declare-const $t@890 $Snap)
(declare-const $k@891 $Perm)
(assert ($Perm.isValidVar $k@891))
(assert ($Perm.isReadVar $k@891 $Perm.Write))
(declare-const $t@892 $Ref)
(declare-const $k@893 $Perm)
(assert ($Perm.isValidVar $k@893))
(assert ($Perm.isReadVar $k@893 $Perm.Write))
(declare-const $t@894 $Ref)
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@895 $Perm)
(assert ($Perm.isValidVar $k@895))
(assert ($Perm.isReadVar $k@895 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@895 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@895 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@896 $Perm)
(assert ($Perm.isValidVar $k@896))
(assert ($Perm.isReadVar $k@896 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@896 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@896 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 149] $t@807 != Null
(push) ; 6
; [else-branch 149] $t@807 == Null
(declare-const $k@897 $Perm)
(assert ($Perm.isValidVar $k@897))
(assert ($Perm.isReadVar $k@897 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@897 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@880 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@880 $Perm.No)))
(assert (< $k@897 $k@880))
(declare-const $k@898 $Perm)
(assert ($Perm.isValidVar $k@898))
(assert ($Perm.isReadVar $k@898 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@898 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@882 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@882 $Perm.No)))
(assert (< $k@898 $k@882))
(pop) ; 6
(assert ($Perm.isValidVar $k@897))
(assert ($Perm.isReadVar $k@897 $Perm.Write))
(assert (not (= $k@880 $Perm.No)))
(assert (< $k@897 $k@880))
(assert ($Perm.isValidVar $k@898))
(assert ($Perm.isReadVar $k@898 $Perm.Write))
(assert (not (= $k@882 $Perm.No)))
(assert (< $k@898 $k@882))
(push) ; 6
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 150] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0))
; [eval] BlockingQueue__contents(diz) == Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@899 $Perm)
(assert ($Perm.isValidVar $k@899))
(assert ($Perm.isReadVar $k@899 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@899 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@899 $k@884))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@900 $Perm)
(assert ($Perm.isValidVar $k@900))
(assert ($Perm.isReadVar $k@900 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@900 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@900 $k@886))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@889 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 151] $t@889 != Null
(declare-const $k@901 $Perm)
(assert ($Perm.isValidVar $k@901))
(assert ($Perm.isReadVar $k@901 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@901 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@891 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@891 $Perm.No)))
(assert (< $k@901 $k@891))
(declare-const $k@902 $Perm)
(assert ($Perm.isValidVar $k@902))
(assert ($Perm.isReadVar $k@902 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@902 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@893 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@893 $Perm.No)))
(assert (< $k@902 $k@893))
(pop) ; 8
; [dead else-branch 151] $t@889 == Null
(assert ($Perm.isValidVar $k@901))
(assert ($Perm.isReadVar $k@901 $Perm.Write))
(assert (not (= $k@891 $Perm.No)))
(assert (< $k@901 $k@891))
(assert ($Perm.isValidVar $k@902))
(assert ($Perm.isReadVar $k@902 $Perm.Write))
(assert (not (= $k@893 $Perm.No)))
(assert (< $k@902 $k@893))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@797)) 1))
(pop) ; 7
; [dead else-branch 150] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| != 0
(pop) ; 6
(assert ($Perm.isValidVar $k@899))
(assert ($Perm.isReadVar $k@899 $Perm.Write))
(assert (< $k@899 $k@884))
(assert ($Perm.isValidVar $k@900))
(assert ($Perm.isReadVar $k@900 $Perm.Write))
(assert (< $k@900 $k@886))
(assert ($Perm.isValidVar $k@901))
(assert ($Perm.isReadVar $k@901 $Perm.Write))
(assert (not (= $k@891 $Perm.No)))
(assert (< $k@901 $k@891))
(assert ($Perm.isValidVar $k@902))
(assert ($Perm.isReadVar $k@902 $Perm.Write))
(assert (not (= $k@893 $Perm.No)))
(assert (< $k@902 $k@893))
(assert (= ($Seq.length ($Seq.singleton val@797)) 1))
(assert (implies
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0)
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@885))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@887))
              ($SortWrappers.IntTo$Snap $t@888))
            ($SortWrappers.$RefTo$Snap $t@889))
          $t@890)
        ($SortWrappers.$RefTo$Snap $t@892))
      ($SortWrappers.$RefTo$Snap $t@894)) diz@796)
    ($Seq.singleton val@797))))
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@903 $Perm)
(assert ($Perm.isValidVar $k@903))
(assert ($Perm.isReadVar $k@903 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@903 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@903 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@904 $Perm)
(assert ($Perm.isValidVar $k@904))
(assert ($Perm.isReadVar $k@904 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@904 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@904 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 152] $t@807 != Null
(push) ; 6
; [else-branch 152] $t@807 == Null
(declare-const $k@905 $Perm)
(assert ($Perm.isValidVar $k@905))
(assert ($Perm.isReadVar $k@905 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@905 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@905 $k@880))
(declare-const $k@906 $Perm)
(assert ($Perm.isValidVar $k@906))
(assert ($Perm.isReadVar $k@906 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@906 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@906 $k@882))
(pop) ; 6
(assert ($Perm.isValidVar $k@905))
(assert ($Perm.isReadVar $k@905 $Perm.Write))
(assert (< $k@905 $k@880))
(assert ($Perm.isValidVar $k@906))
(assert ($Perm.isReadVar $k@906 $Perm.Write))
(assert (< $k@906 $k@882))
(push) ; 6
(push) ; 7
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 153] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| != 0
(push) ; 7
; [else-branch 153] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 148] $t@889 == Null
(assert (= $t@889 $Ref.null))
(declare-const $k@907 $Perm)
(assert ($Perm.isValidVar $k@907))
(assert ($Perm.isReadVar $k@907 $Perm.Write))
(declare-const $t@908 $Ref)
(declare-const $k@909 $Perm)
(assert ($Perm.isValidVar $k@909))
(assert ($Perm.isReadVar $k@909 $Perm.Write))
(declare-const $t@910 $Ref)
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@889 $Ref.null)))
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@911 $Perm)
(assert ($Perm.isValidVar $k@911))
(assert ($Perm.isReadVar $k@911 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@911 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@911 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@912 $Perm)
(assert ($Perm.isValidVar $k@912))
(assert ($Perm.isReadVar $k@912 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@912 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@912 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [dead then-branch 154] $t@807 != Null
; [dead else-branch 154] $t@807 == Null
(pop) ; 5
(pop) ; 4
(push) ; 4
; [eval] diz.BlockingQueue__first == null
(push) ; 5
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 155] $t@807 == Null
; [exec]
; __flatten_35 := Node__Node(val, null)
; [eval] next != null
(push) ; 6
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 156] False
(push) ; 6
; [else-branch 156] True
(declare-const sys__result@913 $Ref)
(declare-const $t@914 $Snap)
(declare-const $t@915 $Snap)
(assert (= $t@914 ($Snap.combine $t@915 $Snap.unit)))
(declare-const $t@916 $Snap)
(assert (= $t@915 ($Snap.combine $t@916 $Snap.unit)))
(declare-const $t@917 $Snap)
(assert (= $t@916 ($Snap.combine $Snap.unit $t@917)))
; [eval] sys__result != null
(assert (not (= sys__result@913 $Ref.null)))
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@918 $Snap)
(declare-const $t@919 $Snap)
(assert (= $t@917 ($Snap.combine $t@918 $t@919)))
(declare-const $t@920 Int)
(declare-const $t@921 $Ref)
(assert (=
  $t@918
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@920)
    ($SortWrappers.$RefTo$Snap $t@921))))
(declare-const $k@922 $Perm)
(assert ($Perm.isValidVar $k@922))
(assert ($Perm.isReadVar $k@922 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 7
(assert (not (= $t@921 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@921 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 157] $t@921 != Null
(assert (not (= $t@921 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@922 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@922 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@920 val@797))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@920 val@797)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 158] $t@920 == val@797
(assert (= $t@920 val@797))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 158] $t@920 != val@797
(assert (not (= $t@920 val@797)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 157] $t@921 == Null
(assert (= $t@921 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@922 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@922 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@920 val@797))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@920 val@797)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 159] $t@920 == val@797
(assert (= $t@920 val@797))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 159] $t@920 != val@797
(assert (not (= $t@920 val@797)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(declare-fun joinedIn@923 () Bool)
(assert (implies
  (= $t@921 $Ref.null)
  (and
    (not (= $k@922 $Perm.No))
    (= $t@921 $Ref.null)
    ($Perm.isReadVar $k@922 $Perm.Write)
    ($Perm.isValidVar $k@922)
    (=
      $t@918
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@920)
        ($SortWrappers.$RefTo$Snap $t@921)))
    (= $t@917 ($Snap.combine $t@918 $t@919)))))
(assert (implies
  (not (= $t@921 $Ref.null))
  (and
    (not (= $k@922 $Perm.No))
    (not (= $t@921 $Ref.null))
    ($Perm.isReadVar $k@922 $Perm.Write)
    ($Perm.isValidVar $k@922)
    (=
      $t@918
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@920)
        ($SortWrappers.$RefTo$Snap $t@921)))
    (= $t@917 ($Snap.combine $t@918 $t@919)))))
(assert (and
  (implies
    (= $t@921 $Ref.null)
    (= joinedIn@923 (and (= $t@920 val@797) (= $t@921 $Ref.null))))
  (implies
    (not (= $t@921 $Ref.null))
    (= joinedIn@923 (and (= $t@920 val@797) (= $t@921 $Ref.null))))))
(assert joinedIn@923)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@797)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 7
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 160] True
; [eval] Seq[Int]()
(pop) ; 7
; [dead else-branch 160] False
(declare-const $deadElse@924 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@917) sys__result@913)
  ($Seq.append ($Seq.singleton val@797) $Seq.empty<Int>)))
; [exec]
; __flatten_34 := __flatten_35
; [exec]
; __flatten_65 := __flatten_34
; [exec]
; diz.BlockingQueue__first := __flatten_65
(declare-const $k@925 $Perm)
(assert ($Perm.isValidVar $k@925))
(assert ($Perm.isReadVar $k@925 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@925 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@925 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@926 $Perm)
(assert ($Perm.isValidVar $k@926))
(assert ($Perm.isReadVar $k@926 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@926 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@926 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= sys__result@913 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 161] sys__result@913 != Null
(declare-const $k@927 $Perm)
(assert ($Perm.isValidVar $k@927))
(assert ($Perm.isReadVar $k@927 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@927 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@880 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@880 $Perm.No)))
(assert (< $k@927 $k@880))
(declare-const $k@928 $Perm)
(assert ($Perm.isValidVar $k@928))
(assert ($Perm.isReadVar $k@928 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@928 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@882 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@882 $Perm.No)))
(assert (< $k@928 $k@882))
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@929 $Perm)
(assert ($Perm.isValidVar $k@929))
(assert ($Perm.isReadVar $k@929 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@929 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@929 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@930 $Perm)
(assert ($Perm.isValidVar $k@930))
(assert ($Perm.isReadVar $k@930 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@930 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@930 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 162] $t@807 != Null
(push) ; 8
; [else-branch 162] $t@807 == Null
(declare-const $k@931 $Perm)
(assert ($Perm.isValidVar $k@931))
(assert ($Perm.isReadVar $k@931 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@931 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@931 $k@880))
(declare-const $k@932 $Perm)
(assert ($Perm.isValidVar $k@932))
(assert ($Perm.isReadVar $k@932 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@932 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@932 $k@882))
(pop) ; 8
(assert ($Perm.isValidVar $k@931))
(assert ($Perm.isReadVar $k@931 $Perm.Write))
(assert (< $k@931 $k@880))
(assert ($Perm.isValidVar $k@932))
(assert ($Perm.isReadVar $k@932 $Perm.Write))
(assert (< $k@932 $k@882))
(push) ; 8
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 163] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0))
; [eval] BlockingQueue__contents(diz) == Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@933 $Perm)
(assert ($Perm.isValidVar $k@933))
(assert ($Perm.isReadVar $k@933 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@933 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@933 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@934 $Perm)
(assert ($Perm.isValidVar $k@934))
(assert ($Perm.isReadVar $k@934 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@934 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@934 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 10
(assert (not (= sys__result@913 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 164] sys__result@913 != Null
(declare-const $k@935 $Perm)
(assert ($Perm.isValidVar $k@935))
(assert ($Perm.isReadVar $k@935 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@935 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@935 $k@880))
(declare-const $k@936 $Perm)
(assert ($Perm.isValidVar $k@936))
(assert ($Perm.isReadVar $k@936 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@936 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@936 $k@882))
(pop) ; 10
; [dead else-branch 164] sys__result@913 == Null
(assert ($Perm.isValidVar $k@935))
(assert ($Perm.isReadVar $k@935 $Perm.Write))
(assert (< $k@935 $k@880))
(assert ($Perm.isValidVar $k@936))
(assert ($Perm.isReadVar $k@936 $Perm.Write))
(assert (< $k@936 $k@882))
; [eval] Seq(val)
(pop) ; 9
; [dead else-branch 163] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| != 0
(pop) ; 8
(assert ($Perm.isValidVar $k@933))
(assert ($Perm.isReadVar $k@933 $Perm.Write))
(assert (< $k@933 $k@802))
(assert ($Perm.isValidVar $k@934))
(assert ($Perm.isReadVar $k@934 $Perm.Write))
(assert (< $k@934 $k@804))
(assert ($Perm.isValidVar $k@935))
(assert ($Perm.isReadVar $k@935 $Perm.Write))
(assert (< $k@935 $k@880))
(assert ($Perm.isValidVar $k@936))
(assert ($Perm.isReadVar $k@936 $Perm.Write))
(assert (< $k@936 $k@882))
(push) ; 8
(assert (not (implies
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0)
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap sys__result@913))
          $t@917)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796)
    ($Seq.singleton val@797)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0)
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap sys__result@913))
          $t@917)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796)
    ($Seq.singleton val@797))))
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@937 $Perm)
(assert ($Perm.isValidVar $k@937))
(assert ($Perm.isReadVar $k@937 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@937 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@937 $k@802))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@938 $Perm)
(assert ($Perm.isValidVar $k@938))
(assert ($Perm.isReadVar $k@938 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@938 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@938 $k@804))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 165] $t@807 != Null
(push) ; 8
; [else-branch 165] $t@807 == Null
(declare-const $k@939 $Perm)
(assert ($Perm.isValidVar $k@939))
(assert ($Perm.isReadVar $k@939 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@939 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@939 $k@880))
(declare-const $k@940 $Perm)
(assert ($Perm.isValidVar $k@940))
(assert ($Perm.isReadVar $k@940 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@940 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@940 $k@882))
(pop) ; 8
(assert ($Perm.isValidVar $k@939))
(assert ($Perm.isReadVar $k@939 $Perm.Write))
(assert (< $k@939 $k@880))
(assert ($Perm.isValidVar $k@940))
(assert ($Perm.isReadVar $k@940 $Perm.Write))
(assert (< $k@940 $k@882))
(push) ; 8
(push) ; 9
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@805))
                ($SortWrappers.IntTo$Snap $t@806))
              ($SortWrappers.$RefTo$Snap $t@807))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@881))
        ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 166] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| != 0
(push) ; 9
; [else-branch 166] |BlockingQueue__contents(diz@796;((((((((_, $t@803), _), $t@805), $t@806), $t@807), _), $t@881), $t@883))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@803))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@805))
              ($SortWrappers.IntTo$Snap $t@806))
            ($SortWrappers.$RefTo$Snap $t@807))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@881))
      ($SortWrappers.$RefTo$Snap $t@883)) diz@796))
  0))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 161] sys__result@913 == Null
(pop) ; 6
(pop) ; 5
; [dead else-branch 155] $t@807 != Null
; [eval] !(diz.BlockingQueue__first == null)
; [eval] diz.BlockingQueue__first == null
(push) ; 5
(assert (not (not (= $t@807 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 167] $t@807 != Null
(push) ; 5
; [else-branch 167] $t@807 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
