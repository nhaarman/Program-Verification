(get-info :version)
; (:version "4.3.2")
; Input file is <unknown>
; Started: 2015-07-01 16:08:46
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
(declare-const __flatten_75@39 Int)
(declare-const __flatten_76@40 Int)
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
; __flatten_75 := __flatten_1
; [exec]
; diz.AtomicInteger__val := __flatten_75
; [exec]
; __flatten_2 := diz.AtomicInteger__val
; [exec]
; __flatten_76 := __flatten_2
; [exec]
; diz.AtomicInteger__ghostVal := __flatten_76
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
(declare-const __flatten_77@60 Int)
(declare-const __flatten_78@61 Int)
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
; __flatten_77 := __flatten_4
; [exec]
; diz.AtomicInteger__val := __flatten_77
; [exec]
; __flatten_5 := diz.AtomicInteger__val
; [exec]
; __flatten_78 := __flatten_5
; [exec]
; diz.AtomicInteger__ghostVal := __flatten_78
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
(declare-const __flatten_79@73 Int)
(declare-const __flatten_80@74 Int)
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
; __flatten_79 := __flatten_7
; [exec]
; diz.AtomicInteger__val := __flatten_79
; [exec]
; __flatten_8 := diz.AtomicInteger__val
; [exec]
; __flatten_80 := __flatten_8
; [exec]
; diz.AtomicInteger__ghostVal := __flatten_80
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
(declare-const __flatten_81@86 Int)
(declare-const __flatten_82@87 $Ref)
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
  (not (= __flatten_82@87 diz@97))
  (not (= Node__next@98 diz@97))))
; [exec]
; __flatten_10 := val
; [exec]
; __flatten_81 := __flatten_10
; [exec]
; diz.Node__val := __flatten_81
; [exec]
; __flatten_11 := next
; [exec]
; __flatten_82 := __flatten_11
; [exec]
; diz.Node__next := __flatten_82
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
  (not (= __flatten_82@87 diz@115))
  (not (= Node__next@116 diz@115))))
; [exec]
; __flatten_10 := val
; [exec]
; __flatten_81 := __flatten_10
; [exec]
; diz.Node__val := __flatten_81
; [exec]
; __flatten_11 := next
; [exec]
; __flatten_82 := __flatten_11
; [exec]
; diz.Node__next := __flatten_82
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
(declare-const __flatten_83@128 $Ref)
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
; __flatten_83 := __flatten_12
; [exec]
; diz.Node__next := __flatten_83
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
(declare-const __flatten_86@154 $Ref)
(declare-const __flatten_88@155 $Ref)
(declare-const __flatten_89@156 Int)
(declare-const __flatten_91@157 $Ref)
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
  (not (= __flatten_86@154 diz@173))
  (not (= __flatten_88@155 diz@173))
  (not (= __flatten_91@157 diz@173))
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
; __flatten_86 := __flatten_14
; [exec]
; diz.BlockingQueue__putLock := __flatten_86
; [exec]
; __flatten_17 := Lock__Lock()
(declare-const sys__result@180 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@180 $Ref.null)))
; [exec]
; __flatten_16 := __flatten_17
; [exec]
; __flatten_88 := __flatten_16
; [exec]
; diz.BlockingQueue__takeLock := __flatten_88
; [exec]
; __flatten_18 := capacity
; [exec]
; __flatten_89 := __flatten_18
; [exec]
; diz.BlockingQueue__capacity := __flatten_89
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
; __flatten_91 := __flatten_19
; [exec]
; diz.BlockingQueue__count := __flatten_91
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
(declare-const __flatten_92@196 $Ref)
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
; __flatten_92 := __flatten_22
; [exec]
; diz.BlockingQueue__first := __flatten_92
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
; __flatten_92 := __flatten_22
; [exec]
; diz.BlockingQueue__first := __flatten_92
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
(declare-const __flatten_102@801 $Ref)
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
; __flatten_102 := __flatten_34
; [exec]
; diz.BlockingQueue__first := __flatten_102
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
; ---------- BlockingQueue__offer ----------
(declare-const diz@941 $Ref)
(declare-const val@942 Int)
(declare-const sys__result@943 Bool)
(declare-const currentCount@944 Int)
(declare-const __flatten_38@945 Int)
(declare-const __flatten_39@946 Bool)
(declare-const c@947 Int)
(declare-const __flatten_40@948 Int)
(declare-const __flatten_42@949 Int)
(declare-const __flatten_43@950 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@941 $Ref.null)))
(declare-const $k@951 $Perm)
(assert ($Perm.isValidVar $k@951))
(assert ($Perm.isReadVar $k@951 $Perm.Write))
(declare-const $t@952 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@951 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@951 $Perm.No)))
(assert (> $t@952 0))
(declare-const $k@953 $Perm)
(assert ($Perm.isValidVar $k@953))
(assert ($Perm.isReadVar $k@953 $Perm.Write))
(declare-const $t@954 $Ref)
(push) ; 3
(assert (not (not (= $k@953 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@953 $Perm.No)))
(assert (not (= $t@954 $Ref.null)))
(declare-const $t@955 Int)
(declare-const $t@956 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 168] $t@956 != Null
(assert (not (= $t@956 $Ref.null)))
(declare-const $t@957 $Snap)
(declare-const $k@958 $Perm)
(assert ($Perm.isValidVar $k@958))
(assert ($Perm.isReadVar $k@958 $Perm.Write))
(declare-const $t@959 $Ref)
(declare-const $k@960 $Perm)
(assert ($Perm.isValidVar $k@960))
(assert ($Perm.isReadVar $k@960 $Perm.Write))
(declare-const $t@961 $Ref)
(push) ; 4
(declare-const $k@962 $Perm)
(assert ($Perm.isValidVar $k@962))
(assert ($Perm.isReadVar $k@962 $Perm.Write))
(declare-const $t@963 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@962 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@962 $Perm.No)))
(assert (> $t@963 0))
(declare-const $k@964 $Perm)
(assert ($Perm.isValidVar $k@964))
(assert ($Perm.isReadVar $k@964 $Perm.Write))
(declare-const $t@965 $Ref)
(push) ; 5
(assert (not (not (= $k@964 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@964 $Perm.No)))
(assert (not (= $t@965 $Ref.null)))
(declare-const $t@966 Int)
(declare-const $t@967 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@967 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@967 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 169] $t@967 != Null
(assert (not (= $t@967 $Ref.null)))
(declare-const $t@968 $Snap)
(declare-const $k@969 $Perm)
(assert ($Perm.isValidVar $k@969))
(assert ($Perm.isReadVar $k@969 $Perm.Write))
(declare-const $t@970 $Ref)
(declare-const $k@971 $Perm)
(assert ($Perm.isValidVar $k@971))
(assert ($Perm.isReadVar $k@971 $Perm.Write))
(declare-const $t@972 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 169] $t@967 == Null
(assert (= $t@967 $Ref.null))
(declare-const $k@973 $Perm)
(assert ($Perm.isValidVar $k@973))
(assert ($Perm.isReadVar $k@973 $Perm.Write))
(declare-const $t@974 $Ref)
(declare-const $k@975 $Perm)
(assert ($Perm.isValidVar $k@975))
(assert ($Perm.isReadVar $k@975 $Perm.Write))
(declare-const $t@976 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_38 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@977 Int)
(declare-const $t@978 $Snap)
(declare-const $t@979 Int)
(assert (= $t@978 ($Snap.combine ($SortWrappers.IntTo$Snap $t@979) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@977 $t@979))
; [exec]
; currentCount := __flatten_38
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (= sys__result@977 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= sys__result@977 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 170] sys__result@977 == $t@952
(assert (= sys__result@977 $t@952))
; [exec]
; __flatten_39 := false
; [exec]
; sys__result := __flatten_39
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@980 $Perm)
(assert ($Perm.isValidVar $k@980))
(assert ($Perm.isReadVar $k@980 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@980 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@980 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@981 $Perm)
(assert ($Perm.isValidVar $k@981))
(assert ($Perm.isReadVar $k@981 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@981 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@981 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 171] $t@956 != Null
(declare-const $k@982 $Perm)
(assert ($Perm.isValidVar $k@982))
(assert ($Perm.isReadVar $k@982 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@982 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@958 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@958 $Perm.No)))
(assert (< $k@982 $k@958))
(declare-const $k@983 $Perm)
(assert ($Perm.isValidVar $k@983))
(assert ($Perm.isReadVar $k@983 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@983 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@960 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@960 $Perm.No)))
(assert (< $k@983 $k@960))
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 171] $t@956 == Null
(pop) ; 5
(push) ; 5
; [else-branch 170] sys__result@977 != $t@952
(assert (not (= sys__result@977 $t@952)))
(pop) ; 5
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (= sys__result@977 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= sys__result@977 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 172] sys__result@977 != $t@952
(assert (not (= sys__result@977 $t@952)))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 6
(assert (not (not (= $k@958 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@958 $Perm.No)))
(declare-const $t@984 $Snap)
; [exec]
; c := -1
; [eval] -1
; [exec]
; __flatten_40 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@985 Int)
(declare-const $t@986 $Snap)
(declare-const $t@987 Int)
(assert (= $t@986 ($Snap.combine ($SortWrappers.IntTo$Snap $t@987) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@985 $t@987))
; [exec]
; currentCount := __flatten_40
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (< sys__result@985 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (< sys__result@985 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 173] sys__result@985 < $t@952
(assert (< sys__result@985 $t@952))
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@988 $Perm)
(assert ($Perm.isValidVar $k@988))
(assert ($Perm.isReadVar $k@988 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@988 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@988 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@989 $Perm)
(assert ($Perm.isValidVar $k@989))
(assert ($Perm.isReadVar $k@989 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@989 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@989 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 174] $t@956 != Null
(declare-const $k@990 $Perm)
(assert ($Perm.isValidVar $k@990))
(assert ($Perm.isReadVar $k@990 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@990 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@990 $k@958))
(declare-const $k@991 $Perm)
(assert ($Perm.isValidVar $k@991))
(assert ($Perm.isReadVar $k@991 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@991 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@960 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@960 $Perm.No)))
(assert (< $k@991 $k@960))
(declare-const $t@992 $Snap)
(declare-const $t@993 $Snap)
(assert (= $t@992 ($Snap.combine $t@993 $Snap.unit)))
(declare-const $t@994 $Snap)
(assert (= $t@993 ($Snap.combine $t@994 $Snap.unit)))
(declare-const $t@995 $Snap)
(assert (= $t@994 ($Snap.combine $t@995 $Snap.unit)))
(declare-const $t@996 $Snap)
(declare-const $t@997 $Ref)
(assert (= $t@995 ($Snap.combine $t@996 ($SortWrappers.$RefTo$Snap $t@997))))
(declare-const $t@998 $Snap)
(declare-const $t@999 $Ref)
(assert (= $t@996 ($Snap.combine $t@998 ($SortWrappers.$RefTo$Snap $t@999))))
(declare-const $t@1000 $Snap)
(declare-const $t@1001 $Snap)
(assert (= $t@998 ($Snap.combine $t@1000 $t@1001)))
(declare-const $t@1002 $Snap)
(declare-const $t@1003 $Ref)
(assert (= $t@1000 ($Snap.combine $t@1002 ($SortWrappers.$RefTo$Snap $t@1003))))
(declare-const $t@1004 $Snap)
(declare-const $t@1005 Int)
(assert (= $t@1002 ($Snap.combine $t@1004 ($SortWrappers.IntTo$Snap $t@1005))))
(declare-const $t@1006 Int)
(declare-const $t@1007 $Ref)
(assert (=
  $t@1004
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1006)
    ($SortWrappers.$RefTo$Snap $t@1007))))
(declare-const $t@1008 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1006)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1008) $Snap.unit)))
(declare-const $k@1009 $Perm)
(assert ($Perm.isValidVar $k@1009))
(assert ($Perm.isReadVar $k@1009 $Perm.Write))
(assert (implies (< $Perm.No (- $k@951 $k@988)) (= $t@1008 $t@952)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- $k@951 $k@988) $k@1009) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@951 $k@988) $k@1009) $Perm.No)))
(assert (> $t@1008 0))
(declare-const $k@1010 $Perm)
(assert ($Perm.isValidVar $k@1010))
(assert ($Perm.isReadVar $k@1010 $Perm.Write))
(assert (implies (< $Perm.No (- $k@953 $k@989)) (= $t@1007 $t@954)))
(push) ; 8
(assert (not (not (= (+ (- $k@953 $k@989) $k@1010) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@953 $k@989) $k@1010) $Perm.No)))
(assert (not (= $t@1007 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1003 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1003 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 175] $t@1003 != Null
(assert (not (= $t@1003 $Ref.null)))
(declare-const $k@1011 $Perm)
(assert ($Perm.isValidVar $k@1011))
(assert ($Perm.isReadVar $k@1011 $Perm.Write))
(assert (implies (< $Perm.No (- $k@958 $k@990)) (= $t@999 $t@959)))
(declare-const $k@1012 $Perm)
(assert ($Perm.isValidVar $k@1012))
(assert ($Perm.isReadVar $k@1012 $Perm.Write))
(assert (implies (< $Perm.No (- $k@960 $k@991)) (= $t@997 $t@961)))
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1013 $Perm)
(assert ($Perm.isValidVar $k@1013))
(assert ($Perm.isReadVar $k@1013 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1013 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1013 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1014 $Perm)
(assert ($Perm.isValidVar $k@1014))
(assert ($Perm.isReadVar $k@1014 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1014 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1014 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 176] $t@956 != Null
(declare-const $k@1015 $Perm)
(assert ($Perm.isValidVar $k@1015))
(assert ($Perm.isReadVar $k@1015 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1015 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1015 $k@958))
(declare-const $k@1016 $Perm)
(assert ($Perm.isValidVar $k@1016))
(assert ($Perm.isReadVar $k@1016 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1016 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1016 $k@960))
(pop) ; 9
; [dead else-branch 176] $t@956 == Null
(assert ($Perm.isValidVar $k@1015))
(assert ($Perm.isReadVar $k@1015 $Perm.Write))
(assert (< $k@1015 $k@958))
(assert ($Perm.isValidVar $k@1016))
(assert ($Perm.isReadVar $k@1016 $Perm.Write))
(assert (< $k@1016 $k@960))
(push) ; 9
(push) ; 10
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@987))
              ($SortWrappers.$RefTo$Snap $t@956))
            $t@957)
          ($SortWrappers.$RefTo$Snap $t@959))
        ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@954))
              ($SortWrappers.IntTo$Snap $t@987))
            ($SortWrappers.$RefTo$Snap $t@956))
          $t@957)
        ($SortWrappers.$RefTo$Snap $t@959))
      ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
; [dead then-branch 177] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@987), $t@956), $t@957), $t@959), $t@961))| == 0
(push) ; 10
; [else-branch 177] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@987), $t@956), $t@957), $t@959), $t@961))| != 0
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@987))
              ($SortWrappers.$RefTo$Snap $t@956))
            $t@957)
          ($SortWrappers.$RefTo$Snap $t@959))
        ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
    0)))
(pop) ; 10
(pop) ; 9
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1017 $Perm)
(assert ($Perm.isValidVar $k@1017))
(assert ($Perm.isReadVar $k@1017 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1017 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1017 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1018 $Perm)
(assert ($Perm.isValidVar $k@1018))
(assert ($Perm.isReadVar $k@1018 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1018 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1018 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 178] $t@956 != Null
(declare-const $k@1019 $Perm)
(assert ($Perm.isValidVar $k@1019))
(assert ($Perm.isReadVar $k@1019 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1019 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1019 $k@958))
(declare-const $k@1020 $Perm)
(assert ($Perm.isValidVar $k@1020))
(assert ($Perm.isReadVar $k@1020 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1020 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1020 $k@960))
(pop) ; 9
; [dead else-branch 178] $t@956 == Null
(assert ($Perm.isValidVar $k@1019))
(assert ($Perm.isReadVar $k@1019 $Perm.Write))
(assert (< $k@1019 $k@958))
(assert ($Perm.isValidVar $k@1020))
(assert ($Perm.isReadVar $k@1020 $Perm.Write))
(assert (< $k@1020 $k@960))
(push) ; 9
(push) ; 10
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@954))
              ($SortWrappers.IntTo$Snap $t@987))
            ($SortWrappers.$RefTo$Snap $t@956))
          $t@957)
        ($SortWrappers.$RefTo$Snap $t@959))
      ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@987))
              ($SortWrappers.$RefTo$Snap $t@956))
            $t@957)
          ($SortWrappers.$RefTo$Snap $t@959))
        ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 179] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@987), $t@956), $t@957), $t@959), $t@961))| != 0
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@987))
              ($SortWrappers.$RefTo$Snap $t@956))
            $t@957)
          ($SortWrappers.$RefTo$Snap $t@959))
        ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1021 $Perm)
(assert ($Perm.isValidVar $k@1021))
(assert ($Perm.isReadVar $k@1021 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1021 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1021 (+ (- $k@951 $k@988) $k@1009)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1022 $Perm)
(assert ($Perm.isValidVar $k@1022))
(assert ($Perm.isReadVar $k@1022 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1022 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1022 (+ (- $k@953 $k@989) $k@1010)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1003 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 180] $t@1003 != Null
(declare-const $k@1023 $Perm)
(assert ($Perm.isValidVar $k@1023))
(assert ($Perm.isReadVar $k@1023 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1023 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(push) ; 12
(assert (not (not (= (+ (- $k@958 $k@990) $k@1011) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (not (= (+ (- $k@958 $k@990) $k@1011) $Perm.No)))
(assert (< $k@1023 (+ (- $k@958 $k@990) $k@1011)))
(declare-const $k@1024 $Perm)
(assert ($Perm.isValidVar $k@1024))
(assert ($Perm.isReadVar $k@1024 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1024 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(push) ; 12
(assert (not (not (= (+ (- $k@960 $k@991) $k@1012) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (not (= (+ (- $k@960 $k@991) $k@1012) $Perm.No)))
(assert (< $k@1024 (+ (- $k@960 $k@991) $k@1012)))
(pop) ; 11
; [dead else-branch 180] $t@1003 == Null
(assert ($Perm.isValidVar $k@1023))
(assert ($Perm.isReadVar $k@1023 $Perm.Write))
(assert (not (= (+ (- $k@958 $k@990) $k@1011) $Perm.No)))
(assert (< $k@1023 (+ (- $k@958 $k@990) $k@1011)))
(assert ($Perm.isValidVar $k@1024))
(assert ($Perm.isReadVar $k@1024 $Perm.Write))
(assert (not (= (+ (- $k@960 $k@991) $k@1012) $Perm.No)))
(assert (< $k@1024 (+ (- $k@960 $k@991) $k@1012)))
; [eval] old(BlockingQueue__contents(diz)) ++ Seq(val)
; [eval] old(BlockingQueue__contents(diz))
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1025 $Perm)
(assert ($Perm.isValidVar $k@1025))
(assert ($Perm.isReadVar $k@1025 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1025 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1025 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1026 $Perm)
(assert ($Perm.isValidVar $k@1026))
(assert ($Perm.isReadVar $k@1026 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1026 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1026 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 181] $t@956 != Null
(declare-const $k@1027 $Perm)
(assert ($Perm.isValidVar $k@1027))
(assert ($Perm.isReadVar $k@1027 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1027 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1027 $k@958))
(declare-const $k@1028 $Perm)
(assert ($Perm.isValidVar $k@1028))
(assert ($Perm.isReadVar $k@1028 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1028 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1028 $k@960))
(pop) ; 11
; [dead else-branch 181] $t@956 == Null
(assert ($Perm.isValidVar $k@1027))
(assert ($Perm.isReadVar $k@1027 $Perm.Write))
(assert (< $k@1027 $k@958))
(assert ($Perm.isValidVar $k@1028))
(assert ($Perm.isReadVar $k@1028 $Perm.Write))
(assert (< $k@1028 $k@960))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@942)) 1))
(pop) ; 10
; [dead else-branch 179] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@987), $t@956), $t@957), $t@959), $t@961))| == 0
(pop) ; 9
(assert ($Perm.isValidVar $k@1021))
(assert ($Perm.isReadVar $k@1021 $Perm.Write))
(assert (< $k@1021 (+ (- $k@951 $k@988) $k@1009)))
(assert ($Perm.isValidVar $k@1022))
(assert ($Perm.isReadVar $k@1022 $Perm.Write))
(assert (< $k@1022 (+ (- $k@953 $k@989) $k@1010)))
(assert ($Perm.isValidVar $k@1023))
(assert ($Perm.isReadVar $k@1023 $Perm.Write))
(assert (not (= (+ (- $k@958 $k@990) $k@1011) $Perm.No)))
(assert (< $k@1023 (+ (- $k@958 $k@990) $k@1011)))
(assert ($Perm.isValidVar $k@1024))
(assert ($Perm.isReadVar $k@1024 $Perm.Write))
(assert (not (= (+ (- $k@960 $k@991) $k@1012) $Perm.No)))
(assert (< $k@1024 (+ (- $k@960 $k@991) $k@1012)))
(assert ($Perm.isValidVar $k@1025))
(assert ($Perm.isReadVar $k@1025 $Perm.Write))
(assert (< $k@1025 $k@951))
(assert ($Perm.isValidVar $k@1026))
(assert ($Perm.isReadVar $k@1026 $Perm.Write))
(assert (< $k@1026 $k@953))
(assert ($Perm.isValidVar $k@1027))
(assert ($Perm.isReadVar $k@1027 $Perm.Write))
(assert (< $k@1027 $k@958))
(assert ($Perm.isValidVar $k@1028))
(assert ($Perm.isReadVar $k@1028 $Perm.Write))
(assert (< $k@1028 $k@960))
(assert (= ($Seq.length ($Seq.singleton val@942)) 1))
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
                        ($SortWrappers.IntTo$Snap $t@952))
                      $Snap.unit)
                    ($SortWrappers.$RefTo$Snap $t@954))
                  ($SortWrappers.IntTo$Snap $t@987))
                ($SortWrappers.$RefTo$Snap $t@956))
              $t@957)
            ($SortWrappers.$RefTo$Snap $t@959))
          ($SortWrappers.$RefTo$Snap $t@961)) diz@941))
      0))
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1008))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@1007))
              ($SortWrappers.IntTo$Snap $t@1005))
            ($SortWrappers.$RefTo$Snap $t@1003))
          $t@1001)
        ($SortWrappers.$RefTo$Snap $t@999))
      ($SortWrappers.$RefTo$Snap $t@997)) diz@941)
    ($Seq.append
      ($BlockingQueue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@987))
              ($SortWrappers.$RefTo$Snap $t@956))
            $t@957)
          ($SortWrappers.$RefTo$Snap $t@959))
        ($SortWrappers.$RefTo$Snap $t@961)) diz@941)
      ($Seq.singleton val@942)))))
; [exec]
; __flatten_42 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1029 Int)
(declare-const $t@1030 $Snap)
(declare-const $t@1031 Int)
(assert (= $t@1030 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1031) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal - 1
; [eval] diz.AtomicInteger__ghostVal - 1
(assert (= sys__result@1029 (- $t@1031 1)))
; [exec]
; c := __flatten_42
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 9
(assert (not (not (< (+ sys__result@1029 1) $t@1008))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (< (+ sys__result@1029 1) $t@1008)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 182] sys__result@1029 + 1 < $t@1008
(assert (< (+ sys__result@1029 1) $t@1008))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 10
(assert (not (= $t@959 $t@999)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 10
(assert (not (= $t@959 $t@999)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == 0
(push) ; 10
(assert (not (not (= sys__result@1029 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1029 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 183] sys__result@1029 == 0
(assert (= sys__result@1029 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@1032 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1033 $Perm)
(assert ($Perm.isValidVar $k@1033))
(assert ($Perm.isReadVar $k@1033 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1033 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1033 (+ (- $k@951 $k@988) $k@1009)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1034 $Perm)
(assert ($Perm.isValidVar $k@1034))
(assert ($Perm.isReadVar $k@1034 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1034 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1034 (+ (- $k@953 $k@989) $k@1010)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1003 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 184] $t@1003 != Null
(declare-const $k@1035 $Perm)
(assert ($Perm.isValidVar $k@1035))
(assert ($Perm.isReadVar $k@1035 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1035 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1035 (+ (- $k@958 $k@990) $k@1011)))
(declare-const $k@1036 $Perm)
(assert ($Perm.isValidVar $k@1036))
(assert ($Perm.isReadVar $k@1036 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1036 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1036 (+ (- $k@960 $k@991) $k@1012)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 184] $t@1003 == Null
(pop) ; 10
(push) ; 10
; [else-branch 183] sys__result@1029 != 0
(assert (not (= sys__result@1029 0)))
(pop) ; 10
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 10
(assert (not (= sys__result@1029 0)))
(check-sat)
; unknown
; 0.01s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1029 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 185] sys__result@1029 != 0
(assert (not (= sys__result@1029 0)))
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1037 $Perm)
(assert ($Perm.isValidVar $k@1037))
(assert ($Perm.isReadVar $k@1037 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1037 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1037 (+ (- $k@951 $k@988) $k@1009)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1038 $Perm)
(assert ($Perm.isValidVar $k@1038))
(assert ($Perm.isReadVar $k@1038 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1038 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1038 (+ (- $k@953 $k@989) $k@1010)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1003 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 186] $t@1003 != Null
(declare-const $k@1039 $Perm)
(assert ($Perm.isValidVar $k@1039))
(assert ($Perm.isReadVar $k@1039 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1039 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1039 (+ (- $k@958 $k@990) $k@1011)))
(declare-const $k@1040 $Perm)
(assert ($Perm.isValidVar $k@1040))
(assert ($Perm.isReadVar $k@1040 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1040 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1040 (+ (- $k@960 $k@991) $k@1012)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 186] $t@1003 == Null
(pop) ; 10
(push) ; 10
; [else-branch 185] sys__result@1029 == 0
(assert (= sys__result@1029 0))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 182] !sys__result@1029 + 1 < $t@1008
(assert (not (< (+ sys__result@1029 1) $t@1008)))
(pop) ; 9
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 9
(assert (not (< (+ sys__result@1029 1) $t@1008)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (< (+ sys__result@1029 1) $t@1008))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 187] !sys__result@1029 + 1 < $t@1008
(assert (not (< (+ sys__result@1029 1) $t@1008)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 10
(assert (not (= $t@959 $t@999)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == 0
(push) ; 10
(assert (not (not (= sys__result@1029 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1029 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 188] sys__result@1029 == 0
(assert (= sys__result@1029 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@1041 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1042 $Perm)
(assert ($Perm.isValidVar $k@1042))
(assert ($Perm.isReadVar $k@1042 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1042 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1042 (+ (- $k@951 $k@988) $k@1009)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1043 $Perm)
(assert ($Perm.isValidVar $k@1043))
(assert ($Perm.isReadVar $k@1043 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1043 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1043 (+ (- $k@953 $k@989) $k@1010)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1003 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 189] $t@1003 != Null
(declare-const $k@1044 $Perm)
(assert ($Perm.isValidVar $k@1044))
(assert ($Perm.isReadVar $k@1044 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1044 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1044 (+ (- $k@958 $k@990) $k@1011)))
(declare-const $k@1045 $Perm)
(assert ($Perm.isValidVar $k@1045))
(assert ($Perm.isReadVar $k@1045 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1045 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1045 (+ (- $k@960 $k@991) $k@1012)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 189] $t@1003 == Null
(pop) ; 10
(push) ; 10
; [else-branch 188] sys__result@1029 != 0
(assert (not (= sys__result@1029 0)))
(pop) ; 10
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 10
(assert (not (= sys__result@1029 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1029 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 190] sys__result@1029 != 0
(assert (not (= sys__result@1029 0)))
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1046 $Perm)
(assert ($Perm.isValidVar $k@1046))
(assert ($Perm.isReadVar $k@1046 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1046 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1046 (+ (- $k@951 $k@988) $k@1009)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1047 $Perm)
(assert ($Perm.isValidVar $k@1047))
(assert ($Perm.isReadVar $k@1047 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1047 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1047 (+ (- $k@953 $k@989) $k@1010)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1003 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 191] $t@1003 != Null
(declare-const $k@1048 $Perm)
(assert ($Perm.isValidVar $k@1048))
(assert ($Perm.isReadVar $k@1048 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1048 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1048 (+ (- $k@958 $k@990) $k@1011)))
(declare-const $k@1049 $Perm)
(assert ($Perm.isValidVar $k@1049))
(assert ($Perm.isReadVar $k@1049 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1049 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1049 (+ (- $k@960 $k@991) $k@1012)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 191] $t@1003 == Null
(pop) ; 10
(push) ; 10
; [else-branch 190] sys__result@1029 == 0
(assert (= sys__result@1029 0))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 187] sys__result@1029 + 1 < $t@1008
(assert (< (+ sys__result@1029 1) $t@1008))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 175] $t@1003 == Null
(assert (= $t@1003 $Ref.null))
(declare-const $k@1050 $Perm)
(assert ($Perm.isValidVar $k@1050))
(assert ($Perm.isReadVar $k@1050 $Perm.Write))
(assert (implies (< $Perm.No (- $k@958 $k@990)) (= $t@999 $t@959)))
(declare-const $k@1051 $Perm)
(assert ($Perm.isValidVar $k@1051))
(assert ($Perm.isReadVar $k@1051 $Perm.Write))
(assert (implies (< $Perm.No (- $k@960 $k@991)) (= $t@997 $t@961)))
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@1003 $Ref.null)))
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1052 $Perm)
(assert ($Perm.isValidVar $k@1052))
(assert ($Perm.isReadVar $k@1052 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1052 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1052 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1053 $Perm)
(assert ($Perm.isValidVar $k@1053))
(assert ($Perm.isReadVar $k@1053 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1053 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1053 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [dead then-branch 192] $t@956 != Null
; [dead else-branch 192] $t@956 == Null
(pop) ; 8
(pop) ; 7
; [dead else-branch 174] $t@956 == Null
(pop) ; 6
(push) ; 6
; [else-branch 173] !sys__result@985 < $t@952
(assert (not (< sys__result@985 $t@952)))
(pop) ; 6
; [eval] !(currentCount < diz.BlockingQueue__capacity)
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 6
(assert (not (< sys__result@985 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (< sys__result@985 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 193] !sys__result@985 < $t@952
(assert (not (< sys__result@985 $t@952)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [eval] c == 0
(push) ; 7
(assert (not (not (= (- 0 1) 0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= (- 0 1) 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 194] -1 == 0
(push) ; 7
; [else-branch 194] -1 != 0
(assert (not (= (- 0 1) 0)))
(pop) ; 7
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 7
(assert (not (= (- 0 1) 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- 0 1) 0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 195] -1 != 0
(assert (not (= (- 0 1) 0)))
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1054 $Perm)
(assert ($Perm.isValidVar $k@1054))
(assert ($Perm.isReadVar $k@1054 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1054 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1054 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1055 $Perm)
(assert ($Perm.isValidVar $k@1055))
(assert ($Perm.isReadVar $k@1055 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1055 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1055 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@956 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 196] $t@956 != Null
(declare-const $k@1056 $Perm)
(assert ($Perm.isValidVar $k@1056))
(assert ($Perm.isReadVar $k@1056 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1056 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1056 $k@958))
(declare-const $k@1057 $Perm)
(assert ($Perm.isValidVar $k@1057))
(assert ($Perm.isReadVar $k@1057 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1057 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@960 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@960 $Perm.No)))
(assert (< $k@1057 $k@960))
; [exec]
; inhale false
(pop) ; 8
; [dead else-branch 196] $t@956 == Null
(pop) ; 7
; [dead else-branch 195] -1 == 0
(pop) ; 6
(push) ; 6
; [else-branch 193] sys__result@985 < $t@952
(assert (< sys__result@985 $t@952))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 172] sys__result@977 == $t@952
(assert (= sys__result@977 $t@952))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 168] $t@956 == Null
(assert (= $t@956 $Ref.null))
(declare-const $k@1058 $Perm)
(assert ($Perm.isValidVar $k@1058))
(assert ($Perm.isReadVar $k@1058 $Perm.Write))
(declare-const $t@1059 $Ref)
(declare-const $k@1060 $Perm)
(assert ($Perm.isValidVar $k@1060))
(assert ($Perm.isReadVar $k@1060 $Perm.Write))
(declare-const $t@1061 $Ref)
(push) ; 4
(declare-const $k@1062 $Perm)
(assert ($Perm.isValidVar $k@1062))
(assert ($Perm.isReadVar $k@1062 $Perm.Write))
(declare-const $t@1063 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1062 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1062 $Perm.No)))
(assert (> $t@1063 0))
(declare-const $k@1064 $Perm)
(assert ($Perm.isValidVar $k@1064))
(assert ($Perm.isReadVar $k@1064 $Perm.Write))
(declare-const $t@1065 $Ref)
(push) ; 5
(assert (not (not (= $k@1064 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1064 $Perm.No)))
(assert (not (= $t@1065 $Ref.null)))
(declare-const $t@1066 Int)
(declare-const $t@1067 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1067 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1067 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 197] $t@1067 != Null
(assert (not (= $t@1067 $Ref.null)))
(declare-const $t@1068 $Snap)
(declare-const $k@1069 $Perm)
(assert ($Perm.isValidVar $k@1069))
(assert ($Perm.isReadVar $k@1069 $Perm.Write))
(declare-const $t@1070 $Ref)
(declare-const $k@1071 $Perm)
(assert ($Perm.isValidVar $k@1071))
(assert ($Perm.isReadVar $k@1071 $Perm.Write))
(declare-const $t@1072 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 197] $t@1067 == Null
(assert (= $t@1067 $Ref.null))
(declare-const $k@1073 $Perm)
(assert ($Perm.isValidVar $k@1073))
(assert ($Perm.isReadVar $k@1073 $Perm.Write))
(declare-const $t@1074 $Ref)
(declare-const $k@1075 $Perm)
(assert ($Perm.isValidVar $k@1075))
(assert ($Perm.isReadVar $k@1075 $Perm.Write))
(declare-const $t@1076 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_38 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1077 Int)
(declare-const $t@1078 $Snap)
(declare-const $t@1079 Int)
(assert (= $t@1078 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1079) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1077 $t@1079))
; [exec]
; currentCount := __flatten_38
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (not (= sys__result@1077 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= sys__result@1077 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 198] sys__result@1077 == $t@952
(assert (= sys__result@1077 $t@952))
; [exec]
; __flatten_39 := false
; [exec]
; sys__result := __flatten_39
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1080 $Perm)
(assert ($Perm.isValidVar $k@1080))
(assert ($Perm.isReadVar $k@1080 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1080 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1080 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1081 $Perm)
(assert ($Perm.isValidVar $k@1081))
(assert ($Perm.isReadVar $k@1081 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1081 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1081 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 199] $t@956 != Null
(push) ; 6
; [else-branch 199] $t@956 == Null
(declare-const $k@1082 $Perm)
(assert ($Perm.isValidVar $k@1082))
(assert ($Perm.isReadVar $k@1082 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1082 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1058 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1058 $Perm.No)))
(assert (< $k@1082 $k@1058))
(declare-const $k@1083 $Perm)
(assert ($Perm.isValidVar $k@1083))
(assert ($Perm.isReadVar $k@1083 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1083 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1060 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1060 $Perm.No)))
(assert (< $k@1083 $k@1060))
; [exec]
; inhale false
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 198] sys__result@1077 != $t@952
(assert (not (= sys__result@1077 $t@952)))
(pop) ; 5
; [eval] !(currentCount == diz.BlockingQueue__capacity)
; [eval] currentCount == diz.BlockingQueue__capacity
(push) ; 5
(assert (not (= sys__result@1077 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= sys__result@1077 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 200] sys__result@1077 != $t@952
(assert (not (= sys__result@1077 $t@952)))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 6
(assert (not (not (= $k@1058 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1058 $Perm.No)))
(declare-const $t@1084 $Snap)
; [exec]
; c := -1
; [eval] -1
; [exec]
; __flatten_40 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1085 Int)
(declare-const $t@1086 $Snap)
(declare-const $t@1087 Int)
(assert (= $t@1086 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1087) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1085 $t@1087))
; [exec]
; currentCount := __flatten_40
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 6
(assert (not (not (< sys__result@1085 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (< sys__result@1085 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 201] sys__result@1085 < $t@952
(assert (< sys__result@1085 $t@952))
; [exec]
; BlockingQueue__linkLast(diz, val)
; [eval] diz != null
(declare-const $k@1088 $Perm)
(assert ($Perm.isValidVar $k@1088))
(assert ($Perm.isReadVar $k@1088 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1088 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1088 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1089 $Perm)
(assert ($Perm.isValidVar $k@1089))
(assert ($Perm.isReadVar $k@1089 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1089 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1089 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 202] $t@956 != Null
(push) ; 7
; [else-branch 202] $t@956 == Null
(declare-const $k@1090 $Perm)
(assert ($Perm.isValidVar $k@1090))
(assert ($Perm.isReadVar $k@1090 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1090 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1090 $k@1058))
(declare-const $k@1091 $Perm)
(assert ($Perm.isValidVar $k@1091))
(assert ($Perm.isReadVar $k@1091 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1091 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@1060 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@1060 $Perm.No)))
(assert (< $k@1091 $k@1060))
(declare-const $t@1092 $Snap)
(declare-const $t@1093 $Snap)
(assert (= $t@1092 ($Snap.combine $t@1093 $Snap.unit)))
(declare-const $t@1094 $Snap)
(assert (= $t@1093 ($Snap.combine $t@1094 $Snap.unit)))
(declare-const $t@1095 $Snap)
(assert (= $t@1094 ($Snap.combine $t@1095 $Snap.unit)))
(declare-const $t@1096 $Snap)
(declare-const $t@1097 $Ref)
(assert (= $t@1095 ($Snap.combine $t@1096 ($SortWrappers.$RefTo$Snap $t@1097))))
(declare-const $t@1098 $Snap)
(declare-const $t@1099 $Ref)
(assert (= $t@1096 ($Snap.combine $t@1098 ($SortWrappers.$RefTo$Snap $t@1099))))
(declare-const $t@1100 $Snap)
(declare-const $t@1101 $Snap)
(assert (= $t@1098 ($Snap.combine $t@1100 $t@1101)))
(declare-const $t@1102 $Snap)
(declare-const $t@1103 $Ref)
(assert (= $t@1100 ($Snap.combine $t@1102 ($SortWrappers.$RefTo$Snap $t@1103))))
(declare-const $t@1104 $Snap)
(declare-const $t@1105 Int)
(assert (= $t@1102 ($Snap.combine $t@1104 ($SortWrappers.IntTo$Snap $t@1105))))
(declare-const $t@1106 Int)
(declare-const $t@1107 $Ref)
(assert (=
  $t@1104
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1106)
    ($SortWrappers.$RefTo$Snap $t@1107))))
(declare-const $t@1108 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1106)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1108) $Snap.unit)))
(declare-const $k@1109 $Perm)
(assert ($Perm.isValidVar $k@1109))
(assert ($Perm.isReadVar $k@1109 $Perm.Write))
(assert (implies (< $Perm.No (- $k@951 $k@1088)) (= $t@1108 $t@952)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- $k@951 $k@1088) $k@1109) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@951 $k@1088) $k@1109) $Perm.No)))
(assert (> $t@1108 0))
(declare-const $k@1110 $Perm)
(assert ($Perm.isValidVar $k@1110))
(assert ($Perm.isReadVar $k@1110 $Perm.Write))
(assert (implies (< $Perm.No (- $k@953 $k@1089)) (= $t@1107 $t@954)))
(push) ; 8
(assert (not (not (= (+ (- $k@953 $k@1089) $k@1110) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@953 $k@1089) $k@1110) $Perm.No)))
(assert (not (= $t@1107 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1103 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1103 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 203] $t@1103 != Null
(assert (not (= $t@1103 $Ref.null)))
(declare-const $k@1111 $Perm)
(assert ($Perm.isValidVar $k@1111))
(assert ($Perm.isReadVar $k@1111 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1058 $k@1090)) (= $t@1099 $t@1059)))
(declare-const $k@1112 $Perm)
(assert ($Perm.isValidVar $k@1112))
(assert ($Perm.isReadVar $k@1112 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1060 $k@1091)) (= $t@1097 $t@1061)))
; [eval] diz.BlockingQueue__first != null
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1113 $Perm)
(assert ($Perm.isValidVar $k@1113))
(assert ($Perm.isReadVar $k@1113 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1113 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1113 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1114 $Perm)
(assert ($Perm.isValidVar $k@1114))
(assert ($Perm.isReadVar $k@1114 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1114 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1114 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 204] $t@956 != Null
(push) ; 9
; [else-branch 204] $t@956 == Null
(declare-const $k@1115 $Perm)
(assert ($Perm.isValidVar $k@1115))
(assert ($Perm.isReadVar $k@1115 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1115 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1115 $k@1058))
(declare-const $k@1116 $Perm)
(assert ($Perm.isValidVar $k@1116))
(assert ($Perm.isReadVar $k@1116 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1116 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1116 $k@1060))
(pop) ; 9
(assert ($Perm.isValidVar $k@1115))
(assert ($Perm.isReadVar $k@1115 $Perm.Write))
(assert (< $k@1115 $k@1058))
(assert ($Perm.isValidVar $k@1116))
(assert ($Perm.isReadVar $k@1116 $Perm.Write))
(assert (< $k@1116 $k@1060))
(push) ; 9
(push) ; 10
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@1087))
              ($SortWrappers.$RefTo$Snap $t@956))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@1059))
        ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@954))
              ($SortWrappers.IntTo$Snap $t@1087))
            ($SortWrappers.$RefTo$Snap $t@956))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@1059))
      ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 205] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@1087), $t@956), _), $t@1059), $t@1061))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@954))
              ($SortWrappers.IntTo$Snap $t@1087))
            ($SortWrappers.$RefTo$Snap $t@956))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@1059))
      ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
  0))
; [eval] BlockingQueue__contents(diz) == Seq(val)
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1117 $Perm)
(assert ($Perm.isValidVar $k@1117))
(assert ($Perm.isReadVar $k@1117 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1117 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1117 (+ (- $k@951 $k@1088) $k@1109)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1118 $Perm)
(assert ($Perm.isValidVar $k@1118))
(assert ($Perm.isReadVar $k@1118 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1118 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1118 (+ (- $k@953 $k@1089) $k@1110)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1103 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 206] $t@1103 != Null
(declare-const $k@1119 $Perm)
(assert ($Perm.isValidVar $k@1119))
(assert ($Perm.isReadVar $k@1119 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1119 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(push) ; 12
(assert (not (not (= (+ (- $k@1058 $k@1090) $k@1111) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (not (= (+ (- $k@1058 $k@1090) $k@1111) $Perm.No)))
(assert (< $k@1119 (+ (- $k@1058 $k@1090) $k@1111)))
(declare-const $k@1120 $Perm)
(assert ($Perm.isValidVar $k@1120))
(assert ($Perm.isReadVar $k@1120 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1120 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(push) ; 12
(assert (not (not (= (+ (- $k@1060 $k@1091) $k@1112) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (not (= (+ (- $k@1060 $k@1091) $k@1112) $Perm.No)))
(assert (< $k@1120 (+ (- $k@1060 $k@1091) $k@1112)))
(pop) ; 11
; [dead else-branch 206] $t@1103 == Null
(assert ($Perm.isValidVar $k@1119))
(assert ($Perm.isReadVar $k@1119 $Perm.Write))
(assert (not (= (+ (- $k@1058 $k@1090) $k@1111) $Perm.No)))
(assert (< $k@1119 (+ (- $k@1058 $k@1090) $k@1111)))
(assert ($Perm.isValidVar $k@1120))
(assert ($Perm.isReadVar $k@1120 $Perm.Write))
(assert (not (= (+ (- $k@1060 $k@1091) $k@1112) $Perm.No)))
(assert (< $k@1120 (+ (- $k@1060 $k@1091) $k@1112)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@942)) 1))
(pop) ; 10
; [dead else-branch 205] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@1087), $t@956), _), $t@1059), $t@1061))| != 0
(pop) ; 9
(assert ($Perm.isValidVar $k@1117))
(assert ($Perm.isReadVar $k@1117 $Perm.Write))
(assert (< $k@1117 (+ (- $k@951 $k@1088) $k@1109)))
(assert ($Perm.isValidVar $k@1118))
(assert ($Perm.isReadVar $k@1118 $Perm.Write))
(assert (< $k@1118 (+ (- $k@953 $k@1089) $k@1110)))
(assert ($Perm.isValidVar $k@1119))
(assert ($Perm.isReadVar $k@1119 $Perm.Write))
(assert (not (= (+ (- $k@1058 $k@1090) $k@1111) $Perm.No)))
(assert (< $k@1119 (+ (- $k@1058 $k@1090) $k@1111)))
(assert ($Perm.isValidVar $k@1120))
(assert ($Perm.isReadVar $k@1120 $Perm.Write))
(assert (not (= (+ (- $k@1060 $k@1091) $k@1112) $Perm.No)))
(assert (< $k@1120 (+ (- $k@1060 $k@1091) $k@1112)))
(assert (= ($Seq.length ($Seq.singleton val@942)) 1))
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@1087))
              ($SortWrappers.$RefTo$Snap $t@956))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@1059))
        ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
    0)
  ($Seq.equal
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1108))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@1107))
              ($SortWrappers.IntTo$Snap $t@1105))
            ($SortWrappers.$RefTo$Snap $t@1103))
          $t@1101)
        ($SortWrappers.$RefTo$Snap $t@1099))
      ($SortWrappers.$RefTo$Snap $t@1097)) diz@941)
    ($Seq.singleton val@942))))
; [eval] (old(|BlockingQueue__contents(diz)|) != 0) ==> (BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)) ++ Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) != 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1121 $Perm)
(assert ($Perm.isValidVar $k@1121))
(assert ($Perm.isReadVar $k@1121 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1121 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1121 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1122 $Perm)
(assert ($Perm.isValidVar $k@1122))
(assert ($Perm.isReadVar $k@1122 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1122 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1122 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 207] $t@956 != Null
(push) ; 9
; [else-branch 207] $t@956 == Null
(declare-const $k@1123 $Perm)
(assert ($Perm.isValidVar $k@1123))
(assert ($Perm.isReadVar $k@1123 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1123 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1123 $k@1058))
(declare-const $k@1124 $Perm)
(assert ($Perm.isValidVar $k@1124))
(assert ($Perm.isReadVar $k@1124 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1124 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1124 $k@1060))
(pop) ; 9
(assert ($Perm.isValidVar $k@1123))
(assert ($Perm.isReadVar $k@1123 $Perm.Write))
(assert (< $k@1123 $k@1058))
(assert ($Perm.isValidVar $k@1124))
(assert ($Perm.isReadVar $k@1124 $Perm.Write))
(assert (< $k@1124 $k@1060))
(push) ; 9
(push) ; 10
(assert (not (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@954))
              ($SortWrappers.IntTo$Snap $t@1087))
            ($SortWrappers.$RefTo$Snap $t@956))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@1059))
      ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
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
                    ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                    $Snap.unit)
                  ($SortWrappers.$RefTo$Snap $t@954))
                ($SortWrappers.IntTo$Snap $t@1087))
              ($SortWrappers.$RefTo$Snap $t@956))
            $Snap.unit)
          ($SortWrappers.$RefTo$Snap $t@1059))
        ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
; [dead then-branch 208] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@1087), $t@956), _), $t@1059), $t@1061))| != 0
(push) ; 10
; [else-branch 208] |BlockingQueue__contents(diz@941;((((((((_, $t@952), _), $t@954), $t@1087), $t@956), _), $t@1059), $t@1061))| == 0
(assert (=
  ($Seq.length
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@952))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@954))
              ($SortWrappers.IntTo$Snap $t@1087))
            ($SortWrappers.$RefTo$Snap $t@956))
          $Snap.unit)
        ($SortWrappers.$RefTo$Snap $t@1059))
      ($SortWrappers.$RefTo$Snap $t@1061)) diz@941))
  0))
(pop) ; 10
(pop) ; 9
; [exec]
; __flatten_42 := AtomicInteger__getAndIncrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1125 Int)
(declare-const $t@1126 $Snap)
(declare-const $t@1127 Int)
(assert (= $t@1126 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1127) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal - 1
; [eval] diz.AtomicInteger__ghostVal - 1
(assert (= sys__result@1125 (- $t@1127 1)))
; [exec]
; c := __flatten_42
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 9
(assert (not (not (< (+ sys__result@1125 1) $t@1108))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (< (+ sys__result@1125 1) $t@1108)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 209] sys__result@1125 + 1 < $t@1108
(assert (< (+ sys__result@1125 1) $t@1108))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 10
(assert (not (= $t@1059 $t@1099)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 10
(assert (not (= $t@1059 $t@1099)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == 0
(push) ; 10
(assert (not (not (= sys__result@1125 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1125 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 210] sys__result@1125 == 0
(assert (= sys__result@1125 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@1128 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1129 $Perm)
(assert ($Perm.isValidVar $k@1129))
(assert ($Perm.isReadVar $k@1129 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1129 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1129 (+ (- $k@951 $k@1088) $k@1109)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1130 $Perm)
(assert ($Perm.isValidVar $k@1130))
(assert ($Perm.isReadVar $k@1130 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1130 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1130 (+ (- $k@953 $k@1089) $k@1110)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1103 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 211] $t@1103 != Null
(declare-const $k@1131 $Perm)
(assert ($Perm.isValidVar $k@1131))
(assert ($Perm.isReadVar $k@1131 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1131 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1131 (+ (- $k@1058 $k@1090) $k@1111)))
(declare-const $k@1132 $Perm)
(assert ($Perm.isValidVar $k@1132))
(assert ($Perm.isReadVar $k@1132 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1132 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1132 (+ (- $k@1060 $k@1091) $k@1112)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 211] $t@1103 == Null
(pop) ; 10
(push) ; 10
; [else-branch 210] sys__result@1125 != 0
(assert (not (= sys__result@1125 0)))
(pop) ; 10
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 10
(assert (not (= sys__result@1125 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1125 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 212] sys__result@1125 != 0
(assert (not (= sys__result@1125 0)))
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1133 $Perm)
(assert ($Perm.isValidVar $k@1133))
(assert ($Perm.isReadVar $k@1133 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1133 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1133 (+ (- $k@951 $k@1088) $k@1109)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1134 $Perm)
(assert ($Perm.isValidVar $k@1134))
(assert ($Perm.isReadVar $k@1134 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1134 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1134 (+ (- $k@953 $k@1089) $k@1110)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1103 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 213] $t@1103 != Null
(declare-const $k@1135 $Perm)
(assert ($Perm.isValidVar $k@1135))
(assert ($Perm.isReadVar $k@1135 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1135 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1135 (+ (- $k@1058 $k@1090) $k@1111)))
(declare-const $k@1136 $Perm)
(assert ($Perm.isValidVar $k@1136))
(assert ($Perm.isReadVar $k@1136 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1136 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1136 (+ (- $k@1060 $k@1091) $k@1112)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 213] $t@1103 == Null
(pop) ; 10
(push) ; 10
; [else-branch 212] sys__result@1125 == 0
(assert (= sys__result@1125 0))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 209] !sys__result@1125 + 1 < $t@1108
(assert (not (< (+ sys__result@1125 1) $t@1108)))
(pop) ; 9
; [eval] !(c + 1 < diz.BlockingQueue__capacity)
; [eval] c + 1 < diz.BlockingQueue__capacity
; [eval] c + 1
(push) ; 9
(assert (not (< (+ sys__result@1125 1) $t@1108)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (< (+ sys__result@1125 1) $t@1108))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 214] !sys__result@1125 + 1 < $t@1108
(assert (not (< (+ sys__result@1125 1) $t@1108)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(push) ; 10
(assert (not (= $t@1059 $t@1099)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == 0
(push) ; 10
(assert (not (not (= sys__result@1125 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1125 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 215] sys__result@1125 == 0
(assert (= sys__result@1125 0))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(declare-const $t@1137 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1138 $Perm)
(assert ($Perm.isValidVar $k@1138))
(assert ($Perm.isReadVar $k@1138 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1138 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1138 (+ (- $k@951 $k@1088) $k@1109)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1139 $Perm)
(assert ($Perm.isValidVar $k@1139))
(assert ($Perm.isReadVar $k@1139 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1139 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1139 (+ (- $k@953 $k@1089) $k@1110)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1103 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 216] $t@1103 != Null
(declare-const $k@1140 $Perm)
(assert ($Perm.isValidVar $k@1140))
(assert ($Perm.isReadVar $k@1140 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1140 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1140 (+ (- $k@1058 $k@1090) $k@1111)))
(declare-const $k@1141 $Perm)
(assert ($Perm.isValidVar $k@1141))
(assert ($Perm.isReadVar $k@1141 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1141 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1141 (+ (- $k@1060 $k@1091) $k@1112)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 216] $t@1103 == Null
(pop) ; 10
(push) ; 10
; [else-branch 215] sys__result@1125 != 0
(assert (not (= sys__result@1125 0)))
(pop) ; 10
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 10
(assert (not (= sys__result@1125 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1125 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 217] sys__result@1125 != 0
(assert (not (= sys__result@1125 0)))
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1142 $Perm)
(assert ($Perm.isValidVar $k@1142))
(assert ($Perm.isReadVar $k@1142 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1142 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1142 (+ (- $k@951 $k@1088) $k@1109)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1143 $Perm)
(assert ($Perm.isValidVar $k@1143))
(assert ($Perm.isReadVar $k@1143 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1143 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1143 (+ (- $k@953 $k@1089) $k@1110)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1103 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 218] $t@1103 != Null
(declare-const $k@1144 $Perm)
(assert ($Perm.isValidVar $k@1144))
(assert ($Perm.isReadVar $k@1144 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1144 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1144 (+ (- $k@1058 $k@1090) $k@1111)))
(declare-const $k@1145 $Perm)
(assert ($Perm.isValidVar $k@1145))
(assert ($Perm.isReadVar $k@1145 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1145 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1145 (+ (- $k@1060 $k@1091) $k@1112)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 218] $t@1103 == Null
(pop) ; 10
(push) ; 10
; [else-branch 217] sys__result@1125 == 0
(assert (= sys__result@1125 0))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 214] sys__result@1125 + 1 < $t@1108
(assert (< (+ sys__result@1125 1) $t@1108))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 203] $t@1103 == Null
(assert (= $t@1103 $Ref.null))
(declare-const $k@1146 $Perm)
(assert ($Perm.isValidVar $k@1146))
(assert ($Perm.isReadVar $k@1146 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1058 $k@1090)) (= $t@1099 $t@1059)))
(declare-const $k@1147 $Perm)
(assert ($Perm.isValidVar $k@1147))
(assert ($Perm.isReadVar $k@1147 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1060 $k@1091)) (= $t@1097 $t@1061)))
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@1103 $Ref.null)))
; [eval] (old(|BlockingQueue__contents(diz)|) == 0) ==> (BlockingQueue__contents(diz) == Seq(val))
; [eval] old(|BlockingQueue__contents(diz)|) == 0
; [eval] old(|BlockingQueue__contents(diz)|)
; [eval] |BlockingQueue__contents(diz)|
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1148 $Perm)
(assert ($Perm.isValidVar $k@1148))
(assert ($Perm.isReadVar $k@1148 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1148 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1148 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1149 $Perm)
(assert ($Perm.isValidVar $k@1149))
(assert ($Perm.isReadVar $k@1149 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1149 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1149 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
; [dead then-branch 219] $t@956 != Null
; [dead else-branch 219] $t@956 == Null
(pop) ; 8
(pop) ; 7
(pop) ; 6
(push) ; 6
; [else-branch 201] !sys__result@1085 < $t@952
(assert (not (< sys__result@1085 $t@952)))
(pop) ; 6
; [eval] !(currentCount < diz.BlockingQueue__capacity)
; [eval] currentCount < diz.BlockingQueue__capacity
(push) ; 6
(assert (not (< sys__result@1085 $t@952)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (< sys__result@1085 $t@952))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 220] !sys__result@1085 < $t@952
(assert (not (< sys__result@1085 $t@952)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [eval] c == 0
(push) ; 7
(assert (not (not (= (- 0 1) 0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= (- 0 1) 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 221] -1 == 0
(push) ; 7
; [else-branch 221] -1 != 0
(assert (not (= (- 0 1) 0)))
(pop) ; 7
; [eval] !(c == 0)
; [eval] c == 0
(push) ; 7
(assert (not (= (- 0 1) 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- 0 1) 0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 222] -1 != 0
(assert (not (= (- 0 1) 0)))
; [exec]
; __flatten_43 := c >= 0
; [eval] c >= 0
; [exec]
; sys__result := __flatten_43
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1150 $Perm)
(assert ($Perm.isValidVar $k@1150))
(assert ($Perm.isReadVar $k@1150 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1150 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1150 $k@951))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1151 $Perm)
(assert ($Perm.isValidVar $k@1151))
(assert ($Perm.isReadVar $k@1151 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1151 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1151 $k@953))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@956 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 223] $t@956 != Null
(push) ; 8
; [else-branch 223] $t@956 == Null
(declare-const $k@1152 $Perm)
(assert ($Perm.isValidVar $k@1152))
(assert ($Perm.isReadVar $k@1152 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1152 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1152 $k@1058))
(declare-const $k@1153 $Perm)
(assert ($Perm.isValidVar $k@1153))
(assert ($Perm.isReadVar $k@1153 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1153 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@1060 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1060 $Perm.No)))
(assert (< $k@1153 $k@1060))
; [exec]
; inhale false
(pop) ; 8
(pop) ; 7
; [dead else-branch 222] -1 == 0
(pop) ; 6
(push) ; 6
; [else-branch 220] sys__result@1085 < $t@952
(assert (< sys__result@1085 $t@952))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 200] sys__result@1077 == $t@952
(assert (= sys__result@1077 $t@952))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__poll ----------
(declare-const diz@1154 $Ref)
(declare-const sys__result@1155 $Ref)
(declare-const x@1156 $Ref)
(declare-const currentCount@1157 Int)
(declare-const __flatten_44@1158 Int)
(declare-const __flatten_45@1159 $Ref)
(declare-const c@1160 Int)
(declare-const __flatten_46@1161 Int)
(declare-const __flatten_47@1162 Int)
(declare-const __flatten_48@1163 $Ref)
(declare-const __flatten_49@1164 Int)
(declare-const __flatten_50@1165 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1154 $Ref.null)))
(declare-const $k@1166 $Perm)
(assert ($Perm.isValidVar $k@1166))
(assert ($Perm.isReadVar $k@1166 $Perm.Write))
(declare-const $t@1167 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1166 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1166 $Perm.No)))
(assert (> $t@1167 0))
(declare-const $k@1168 $Perm)
(assert ($Perm.isValidVar $k@1168))
(assert ($Perm.isReadVar $k@1168 $Perm.Write))
(declare-const $t@1169 $Ref)
(push) ; 3
(assert (not (not (= $k@1168 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1168 $Perm.No)))
(assert (not (= $t@1169 $Ref.null)))
(declare-const $t@1170 Int)
(declare-const $t@1171 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@1171 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 224] $t@1171 != Null
(assert (not (= $t@1171 $Ref.null)))
(declare-const $t@1172 $Snap)
(declare-const $k@1173 $Perm)
(assert ($Perm.isValidVar $k@1173))
(assert ($Perm.isReadVar $k@1173 $Perm.Write))
(declare-const $t@1174 $Ref)
(declare-const $k@1175 $Perm)
(assert ($Perm.isValidVar $k@1175))
(assert ($Perm.isReadVar $k@1175 $Perm.Write))
(declare-const $t@1176 $Ref)
(push) ; 4
(declare-const $k@1177 $Perm)
(assert ($Perm.isValidVar $k@1177))
(assert ($Perm.isReadVar $k@1177 $Perm.Write))
(declare-const $t@1178 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1177 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1177 $Perm.No)))
(assert (> $t@1178 0))
(declare-const $k@1179 $Perm)
(assert ($Perm.isValidVar $k@1179))
(assert ($Perm.isReadVar $k@1179 $Perm.Write))
(declare-const $t@1180 $Ref)
(push) ; 5
(assert (not (not (= $k@1179 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1179 $Perm.No)))
(assert (not (= $t@1180 $Ref.null)))
(declare-const $t@1181 Int)
(declare-const $t@1182 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1182 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1182 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 225] $t@1182 != Null
(assert (not (= $t@1182 $Ref.null)))
(declare-const $t@1183 $Snap)
(declare-const $k@1184 $Perm)
(assert ($Perm.isValidVar $k@1184))
(assert ($Perm.isReadVar $k@1184 $Perm.Write))
(declare-const $t@1185 $Ref)
(declare-const $k@1186 $Perm)
(assert ($Perm.isValidVar $k@1186))
(assert ($Perm.isReadVar $k@1186 $Perm.Write))
(declare-const $t@1187 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 225] $t@1182 == Null
(assert (= $t@1182 $Ref.null))
(declare-const $k@1188 $Perm)
(assert ($Perm.isValidVar $k@1188))
(assert ($Perm.isReadVar $k@1188 $Perm.Write))
(declare-const $t@1189 $Ref)
(declare-const $k@1190 $Perm)
(assert ($Perm.isValidVar $k@1190))
(assert ($Perm.isReadVar $k@1190 $Perm.Write))
(declare-const $t@1191 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; x := null
; [exec]
; __flatten_44 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1192 Int)
(declare-const $t@1193 $Snap)
(declare-const $t@1194 Int)
(assert (= $t@1193 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1194) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1192 $t@1194))
; [exec]
; currentCount := __flatten_44
; [eval] currentCount == 0
(push) ; 5
(assert (not (not (= sys__result@1192 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= sys__result@1192 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 226] sys__result@1192 == 0
(assert (= sys__result@1192 0))
; [exec]
; __flatten_45 := x
; [exec]
; sys__result := __flatten_45
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1195 $Perm)
(assert ($Perm.isValidVar $k@1195))
(assert ($Perm.isReadVar $k@1195 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1195 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1195 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1196 $Perm)
(assert ($Perm.isValidVar $k@1196))
(assert ($Perm.isReadVar $k@1196 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1196 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1196 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 227] $t@1171 != Null
(declare-const $k@1197 $Perm)
(assert ($Perm.isValidVar $k@1197))
(assert ($Perm.isReadVar $k@1197 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1197 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1173 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1173 $Perm.No)))
(assert (< $k@1197 $k@1173))
(declare-const $k@1198 $Perm)
(assert ($Perm.isValidVar $k@1198))
(assert ($Perm.isReadVar $k@1198 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1198 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1175 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1175 $Perm.No)))
(assert (< $k@1198 $k@1175))
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 227] $t@1171 == Null
(pop) ; 5
(push) ; 5
; [else-branch 226] sys__result@1192 != 0
(assert (not (= sys__result@1192 0)))
(pop) ; 5
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 5
(assert (not (= sys__result@1192 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= sys__result@1192 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 228] sys__result@1192 != 0
(assert (not (= sys__result@1192 0)))
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 6
(assert (not (not (= $k@1175 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1175 $Perm.No)))
(declare-const $t@1199 $Snap)
; [exec]
; __flatten_46 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1200 Int)
(declare-const $t@1201 $Snap)
(declare-const $t@1202 Int)
(assert (= $t@1201 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1202) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1200 $t@1202))
; [exec]
; currentCount := __flatten_46
; [eval] currentCount > 0
(push) ; 6
(assert (not (not (> sys__result@1200 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (> sys__result@1200 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 229] sys__result@1200 > 0
(assert (> sys__result@1200 0))
; [exec]
; inhale diz.BlockingQueue__first != null
; [eval] diz.BlockingQueue__first != null
; [exec]
; __flatten_47 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@1203 $Perm)
(assert ($Perm.isValidVar $k@1203))
(assert ($Perm.isReadVar $k@1203 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1203 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1203 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1204 $Perm)
(assert ($Perm.isValidVar $k@1204))
(assert ($Perm.isReadVar $k@1204 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1204 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1204 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 230] $t@1171 != Null
(declare-const $k@1205 $Perm)
(assert ($Perm.isValidVar $k@1205))
(assert ($Perm.isReadVar $k@1205 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1205 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@1173 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@1173 $Perm.No)))
(assert (< $k@1205 $k@1173))
(declare-const $k@1206 $Perm)
(assert ($Perm.isValidVar $k@1206))
(assert ($Perm.isReadVar $k@1206 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1206 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1206 $k@1175))
; [eval] diz.BlockingQueue__first != null
(declare-const sys__result@1207 Int)
(declare-const $t@1208 $Snap)
(declare-const $t@1209 $Snap)
(assert (= $t@1208 ($Snap.combine $t@1209 $Snap.unit)))
(declare-const $t@1210 $Snap)
(assert (= $t@1209 ($Snap.combine $t@1210 $Snap.unit)))
(declare-const $t@1211 $Snap)
(declare-const $t@1212 $Ref)
(assert (= $t@1210 ($Snap.combine $t@1211 ($SortWrappers.$RefTo$Snap $t@1212))))
(declare-const $t@1213 $Snap)
(declare-const $t@1214 $Ref)
(assert (= $t@1211 ($Snap.combine $t@1213 ($SortWrappers.$RefTo$Snap $t@1214))))
(declare-const $t@1215 $Snap)
(declare-const $t@1216 $Snap)
(assert (= $t@1213 ($Snap.combine $t@1215 $t@1216)))
(declare-const $t@1217 $Snap)
(declare-const $t@1218 $Ref)
(assert (= $t@1215 ($Snap.combine $t@1217 ($SortWrappers.$RefTo$Snap $t@1218))))
(declare-const $t@1219 $Snap)
(declare-const $t@1220 Int)
(assert (= $t@1217 ($Snap.combine $t@1219 ($SortWrappers.IntTo$Snap $t@1220))))
(declare-const $t@1221 Int)
(declare-const $t@1222 $Ref)
(assert (=
  $t@1219
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1221)
    ($SortWrappers.$RefTo$Snap $t@1222))))
(declare-const $t@1223 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1221)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1223) $Snap.unit)))
(declare-const $k@1224 $Perm)
(assert ($Perm.isValidVar $k@1224))
(assert ($Perm.isReadVar $k@1224 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1166 $k@1203)) (= $t@1223 $t@1167)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- $k@1166 $k@1203) $k@1224) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1166 $k@1203) $k@1224) $Perm.No)))
(assert (> $t@1223 0))
(declare-const $k@1225 $Perm)
(assert ($Perm.isValidVar $k@1225))
(assert ($Perm.isReadVar $k@1225 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1168 $k@1204)) (= $t@1222 $t@1169)))
(push) ; 8
(assert (not (not (= (+ (- $k@1168 $k@1204) $k@1225) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1168 $k@1204) $k@1225) $Perm.No)))
(assert (not (= $t@1222 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1218 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 231] $t@1218 != Null
(assert (not (= $t@1218 $Ref.null)))
(declare-const $k@1226 $Perm)
(assert ($Perm.isValidVar $k@1226))
(assert ($Perm.isReadVar $k@1226 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1173 $k@1205)) (= $t@1214 $t@1174)))
(declare-const $k@1227 $Perm)
(assert ($Perm.isValidVar $k@1227))
(assert ($Perm.isReadVar $k@1227 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1175 $k@1206)) (= $t@1212 $t@1176)))
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1228 $Perm)
(assert ($Perm.isValidVar $k@1228))
(assert ($Perm.isReadVar $k@1228 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1228 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1228 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1229 $Perm)
(assert ($Perm.isValidVar $k@1229))
(assert ($Perm.isReadVar $k@1229 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1229 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1229 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 232] $t@1171 != Null
(declare-const $k@1230 $Perm)
(assert ($Perm.isValidVar $k@1230))
(assert ($Perm.isReadVar $k@1230 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1230 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1230 $k@1173))
(declare-const $k@1231 $Perm)
(assert ($Perm.isValidVar $k@1231))
(assert ($Perm.isReadVar $k@1231 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1231 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1231 $k@1175))
(pop) ; 9
; [dead else-branch 232] $t@1171 == Null
(assert ($Perm.isValidVar $k@1230))
(assert ($Perm.isReadVar $k@1230 $Perm.Write))
(assert (< $k@1230 $k@1173))
(assert ($Perm.isValidVar $k@1231))
(assert ($Perm.isReadVar $k@1231 $Perm.Write))
(assert (< $k@1231 $k@1175))
(assert (=
  sys__result@1207
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1167))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@1169))
              ($SortWrappers.IntTo$Snap $t@1202))
            ($SortWrappers.$RefTo$Snap $t@1171))
          $t@1172)
        ($SortWrappers.$RefTo$Snap $t@1174))
      ($SortWrappers.$RefTo$Snap $t@1176)) diz@1154)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1232 $Perm)
(assert ($Perm.isValidVar $k@1232))
(assert ($Perm.isReadVar $k@1232 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1232 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1232 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1233 $Perm)
(assert ($Perm.isValidVar $k@1233))
(assert ($Perm.isReadVar $k@1233 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1233 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1233 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 233] $t@1218 != Null
(declare-const $k@1234 $Perm)
(assert ($Perm.isValidVar $k@1234))
(assert ($Perm.isReadVar $k@1234 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1234 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- $k@1173 $k@1205) $k@1226) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- $k@1173 $k@1205) $k@1226) $Perm.No)))
(assert (< $k@1234 (+ (- $k@1173 $k@1205) $k@1226)))
(declare-const $k@1235 $Perm)
(assert ($Perm.isValidVar $k@1235))
(assert ($Perm.isReadVar $k@1235 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1235 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- $k@1175 $k@1206) $k@1227) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- $k@1175 $k@1206) $k@1227) $Perm.No)))
(assert (< $k@1235 (+ (- $k@1175 $k@1206) $k@1227)))
(pop) ; 9
; [dead else-branch 233] $t@1218 == Null
(assert ($Perm.isValidVar $k@1234))
(assert ($Perm.isReadVar $k@1234 $Perm.Write))
(assert (not (= (+ (- $k@1173 $k@1205) $k@1226) $Perm.No)))
(assert (< $k@1234 (+ (- $k@1173 $k@1205) $k@1226)))
(assert ($Perm.isValidVar $k@1235))
(assert ($Perm.isReadVar $k@1235 $Perm.Write))
(assert (not (= (+ (- $k@1175 $k@1206) $k@1227) $Perm.No)))
(assert (< $k@1235 (+ (- $k@1175 $k@1206) $k@1227)))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1236 $Perm)
(assert ($Perm.isValidVar $k@1236))
(assert ($Perm.isReadVar $k@1236 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1236 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1236 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1237 $Perm)
(assert ($Perm.isValidVar $k@1237))
(assert ($Perm.isReadVar $k@1237 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1237 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1237 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 234] $t@1171 != Null
(declare-const $k@1238 $Perm)
(assert ($Perm.isValidVar $k@1238))
(assert ($Perm.isReadVar $k@1238 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1238 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1238 $k@1173))
(declare-const $k@1239 $Perm)
(assert ($Perm.isValidVar $k@1239))
(assert ($Perm.isReadVar $k@1239 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1239 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1239 $k@1175))
(pop) ; 9
; [dead else-branch 234] $t@1171 == Null
(assert ($Perm.isValidVar $k@1238))
(assert ($Perm.isReadVar $k@1238 $Perm.Write))
(assert (< $k@1238 $k@1173))
(assert ($Perm.isValidVar $k@1239))
(assert ($Perm.isReadVar $k@1239 $Perm.Write))
(assert (< $k@1239 $k@1175))
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1223))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@1222))
            ($SortWrappers.IntTo$Snap $t@1220))
          ($SortWrappers.$RefTo$Snap $t@1218))
        $t@1216)
      ($SortWrappers.$RefTo$Snap $t@1214))
    ($SortWrappers.$RefTo$Snap $t@1212)) diz@1154)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1167))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@1169))
              ($SortWrappers.IntTo$Snap $t@1202))
            ($SortWrappers.$RefTo$Snap $t@1171))
          $t@1172)
        ($SortWrappers.$RefTo$Snap $t@1174))
      ($SortWrappers.$RefTo$Snap $t@1176)) diz@1154)
    1)))
; [exec]
; __flatten_48 := Integer__Integer(__flatten_47)
(declare-const sys__result@1240 $Ref)
(declare-const $t@1241 $Snap)
(declare-const $t@1242 Int)
(assert (= $t@1241 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1242) $Snap.unit)))
(declare-const $t@1243 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1242)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1243))))
; [eval] sys__result != null
(assert (not (= sys__result@1240 $Ref.null)))
(declare-const $k@1244 $Perm)
(assert ($Perm.isValidVar $k@1244))
(assert ($Perm.isReadVar $k@1244 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 9
(assert (not (not (= $k@1244 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1244 $Perm.No)))
(assert (= $t@1243 sys__result@1207))
; [exec]
; x := __flatten_48
; [exec]
; __flatten_49 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1245 Int)
(declare-const $t@1246 $Snap)
(declare-const $t@1247 Int)
(assert (= $t@1246 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1247) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal + 1
; [eval] diz.AtomicInteger__ghostVal + 1
(assert (= sys__result@1245 (+ $t@1247 1)))
; [exec]
; c := __flatten_49
; [eval] c > 1
(push) ; 9
(assert (not (not (> sys__result@1245 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (> sys__result@1245 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 235] sys__result@1245 > 1
(assert (> sys__result@1245 1))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 10
(assert (not (= $t@1176 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 10
(assert (not (= $t@1176 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (not (= sys__result@1245 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1245 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 236] sys__result@1245 == $t@1223
(assert (= sys__result@1245 $t@1223))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@1248 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1249 $Perm)
(assert ($Perm.isValidVar $k@1249))
(assert ($Perm.isReadVar $k@1249 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1249 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1249 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1250 $Perm)
(assert ($Perm.isValidVar $k@1250))
(assert ($Perm.isReadVar $k@1250 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1250 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1250 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 237] $t@1218 != Null
(declare-const $k@1251 $Perm)
(assert ($Perm.isValidVar $k@1251))
(assert ($Perm.isReadVar $k@1251 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1251 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1251 (+ (- $k@1173 $k@1205) $k@1226)))
(declare-const $k@1252 $Perm)
(assert ($Perm.isValidVar $k@1252))
(assert ($Perm.isReadVar $k@1252 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1252 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1252 (+ (- $k@1175 $k@1206) $k@1227)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 237] $t@1218 == Null
(pop) ; 10
(push) ; 10
; [else-branch 236] sys__result@1245 != $t@1223
(assert (not (= sys__result@1245 $t@1223)))
(pop) ; 10
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (= sys__result@1245 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1245 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 238] sys__result@1245 != $t@1223
(assert (not (= sys__result@1245 $t@1223)))
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1253 $Perm)
(assert ($Perm.isValidVar $k@1253))
(assert ($Perm.isReadVar $k@1253 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1253 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1253 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1254 $Perm)
(assert ($Perm.isValidVar $k@1254))
(assert ($Perm.isReadVar $k@1254 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1254 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1254 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 239] $t@1218 != Null
(declare-const $k@1255 $Perm)
(assert ($Perm.isValidVar $k@1255))
(assert ($Perm.isReadVar $k@1255 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1255 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1255 (+ (- $k@1173 $k@1205) $k@1226)))
(declare-const $k@1256 $Perm)
(assert ($Perm.isValidVar $k@1256))
(assert ($Perm.isReadVar $k@1256 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1256 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1256 (+ (- $k@1175 $k@1206) $k@1227)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 239] $t@1218 == Null
(pop) ; 10
(push) ; 10
; [else-branch 238] sys__result@1245 == $t@1223
(assert (= sys__result@1245 $t@1223))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 235] !sys__result@1245 > 1
(assert (not (> sys__result@1245 1)))
(pop) ; 9
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 9
(assert (not (> sys__result@1245 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (> sys__result@1245 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 240] !sys__result@1245 > 1
(assert (not (> sys__result@1245 1)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 10
(assert (not (= $t@1176 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (not (= sys__result@1245 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1245 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 241] sys__result@1245 == $t@1223
(assert (= sys__result@1245 $t@1223))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@1257 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1258 $Perm)
(assert ($Perm.isValidVar $k@1258))
(assert ($Perm.isReadVar $k@1258 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1258 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1258 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1259 $Perm)
(assert ($Perm.isValidVar $k@1259))
(assert ($Perm.isReadVar $k@1259 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1259 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1259 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 242] $t@1218 != Null
(declare-const $k@1260 $Perm)
(assert ($Perm.isValidVar $k@1260))
(assert ($Perm.isReadVar $k@1260 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1260 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1260 (+ (- $k@1173 $k@1205) $k@1226)))
(declare-const $k@1261 $Perm)
(assert ($Perm.isValidVar $k@1261))
(assert ($Perm.isReadVar $k@1261 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1261 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1261 (+ (- $k@1175 $k@1206) $k@1227)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 242] $t@1218 == Null
(pop) ; 10
(push) ; 10
; [else-branch 241] sys__result@1245 != $t@1223
(assert (not (= sys__result@1245 $t@1223)))
(pop) ; 10
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (= sys__result@1245 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1245 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 243] sys__result@1245 != $t@1223
(assert (not (= sys__result@1245 $t@1223)))
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1262 $Perm)
(assert ($Perm.isValidVar $k@1262))
(assert ($Perm.isReadVar $k@1262 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1262 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1262 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1263 $Perm)
(assert ($Perm.isValidVar $k@1263))
(assert ($Perm.isReadVar $k@1263 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1263 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1263 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (= $t@1218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
(push) ; 11
; [then-branch 244] $t@1218 != Null
(declare-const $k@1264 $Perm)
(assert ($Perm.isValidVar $k@1264))
(assert ($Perm.isReadVar $k@1264 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1264 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1264 (+ (- $k@1173 $k@1205) $k@1226)))
(declare-const $k@1265 $Perm)
(assert ($Perm.isValidVar $k@1265))
(assert ($Perm.isReadVar $k@1265 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1265 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1265 (+ (- $k@1175 $k@1206) $k@1227)))
; [exec]
; inhale false
(pop) ; 11
; [dead else-branch 244] $t@1218 == Null
(pop) ; 10
(push) ; 10
; [else-branch 243] sys__result@1245 == $t@1223
(assert (= sys__result@1245 $t@1223))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 240] sys__result@1245 > 1
(assert (> sys__result@1245 1))
(pop) ; 9
(pop) ; 8
(push) ; 8
; [else-branch 231] $t@1218 == Null
(assert (= $t@1218 $Ref.null))
(declare-const $k@1266 $Perm)
(assert ($Perm.isValidVar $k@1266))
(assert ($Perm.isReadVar $k@1266 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1173 $k@1205)) (= $t@1214 $t@1174)))
(declare-const $k@1267 $Perm)
(assert ($Perm.isValidVar $k@1267))
(assert ($Perm.isReadVar $k@1267 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1175 $k@1206)) (= $t@1212 $t@1176)))
; [eval] sys__result == old(BlockingQueue__contents(diz)[0])
; [eval] old(BlockingQueue__contents(diz)[0])
; [eval] BlockingQueue__contents(diz)[0]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1268 $Perm)
(assert ($Perm.isValidVar $k@1268))
(assert ($Perm.isReadVar $k@1268 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1268 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1268 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1269 $Perm)
(assert ($Perm.isValidVar $k@1269))
(assert ($Perm.isReadVar $k@1269 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1269 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1269 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 245] $t@1171 != Null
(declare-const $k@1270 $Perm)
(assert ($Perm.isValidVar $k@1270))
(assert ($Perm.isReadVar $k@1270 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1270 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1270 $k@1173))
(declare-const $k@1271 $Perm)
(assert ($Perm.isValidVar $k@1271))
(assert ($Perm.isReadVar $k@1271 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1271 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1271 $k@1175))
(pop) ; 9
; [dead else-branch 245] $t@1171 == Null
(assert ($Perm.isValidVar $k@1270))
(assert ($Perm.isReadVar $k@1270 $Perm.Write))
(assert (< $k@1270 $k@1173))
(assert ($Perm.isValidVar $k@1271))
(assert ($Perm.isReadVar $k@1271 $Perm.Write))
(assert (< $k@1271 $k@1175))
(assert (=
  sys__result@1207
  ($Seq.index
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1167))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@1169))
              ($SortWrappers.IntTo$Snap $t@1202))
            ($SortWrappers.$RefTo$Snap $t@1171))
          $t@1172)
        ($SortWrappers.$RefTo$Snap $t@1174))
      ($SortWrappers.$RefTo$Snap $t@1176)) diz@1154)
    0)))
; [eval] BlockingQueue__contents(diz) == old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1272 $Perm)
(assert ($Perm.isValidVar $k@1272))
(assert ($Perm.isReadVar $k@1272 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1272 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1272 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1273 $Perm)
(assert ($Perm.isValidVar $k@1273))
(assert ($Perm.isReadVar $k@1273 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1273 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1273 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1218 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 246] $t@1218 != Null
(push) ; 9
; [else-branch 246] $t@1218 == Null
(declare-const $k@1274 $Perm)
(assert ($Perm.isValidVar $k@1274))
(assert ($Perm.isReadVar $k@1274 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1274 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- $k@1173 $k@1205) $k@1266) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- $k@1173 $k@1205) $k@1266) $Perm.No)))
(assert (< $k@1274 (+ (- $k@1173 $k@1205) $k@1266)))
(declare-const $k@1275 $Perm)
(assert ($Perm.isValidVar $k@1275))
(assert ($Perm.isReadVar $k@1275 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1275 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- $k@1175 $k@1206) $k@1267) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- $k@1175 $k@1206) $k@1267) $Perm.No)))
(assert (< $k@1275 (+ (- $k@1175 $k@1206) $k@1267)))
(pop) ; 9
(assert ($Perm.isValidVar $k@1274))
(assert ($Perm.isReadVar $k@1274 $Perm.Write))
(assert (not (= (+ (- $k@1173 $k@1205) $k@1266) $Perm.No)))
(assert (< $k@1274 (+ (- $k@1173 $k@1205) $k@1266)))
(assert ($Perm.isValidVar $k@1275))
(assert ($Perm.isReadVar $k@1275 $Perm.Write))
(assert (not (= (+ (- $k@1175 $k@1206) $k@1267) $Perm.No)))
(assert (< $k@1275 (+ (- $k@1175 $k@1206) $k@1267)))
; [eval] old(BlockingQueue__contents(diz)[1..])
; [eval] BlockingQueue__contents(diz)[1..]
; [eval] BlockingQueue__contents(diz)
; [eval] diz != null
(declare-const $k@1276 $Perm)
(assert ($Perm.isValidVar $k@1276))
(assert ($Perm.isReadVar $k@1276 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1276 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1276 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1277 $Perm)
(assert ($Perm.isValidVar $k@1277))
(assert ($Perm.isReadVar $k@1277 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1277 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1277 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 247] $t@1171 != Null
(declare-const $k@1278 $Perm)
(assert ($Perm.isValidVar $k@1278))
(assert ($Perm.isReadVar $k@1278 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1278 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1278 $k@1173))
(declare-const $k@1279 $Perm)
(assert ($Perm.isValidVar $k@1279))
(assert ($Perm.isReadVar $k@1279 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1279 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (< $k@1279 $k@1175))
(pop) ; 9
; [dead else-branch 247] $t@1171 == Null
(assert ($Perm.isValidVar $k@1278))
(assert ($Perm.isReadVar $k@1278 $Perm.Write))
(assert (< $k@1278 $k@1173))
(assert ($Perm.isValidVar $k@1279))
(assert ($Perm.isReadVar $k@1279 $Perm.Write))
(assert (< $k@1279 $k@1175))
(assert ($Seq.equal
  ($BlockingQueue__contents ($Snap.combine
    ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1223))
                $Snap.unit)
              ($SortWrappers.$RefTo$Snap $t@1222))
            ($SortWrappers.IntTo$Snap $t@1220))
          ($SortWrappers.$RefTo$Snap $t@1218))
        $Snap.unit)
      ($SortWrappers.$RefTo$Snap $t@1214))
    ($SortWrappers.$RefTo$Snap $t@1212)) diz@1154)
  ($Seq.drop
    ($BlockingQueue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1167))
                  $Snap.unit)
                ($SortWrappers.$RefTo$Snap $t@1169))
              ($SortWrappers.IntTo$Snap $t@1202))
            ($SortWrappers.$RefTo$Snap $t@1171))
          $t@1172)
        ($SortWrappers.$RefTo$Snap $t@1174))
      ($SortWrappers.$RefTo$Snap $t@1176)) diz@1154)
    1)))
; [exec]
; __flatten_48 := Integer__Integer(__flatten_47)
(declare-const sys__result@1280 $Ref)
(declare-const $t@1281 $Snap)
(declare-const $t@1282 Int)
(assert (= $t@1281 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1282) $Snap.unit)))
(declare-const $t@1283 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1282)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1283))))
; [eval] sys__result != null
(assert (not (= sys__result@1280 $Ref.null)))
(declare-const $k@1284 $Perm)
(assert ($Perm.isValidVar $k@1284))
(assert ($Perm.isReadVar $k@1284 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 9
(assert (not (not (= $k@1284 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1284 $Perm.No)))
(assert (= $t@1283 sys__result@1207))
; [exec]
; x := __flatten_48
; [exec]
; __flatten_49 := AtomicInteger__getAndDecrement(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1285 Int)
(declare-const $t@1286 $Snap)
(declare-const $t@1287 Int)
(assert (= $t@1286 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1287) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal + 1
; [eval] diz.AtomicInteger__ghostVal + 1
(assert (= sys__result@1285 (+ $t@1287 1)))
; [exec]
; c := __flatten_49
; [eval] c > 1
(push) ; 9
(assert (not (not (> sys__result@1285 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (> sys__result@1285 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 248] sys__result@1285 > 1
(assert (> sys__result@1285 1))
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 10
(assert (not (= $t@1176 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 10
(assert (not (= $t@1176 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (not (= sys__result@1285 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1285 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 249] sys__result@1285 == $t@1223
(assert (= sys__result@1285 $t@1223))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@1288 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1289 $Perm)
(assert ($Perm.isValidVar $k@1289))
(assert ($Perm.isReadVar $k@1289 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1289 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1289 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1290 $Perm)
(assert ($Perm.isValidVar $k@1290))
(assert ($Perm.isReadVar $k@1290 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1290 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1290 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (not (= $t@1218 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
; [dead then-branch 250] $t@1218 != Null
(push) ; 11
; [else-branch 250] $t@1218 == Null
(declare-const $k@1291 $Perm)
(assert ($Perm.isValidVar $k@1291))
(assert ($Perm.isReadVar $k@1291 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1291 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1291 (+ (- $k@1173 $k@1205) $k@1266)))
(declare-const $k@1292 $Perm)
(assert ($Perm.isValidVar $k@1292))
(assert ($Perm.isReadVar $k@1292 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1292 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1292 (+ (- $k@1175 $k@1206) $k@1267)))
; [exec]
; inhale false
(pop) ; 11
(pop) ; 10
(push) ; 10
; [else-branch 249] sys__result@1285 != $t@1223
(assert (not (= sys__result@1285 $t@1223)))
(pop) ; 10
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (= sys__result@1285 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1285 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 251] sys__result@1285 != $t@1223
(assert (not (= sys__result@1285 $t@1223)))
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1293 $Perm)
(assert ($Perm.isValidVar $k@1293))
(assert ($Perm.isReadVar $k@1293 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1293 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1293 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1294 $Perm)
(assert ($Perm.isValidVar $k@1294))
(assert ($Perm.isReadVar $k@1294 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1294 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1294 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (not (= $t@1218 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
; [dead then-branch 252] $t@1218 != Null
(push) ; 11
; [else-branch 252] $t@1218 == Null
(declare-const $k@1295 $Perm)
(assert ($Perm.isValidVar $k@1295))
(assert ($Perm.isReadVar $k@1295 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1295 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1295 (+ (- $k@1173 $k@1205) $k@1266)))
(declare-const $k@1296 $Perm)
(assert ($Perm.isValidVar $k@1296))
(assert ($Perm.isReadVar $k@1296 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1296 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1296 (+ (- $k@1175 $k@1206) $k@1267)))
; [exec]
; inhale false
(pop) ; 11
(pop) ; 10
(push) ; 10
; [else-branch 251] sys__result@1285 == $t@1223
(assert (= sys__result@1285 $t@1223))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 248] !sys__result@1285 > 1
(assert (not (> sys__result@1285 1)))
(pop) ; 9
; [eval] !(c > 1)
; [eval] c > 1
(push) ; 9
(assert (not (> sys__result@1285 1)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (> sys__result@1285 1))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 253] !sys__result@1285 > 1
(assert (not (> sys__result@1285 1)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 10
(assert (not (= $t@1176 $t@1212)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (not (= sys__result@1285 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (= sys__result@1285 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 254] sys__result@1285 == $t@1223
(assert (= sys__result@1285 $t@1223))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
(declare-const $t@1297 $Snap)
; [exec]
; assert acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__putLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1298 $Perm)
(assert ($Perm.isValidVar $k@1298))
(assert ($Perm.isReadVar $k@1298 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1298 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1298 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1299 $Perm)
(assert ($Perm.isValidVar $k@1299))
(assert ($Perm.isReadVar $k@1299 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1299 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1299 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (not (= $t@1218 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
; [dead then-branch 255] $t@1218 != Null
(push) ; 11
; [else-branch 255] $t@1218 == Null
(declare-const $k@1300 $Perm)
(assert ($Perm.isValidVar $k@1300))
(assert ($Perm.isReadVar $k@1300 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1300 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1300 (+ (- $k@1173 $k@1205) $k@1266)))
(declare-const $k@1301 $Perm)
(assert ($Perm.isValidVar $k@1301))
(assert ($Perm.isReadVar $k@1301 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1301 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1301 (+ (- $k@1175 $k@1206) $k@1267)))
; [exec]
; inhale false
(pop) ; 11
(pop) ; 10
(push) ; 10
; [else-branch 254] sys__result@1285 != $t@1223
(assert (not (= sys__result@1285 $t@1223)))
(pop) ; 10
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 10
(assert (not (= sys__result@1285 $t@1223)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= sys__result@1285 $t@1223))))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 256] sys__result@1285 != $t@1223
(assert (not (= sys__result@1285 $t@1223)))
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1302 $Perm)
(assert ($Perm.isValidVar $k@1302))
(assert ($Perm.isReadVar $k@1302 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1302 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1302 (+ (- $k@1166 $k@1203) $k@1224)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1303 $Perm)
(assert ($Perm.isValidVar $k@1303))
(assert ($Perm.isReadVar $k@1303 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@1303 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@1303 (+ (- $k@1168 $k@1204) $k@1225)))
; [eval] diz.BlockingQueue__first != null
(push) ; 11
(assert (not (not (= $t@1218 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 11
; [dead then-branch 257] $t@1218 != Null
(push) ; 11
; [else-branch 257] $t@1218 == Null
(declare-const $k@1304 $Perm)
(assert ($Perm.isValidVar $k@1304))
(assert ($Perm.isReadVar $k@1304 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1304 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1304 (+ (- $k@1173 $k@1205) $k@1266)))
(declare-const $k@1305 $Perm)
(assert ($Perm.isValidVar $k@1305))
(assert ($Perm.isReadVar $k@1305 $Perm.Write))
(push) ; 12
(assert (not (or (= $k@1305 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 12
(assert (< $k@1305 (+ (- $k@1175 $k@1206) $k@1267)))
; [exec]
; inhale false
(pop) ; 11
(pop) ; 10
(push) ; 10
; [else-branch 256] sys__result@1285 == $t@1223
(assert (= sys__result@1285 $t@1223))
(pop) ; 10
(pop) ; 9
(push) ; 9
; [else-branch 253] sys__result@1285 > 1
(assert (> sys__result@1285 1))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 230] $t@1171 == Null
(pop) ; 6
(push) ; 6
; [else-branch 229] !sys__result@1200 > 0
(assert (not (> sys__result@1200 0)))
(pop) ; 6
; [eval] !(currentCount > 0)
; [eval] currentCount > 0
(push) ; 6
(assert (not (> sys__result@1200 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (> sys__result@1200 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 258] !sys__result@1200 > 0
(assert (not (> sys__result@1200 0)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (not (= (- 0 1) $t@1167))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= (- 0 1) $t@1167)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 259] -1 == $t@1167
(push) ; 7
; [else-branch 259] -1 != $t@1167
(assert (not (= (- 0 1) $t@1167)))
(pop) ; 7
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (= (- 0 1) $t@1167)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- 0 1) $t@1167))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 260] -1 != $t@1167
(assert (not (= (- 0 1) $t@1167)))
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1306 $Perm)
(assert ($Perm.isValidVar $k@1306))
(assert ($Perm.isReadVar $k@1306 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1306 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1306 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1307 $Perm)
(assert ($Perm.isValidVar $k@1307))
(assert ($Perm.isReadVar $k@1307 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1307 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1307 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1171 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 261] $t@1171 != Null
(declare-const $k@1308 $Perm)
(assert ($Perm.isValidVar $k@1308))
(assert ($Perm.isReadVar $k@1308 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1308 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@1173 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1173 $Perm.No)))
(assert (< $k@1308 $k@1173))
(declare-const $k@1309 $Perm)
(assert ($Perm.isValidVar $k@1309))
(assert ($Perm.isReadVar $k@1309 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1309 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1309 $k@1175))
; [exec]
; inhale false
(pop) ; 8
; [dead else-branch 261] $t@1171 == Null
(pop) ; 7
; [dead else-branch 260] -1 == $t@1167
(pop) ; 6
(push) ; 6
; [else-branch 258] sys__result@1200 > 0
(assert (> sys__result@1200 0))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 228] sys__result@1192 == 0
(assert (= sys__result@1192 0))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 224] $t@1171 == Null
(assert (= $t@1171 $Ref.null))
(declare-const $k@1310 $Perm)
(assert ($Perm.isValidVar $k@1310))
(assert ($Perm.isReadVar $k@1310 $Perm.Write))
(declare-const $t@1311 $Ref)
(declare-const $k@1312 $Perm)
(assert ($Perm.isValidVar $k@1312))
(assert ($Perm.isReadVar $k@1312 $Perm.Write))
(declare-const $t@1313 $Ref)
(push) ; 4
(declare-const $k@1314 $Perm)
(assert ($Perm.isValidVar $k@1314))
(assert ($Perm.isReadVar $k@1314 $Perm.Write))
(declare-const $t@1315 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1314 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1314 $Perm.No)))
(assert (> $t@1315 0))
(declare-const $k@1316 $Perm)
(assert ($Perm.isValidVar $k@1316))
(assert ($Perm.isReadVar $k@1316 $Perm.Write))
(declare-const $t@1317 $Ref)
(push) ; 5
(assert (not (not (= $k@1316 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1316 $Perm.No)))
(assert (not (= $t@1317 $Ref.null)))
(declare-const $t@1318 Int)
(declare-const $t@1319 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1319 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1319 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 262] $t@1319 != Null
(assert (not (= $t@1319 $Ref.null)))
(declare-const $t@1320 $Snap)
(declare-const $k@1321 $Perm)
(assert ($Perm.isValidVar $k@1321))
(assert ($Perm.isReadVar $k@1321 $Perm.Write))
(declare-const $t@1322 $Ref)
(declare-const $k@1323 $Perm)
(assert ($Perm.isValidVar $k@1323))
(assert ($Perm.isReadVar $k@1323 $Perm.Write))
(declare-const $t@1324 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 262] $t@1319 == Null
(assert (= $t@1319 $Ref.null))
(declare-const $k@1325 $Perm)
(assert ($Perm.isValidVar $k@1325))
(assert ($Perm.isReadVar $k@1325 $Perm.Write))
(declare-const $t@1326 $Ref)
(declare-const $k@1327 $Perm)
(assert ($Perm.isValidVar $k@1327))
(assert ($Perm.isReadVar $k@1327 $Perm.Write))
(declare-const $t@1328 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; x := null
; [exec]
; __flatten_44 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1329 Int)
(declare-const $t@1330 $Snap)
(declare-const $t@1331 Int)
(assert (= $t@1330 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1331) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1329 $t@1331))
; [exec]
; currentCount := __flatten_44
; [eval] currentCount == 0
(push) ; 5
(assert (not (not (= sys__result@1329 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= sys__result@1329 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 263] sys__result@1329 == 0
(assert (= sys__result@1329 0))
; [exec]
; __flatten_45 := x
; [exec]
; sys__result := __flatten_45
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1332 $Perm)
(assert ($Perm.isValidVar $k@1332))
(assert ($Perm.isReadVar $k@1332 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1332 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1332 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1333 $Perm)
(assert ($Perm.isValidVar $k@1333))
(assert ($Perm.isReadVar $k@1333 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1333 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1333 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@1171 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 264] $t@1171 != Null
(push) ; 6
; [else-branch 264] $t@1171 == Null
(declare-const $k@1334 $Perm)
(assert ($Perm.isValidVar $k@1334))
(assert ($Perm.isReadVar $k@1334 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1334 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1310 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1310 $Perm.No)))
(assert (< $k@1334 $k@1310))
(declare-const $k@1335 $Perm)
(assert ($Perm.isValidVar $k@1335))
(assert ($Perm.isReadVar $k@1335 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1335 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1312 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1312 $Perm.No)))
(assert (< $k@1335 $k@1312))
; [exec]
; inhale false
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 263] sys__result@1329 != 0
(assert (not (= sys__result@1329 0)))
(pop) ; 5
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 5
(assert (not (= sys__result@1329 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= sys__result@1329 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 265] sys__result@1329 != 0
(assert (not (= sys__result@1329 0)))
; [exec]
; c := -1
; [eval] -1
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 6
(assert (not (not (= $k@1312 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1312 $Perm.No)))
(declare-const $t@1336 $Snap)
; [exec]
; __flatten_46 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1337 Int)
(declare-const $t@1338 $Snap)
(declare-const $t@1339 Int)
(assert (= $t@1338 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1339) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1337 $t@1339))
; [exec]
; currentCount := __flatten_46
; [eval] currentCount > 0
(push) ; 6
(assert (not (not (> sys__result@1337 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (> sys__result@1337 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 266] sys__result@1337 > 0
(assert (> sys__result@1337 0))
; [exec]
; inhale diz.BlockingQueue__first != null
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@1171 $Ref.null)))
; [exec]
; __flatten_47 := BlockingQueue__unlinkFirst(diz)
; [eval] diz != null
(declare-const $k@1340 $Perm)
(assert ($Perm.isValidVar $k@1340))
(assert ($Perm.isReadVar $k@1340 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1340 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1340 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1341 $Perm)
(assert ($Perm.isValidVar $k@1341))
(assert ($Perm.isReadVar $k@1341 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1341 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1341 $k@1168))
; [eval] diz.BlockingQueue__first != null
; [dead then-branch 267] $t@1171 != Null
; [dead else-branch 267] $t@1171 == Null
(pop) ; 6
(push) ; 6
; [else-branch 266] !sys__result@1337 > 0
(assert (not (> sys__result@1337 0)))
(pop) ; 6
; [eval] !(currentCount > 0)
; [eval] currentCount > 0
(push) ; 6
(assert (not (> sys__result@1337 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (> sys__result@1337 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 268] !sys__result@1337 > 0
(assert (not (> sys__result@1337 0)))
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (not (= (- 0 1) $t@1167))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= (- 0 1) $t@1167)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 269] -1 == $t@1167
(push) ; 7
; [else-branch 269] -1 != $t@1167
(assert (not (= (- 0 1) $t@1167)))
(pop) ; 7
; [eval] !(c == diz.BlockingQueue__capacity)
; [eval] c == diz.BlockingQueue__capacity
(push) ; 7
(assert (not (= (- 0 1) $t@1167)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= (- 0 1) $t@1167))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 270] -1 != $t@1167
(assert (not (= (- 0 1) $t@1167)))
; [exec]
; __flatten_50 := x
; [exec]
; sys__result := __flatten_50
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1342 $Perm)
(assert ($Perm.isValidVar $k@1342))
(assert ($Perm.isReadVar $k@1342 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1342 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1342 $k@1166))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1343 $Perm)
(assert ($Perm.isValidVar $k@1343))
(assert ($Perm.isReadVar $k@1343 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1343 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1343 $k@1168))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (not (= $t@1171 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 271] $t@1171 != Null
(push) ; 8
; [else-branch 271] $t@1171 == Null
(declare-const $k@1344 $Perm)
(assert ($Perm.isValidVar $k@1344))
(assert ($Perm.isReadVar $k@1344 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1344 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@1310 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1310 $Perm.No)))
(assert (< $k@1344 $k@1310))
(declare-const $k@1345 $Perm)
(assert ($Perm.isValidVar $k@1345))
(assert ($Perm.isReadVar $k@1345 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1345 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1345 $k@1312))
; [exec]
; inhale false
(pop) ; 8
(pop) ; 7
; [dead else-branch 270] -1 == $t@1167
(pop) ; 6
(push) ; 6
; [else-branch 268] sys__result@1337 > 0
(assert (> sys__result@1337 0))
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 265] sys__result@1329 == 0
(assert (= sys__result@1329 0))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- BlockingQueue__peek ----------
(declare-const diz@1346 $Ref)
(declare-const sys__result@1347 $Ref)
(declare-const x@1348 $Ref)
(declare-const currentCount@1349 Int)
(declare-const __flatten_51@1350 Int)
(declare-const __flatten_52@1351 $Ref)
(declare-const __flatten_53@1352 $Ref)
(declare-const __flatten_54@1353 $Ref)
(declare-const __flatten_55@1354 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1346 $Ref.null)))
(declare-const $k@1355 $Perm)
(assert ($Perm.isValidVar $k@1355))
(assert ($Perm.isReadVar $k@1355 $Perm.Write))
(declare-const $t@1356 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1355 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1355 $Perm.No)))
(assert (> $t@1356 0))
(declare-const $k@1357 $Perm)
(assert ($Perm.isValidVar $k@1357))
(assert ($Perm.isReadVar $k@1357 $Perm.Write))
(declare-const $t@1358 $Ref)
(push) ; 3
(assert (not (not (= $k@1357 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1357 $Perm.No)))
(assert (not (= $t@1358 $Ref.null)))
(declare-const $t@1359 Int)
(declare-const $t@1360 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@1360 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@1360 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 272] $t@1360 != Null
(assert (not (= $t@1360 $Ref.null)))
(declare-const $t@1361 $Snap)
(declare-const $k@1362 $Perm)
(assert ($Perm.isValidVar $k@1362))
(assert ($Perm.isReadVar $k@1362 $Perm.Write))
(declare-const $t@1363 $Ref)
(declare-const $k@1364 $Perm)
(assert ($Perm.isValidVar $k@1364))
(assert ($Perm.isReadVar $k@1364 $Perm.Write))
(declare-const $t@1365 $Ref)
(push) ; 4
(declare-const $k@1366 $Perm)
(assert ($Perm.isValidVar $k@1366))
(assert ($Perm.isReadVar $k@1366 $Perm.Write))
(declare-const $t@1367 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1366 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1366 $Perm.No)))
(assert (> $t@1367 0))
(declare-const $k@1368 $Perm)
(assert ($Perm.isValidVar $k@1368))
(assert ($Perm.isReadVar $k@1368 $Perm.Write))
(declare-const $t@1369 $Ref)
(push) ; 5
(assert (not (not (= $k@1368 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1368 $Perm.No)))
(assert (not (= $t@1369 $Ref.null)))
(declare-const $t@1370 Int)
(declare-const $t@1371 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1371 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1371 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 273] $t@1371 != Null
(assert (not (= $t@1371 $Ref.null)))
(declare-const $t@1372 $Snap)
(declare-const $k@1373 $Perm)
(assert ($Perm.isValidVar $k@1373))
(assert ($Perm.isReadVar $k@1373 $Perm.Write))
(declare-const $t@1374 $Ref)
(declare-const $k@1375 $Perm)
(assert ($Perm.isValidVar $k@1375))
(assert ($Perm.isReadVar $k@1375 $Perm.Write))
(declare-const $t@1376 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 273] $t@1371 == Null
(assert (= $t@1371 $Ref.null))
(declare-const $k@1377 $Perm)
(assert ($Perm.isValidVar $k@1377))
(assert ($Perm.isReadVar $k@1377 $Perm.Write))
(declare-const $t@1378 $Ref)
(declare-const $k@1379 $Perm)
(assert ($Perm.isValidVar $k@1379))
(assert ($Perm.isReadVar $k@1379 $Perm.Write))
(declare-const $t@1380 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; x := null
; [exec]
; __flatten_51 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1381 Int)
(declare-const $t@1382 $Snap)
(declare-const $t@1383 Int)
(assert (= $t@1382 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1383) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1381 $t@1383))
; [exec]
; currentCount := __flatten_51
; [eval] currentCount == 0
(push) ; 5
(assert (not (not (= sys__result@1381 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= sys__result@1381 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 274] sys__result@1381 == 0
(assert (= sys__result@1381 0))
; [exec]
; __flatten_52 := x
; [exec]
; sys__result := __flatten_52
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1384 $Perm)
(assert ($Perm.isValidVar $k@1384))
(assert ($Perm.isReadVar $k@1384 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1384 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1384 $k@1355))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1385 $Perm)
(assert ($Perm.isValidVar $k@1385))
(assert ($Perm.isReadVar $k@1385 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1385 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1385 $k@1357))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@1360 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 275] $t@1360 != Null
(declare-const $k@1386 $Perm)
(assert ($Perm.isValidVar $k@1386))
(assert ($Perm.isReadVar $k@1386 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1386 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1362 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1362 $Perm.No)))
(assert (< $k@1386 $k@1362))
(declare-const $k@1387 $Perm)
(assert ($Perm.isValidVar $k@1387))
(assert ($Perm.isReadVar $k@1387 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1387 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1364 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1364 $Perm.No)))
(assert (< $k@1387 $k@1364))
; [exec]
; inhale false
(pop) ; 6
; [dead else-branch 275] $t@1360 == Null
(pop) ; 5
(push) ; 5
; [else-branch 274] sys__result@1381 != 0
(assert (not (= sys__result@1381 0)))
(pop) ; 5
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 5
(assert (not (= sys__result@1381 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= sys__result@1381 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 276] sys__result@1381 != 0
(assert (not (= sys__result@1381 0)))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 6
(assert (not (not (= $k@1364 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1364 $Perm.No)))
(declare-const $t@1388 $Snap)
; [exec]
; inhale diz.BlockingQueue__first != null
; [eval] diz.BlockingQueue__first != null
; [exec]
; unfold acc(Node__state(diz.BlockingQueue__first), write)
(declare-const $t@1389 $Snap)
(declare-const $t@1390 $Snap)
(assert (= $t@1361 ($Snap.combine $t@1389 $t@1390)))
(declare-const $t@1391 Int)
(declare-const $t@1392 $Ref)
(assert (=
  $t@1389
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1391)
    ($SortWrappers.$RefTo$Snap $t@1392))))
(declare-const $k@1393 $Perm)
(assert ($Perm.isValidVar $k@1393))
(assert ($Perm.isReadVar $k@1393 $Perm.Write))
; [eval] diz.BlockingQueue__first.Node__next != null
(push) ; 6
(assert (not (= $t@1392 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@1392 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 277] $t@1392 != Null
(assert (not (= $t@1392 $Ref.null)))
; [exec]
; __flatten_53 := diz.BlockingQueue__first
; [exec]
; __flatten_54 := Integer__Integer(__flatten_53.Node__val)
(push) ; 7
(assert (not (not (= $k@1393 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1393 $Perm.No)))
(declare-const sys__result@1394 $Ref)
(declare-const $t@1395 $Snap)
(declare-const $t@1396 Int)
(assert (= $t@1395 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1396) $Snap.unit)))
(declare-const $t@1397 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1396)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1397))))
; [eval] sys__result != null
(assert (not (= sys__result@1394 $Ref.null)))
(declare-const $k@1398 $Perm)
(assert ($Perm.isValidVar $k@1398))
(assert ($Perm.isReadVar $k@1398 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 7
(assert (not (not (= $k@1398 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1398 $Perm.No)))
(assert (= $t@1397 $t@1391))
; [exec]
; x := __flatten_54
; [exec]
; fold acc(Node__state(diz.BlockingQueue__first), write)
(declare-const $k@1399 $Perm)
(assert ($Perm.isValidVar $k@1399))
(assert ($Perm.isReadVar $k@1399 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1399 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1399 $k@1393))
; [eval] diz.Node__next != null
(push) ; 7
(assert (not (= $t@1392 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 278] $t@1392 != Null
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_55 := x
; [exec]
; sys__result := __flatten_55
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1400 $Perm)
(assert ($Perm.isValidVar $k@1400))
(assert ($Perm.isReadVar $k@1400 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1400 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1400 $k@1355))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1401 $Perm)
(assert ($Perm.isValidVar $k@1401))
(assert ($Perm.isReadVar $k@1401 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1401 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1401 $k@1357))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1360 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 279] $t@1360 != Null
(declare-const $k@1402 $Perm)
(assert ($Perm.isValidVar $k@1402))
(assert ($Perm.isReadVar $k@1402 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1402 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@1362 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1362 $Perm.No)))
(assert (< $k@1402 $k@1362))
(declare-const $k@1403 $Perm)
(assert ($Perm.isValidVar $k@1403))
(assert ($Perm.isReadVar $k@1403 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1403 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1403 $k@1364))
; [exec]
; inhale false
(pop) ; 8
; [dead else-branch 279] $t@1360 == Null
(pop) ; 7
; [dead else-branch 278] $t@1392 == Null
(pop) ; 6
(push) ; 6
; [else-branch 277] $t@1392 == Null
(assert (= $t@1392 $Ref.null))
; [exec]
; __flatten_53 := diz.BlockingQueue__first
; [exec]
; __flatten_54 := Integer__Integer(__flatten_53.Node__val)
(push) ; 7
(assert (not (not (= $k@1393 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1393 $Perm.No)))
(declare-const sys__result@1404 $Ref)
(declare-const $t@1405 $Snap)
(declare-const $t@1406 Int)
(assert (= $t@1405 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1406) $Snap.unit)))
(declare-const $t@1407 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1406)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@1407))))
; [eval] sys__result != null
(assert (not (= sys__result@1404 $Ref.null)))
(declare-const $k@1408 $Perm)
(assert ($Perm.isValidVar $k@1408))
(assert ($Perm.isReadVar $k@1408 $Perm.Write))
; [eval] sys__result.Integer__val == val
(push) ; 7
(assert (not (not (= $k@1408 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1408 $Perm.No)))
(assert (= $t@1407 $t@1391))
; [exec]
; x := __flatten_54
; [exec]
; fold acc(Node__state(diz.BlockingQueue__first), write)
(declare-const $k@1409 $Perm)
(assert ($Perm.isValidVar $k@1409))
(assert ($Perm.isReadVar $k@1409 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1409 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1409 $k@1393))
; [eval] diz.Node__next != null
(push) ; 7
(assert (not (not (= $t@1392 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 280] $t@1392 != Null
(push) ; 7
; [else-branch 280] $t@1392 == Null
; [exec]
; exhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
; [exec]
; exhale true
; [exec]
; __flatten_55 := x
; [exec]
; sys__result := __flatten_55
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1410 $Perm)
(assert ($Perm.isValidVar $k@1410))
(assert ($Perm.isReadVar $k@1410 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1410 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1410 $k@1355))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1411 $Perm)
(assert ($Perm.isValidVar $k@1411))
(assert ($Perm.isReadVar $k@1411 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1411 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (< $k@1411 $k@1357))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1360 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 281] $t@1360 != Null
(declare-const $k@1412 $Perm)
(assert ($Perm.isValidVar $k@1412))
(assert ($Perm.isReadVar $k@1412 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1412 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@1362 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@1362 $Perm.No)))
(assert (< $k@1412 $k@1362))
(declare-const $k@1413 $Perm)
(assert ($Perm.isValidVar $k@1413))
(assert ($Perm.isReadVar $k@1413 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1413 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1413 $k@1364))
; [exec]
; inhale false
(pop) ; 8
; [dead else-branch 281] $t@1360 == Null
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 276] sys__result@1381 == 0
(assert (= sys__result@1381 0))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 272] $t@1360 == Null
(assert (= $t@1360 $Ref.null))
(declare-const $k@1414 $Perm)
(assert ($Perm.isValidVar $k@1414))
(assert ($Perm.isReadVar $k@1414 $Perm.Write))
(declare-const $t@1415 $Ref)
(declare-const $k@1416 $Perm)
(assert ($Perm.isValidVar $k@1416))
(assert ($Perm.isReadVar $k@1416 $Perm.Write))
(declare-const $t@1417 $Ref)
(push) ; 4
(declare-const $k@1418 $Perm)
(assert ($Perm.isValidVar $k@1418))
(assert ($Perm.isReadVar $k@1418 $Perm.Write))
(declare-const $t@1419 Int)
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1418 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1418 $Perm.No)))
(assert (> $t@1419 0))
(declare-const $k@1420 $Perm)
(assert ($Perm.isValidVar $k@1420))
(assert ($Perm.isReadVar $k@1420 $Perm.Write))
(declare-const $t@1421 $Ref)
(push) ; 5
(assert (not (not (= $k@1420 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1420 $Perm.No)))
(assert (not (= $t@1421 $Ref.null)))
(declare-const $t@1422 Int)
(declare-const $t@1423 $Ref)
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1423 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1423 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 282] $t@1423 != Null
(assert (not (= $t@1423 $Ref.null)))
(declare-const $t@1424 $Snap)
(declare-const $k@1425 $Perm)
(assert ($Perm.isValidVar $k@1425))
(assert ($Perm.isReadVar $k@1425 $Perm.Write))
(declare-const $t@1426 $Ref)
(declare-const $k@1427 $Perm)
(assert ($Perm.isValidVar $k@1427))
(assert ($Perm.isReadVar $k@1427 $Perm.Write))
(declare-const $t@1428 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 282] $t@1423 == Null
(assert (= $t@1423 $Ref.null))
(declare-const $k@1429 $Perm)
(assert ($Perm.isValidVar $k@1429))
(assert ($Perm.isReadVar $k@1429 $Perm.Write))
(declare-const $t@1430 $Ref)
(declare-const $k@1431 $Perm)
(assert ($Perm.isValidVar $k@1431))
(assert ($Perm.isReadVar $k@1431 $Perm.Write))
(declare-const $t@1432 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; x := null
; [exec]
; __flatten_51 := AtomicInteger__get(diz.BlockingQueue__count)
; [eval] diz != null
(declare-const sys__result@1433 Int)
(declare-const $t@1434 $Snap)
(declare-const $t@1435 Int)
(assert (= $t@1434 ($Snap.combine ($SortWrappers.IntTo$Snap $t@1435) $Snap.unit)))
; [eval] sys__result == diz.AtomicInteger__ghostVal
(assert (= sys__result@1433 $t@1435))
; [exec]
; currentCount := __flatten_51
; [eval] currentCount == 0
(push) ; 5
(assert (not (not (= sys__result@1433 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (= sys__result@1433 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 283] sys__result@1433 == 0
(assert (= sys__result@1433 0))
; [exec]
; __flatten_52 := x
; [exec]
; sys__result := __flatten_52
; [exec]
; assert acc(diz.BlockingQueue__capacity, wildcard) && (diz.BlockingQueue__capacity > 0) && acc(diz.BlockingQueue__count, wildcard) && acc(diz.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(diz.BlockingQueue__first, write) && ((diz.BlockingQueue__first != null) ==> acc(Node__state(diz.BlockingQueue__first), write)) && acc(diz.BlockingQueue__putLock, wildcard) && acc(diz.BlockingQueue__takeLock, wildcard)
(declare-const $k@1436 $Perm)
(assert ($Perm.isValidVar $k@1436))
(assert ($Perm.isReadVar $k@1436 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1436 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1436 $k@1355))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1437 $Perm)
(assert ($Perm.isValidVar $k@1437))
(assert ($Perm.isReadVar $k@1437 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1437 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@1437 $k@1357))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (not (= $t@1360 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 284] $t@1360 != Null
(push) ; 6
; [else-branch 284] $t@1360 == Null
(declare-const $k@1438 $Perm)
(assert ($Perm.isValidVar $k@1438))
(assert ($Perm.isReadVar $k@1438 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1438 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1414 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1414 $Perm.No)))
(assert (< $k@1438 $k@1414))
(declare-const $k@1439 $Perm)
(assert ($Perm.isValidVar $k@1439))
(assert ($Perm.isReadVar $k@1439 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1439 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@1416 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@1416 $Perm.No)))
(assert (< $k@1439 $k@1416))
; [exec]
; inhale false
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 283] sys__result@1433 != 0
(assert (not (= sys__result@1433 0)))
(pop) ; 5
; [eval] !(currentCount == 0)
; [eval] currentCount == 0
(push) ; 5
(assert (not (= sys__result@1433 0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= sys__result@1433 0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 285] sys__result@1433 != 0
(assert (not (= sys__result@1433 0)))
; [exec]
; inhale true
; [exec]
; inhale acc(Lock__lock_held(diz.BlockingQueue__takeLock), write)
(push) ; 6
(assert (not (not (= $k@1416 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1416 $Perm.No)))
(declare-const $t@1440 $Snap)
; [exec]
; inhale diz.BlockingQueue__first != null
; [eval] diz.BlockingQueue__first != null
(assert (not (= $t@1360 $Ref.null)))
; [exec]
; unfold acc(Node__state(diz.BlockingQueue__first), write)
(check-sat)
; unsat
(pop) ; 5
(push) ; 5
; [else-branch 285] sys__result@1433 == 0
(assert (= sys__result@1433 0))
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Integer__Integer ----------
(declare-const val@1441 Int)
(declare-const sys__result@1442 $Ref)
(declare-const diz@1443 $Ref)
(declare-const __flatten_56@1444 Int)
(declare-const __flatten_116@1445 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@1442 $Ref.null)))
(declare-const $k@1446 $Perm)
(assert ($Perm.isValidVar $k@1446))
(assert ($Perm.isReadVar $k@1446 $Perm.Write))
(declare-const $t@1447 Int)
; [eval] sys__result.Integer__val == val
(push) ; 4
(assert (not (not (= $k@1446 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@1446 $Perm.No)))
(assert (= $t@1447 val@1441))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(Integer__val)
(declare-const diz@1448 $Ref)
(assert (not (= diz@1448 $Ref.null)))
(declare-const Integer__val@1449 Int)
(assert (not (= sys__result@1442 diz@1448)))
; [exec]
; __flatten_56 := val
; [exec]
; __flatten_116 := __flatten_56
; [exec]
; diz.Integer__val := __flatten_116
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.Integer__val, wildcard) && (sys__result.Integer__val == val)
; [eval] sys__result != null
(declare-const $k@1450 $Perm)
(assert ($Perm.isValidVar $k@1450))
(assert ($Perm.isReadVar $k@1450 $Perm.Write))
(push) ; 4
(assert (not (or (= $k@1450 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (< $k@1450 $Perm.Write))
; [eval] sys__result.Integer__val == val
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
; ---------- LBQThread1a__LBQThread1a ----------
(declare-const queue@1451 $Ref)
(declare-const sys__result@1452 $Ref)
(declare-const diz@1453 $Ref)
(declare-const __flatten_57@1454 $Ref)
(declare-const __flatten_117@1455 $Ref)
(push) ; 2
(assert (not (= queue@1451 $Ref.null)))
(declare-const $k@1456 $Perm)
(assert ($Perm.isValidVar $k@1456))
(assert ($Perm.isReadVar $k@1456 $Perm.Write))
(declare-const $t@1457 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1456 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1456 $Perm.No)))
(assert (> $t@1457 0))
(declare-const $k@1458 $Perm)
(assert ($Perm.isValidVar $k@1458))
(assert ($Perm.isReadVar $k@1458 $Perm.Write))
(declare-const $t@1459 $Ref)
(push) ; 3
(assert (not (not (= $k@1458 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1458 $Perm.No)))
(assert (not (= $t@1459 $Ref.null)))
(declare-const $t@1460 Int)
(declare-const $t@1461 $Ref)
; [eval] queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@1461 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@1461 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 286] $t@1461 != Null
(assert (not (= $t@1461 $Ref.null)))
(declare-const $t@1462 $Snap)
(declare-const $k@1463 $Perm)
(assert ($Perm.isValidVar $k@1463))
(assert ($Perm.isReadVar $k@1463 $Perm.Write))
(declare-const $t@1464 $Ref)
(declare-const $k@1465 $Perm)
(assert ($Perm.isValidVar $k@1465))
(assert ($Perm.isReadVar $k@1465 $Perm.Write))
(declare-const $t@1466 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@1452 $Ref.null)))
(declare-const $k@1467 $Perm)
(assert ($Perm.isValidVar $k@1467))
(assert ($Perm.isReadVar $k@1467 $Perm.Write))
(declare-const $t@1468 $Ref)
(push) ; 5
(assert (not (not (= $k@1467 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1467 $Perm.No)))
(assert (not (= $t@1468 $Ref.null)))
(declare-const $k@1469 $Perm)
(assert ($Perm.isValidVar $k@1469))
(assert ($Perm.isReadVar $k@1469 $Perm.Write))
(declare-const $t@1470 Int)
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1469 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1469 $Perm.No)))
(assert (> $t@1470 0))
(declare-const $k@1471 $Perm)
(assert ($Perm.isValidVar $k@1471))
(assert ($Perm.isReadVar $k@1471 $Perm.Write))
(declare-const $t@1472 $Ref)
(push) ; 5
(assert (not (not (= $k@1471 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1471 $Perm.No)))
(assert (not (= $t@1472 $Ref.null)))
(declare-const $t@1473 Int)
(declare-const $t@1474 $Ref)
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1474 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1474 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 287] $t@1474 != Null
(assert (not (= $t@1474 $Ref.null)))
(declare-const $t@1475 $Snap)
(declare-const $k@1476 $Perm)
(assert ($Perm.isValidVar $k@1476))
(assert ($Perm.isReadVar $k@1476 $Perm.Write))
(declare-const $t@1477 $Ref)
(declare-const $k@1478 $Perm)
(assert ($Perm.isValidVar $k@1478))
(assert ($Perm.isReadVar $k@1478 $Perm.Write))
(declare-const $t@1479 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 287] $t@1474 == Null
(assert (= $t@1474 $Ref.null))
(declare-const $k@1480 $Perm)
(assert ($Perm.isValidVar $k@1480))
(assert ($Perm.isReadVar $k@1480 $Perm.Write))
(declare-const $t@1481 $Ref)
(declare-const $k@1482 $Perm)
(assert ($Perm.isValidVar $k@1482))
(assert ($Perm.isReadVar $k@1482 $Perm.Write))
(declare-const $t@1483 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread1a__queue)
(declare-const diz@1484 $Ref)
(assert (not (= diz@1484 $Ref.null)))
(declare-const LBQThread1a__queue@1485 $Ref)
(assert (and
  (not (= queue@1451 diz@1484))
  (not (= sys__result@1452 diz@1484))
  (not (= __flatten_57@1454 diz@1484))
  (not (= __flatten_117@1455 diz@1484))
  (not (= $t@1459 diz@1484))
  (not (= $t@1461 diz@1484))
  (not (= LBQThread1a__queue@1485 diz@1484))
  (not (= $t@1464 diz@1484))
  (not (= $t@1466 diz@1484))))
; [exec]
; __flatten_57 := queue
; [exec]
; __flatten_117 := __flatten_57
; [exec]
; diz.LBQThread1a__queue := __flatten_117
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread1a__queue, wildcard) && acc(sys__result.LBQThread1a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread1a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread1a__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread1a__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread1a__queue.BlockingQueue__first, write) && ((sys__result.LBQThread1a__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread1a__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread1a__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread1a__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@1486 $Perm)
(assert ($Perm.isValidVar $k@1486))
(assert ($Perm.isReadVar $k@1486 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1486 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1486 $Perm.Write))
(declare-const $k@1487 $Perm)
(assert ($Perm.isValidVar $k@1487))
(assert ($Perm.isReadVar $k@1487 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1487 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1487 $k@1456))
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1488 $Perm)
(assert ($Perm.isValidVar $k@1488))
(assert ($Perm.isReadVar $k@1488 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1488 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1488 $k@1458))
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1461 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 288] $t@1461 != Null
(declare-const $k@1489 $Perm)
(assert ($Perm.isValidVar $k@1489))
(assert ($Perm.isReadVar $k@1489 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1489 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1463 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1463 $Perm.No)))
(assert (< $k@1489 $k@1463))
(declare-const $k@1490 $Perm)
(assert ($Perm.isValidVar $k@1490))
(assert ($Perm.isReadVar $k@1490 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1490 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1465 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1465 $Perm.No)))
(assert (< $k@1490 $k@1465))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 288] $t@1461 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 286] $t@1461 == Null
(assert (= $t@1461 $Ref.null))
(declare-const $k@1491 $Perm)
(assert ($Perm.isValidVar $k@1491))
(assert ($Perm.isReadVar $k@1491 $Perm.Write))
(declare-const $t@1492 $Ref)
(declare-const $k@1493 $Perm)
(assert ($Perm.isValidVar $k@1493))
(assert ($Perm.isReadVar $k@1493 $Perm.Write))
(declare-const $t@1494 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@1452 $Ref.null)))
(declare-const $k@1495 $Perm)
(assert ($Perm.isValidVar $k@1495))
(assert ($Perm.isReadVar $k@1495 $Perm.Write))
(declare-const $t@1496 $Ref)
(push) ; 5
(assert (not (not (= $k@1495 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1495 $Perm.No)))
(assert (not (= $t@1496 $Ref.null)))
(declare-const $k@1497 $Perm)
(assert ($Perm.isValidVar $k@1497))
(assert ($Perm.isReadVar $k@1497 $Perm.Write))
(declare-const $t@1498 Int)
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1497 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1497 $Perm.No)))
(assert (> $t@1498 0))
(declare-const $k@1499 $Perm)
(assert ($Perm.isValidVar $k@1499))
(assert ($Perm.isReadVar $k@1499 $Perm.Write))
(declare-const $t@1500 $Ref)
(push) ; 5
(assert (not (not (= $k@1499 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1499 $Perm.No)))
(assert (not (= $t@1500 $Ref.null)))
(declare-const $t@1501 Int)
(declare-const $t@1502 $Ref)
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1502 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1502 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 289] $t@1502 != Null
(assert (not (= $t@1502 $Ref.null)))
(declare-const $t@1503 $Snap)
(declare-const $k@1504 $Perm)
(assert ($Perm.isValidVar $k@1504))
(assert ($Perm.isReadVar $k@1504 $Perm.Write))
(declare-const $t@1505 $Ref)
(declare-const $k@1506 $Perm)
(assert ($Perm.isValidVar $k@1506))
(assert ($Perm.isReadVar $k@1506 $Perm.Write))
(declare-const $t@1507 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 289] $t@1502 == Null
(assert (= $t@1502 $Ref.null))
(declare-const $k@1508 $Perm)
(assert ($Perm.isValidVar $k@1508))
(assert ($Perm.isReadVar $k@1508 $Perm.Write))
(declare-const $t@1509 $Ref)
(declare-const $k@1510 $Perm)
(assert ($Perm.isValidVar $k@1510))
(assert ($Perm.isReadVar $k@1510 $Perm.Write))
(declare-const $t@1511 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread1a__queue)
(declare-const diz@1512 $Ref)
(assert (not (= diz@1512 $Ref.null)))
(declare-const LBQThread1a__queue@1513 $Ref)
(assert (and
  (not (= queue@1451 diz@1512))
  (not (= sys__result@1452 diz@1512))
  (not (= __flatten_57@1454 diz@1512))
  (not (= __flatten_117@1455 diz@1512))
  (not (= $t@1459 diz@1512))
  (not (= LBQThread1a__queue@1513 diz@1512))
  (not (= $t@1461 diz@1512))
  (not (= $t@1492 diz@1512))
  (not (= $t@1494 diz@1512))))
; [exec]
; __flatten_57 := queue
; [exec]
; __flatten_117 := __flatten_57
; [exec]
; diz.LBQThread1a__queue := __flatten_117
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread1a__queue, wildcard) && acc(sys__result.LBQThread1a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread1a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread1a__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread1a__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread1a__queue.BlockingQueue__first, write) && ((sys__result.LBQThread1a__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread1a__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread1a__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread1a__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@1514 $Perm)
(assert ($Perm.isValidVar $k@1514))
(assert ($Perm.isReadVar $k@1514 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1514 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1514 $Perm.Write))
(declare-const $k@1515 $Perm)
(assert ($Perm.isValidVar $k@1515))
(assert ($Perm.isReadVar $k@1515 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1515 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1515 $k@1456))
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1516 $Perm)
(assert ($Perm.isValidVar $k@1516))
(assert ($Perm.isReadVar $k@1516 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1516 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1516 $k@1458))
; [eval] sys__result.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@1461 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 290] $t@1461 != Null
(push) ; 5
; [else-branch 290] $t@1461 == Null
(declare-const $k@1517 $Perm)
(assert ($Perm.isValidVar $k@1517))
(assert ($Perm.isReadVar $k@1517 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1517 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1491 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1491 $Perm.No)))
(assert (< $k@1517 $k@1491))
(declare-const $k@1518 $Perm)
(assert ($Perm.isValidVar $k@1518))
(assert ($Perm.isReadVar $k@1518 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1518 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1493 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1493 $Perm.No)))
(assert (< $k@1518 $k@1493))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread1a__run ----------
(declare-const diz@1519 $Ref)
(declare-const b@1520 Bool)
(declare-const __flatten_58@1521 Bool)
(declare-const i@1522 $Ref)
(declare-const __flatten_59@1523 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1519 $Ref.null)))
(declare-const $k@1524 $Perm)
(assert ($Perm.isValidVar $k@1524))
(assert ($Perm.isReadVar $k@1524 $Perm.Write))
(declare-const $t@1525 $Ref)
(push) ; 3
(assert (not (not (= $k@1524 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1524 $Perm.No)))
(assert (not (= $t@1525 $Ref.null)))
(declare-const $k@1526 $Perm)
(assert ($Perm.isValidVar $k@1526))
(assert ($Perm.isReadVar $k@1526 $Perm.Write))
(declare-const $t@1527 Int)
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1526 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1526 $Perm.No)))
(assert (> $t@1527 0))
(declare-const $k@1528 $Perm)
(assert ($Perm.isValidVar $k@1528))
(assert ($Perm.isReadVar $k@1528 $Perm.Write))
(declare-const $t@1529 $Ref)
(push) ; 3
(assert (not (not (= $k@1528 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1528 $Perm.No)))
(assert (not (= $t@1529 $Ref.null)))
(declare-const $t@1530 Int)
(declare-const $t@1531 $Ref)
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@1531 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@1531 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 291] $t@1531 != Null
(assert (not (= $t@1531 $Ref.null)))
(declare-const $t@1532 $Snap)
(declare-const $k@1533 $Perm)
(assert ($Perm.isValidVar $k@1533))
(assert ($Perm.isReadVar $k@1533 $Perm.Write))
(declare-const $t@1534 $Ref)
(declare-const $k@1535 $Perm)
(assert ($Perm.isValidVar $k@1535))
(assert ($Perm.isReadVar $k@1535 $Perm.Write))
(declare-const $t@1536 $Ref)
(push) ; 4
(declare-const $k@1537 $Perm)
(assert ($Perm.isValidVar $k@1537))
(assert ($Perm.isReadVar $k@1537 $Perm.Write))
(declare-const $t@1538 $Ref)
(push) ; 5
(assert (not (not (= $k@1537 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1537 $Perm.No)))
(assert (not (= $t@1538 $Ref.null)))
(declare-const $k@1539 $Perm)
(assert ($Perm.isValidVar $k@1539))
(assert ($Perm.isReadVar $k@1539 $Perm.Write))
(declare-const $t@1540 Int)
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1539 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1539 $Perm.No)))
(assert (> $t@1540 0))
(declare-const $k@1541 $Perm)
(assert ($Perm.isValidVar $k@1541))
(assert ($Perm.isReadVar $k@1541 $Perm.Write))
(declare-const $t@1542 $Ref)
(push) ; 5
(assert (not (not (= $k@1541 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1541 $Perm.No)))
(assert (not (= $t@1542 $Ref.null)))
(declare-const $t@1543 Int)
(declare-const $t@1544 $Ref)
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1544 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1544 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 292] $t@1544 != Null
(assert (not (= $t@1544 $Ref.null)))
(declare-const $t@1545 $Snap)
(declare-const $k@1546 $Perm)
(assert ($Perm.isValidVar $k@1546))
(assert ($Perm.isReadVar $k@1546 $Perm.Write))
(declare-const $t@1547 $Ref)
(declare-const $k@1548 $Perm)
(assert ($Perm.isValidVar $k@1548))
(assert ($Perm.isReadVar $k@1548 $Perm.Write))
(declare-const $t@1549 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 292] $t@1544 == Null
(assert (= $t@1544 $Ref.null))
(declare-const $k@1550 $Perm)
(assert ($Perm.isValidVar $k@1550))
(assert ($Perm.isReadVar $k@1550 $Perm.Write))
(declare-const $t@1551 $Ref)
(declare-const $k@1552 $Perm)
(assert ($Perm.isValidVar $k@1552))
(assert ($Perm.isReadVar $k@1552 $Perm.Write))
(declare-const $t@1553 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_58 := BlockingQueue__offer(diz.LBQThread1a__queue, 1)
; [eval] diz != null
(declare-const $k@1554 $Perm)
(assert ($Perm.isValidVar $k@1554))
(assert ($Perm.isReadVar $k@1554 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1554 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1554 $k@1526))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1555 $Perm)
(assert ($Perm.isValidVar $k@1555))
(assert ($Perm.isReadVar $k@1555 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1555 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1555 $k@1528))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1531 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 293] $t@1531 != Null
(declare-const $k@1556 $Perm)
(assert ($Perm.isValidVar $k@1556))
(assert ($Perm.isReadVar $k@1556 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1556 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1533 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1533 $Perm.No)))
(assert (< $k@1556 $k@1533))
(declare-const $k@1557 $Perm)
(assert ($Perm.isValidVar $k@1557))
(assert ($Perm.isReadVar $k@1557 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1557 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1535 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1535 $Perm.No)))
(assert (< $k@1557 $k@1535))
(declare-const sys__result@1558 Bool)
(declare-const $t@1559 $Snap)
(declare-const $t@1560 $Snap)
(declare-const $t@1561 $Ref)
(assert (= $t@1559 ($Snap.combine $t@1560 ($SortWrappers.$RefTo$Snap $t@1561))))
(declare-const $t@1562 $Snap)
(declare-const $t@1563 $Ref)
(assert (= $t@1560 ($Snap.combine $t@1562 ($SortWrappers.$RefTo$Snap $t@1563))))
(declare-const $t@1564 $Snap)
(declare-const $t@1565 $Snap)
(assert (= $t@1562 ($Snap.combine $t@1564 $t@1565)))
(declare-const $t@1566 $Snap)
(declare-const $t@1567 $Ref)
(assert (= $t@1564 ($Snap.combine $t@1566 ($SortWrappers.$RefTo$Snap $t@1567))))
(declare-const $t@1568 $Snap)
(declare-const $t@1569 Int)
(assert (= $t@1566 ($Snap.combine $t@1568 ($SortWrappers.IntTo$Snap $t@1569))))
(declare-const $t@1570 Int)
(declare-const $t@1571 $Ref)
(assert (=
  $t@1568
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1570)
    ($SortWrappers.$RefTo$Snap $t@1571))))
(declare-const $t@1572 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1570)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1572) $Snap.unit)))
(declare-const $k@1573 $Perm)
(assert ($Perm.isValidVar $k@1573))
(assert ($Perm.isReadVar $k@1573 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1526 $k@1554)) (= $t@1572 $t@1527)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@1526 $k@1554) $k@1573) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1526 $k@1554) $k@1573) $Perm.No)))
(assert (> $t@1572 0))
(declare-const $k@1574 $Perm)
(assert ($Perm.isValidVar $k@1574))
(assert ($Perm.isReadVar $k@1574 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1528 $k@1555)) (= $t@1571 $t@1529)))
(push) ; 6
(assert (not (not (= (+ (- $k@1528 $k@1555) $k@1574) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1528 $k@1555) $k@1574) $Perm.No)))
(assert (not (= $t@1571 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@1567 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@1567 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 294] $t@1567 != Null
(assert (not (= $t@1567 $Ref.null)))
(declare-const $k@1575 $Perm)
(assert ($Perm.isValidVar $k@1575))
(assert ($Perm.isReadVar $k@1575 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1533 $k@1556)) (= $t@1563 $t@1534)))
(declare-const $k@1576 $Perm)
(assert ($Perm.isValidVar $k@1576))
(assert ($Perm.isReadVar $k@1576 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1535 $k@1557)) (= $t@1561 $t@1536)))
; [exec]
; b := __flatten_58
; [exec]
; __flatten_59 := BlockingQueue__peek(diz.LBQThread1a__queue)
; [eval] diz != null
(declare-const $k@1577 $Perm)
(assert ($Perm.isValidVar $k@1577))
(assert ($Perm.isReadVar $k@1577 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1577 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1577 (+ (- $k@1526 $k@1554) $k@1573)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1578 $Perm)
(assert ($Perm.isValidVar $k@1578))
(assert ($Perm.isReadVar $k@1578 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1578 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1578 (+ (- $k@1528 $k@1555) $k@1574)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@1567 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 295] $t@1567 != Null
(declare-const $k@1579 $Perm)
(assert ($Perm.isValidVar $k@1579))
(assert ($Perm.isReadVar $k@1579 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1579 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1533 $k@1556) $k@1575) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1533 $k@1556) $k@1575) $Perm.No)))
(assert (< $k@1579 (+ (- $k@1533 $k@1556) $k@1575)))
(declare-const $k@1580 $Perm)
(assert ($Perm.isValidVar $k@1580))
(assert ($Perm.isReadVar $k@1580 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1580 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1535 $k@1557) $k@1576) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1535 $k@1557) $k@1576) $Perm.No)))
(assert (< $k@1580 (+ (- $k@1535 $k@1557) $k@1576)))
(declare-const sys__result@1581 $Ref)
(declare-const $t@1582 $Snap)
(declare-const $t@1583 $Snap)
(declare-const $t@1584 $Ref)
(assert (= $t@1582 ($Snap.combine $t@1583 ($SortWrappers.$RefTo$Snap $t@1584))))
(declare-const $t@1585 $Snap)
(declare-const $t@1586 $Ref)
(assert (= $t@1583 ($Snap.combine $t@1585 ($SortWrappers.$RefTo$Snap $t@1586))))
(declare-const $t@1587 $Snap)
(declare-const $t@1588 $Snap)
(assert (= $t@1585 ($Snap.combine $t@1587 $t@1588)))
(declare-const $t@1589 $Snap)
(declare-const $t@1590 $Ref)
(assert (= $t@1587 ($Snap.combine $t@1589 ($SortWrappers.$RefTo$Snap $t@1590))))
(declare-const $t@1591 $Snap)
(declare-const $t@1592 Int)
(assert (= $t@1589 ($Snap.combine $t@1591 ($SortWrappers.IntTo$Snap $t@1592))))
(declare-const $t@1593 Int)
(declare-const $t@1594 $Ref)
(assert (=
  $t@1591
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1593)
    ($SortWrappers.$RefTo$Snap $t@1594))))
(declare-const $t@1595 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1593)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1595) $Snap.unit)))
(declare-const $k@1596 $Perm)
(assert ($Perm.isValidVar $k@1596))
(assert ($Perm.isReadVar $k@1596 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1526 $k@1554) $k@1573) $k@1577))
  (= $t@1595 $t@1572)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1577) $k@1596) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1577) $k@1596) $Perm.No)))
(assert (> $t@1595 0))
(declare-const $k@1597 $Perm)
(assert ($Perm.isValidVar $k@1597))
(assert ($Perm.isReadVar $k@1597 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1528 $k@1555) $k@1574) $k@1578))
  (= $t@1594 $t@1571)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1578) $k@1597) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1578) $k@1597) $Perm.No)))
(assert (not (= $t@1594 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1590 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1590 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 296] $t@1590 != Null
(assert (not (= $t@1590 $Ref.null)))
(declare-const $k@1598 $Perm)
(assert ($Perm.isValidVar $k@1598))
(assert ($Perm.isReadVar $k@1598 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579))
  (= $t@1586 $t@1563)))
(declare-const $k@1599 $Perm)
(assert ($Perm.isValidVar $k@1599))
(assert ($Perm.isReadVar $k@1599 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580))
  (= $t@1584 $t@1561)))
; [exec]
; i := __flatten_59
(declare-const $k@1600 $Perm)
(assert ($Perm.isValidVar $k@1600))
(assert ($Perm.isReadVar $k@1600 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1600 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1600 $k@1524))
(declare-const $k@1601 $Perm)
(assert ($Perm.isValidVar $k@1601))
(assert ($Perm.isReadVar $k@1601 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1601 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1601 (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1577) $k@1596)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1602 $Perm)
(assert ($Perm.isValidVar $k@1602))
(assert ($Perm.isReadVar $k@1602 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1602 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1602 (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1578) $k@1597)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1590 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 297] $t@1590 != Null
(declare-const $k@1603 $Perm)
(assert ($Perm.isValidVar $k@1603))
(assert ($Perm.isReadVar $k@1603 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1603 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579) $k@1598) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579) $k@1598) $Perm.No)))
(assert (< $k@1603 (+ (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579) $k@1598)))
(declare-const $k@1604 $Perm)
(assert ($Perm.isValidVar $k@1604))
(assert ($Perm.isReadVar $k@1604 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1604 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580) $k@1599) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580) $k@1599) $Perm.No)))
(assert (< $k@1604 (+ (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580) $k@1599)))
(pop) ; 9
; [dead else-branch 297] $t@1590 == Null
(pop) ; 8
(push) ; 8
; [else-branch 296] $t@1590 == Null
(assert (= $t@1590 $Ref.null))
(declare-const $k@1605 $Perm)
(assert ($Perm.isValidVar $k@1605))
(assert ($Perm.isReadVar $k@1605 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579))
  (= $t@1586 $t@1563)))
(declare-const $k@1606 $Perm)
(assert ($Perm.isValidVar $k@1606))
(assert ($Perm.isReadVar $k@1606 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580))
  (= $t@1584 $t@1561)))
; [exec]
; i := __flatten_59
(declare-const $k@1607 $Perm)
(assert ($Perm.isValidVar $k@1607))
(assert ($Perm.isReadVar $k@1607 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1607 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1607 $k@1524))
(declare-const $k@1608 $Perm)
(assert ($Perm.isValidVar $k@1608))
(assert ($Perm.isReadVar $k@1608 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1608 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1608 (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1577) $k@1596)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1609 $Perm)
(assert ($Perm.isValidVar $k@1609))
(assert ($Perm.isReadVar $k@1609 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1609 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1609 (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1578) $k@1597)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1590 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 298] $t@1590 != Null
(push) ; 9
; [else-branch 298] $t@1590 == Null
(declare-const $k@1610 $Perm)
(assert ($Perm.isValidVar $k@1610))
(assert ($Perm.isReadVar $k@1610 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1610 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579) $k@1605) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579) $k@1605) $Perm.No)))
(assert (< $k@1610 (+ (- (+ (- $k@1533 $k@1556) $k@1575) $k@1579) $k@1605)))
(declare-const $k@1611 $Perm)
(assert ($Perm.isValidVar $k@1611))
(assert ($Perm.isReadVar $k@1611 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1611 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580) $k@1606) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580) $k@1606) $Perm.No)))
(assert (< $k@1611 (+ (- (+ (- $k@1535 $k@1557) $k@1576) $k@1580) $k@1606)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 295] $t@1567 == Null
(pop) ; 6
(push) ; 6
; [else-branch 294] $t@1567 == Null
(assert (= $t@1567 $Ref.null))
(declare-const $k@1612 $Perm)
(assert ($Perm.isValidVar $k@1612))
(assert ($Perm.isReadVar $k@1612 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1533 $k@1556)) (= $t@1563 $t@1534)))
(declare-const $k@1613 $Perm)
(assert ($Perm.isValidVar $k@1613))
(assert ($Perm.isReadVar $k@1613 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1535 $k@1557)) (= $t@1561 $t@1536)))
; [exec]
; b := __flatten_58
; [exec]
; __flatten_59 := BlockingQueue__peek(diz.LBQThread1a__queue)
; [eval] diz != null
(declare-const $k@1614 $Perm)
(assert ($Perm.isValidVar $k@1614))
(assert ($Perm.isReadVar $k@1614 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1614 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1614 (+ (- $k@1526 $k@1554) $k@1573)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1615 $Perm)
(assert ($Perm.isValidVar $k@1615))
(assert ($Perm.isReadVar $k@1615 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1615 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1615 (+ (- $k@1528 $k@1555) $k@1574)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@1567 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 299] $t@1567 != Null
(push) ; 7
; [else-branch 299] $t@1567 == Null
(declare-const $k@1616 $Perm)
(assert ($Perm.isValidVar $k@1616))
(assert ($Perm.isReadVar $k@1616 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1616 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1533 $k@1556) $k@1612) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1533 $k@1556) $k@1612) $Perm.No)))
(assert (< $k@1616 (+ (- $k@1533 $k@1556) $k@1612)))
(declare-const $k@1617 $Perm)
(assert ($Perm.isValidVar $k@1617))
(assert ($Perm.isReadVar $k@1617 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1617 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1535 $k@1557) $k@1613) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1535 $k@1557) $k@1613) $Perm.No)))
(assert (< $k@1617 (+ (- $k@1535 $k@1557) $k@1613)))
(declare-const sys__result@1618 $Ref)
(declare-const $t@1619 $Snap)
(declare-const $t@1620 $Snap)
(declare-const $t@1621 $Ref)
(assert (= $t@1619 ($Snap.combine $t@1620 ($SortWrappers.$RefTo$Snap $t@1621))))
(declare-const $t@1622 $Snap)
(declare-const $t@1623 $Ref)
(assert (= $t@1620 ($Snap.combine $t@1622 ($SortWrappers.$RefTo$Snap $t@1623))))
(declare-const $t@1624 $Snap)
(declare-const $t@1625 $Snap)
(assert (= $t@1622 ($Snap.combine $t@1624 $t@1625)))
(declare-const $t@1626 $Snap)
(declare-const $t@1627 $Ref)
(assert (= $t@1624 ($Snap.combine $t@1626 ($SortWrappers.$RefTo$Snap $t@1627))))
(declare-const $t@1628 $Snap)
(declare-const $t@1629 Int)
(assert (= $t@1626 ($Snap.combine $t@1628 ($SortWrappers.IntTo$Snap $t@1629))))
(declare-const $t@1630 Int)
(declare-const $t@1631 $Ref)
(assert (=
  $t@1628
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1630)
    ($SortWrappers.$RefTo$Snap $t@1631))))
(declare-const $t@1632 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1630)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1632) $Snap.unit)))
(declare-const $k@1633 $Perm)
(assert ($Perm.isValidVar $k@1633))
(assert ($Perm.isReadVar $k@1633 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1526 $k@1554) $k@1573) $k@1614))
  (= $t@1632 $t@1572)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1614) $k@1633) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1614) $k@1633) $Perm.No)))
(assert (> $t@1632 0))
(declare-const $k@1634 $Perm)
(assert ($Perm.isValidVar $k@1634))
(assert ($Perm.isReadVar $k@1634 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1528 $k@1555) $k@1574) $k@1615))
  (= $t@1631 $t@1571)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1615) $k@1634) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1615) $k@1634) $Perm.No)))
(assert (not (= $t@1631 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1627 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1627 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 300] $t@1627 != Null
(assert (not (= $t@1627 $Ref.null)))
(declare-const $k@1635 $Perm)
(assert ($Perm.isValidVar $k@1635))
(assert ($Perm.isReadVar $k@1635 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616))
  (= $t@1623 $t@1563)))
(declare-const $k@1636 $Perm)
(assert ($Perm.isValidVar $k@1636))
(assert ($Perm.isReadVar $k@1636 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617))
  (= $t@1621 $t@1561)))
; [exec]
; i := __flatten_59
(declare-const $k@1637 $Perm)
(assert ($Perm.isValidVar $k@1637))
(assert ($Perm.isReadVar $k@1637 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1637 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1637 $k@1524))
(declare-const $k@1638 $Perm)
(assert ($Perm.isValidVar $k@1638))
(assert ($Perm.isReadVar $k@1638 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1638 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1638 (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1614) $k@1633)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1639 $Perm)
(assert ($Perm.isValidVar $k@1639))
(assert ($Perm.isReadVar $k@1639 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1639 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1639 (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1615) $k@1634)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1627 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 301] $t@1627 != Null
(declare-const $k@1640 $Perm)
(assert ($Perm.isValidVar $k@1640))
(assert ($Perm.isReadVar $k@1640 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1640 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616) $k@1635) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616) $k@1635) $Perm.No)))
(assert (< $k@1640 (+ (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616) $k@1635)))
(declare-const $k@1641 $Perm)
(assert ($Perm.isValidVar $k@1641))
(assert ($Perm.isReadVar $k@1641 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1641 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617) $k@1636) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617) $k@1636) $Perm.No)))
(assert (< $k@1641 (+ (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617) $k@1636)))
(pop) ; 9
; [dead else-branch 301] $t@1627 == Null
(pop) ; 8
(push) ; 8
; [else-branch 300] $t@1627 == Null
(assert (= $t@1627 $Ref.null))
(declare-const $k@1642 $Perm)
(assert ($Perm.isValidVar $k@1642))
(assert ($Perm.isReadVar $k@1642 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616))
  (= $t@1623 $t@1563)))
(declare-const $k@1643 $Perm)
(assert ($Perm.isValidVar $k@1643))
(assert ($Perm.isReadVar $k@1643 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617))
  (= $t@1621 $t@1561)))
; [exec]
; i := __flatten_59
(declare-const $k@1644 $Perm)
(assert ($Perm.isValidVar $k@1644))
(assert ($Perm.isReadVar $k@1644 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1644 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1644 $k@1524))
(declare-const $k@1645 $Perm)
(assert ($Perm.isValidVar $k@1645))
(assert ($Perm.isReadVar $k@1645 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1645 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1645 (+ (- (+ (- $k@1526 $k@1554) $k@1573) $k@1614) $k@1633)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1646 $Perm)
(assert ($Perm.isValidVar $k@1646))
(assert ($Perm.isReadVar $k@1646 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1646 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1646 (+ (- (+ (- $k@1528 $k@1555) $k@1574) $k@1615) $k@1634)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1627 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 302] $t@1627 != Null
(push) ; 9
; [else-branch 302] $t@1627 == Null
(declare-const $k@1647 $Perm)
(assert ($Perm.isValidVar $k@1647))
(assert ($Perm.isReadVar $k@1647 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1647 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616) $k@1642) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616) $k@1642) $Perm.No)))
(assert (< $k@1647 (+ (- (+ (- $k@1533 $k@1556) $k@1612) $k@1616) $k@1642)))
(declare-const $k@1648 $Perm)
(assert ($Perm.isValidVar $k@1648))
(assert ($Perm.isReadVar $k@1648 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1648 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617) $k@1643) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617) $k@1643) $Perm.No)))
(assert (< $k@1648 (+ (- (+ (- $k@1535 $k@1557) $k@1613) $k@1617) $k@1643)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 293] $t@1531 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 291] $t@1531 == Null
(assert (= $t@1531 $Ref.null))
(declare-const $k@1649 $Perm)
(assert ($Perm.isValidVar $k@1649))
(assert ($Perm.isReadVar $k@1649 $Perm.Write))
(declare-const $t@1650 $Ref)
(declare-const $k@1651 $Perm)
(assert ($Perm.isValidVar $k@1651))
(assert ($Perm.isReadVar $k@1651 $Perm.Write))
(declare-const $t@1652 $Ref)
(push) ; 4
(declare-const $k@1653 $Perm)
(assert ($Perm.isValidVar $k@1653))
(assert ($Perm.isReadVar $k@1653 $Perm.Write))
(declare-const $t@1654 $Ref)
(push) ; 5
(assert (not (not (= $k@1653 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1653 $Perm.No)))
(assert (not (= $t@1654 $Ref.null)))
(declare-const $k@1655 $Perm)
(assert ($Perm.isValidVar $k@1655))
(assert ($Perm.isReadVar $k@1655 $Perm.Write))
(declare-const $t@1656 Int)
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1655 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1655 $Perm.No)))
(assert (> $t@1656 0))
(declare-const $k@1657 $Perm)
(assert ($Perm.isValidVar $k@1657))
(assert ($Perm.isReadVar $k@1657 $Perm.Write))
(declare-const $t@1658 $Ref)
(push) ; 5
(assert (not (not (= $k@1657 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1657 $Perm.No)))
(assert (not (= $t@1658 $Ref.null)))
(declare-const $t@1659 Int)
(declare-const $t@1660 $Ref)
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1660 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1660 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 303] $t@1660 != Null
(assert (not (= $t@1660 $Ref.null)))
(declare-const $t@1661 $Snap)
(declare-const $k@1662 $Perm)
(assert ($Perm.isValidVar $k@1662))
(assert ($Perm.isReadVar $k@1662 $Perm.Write))
(declare-const $t@1663 $Ref)
(declare-const $k@1664 $Perm)
(assert ($Perm.isValidVar $k@1664))
(assert ($Perm.isReadVar $k@1664 $Perm.Write))
(declare-const $t@1665 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 303] $t@1660 == Null
(assert (= $t@1660 $Ref.null))
(declare-const $k@1666 $Perm)
(assert ($Perm.isValidVar $k@1666))
(assert ($Perm.isReadVar $k@1666 $Perm.Write))
(declare-const $t@1667 $Ref)
(declare-const $k@1668 $Perm)
(assert ($Perm.isValidVar $k@1668))
(assert ($Perm.isReadVar $k@1668 $Perm.Write))
(declare-const $t@1669 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_58 := BlockingQueue__offer(diz.LBQThread1a__queue, 1)
; [eval] diz != null
(declare-const $k@1670 $Perm)
(assert ($Perm.isValidVar $k@1670))
(assert ($Perm.isReadVar $k@1670 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1670 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1670 $k@1526))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1671 $Perm)
(assert ($Perm.isValidVar $k@1671))
(assert ($Perm.isReadVar $k@1671 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1671 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1671 $k@1528))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@1531 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 304] $t@1531 != Null
(push) ; 5
; [else-branch 304] $t@1531 == Null
(declare-const $k@1672 $Perm)
(assert ($Perm.isValidVar $k@1672))
(assert ($Perm.isReadVar $k@1672 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1672 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1649 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1649 $Perm.No)))
(assert (< $k@1672 $k@1649))
(declare-const $k@1673 $Perm)
(assert ($Perm.isValidVar $k@1673))
(assert ($Perm.isReadVar $k@1673 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1673 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1651 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1651 $Perm.No)))
(assert (< $k@1673 $k@1651))
(declare-const sys__result@1674 Bool)
(declare-const $t@1675 $Snap)
(declare-const $t@1676 $Snap)
(declare-const $t@1677 $Ref)
(assert (= $t@1675 ($Snap.combine $t@1676 ($SortWrappers.$RefTo$Snap $t@1677))))
(declare-const $t@1678 $Snap)
(declare-const $t@1679 $Ref)
(assert (= $t@1676 ($Snap.combine $t@1678 ($SortWrappers.$RefTo$Snap $t@1679))))
(declare-const $t@1680 $Snap)
(declare-const $t@1681 $Snap)
(assert (= $t@1678 ($Snap.combine $t@1680 $t@1681)))
(declare-const $t@1682 $Snap)
(declare-const $t@1683 $Ref)
(assert (= $t@1680 ($Snap.combine $t@1682 ($SortWrappers.$RefTo$Snap $t@1683))))
(declare-const $t@1684 $Snap)
(declare-const $t@1685 Int)
(assert (= $t@1682 ($Snap.combine $t@1684 ($SortWrappers.IntTo$Snap $t@1685))))
(declare-const $t@1686 Int)
(declare-const $t@1687 $Ref)
(assert (=
  $t@1684
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1686)
    ($SortWrappers.$RefTo$Snap $t@1687))))
(declare-const $t@1688 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1686)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1688) $Snap.unit)))
(declare-const $k@1689 $Perm)
(assert ($Perm.isValidVar $k@1689))
(assert ($Perm.isReadVar $k@1689 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1526 $k@1670)) (= $t@1688 $t@1527)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@1526 $k@1670) $k@1689) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1526 $k@1670) $k@1689) $Perm.No)))
(assert (> $t@1688 0))
(declare-const $k@1690 $Perm)
(assert ($Perm.isValidVar $k@1690))
(assert ($Perm.isReadVar $k@1690 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1528 $k@1671)) (= $t@1687 $t@1529)))
(push) ; 6
(assert (not (not (= (+ (- $k@1528 $k@1671) $k@1690) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1528 $k@1671) $k@1690) $Perm.No)))
(assert (not (= $t@1687 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@1683 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@1683 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 305] $t@1683 != Null
(assert (not (= $t@1683 $Ref.null)))
(declare-const $k@1691 $Perm)
(assert ($Perm.isValidVar $k@1691))
(assert ($Perm.isReadVar $k@1691 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1649 $k@1672)) (= $t@1679 $t@1650)))
(declare-const $k@1692 $Perm)
(assert ($Perm.isValidVar $k@1692))
(assert ($Perm.isReadVar $k@1692 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1651 $k@1673)) (= $t@1677 $t@1652)))
; [exec]
; b := __flatten_58
; [exec]
; __flatten_59 := BlockingQueue__peek(diz.LBQThread1a__queue)
; [eval] diz != null
(declare-const $k@1693 $Perm)
(assert ($Perm.isValidVar $k@1693))
(assert ($Perm.isReadVar $k@1693 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1693 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1693 (+ (- $k@1526 $k@1670) $k@1689)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1694 $Perm)
(assert ($Perm.isValidVar $k@1694))
(assert ($Perm.isReadVar $k@1694 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1694 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1694 (+ (- $k@1528 $k@1671) $k@1690)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@1683 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 306] $t@1683 != Null
(declare-const $k@1695 $Perm)
(assert ($Perm.isValidVar $k@1695))
(assert ($Perm.isReadVar $k@1695 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1695 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1649 $k@1672) $k@1691) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1649 $k@1672) $k@1691) $Perm.No)))
(assert (< $k@1695 (+ (- $k@1649 $k@1672) $k@1691)))
(declare-const $k@1696 $Perm)
(assert ($Perm.isValidVar $k@1696))
(assert ($Perm.isReadVar $k@1696 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1696 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1651 $k@1673) $k@1692) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1651 $k@1673) $k@1692) $Perm.No)))
(assert (< $k@1696 (+ (- $k@1651 $k@1673) $k@1692)))
(declare-const sys__result@1697 $Ref)
(declare-const $t@1698 $Snap)
(declare-const $t@1699 $Snap)
(declare-const $t@1700 $Ref)
(assert (= $t@1698 ($Snap.combine $t@1699 ($SortWrappers.$RefTo$Snap $t@1700))))
(declare-const $t@1701 $Snap)
(declare-const $t@1702 $Ref)
(assert (= $t@1699 ($Snap.combine $t@1701 ($SortWrappers.$RefTo$Snap $t@1702))))
(declare-const $t@1703 $Snap)
(declare-const $t@1704 $Snap)
(assert (= $t@1701 ($Snap.combine $t@1703 $t@1704)))
(declare-const $t@1705 $Snap)
(declare-const $t@1706 $Ref)
(assert (= $t@1703 ($Snap.combine $t@1705 ($SortWrappers.$RefTo$Snap $t@1706))))
(declare-const $t@1707 $Snap)
(declare-const $t@1708 Int)
(assert (= $t@1705 ($Snap.combine $t@1707 ($SortWrappers.IntTo$Snap $t@1708))))
(declare-const $t@1709 Int)
(declare-const $t@1710 $Ref)
(assert (=
  $t@1707
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1709)
    ($SortWrappers.$RefTo$Snap $t@1710))))
(declare-const $t@1711 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1709)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1711) $Snap.unit)))
(declare-const $k@1712 $Perm)
(assert ($Perm.isValidVar $k@1712))
(assert ($Perm.isReadVar $k@1712 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1526 $k@1670) $k@1689) $k@1693))
  (= $t@1711 $t@1688)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1693) $k@1712) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1693) $k@1712) $Perm.No)))
(assert (> $t@1711 0))
(declare-const $k@1713 $Perm)
(assert ($Perm.isValidVar $k@1713))
(assert ($Perm.isReadVar $k@1713 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1528 $k@1671) $k@1690) $k@1694))
  (= $t@1710 $t@1687)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1694) $k@1713) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1694) $k@1713) $Perm.No)))
(assert (not (= $t@1710 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1706 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1706 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 307] $t@1706 != Null
(assert (not (= $t@1706 $Ref.null)))
(declare-const $k@1714 $Perm)
(assert ($Perm.isValidVar $k@1714))
(assert ($Perm.isReadVar $k@1714 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695))
  (= $t@1702 $t@1679)))
(declare-const $k@1715 $Perm)
(assert ($Perm.isValidVar $k@1715))
(assert ($Perm.isReadVar $k@1715 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696))
  (= $t@1700 $t@1677)))
; [exec]
; i := __flatten_59
(declare-const $k@1716 $Perm)
(assert ($Perm.isValidVar $k@1716))
(assert ($Perm.isReadVar $k@1716 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1716 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1716 $k@1524))
(declare-const $k@1717 $Perm)
(assert ($Perm.isValidVar $k@1717))
(assert ($Perm.isReadVar $k@1717 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1717 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1717 (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1693) $k@1712)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1718 $Perm)
(assert ($Perm.isValidVar $k@1718))
(assert ($Perm.isReadVar $k@1718 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1718 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1718 (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1694) $k@1713)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1706 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 308] $t@1706 != Null
(declare-const $k@1719 $Perm)
(assert ($Perm.isValidVar $k@1719))
(assert ($Perm.isReadVar $k@1719 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1719 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695) $k@1714) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695) $k@1714) $Perm.No)))
(assert (< $k@1719 (+ (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695) $k@1714)))
(declare-const $k@1720 $Perm)
(assert ($Perm.isValidVar $k@1720))
(assert ($Perm.isReadVar $k@1720 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1720 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696) $k@1715) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696) $k@1715) $Perm.No)))
(assert (< $k@1720 (+ (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696) $k@1715)))
(pop) ; 9
; [dead else-branch 308] $t@1706 == Null
(pop) ; 8
(push) ; 8
; [else-branch 307] $t@1706 == Null
(assert (= $t@1706 $Ref.null))
(declare-const $k@1721 $Perm)
(assert ($Perm.isValidVar $k@1721))
(assert ($Perm.isReadVar $k@1721 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695))
  (= $t@1702 $t@1679)))
(declare-const $k@1722 $Perm)
(assert ($Perm.isValidVar $k@1722))
(assert ($Perm.isReadVar $k@1722 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696))
  (= $t@1700 $t@1677)))
; [exec]
; i := __flatten_59
(declare-const $k@1723 $Perm)
(assert ($Perm.isValidVar $k@1723))
(assert ($Perm.isReadVar $k@1723 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1723 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1723 $k@1524))
(declare-const $k@1724 $Perm)
(assert ($Perm.isValidVar $k@1724))
(assert ($Perm.isReadVar $k@1724 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1724 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1724 (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1693) $k@1712)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1725 $Perm)
(assert ($Perm.isValidVar $k@1725))
(assert ($Perm.isReadVar $k@1725 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1725 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1725 (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1694) $k@1713)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1706 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 309] $t@1706 != Null
(push) ; 9
; [else-branch 309] $t@1706 == Null
(declare-const $k@1726 $Perm)
(assert ($Perm.isValidVar $k@1726))
(assert ($Perm.isReadVar $k@1726 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1726 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695) $k@1721) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695) $k@1721) $Perm.No)))
(assert (< $k@1726 (+ (- (+ (- $k@1649 $k@1672) $k@1691) $k@1695) $k@1721)))
(declare-const $k@1727 $Perm)
(assert ($Perm.isValidVar $k@1727))
(assert ($Perm.isReadVar $k@1727 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1727 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696) $k@1722) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696) $k@1722) $Perm.No)))
(assert (< $k@1727 (+ (- (+ (- $k@1651 $k@1673) $k@1692) $k@1696) $k@1722)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 306] $t@1683 == Null
(pop) ; 6
(push) ; 6
; [else-branch 305] $t@1683 == Null
(assert (= $t@1683 $Ref.null))
(declare-const $k@1728 $Perm)
(assert ($Perm.isValidVar $k@1728))
(assert ($Perm.isReadVar $k@1728 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1649 $k@1672)) (= $t@1679 $t@1650)))
(declare-const $k@1729 $Perm)
(assert ($Perm.isValidVar $k@1729))
(assert ($Perm.isReadVar $k@1729 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1651 $k@1673)) (= $t@1677 $t@1652)))
; [exec]
; b := __flatten_58
; [exec]
; __flatten_59 := BlockingQueue__peek(diz.LBQThread1a__queue)
; [eval] diz != null
(declare-const $k@1730 $Perm)
(assert ($Perm.isValidVar $k@1730))
(assert ($Perm.isReadVar $k@1730 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1730 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1730 (+ (- $k@1526 $k@1670) $k@1689)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1731 $Perm)
(assert ($Perm.isValidVar $k@1731))
(assert ($Perm.isReadVar $k@1731 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1731 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1731 (+ (- $k@1528 $k@1671) $k@1690)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@1683 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 310] $t@1683 != Null
(push) ; 7
; [else-branch 310] $t@1683 == Null
(declare-const $k@1732 $Perm)
(assert ($Perm.isValidVar $k@1732))
(assert ($Perm.isReadVar $k@1732 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1732 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1649 $k@1672) $k@1728) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1649 $k@1672) $k@1728) $Perm.No)))
(assert (< $k@1732 (+ (- $k@1649 $k@1672) $k@1728)))
(declare-const $k@1733 $Perm)
(assert ($Perm.isValidVar $k@1733))
(assert ($Perm.isReadVar $k@1733 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1733 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1651 $k@1673) $k@1729) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1651 $k@1673) $k@1729) $Perm.No)))
(assert (< $k@1733 (+ (- $k@1651 $k@1673) $k@1729)))
(declare-const sys__result@1734 $Ref)
(declare-const $t@1735 $Snap)
(declare-const $t@1736 $Snap)
(declare-const $t@1737 $Ref)
(assert (= $t@1735 ($Snap.combine $t@1736 ($SortWrappers.$RefTo$Snap $t@1737))))
(declare-const $t@1738 $Snap)
(declare-const $t@1739 $Ref)
(assert (= $t@1736 ($Snap.combine $t@1738 ($SortWrappers.$RefTo$Snap $t@1739))))
(declare-const $t@1740 $Snap)
(declare-const $t@1741 $Snap)
(assert (= $t@1738 ($Snap.combine $t@1740 $t@1741)))
(declare-const $t@1742 $Snap)
(declare-const $t@1743 $Ref)
(assert (= $t@1740 ($Snap.combine $t@1742 ($SortWrappers.$RefTo$Snap $t@1743))))
(declare-const $t@1744 $Snap)
(declare-const $t@1745 Int)
(assert (= $t@1742 ($Snap.combine $t@1744 ($SortWrappers.IntTo$Snap $t@1745))))
(declare-const $t@1746 Int)
(declare-const $t@1747 $Ref)
(assert (=
  $t@1744
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1746)
    ($SortWrappers.$RefTo$Snap $t@1747))))
(declare-const $t@1748 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1746)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1748) $Snap.unit)))
(declare-const $k@1749 $Perm)
(assert ($Perm.isValidVar $k@1749))
(assert ($Perm.isReadVar $k@1749 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1526 $k@1670) $k@1689) $k@1730))
  (= $t@1748 $t@1688)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1730) $k@1749) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1730) $k@1749) $Perm.No)))
(assert (> $t@1748 0))
(declare-const $k@1750 $Perm)
(assert ($Perm.isValidVar $k@1750))
(assert ($Perm.isReadVar $k@1750 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1528 $k@1671) $k@1690) $k@1731))
  (= $t@1747 $t@1687)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1731) $k@1750) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1731) $k@1750) $Perm.No)))
(assert (not (= $t@1747 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1743 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1743 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 311] $t@1743 != Null
(assert (not (= $t@1743 $Ref.null)))
(declare-const $k@1751 $Perm)
(assert ($Perm.isValidVar $k@1751))
(assert ($Perm.isReadVar $k@1751 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732))
  (= $t@1739 $t@1679)))
(declare-const $k@1752 $Perm)
(assert ($Perm.isValidVar $k@1752))
(assert ($Perm.isReadVar $k@1752 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733))
  (= $t@1737 $t@1677)))
; [exec]
; i := __flatten_59
(declare-const $k@1753 $Perm)
(assert ($Perm.isValidVar $k@1753))
(assert ($Perm.isReadVar $k@1753 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1753 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1753 $k@1524))
(declare-const $k@1754 $Perm)
(assert ($Perm.isValidVar $k@1754))
(assert ($Perm.isReadVar $k@1754 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1754 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1754 (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1730) $k@1749)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1755 $Perm)
(assert ($Perm.isValidVar $k@1755))
(assert ($Perm.isReadVar $k@1755 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1755 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1755 (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1731) $k@1750)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1743 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 312] $t@1743 != Null
(declare-const $k@1756 $Perm)
(assert ($Perm.isValidVar $k@1756))
(assert ($Perm.isReadVar $k@1756 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1756 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732) $k@1751) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732) $k@1751) $Perm.No)))
(assert (< $k@1756 (+ (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732) $k@1751)))
(declare-const $k@1757 $Perm)
(assert ($Perm.isValidVar $k@1757))
(assert ($Perm.isReadVar $k@1757 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1757 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733) $k@1752) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733) $k@1752) $Perm.No)))
(assert (< $k@1757 (+ (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733) $k@1752)))
(pop) ; 9
; [dead else-branch 312] $t@1743 == Null
(pop) ; 8
(push) ; 8
; [else-branch 311] $t@1743 == Null
(assert (= $t@1743 $Ref.null))
(declare-const $k@1758 $Perm)
(assert ($Perm.isValidVar $k@1758))
(assert ($Perm.isReadVar $k@1758 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732))
  (= $t@1739 $t@1679)))
(declare-const $k@1759 $Perm)
(assert ($Perm.isValidVar $k@1759))
(assert ($Perm.isReadVar $k@1759 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733))
  (= $t@1737 $t@1677)))
; [exec]
; i := __flatten_59
(declare-const $k@1760 $Perm)
(assert ($Perm.isValidVar $k@1760))
(assert ($Perm.isReadVar $k@1760 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1760 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1760 $k@1524))
(declare-const $k@1761 $Perm)
(assert ($Perm.isValidVar $k@1761))
(assert ($Perm.isReadVar $k@1761 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1761 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1761 (+ (- (+ (- $k@1526 $k@1670) $k@1689) $k@1730) $k@1749)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__capacity > 0
(declare-const $k@1762 $Perm)
(assert ($Perm.isValidVar $k@1762))
(assert ($Perm.isReadVar $k@1762 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1762 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1762 (+ (- (+ (- $k@1528 $k@1671) $k@1690) $k@1731) $k@1750)))
; [eval] diz.LBQThread1a__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1743 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 313] $t@1743 != Null
(push) ; 9
; [else-branch 313] $t@1743 == Null
(declare-const $k@1763 $Perm)
(assert ($Perm.isValidVar $k@1763))
(assert ($Perm.isReadVar $k@1763 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1763 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732) $k@1758) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732) $k@1758) $Perm.No)))
(assert (< $k@1763 (+ (- (+ (- $k@1649 $k@1672) $k@1728) $k@1732) $k@1758)))
(declare-const $k@1764 $Perm)
(assert ($Perm.isValidVar $k@1764))
(assert ($Perm.isReadVar $k@1764 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1764 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733) $k@1759) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733) $k@1759) $Perm.No)))
(assert (< $k@1764 (+ (- (+ (- $k@1651 $k@1673) $k@1729) $k@1733) $k@1759)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread1b__LBQThread1a ----------
(declare-const queue@1765 $Ref)
(declare-const sys__result@1766 $Ref)
(declare-const diz@1767 $Ref)
(declare-const __flatten_60@1768 $Ref)
(declare-const __flatten_120@1769 $Ref)
(push) ; 2
(assert (not (= queue@1765 $Ref.null)))
(declare-const $k@1770 $Perm)
(assert ($Perm.isValidVar $k@1770))
(assert ($Perm.isReadVar $k@1770 $Perm.Write))
(declare-const $t@1771 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1770 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1770 $Perm.No)))
(assert (> $t@1771 0))
(declare-const $k@1772 $Perm)
(assert ($Perm.isValidVar $k@1772))
(assert ($Perm.isReadVar $k@1772 $Perm.Write))
(declare-const $t@1773 $Ref)
(push) ; 3
(assert (not (not (= $k@1772 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1772 $Perm.No)))
(assert (not (= $t@1773 $Ref.null)))
(declare-const $t@1774 Int)
(declare-const $t@1775 $Ref)
; [eval] queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@1775 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@1775 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 314] $t@1775 != Null
(assert (not (= $t@1775 $Ref.null)))
(declare-const $t@1776 $Snap)
(declare-const $k@1777 $Perm)
(assert ($Perm.isValidVar $k@1777))
(assert ($Perm.isReadVar $k@1777 $Perm.Write))
(declare-const $t@1778 $Ref)
(declare-const $k@1779 $Perm)
(assert ($Perm.isValidVar $k@1779))
(assert ($Perm.isReadVar $k@1779 $Perm.Write))
(declare-const $t@1780 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@1766 $Ref.null)))
(declare-const $k@1781 $Perm)
(assert ($Perm.isValidVar $k@1781))
(assert ($Perm.isReadVar $k@1781 $Perm.Write))
(declare-const $t@1782 $Ref)
(push) ; 5
(assert (not (not (= $k@1781 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1781 $Perm.No)))
(assert (not (= $t@1782 $Ref.null)))
(declare-const $k@1783 $Perm)
(assert ($Perm.isValidVar $k@1783))
(assert ($Perm.isReadVar $k@1783 $Perm.Write))
(declare-const $t@1784 Int)
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1783 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1783 $Perm.No)))
(assert (> $t@1784 0))
(declare-const $k@1785 $Perm)
(assert ($Perm.isValidVar $k@1785))
(assert ($Perm.isReadVar $k@1785 $Perm.Write))
(declare-const $t@1786 $Ref)
(push) ; 5
(assert (not (not (= $k@1785 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1785 $Perm.No)))
(assert (not (= $t@1786 $Ref.null)))
(declare-const $t@1787 Int)
(declare-const $t@1788 $Ref)
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1788 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1788 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 315] $t@1788 != Null
(assert (not (= $t@1788 $Ref.null)))
(declare-const $t@1789 $Snap)
(declare-const $k@1790 $Perm)
(assert ($Perm.isValidVar $k@1790))
(assert ($Perm.isReadVar $k@1790 $Perm.Write))
(declare-const $t@1791 $Ref)
(declare-const $k@1792 $Perm)
(assert ($Perm.isValidVar $k@1792))
(assert ($Perm.isReadVar $k@1792 $Perm.Write))
(declare-const $t@1793 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 315] $t@1788 == Null
(assert (= $t@1788 $Ref.null))
(declare-const $k@1794 $Perm)
(assert ($Perm.isValidVar $k@1794))
(assert ($Perm.isReadVar $k@1794 $Perm.Write))
(declare-const $t@1795 $Ref)
(declare-const $k@1796 $Perm)
(assert ($Perm.isValidVar $k@1796))
(assert ($Perm.isReadVar $k@1796 $Perm.Write))
(declare-const $t@1797 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread1b__queue)
(declare-const diz@1798 $Ref)
(assert (not (= diz@1798 $Ref.null)))
(declare-const LBQThread1b__queue@1799 $Ref)
(assert (and
  (not (= queue@1765 diz@1798))
  (not (= sys__result@1766 diz@1798))
  (not (= __flatten_60@1768 diz@1798))
  (not (= __flatten_120@1769 diz@1798))
  (not (= $t@1773 diz@1798))
  (not (= $t@1775 diz@1798))
  (not (= LBQThread1b__queue@1799 diz@1798))
  (not (= $t@1778 diz@1798))
  (not (= $t@1780 diz@1798))))
; [exec]
; __flatten_60 := queue
; [exec]
; __flatten_120 := __flatten_60
; [exec]
; diz.LBQThread1b__queue := __flatten_120
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread1b__queue, wildcard) && acc(sys__result.LBQThread1b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread1b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread1b__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread1b__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread1b__queue.BlockingQueue__first, write) && ((sys__result.LBQThread1b__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread1b__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread1b__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread1b__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@1800 $Perm)
(assert ($Perm.isValidVar $k@1800))
(assert ($Perm.isReadVar $k@1800 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1800 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1800 $Perm.Write))
(declare-const $k@1801 $Perm)
(assert ($Perm.isValidVar $k@1801))
(assert ($Perm.isReadVar $k@1801 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1801 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1801 $k@1770))
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@1802 $Perm)
(assert ($Perm.isValidVar $k@1802))
(assert ($Perm.isReadVar $k@1802 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1802 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1802 $k@1772))
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1775 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 316] $t@1775 != Null
(declare-const $k@1803 $Perm)
(assert ($Perm.isValidVar $k@1803))
(assert ($Perm.isReadVar $k@1803 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1803 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1777 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1777 $Perm.No)))
(assert (< $k@1803 $k@1777))
(declare-const $k@1804 $Perm)
(assert ($Perm.isValidVar $k@1804))
(assert ($Perm.isReadVar $k@1804 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1804 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1779 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1779 $Perm.No)))
(assert (< $k@1804 $k@1779))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 316] $t@1775 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 314] $t@1775 == Null
(assert (= $t@1775 $Ref.null))
(declare-const $k@1805 $Perm)
(assert ($Perm.isValidVar $k@1805))
(assert ($Perm.isReadVar $k@1805 $Perm.Write))
(declare-const $t@1806 $Ref)
(declare-const $k@1807 $Perm)
(assert ($Perm.isValidVar $k@1807))
(assert ($Perm.isReadVar $k@1807 $Perm.Write))
(declare-const $t@1808 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@1766 $Ref.null)))
(declare-const $k@1809 $Perm)
(assert ($Perm.isValidVar $k@1809))
(assert ($Perm.isReadVar $k@1809 $Perm.Write))
(declare-const $t@1810 $Ref)
(push) ; 5
(assert (not (not (= $k@1809 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1809 $Perm.No)))
(assert (not (= $t@1810 $Ref.null)))
(declare-const $k@1811 $Perm)
(assert ($Perm.isValidVar $k@1811))
(assert ($Perm.isReadVar $k@1811 $Perm.Write))
(declare-const $t@1812 Int)
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1811 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1811 $Perm.No)))
(assert (> $t@1812 0))
(declare-const $k@1813 $Perm)
(assert ($Perm.isValidVar $k@1813))
(assert ($Perm.isReadVar $k@1813 $Perm.Write))
(declare-const $t@1814 $Ref)
(push) ; 5
(assert (not (not (= $k@1813 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1813 $Perm.No)))
(assert (not (= $t@1814 $Ref.null)))
(declare-const $t@1815 Int)
(declare-const $t@1816 $Ref)
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1816 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1816 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 317] $t@1816 != Null
(assert (not (= $t@1816 $Ref.null)))
(declare-const $t@1817 $Snap)
(declare-const $k@1818 $Perm)
(assert ($Perm.isValidVar $k@1818))
(assert ($Perm.isReadVar $k@1818 $Perm.Write))
(declare-const $t@1819 $Ref)
(declare-const $k@1820 $Perm)
(assert ($Perm.isValidVar $k@1820))
(assert ($Perm.isReadVar $k@1820 $Perm.Write))
(declare-const $t@1821 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 317] $t@1816 == Null
(assert (= $t@1816 $Ref.null))
(declare-const $k@1822 $Perm)
(assert ($Perm.isValidVar $k@1822))
(assert ($Perm.isReadVar $k@1822 $Perm.Write))
(declare-const $t@1823 $Ref)
(declare-const $k@1824 $Perm)
(assert ($Perm.isValidVar $k@1824))
(assert ($Perm.isReadVar $k@1824 $Perm.Write))
(declare-const $t@1825 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread1b__queue)
(declare-const diz@1826 $Ref)
(assert (not (= diz@1826 $Ref.null)))
(declare-const LBQThread1b__queue@1827 $Ref)
(assert (and
  (not (= queue@1765 diz@1826))
  (not (= sys__result@1766 diz@1826))
  (not (= __flatten_60@1768 diz@1826))
  (not (= __flatten_120@1769 diz@1826))
  (not (= $t@1773 diz@1826))
  (not (= LBQThread1b__queue@1827 diz@1826))
  (not (= $t@1775 diz@1826))
  (not (= $t@1806 diz@1826))
  (not (= $t@1808 diz@1826))))
; [exec]
; __flatten_60 := queue
; [exec]
; __flatten_120 := __flatten_60
; [exec]
; diz.LBQThread1b__queue := __flatten_120
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread1b__queue, wildcard) && acc(sys__result.LBQThread1b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread1b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread1b__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread1b__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread1b__queue.BlockingQueue__first, write) && ((sys__result.LBQThread1b__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread1b__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread1b__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread1b__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@1828 $Perm)
(assert ($Perm.isValidVar $k@1828))
(assert ($Perm.isReadVar $k@1828 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1828 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1828 $Perm.Write))
(declare-const $k@1829 $Perm)
(assert ($Perm.isValidVar $k@1829))
(assert ($Perm.isReadVar $k@1829 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1829 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1829 $k@1770))
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@1830 $Perm)
(assert ($Perm.isValidVar $k@1830))
(assert ($Perm.isReadVar $k@1830 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1830 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1830 $k@1772))
; [eval] sys__result.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@1775 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 318] $t@1775 != Null
(push) ; 5
; [else-branch 318] $t@1775 == Null
(declare-const $k@1831 $Perm)
(assert ($Perm.isValidVar $k@1831))
(assert ($Perm.isReadVar $k@1831 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1831 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1805 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1805 $Perm.No)))
(assert (< $k@1831 $k@1805))
(declare-const $k@1832 $Perm)
(assert ($Perm.isValidVar $k@1832))
(assert ($Perm.isReadVar $k@1832 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1832 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1807 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1807 $Perm.No)))
(assert (< $k@1832 $k@1807))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread1b__run ----------
(declare-const diz@1833 $Ref)
(declare-const b@1834 Bool)
(declare-const __flatten_61@1835 Bool)
(declare-const i@1836 $Ref)
(declare-const __flatten_62@1837 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@1833 $Ref.null)))
(declare-const $k@1838 $Perm)
(assert ($Perm.isValidVar $k@1838))
(assert ($Perm.isReadVar $k@1838 $Perm.Write))
(declare-const $t@1839 $Ref)
(push) ; 3
(assert (not (not (= $k@1838 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1838 $Perm.No)))
(assert (not (= $t@1839 $Ref.null)))
(declare-const $k@1840 $Perm)
(assert ($Perm.isValidVar $k@1840))
(assert ($Perm.isReadVar $k@1840 $Perm.Write))
(declare-const $t@1841 Int)
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@1840 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1840 $Perm.No)))
(assert (> $t@1841 0))
(declare-const $k@1842 $Perm)
(assert ($Perm.isValidVar $k@1842))
(assert ($Perm.isReadVar $k@1842 $Perm.Write))
(declare-const $t@1843 $Ref)
(push) ; 3
(assert (not (not (= $k@1842 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@1842 $Perm.No)))
(assert (not (= $t@1843 $Ref.null)))
(declare-const $t@1844 Int)
(declare-const $t@1845 $Ref)
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@1845 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@1845 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 319] $t@1845 != Null
(assert (not (= $t@1845 $Ref.null)))
(declare-const $t@1846 $Snap)
(declare-const $k@1847 $Perm)
(assert ($Perm.isValidVar $k@1847))
(assert ($Perm.isReadVar $k@1847 $Perm.Write))
(declare-const $t@1848 $Ref)
(declare-const $k@1849 $Perm)
(assert ($Perm.isValidVar $k@1849))
(assert ($Perm.isReadVar $k@1849 $Perm.Write))
(declare-const $t@1850 $Ref)
(push) ; 4
(declare-const $k@1851 $Perm)
(assert ($Perm.isValidVar $k@1851))
(assert ($Perm.isReadVar $k@1851 $Perm.Write))
(declare-const $t@1852 $Ref)
(push) ; 5
(assert (not (not (= $k@1851 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1851 $Perm.No)))
(assert (not (= $t@1852 $Ref.null)))
(declare-const $k@1853 $Perm)
(assert ($Perm.isValidVar $k@1853))
(assert ($Perm.isReadVar $k@1853 $Perm.Write))
(declare-const $t@1854 Int)
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1853 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1853 $Perm.No)))
(assert (> $t@1854 0))
(declare-const $k@1855 $Perm)
(assert ($Perm.isValidVar $k@1855))
(assert ($Perm.isReadVar $k@1855 $Perm.Write))
(declare-const $t@1856 $Ref)
(push) ; 5
(assert (not (not (= $k@1855 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1855 $Perm.No)))
(assert (not (= $t@1856 $Ref.null)))
(declare-const $t@1857 Int)
(declare-const $t@1858 $Ref)
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1858 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1858 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 320] $t@1858 != Null
(assert (not (= $t@1858 $Ref.null)))
(declare-const $t@1859 $Snap)
(declare-const $k@1860 $Perm)
(assert ($Perm.isValidVar $k@1860))
(assert ($Perm.isReadVar $k@1860 $Perm.Write))
(declare-const $t@1861 $Ref)
(declare-const $k@1862 $Perm)
(assert ($Perm.isValidVar $k@1862))
(assert ($Perm.isReadVar $k@1862 $Perm.Write))
(declare-const $t@1863 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 320] $t@1858 == Null
(assert (= $t@1858 $Ref.null))
(declare-const $k@1864 $Perm)
(assert ($Perm.isValidVar $k@1864))
(assert ($Perm.isReadVar $k@1864 $Perm.Write))
(declare-const $t@1865 $Ref)
(declare-const $k@1866 $Perm)
(assert ($Perm.isValidVar $k@1866))
(assert ($Perm.isReadVar $k@1866 $Perm.Write))
(declare-const $t@1867 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_61 := BlockingQueue__offer(diz.LBQThread1b__queue, 2)
; [eval] diz != null
(declare-const $k@1868 $Perm)
(assert ($Perm.isValidVar $k@1868))
(assert ($Perm.isReadVar $k@1868 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1868 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1868 $k@1840))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1869 $Perm)
(assert ($Perm.isValidVar $k@1869))
(assert ($Perm.isReadVar $k@1869 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1869 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1869 $k@1842))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1845 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 321] $t@1845 != Null
(declare-const $k@1870 $Perm)
(assert ($Perm.isValidVar $k@1870))
(assert ($Perm.isReadVar $k@1870 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1870 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1847 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1847 $Perm.No)))
(assert (< $k@1870 $k@1847))
(declare-const $k@1871 $Perm)
(assert ($Perm.isValidVar $k@1871))
(assert ($Perm.isReadVar $k@1871 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1871 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1849 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1849 $Perm.No)))
(assert (< $k@1871 $k@1849))
(declare-const sys__result@1872 Bool)
(declare-const $t@1873 $Snap)
(declare-const $t@1874 $Snap)
(declare-const $t@1875 $Ref)
(assert (= $t@1873 ($Snap.combine $t@1874 ($SortWrappers.$RefTo$Snap $t@1875))))
(declare-const $t@1876 $Snap)
(declare-const $t@1877 $Ref)
(assert (= $t@1874 ($Snap.combine $t@1876 ($SortWrappers.$RefTo$Snap $t@1877))))
(declare-const $t@1878 $Snap)
(declare-const $t@1879 $Snap)
(assert (= $t@1876 ($Snap.combine $t@1878 $t@1879)))
(declare-const $t@1880 $Snap)
(declare-const $t@1881 $Ref)
(assert (= $t@1878 ($Snap.combine $t@1880 ($SortWrappers.$RefTo$Snap $t@1881))))
(declare-const $t@1882 $Snap)
(declare-const $t@1883 Int)
(assert (= $t@1880 ($Snap.combine $t@1882 ($SortWrappers.IntTo$Snap $t@1883))))
(declare-const $t@1884 Int)
(declare-const $t@1885 $Ref)
(assert (=
  $t@1882
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1884)
    ($SortWrappers.$RefTo$Snap $t@1885))))
(declare-const $t@1886 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1884)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1886) $Snap.unit)))
(declare-const $k@1887 $Perm)
(assert ($Perm.isValidVar $k@1887))
(assert ($Perm.isReadVar $k@1887 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1840 $k@1868)) (= $t@1886 $t@1841)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@1840 $k@1868) $k@1887) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1840 $k@1868) $k@1887) $Perm.No)))
(assert (> $t@1886 0))
(declare-const $k@1888 $Perm)
(assert ($Perm.isValidVar $k@1888))
(assert ($Perm.isReadVar $k@1888 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1842 $k@1869)) (= $t@1885 $t@1843)))
(push) ; 6
(assert (not (not (= (+ (- $k@1842 $k@1869) $k@1888) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1842 $k@1869) $k@1888) $Perm.No)))
(assert (not (= $t@1885 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@1881 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@1881 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 322] $t@1881 != Null
(assert (not (= $t@1881 $Ref.null)))
(declare-const $k@1889 $Perm)
(assert ($Perm.isValidVar $k@1889))
(assert ($Perm.isReadVar $k@1889 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1847 $k@1870)) (= $t@1877 $t@1848)))
(declare-const $k@1890 $Perm)
(assert ($Perm.isValidVar $k@1890))
(assert ($Perm.isReadVar $k@1890 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1849 $k@1871)) (= $t@1875 $t@1850)))
; [exec]
; b := __flatten_61
; [exec]
; __flatten_62 := BlockingQueue__peek(diz.LBQThread1b__queue)
; [eval] diz != null
(declare-const $k@1891 $Perm)
(assert ($Perm.isValidVar $k@1891))
(assert ($Perm.isReadVar $k@1891 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1891 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1891 (+ (- $k@1840 $k@1868) $k@1887)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1892 $Perm)
(assert ($Perm.isValidVar $k@1892))
(assert ($Perm.isReadVar $k@1892 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1892 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1892 (+ (- $k@1842 $k@1869) $k@1888)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@1881 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 323] $t@1881 != Null
(declare-const $k@1893 $Perm)
(assert ($Perm.isValidVar $k@1893))
(assert ($Perm.isReadVar $k@1893 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1893 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1847 $k@1870) $k@1889) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1847 $k@1870) $k@1889) $Perm.No)))
(assert (< $k@1893 (+ (- $k@1847 $k@1870) $k@1889)))
(declare-const $k@1894 $Perm)
(assert ($Perm.isValidVar $k@1894))
(assert ($Perm.isReadVar $k@1894 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1894 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1849 $k@1871) $k@1890) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1849 $k@1871) $k@1890) $Perm.No)))
(assert (< $k@1894 (+ (- $k@1849 $k@1871) $k@1890)))
(declare-const sys__result@1895 $Ref)
(declare-const $t@1896 $Snap)
(declare-const $t@1897 $Snap)
(declare-const $t@1898 $Ref)
(assert (= $t@1896 ($Snap.combine $t@1897 ($SortWrappers.$RefTo$Snap $t@1898))))
(declare-const $t@1899 $Snap)
(declare-const $t@1900 $Ref)
(assert (= $t@1897 ($Snap.combine $t@1899 ($SortWrappers.$RefTo$Snap $t@1900))))
(declare-const $t@1901 $Snap)
(declare-const $t@1902 $Snap)
(assert (= $t@1899 ($Snap.combine $t@1901 $t@1902)))
(declare-const $t@1903 $Snap)
(declare-const $t@1904 $Ref)
(assert (= $t@1901 ($Snap.combine $t@1903 ($SortWrappers.$RefTo$Snap $t@1904))))
(declare-const $t@1905 $Snap)
(declare-const $t@1906 Int)
(assert (= $t@1903 ($Snap.combine $t@1905 ($SortWrappers.IntTo$Snap $t@1906))))
(declare-const $t@1907 Int)
(declare-const $t@1908 $Ref)
(assert (=
  $t@1905
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1907)
    ($SortWrappers.$RefTo$Snap $t@1908))))
(declare-const $t@1909 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1907)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1909) $Snap.unit)))
(declare-const $k@1910 $Perm)
(assert ($Perm.isValidVar $k@1910))
(assert ($Perm.isReadVar $k@1910 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1840 $k@1868) $k@1887) $k@1891))
  (= $t@1909 $t@1886)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1891) $k@1910) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1891) $k@1910) $Perm.No)))
(assert (> $t@1909 0))
(declare-const $k@1911 $Perm)
(assert ($Perm.isValidVar $k@1911))
(assert ($Perm.isReadVar $k@1911 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1842 $k@1869) $k@1888) $k@1892))
  (= $t@1908 $t@1885)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1892) $k@1911) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1892) $k@1911) $Perm.No)))
(assert (not (= $t@1908 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1904 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1904 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 324] $t@1904 != Null
(assert (not (= $t@1904 $Ref.null)))
(declare-const $k@1912 $Perm)
(assert ($Perm.isValidVar $k@1912))
(assert ($Perm.isReadVar $k@1912 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893))
  (= $t@1900 $t@1877)))
(declare-const $k@1913 $Perm)
(assert ($Perm.isValidVar $k@1913))
(assert ($Perm.isReadVar $k@1913 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894))
  (= $t@1898 $t@1875)))
; [exec]
; i := __flatten_62
(declare-const $k@1914 $Perm)
(assert ($Perm.isValidVar $k@1914))
(assert ($Perm.isReadVar $k@1914 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1914 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1914 $k@1838))
(declare-const $k@1915 $Perm)
(assert ($Perm.isValidVar $k@1915))
(assert ($Perm.isReadVar $k@1915 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1915 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1915 (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1891) $k@1910)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@1916 $Perm)
(assert ($Perm.isValidVar $k@1916))
(assert ($Perm.isReadVar $k@1916 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1916 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1916 (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1892) $k@1911)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1904 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 325] $t@1904 != Null
(declare-const $k@1917 $Perm)
(assert ($Perm.isValidVar $k@1917))
(assert ($Perm.isReadVar $k@1917 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1917 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893) $k@1912) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893) $k@1912) $Perm.No)))
(assert (< $k@1917 (+ (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893) $k@1912)))
(declare-const $k@1918 $Perm)
(assert ($Perm.isValidVar $k@1918))
(assert ($Perm.isReadVar $k@1918 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1918 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894) $k@1913) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894) $k@1913) $Perm.No)))
(assert (< $k@1918 (+ (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894) $k@1913)))
(pop) ; 9
; [dead else-branch 325] $t@1904 == Null
(pop) ; 8
(push) ; 8
; [else-branch 324] $t@1904 == Null
(assert (= $t@1904 $Ref.null))
(declare-const $k@1919 $Perm)
(assert ($Perm.isValidVar $k@1919))
(assert ($Perm.isReadVar $k@1919 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893))
  (= $t@1900 $t@1877)))
(declare-const $k@1920 $Perm)
(assert ($Perm.isValidVar $k@1920))
(assert ($Perm.isReadVar $k@1920 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894))
  (= $t@1898 $t@1875)))
; [exec]
; i := __flatten_62
(declare-const $k@1921 $Perm)
(assert ($Perm.isValidVar $k@1921))
(assert ($Perm.isReadVar $k@1921 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1921 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1921 $k@1838))
(declare-const $k@1922 $Perm)
(assert ($Perm.isValidVar $k@1922))
(assert ($Perm.isReadVar $k@1922 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1922 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1922 (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1891) $k@1910)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@1923 $Perm)
(assert ($Perm.isValidVar $k@1923))
(assert ($Perm.isReadVar $k@1923 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1923 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1923 (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1892) $k@1911)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1904 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 326] $t@1904 != Null
(push) ; 9
; [else-branch 326] $t@1904 == Null
(declare-const $k@1924 $Perm)
(assert ($Perm.isValidVar $k@1924))
(assert ($Perm.isReadVar $k@1924 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1924 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893) $k@1919) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893) $k@1919) $Perm.No)))
(assert (< $k@1924 (+ (- (+ (- $k@1847 $k@1870) $k@1889) $k@1893) $k@1919)))
(declare-const $k@1925 $Perm)
(assert ($Perm.isValidVar $k@1925))
(assert ($Perm.isReadVar $k@1925 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1925 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894) $k@1920) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894) $k@1920) $Perm.No)))
(assert (< $k@1925 (+ (- (+ (- $k@1849 $k@1871) $k@1890) $k@1894) $k@1920)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 323] $t@1881 == Null
(pop) ; 6
(push) ; 6
; [else-branch 322] $t@1881 == Null
(assert (= $t@1881 $Ref.null))
(declare-const $k@1926 $Perm)
(assert ($Perm.isValidVar $k@1926))
(assert ($Perm.isReadVar $k@1926 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1847 $k@1870)) (= $t@1877 $t@1848)))
(declare-const $k@1927 $Perm)
(assert ($Perm.isValidVar $k@1927))
(assert ($Perm.isReadVar $k@1927 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1849 $k@1871)) (= $t@1875 $t@1850)))
; [exec]
; b := __flatten_61
; [exec]
; __flatten_62 := BlockingQueue__peek(diz.LBQThread1b__queue)
; [eval] diz != null
(declare-const $k@1928 $Perm)
(assert ($Perm.isValidVar $k@1928))
(assert ($Perm.isReadVar $k@1928 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1928 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1928 (+ (- $k@1840 $k@1868) $k@1887)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1929 $Perm)
(assert ($Perm.isValidVar $k@1929))
(assert ($Perm.isReadVar $k@1929 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@1929 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@1929 (+ (- $k@1842 $k@1869) $k@1888)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@1881 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 327] $t@1881 != Null
(push) ; 7
; [else-branch 327] $t@1881 == Null
(declare-const $k@1930 $Perm)
(assert ($Perm.isValidVar $k@1930))
(assert ($Perm.isReadVar $k@1930 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1930 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1847 $k@1870) $k@1926) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1847 $k@1870) $k@1926) $Perm.No)))
(assert (< $k@1930 (+ (- $k@1847 $k@1870) $k@1926)))
(declare-const $k@1931 $Perm)
(assert ($Perm.isValidVar $k@1931))
(assert ($Perm.isReadVar $k@1931 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@1931 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1849 $k@1871) $k@1927) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1849 $k@1871) $k@1927) $Perm.No)))
(assert (< $k@1931 (+ (- $k@1849 $k@1871) $k@1927)))
(declare-const sys__result@1932 $Ref)
(declare-const $t@1933 $Snap)
(declare-const $t@1934 $Snap)
(declare-const $t@1935 $Ref)
(assert (= $t@1933 ($Snap.combine $t@1934 ($SortWrappers.$RefTo$Snap $t@1935))))
(declare-const $t@1936 $Snap)
(declare-const $t@1937 $Ref)
(assert (= $t@1934 ($Snap.combine $t@1936 ($SortWrappers.$RefTo$Snap $t@1937))))
(declare-const $t@1938 $Snap)
(declare-const $t@1939 $Snap)
(assert (= $t@1936 ($Snap.combine $t@1938 $t@1939)))
(declare-const $t@1940 $Snap)
(declare-const $t@1941 $Ref)
(assert (= $t@1938 ($Snap.combine $t@1940 ($SortWrappers.$RefTo$Snap $t@1941))))
(declare-const $t@1942 $Snap)
(declare-const $t@1943 Int)
(assert (= $t@1940 ($Snap.combine $t@1942 ($SortWrappers.IntTo$Snap $t@1943))))
(declare-const $t@1944 Int)
(declare-const $t@1945 $Ref)
(assert (=
  $t@1942
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@1944)
    ($SortWrappers.$RefTo$Snap $t@1945))))
(declare-const $t@1946 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@1944)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@1946) $Snap.unit)))
(declare-const $k@1947 $Perm)
(assert ($Perm.isValidVar $k@1947))
(assert ($Perm.isReadVar $k@1947 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1840 $k@1868) $k@1887) $k@1928))
  (= $t@1946 $t@1886)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1928) $k@1947) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1928) $k@1947) $Perm.No)))
(assert (> $t@1946 0))
(declare-const $k@1948 $Perm)
(assert ($Perm.isValidVar $k@1948))
(assert ($Perm.isReadVar $k@1948 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1842 $k@1869) $k@1888) $k@1929))
  (= $t@1945 $t@1885)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1929) $k@1948) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1929) $k@1948) $Perm.No)))
(assert (not (= $t@1945 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@1941 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@1941 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 328] $t@1941 != Null
(assert (not (= $t@1941 $Ref.null)))
(declare-const $k@1949 $Perm)
(assert ($Perm.isValidVar $k@1949))
(assert ($Perm.isReadVar $k@1949 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930))
  (= $t@1937 $t@1877)))
(declare-const $k@1950 $Perm)
(assert ($Perm.isValidVar $k@1950))
(assert ($Perm.isReadVar $k@1950 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931))
  (= $t@1935 $t@1875)))
; [exec]
; i := __flatten_62
(declare-const $k@1951 $Perm)
(assert ($Perm.isValidVar $k@1951))
(assert ($Perm.isReadVar $k@1951 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1951 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1951 $k@1838))
(declare-const $k@1952 $Perm)
(assert ($Perm.isValidVar $k@1952))
(assert ($Perm.isReadVar $k@1952 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1952 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1952 (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1928) $k@1947)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@1953 $Perm)
(assert ($Perm.isValidVar $k@1953))
(assert ($Perm.isReadVar $k@1953 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1953 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1953 (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1929) $k@1948)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@1941 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 329] $t@1941 != Null
(declare-const $k@1954 $Perm)
(assert ($Perm.isValidVar $k@1954))
(assert ($Perm.isReadVar $k@1954 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1954 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930) $k@1949) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930) $k@1949) $Perm.No)))
(assert (< $k@1954 (+ (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930) $k@1949)))
(declare-const $k@1955 $Perm)
(assert ($Perm.isValidVar $k@1955))
(assert ($Perm.isReadVar $k@1955 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1955 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931) $k@1950) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931) $k@1950) $Perm.No)))
(assert (< $k@1955 (+ (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931) $k@1950)))
(pop) ; 9
; [dead else-branch 329] $t@1941 == Null
(pop) ; 8
(push) ; 8
; [else-branch 328] $t@1941 == Null
(assert (= $t@1941 $Ref.null))
(declare-const $k@1956 $Perm)
(assert ($Perm.isValidVar $k@1956))
(assert ($Perm.isReadVar $k@1956 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930))
  (= $t@1937 $t@1877)))
(declare-const $k@1957 $Perm)
(assert ($Perm.isValidVar $k@1957))
(assert ($Perm.isReadVar $k@1957 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931))
  (= $t@1935 $t@1875)))
; [exec]
; i := __flatten_62
(declare-const $k@1958 $Perm)
(assert ($Perm.isValidVar $k@1958))
(assert ($Perm.isReadVar $k@1958 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1958 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1958 $k@1838))
(declare-const $k@1959 $Perm)
(assert ($Perm.isValidVar $k@1959))
(assert ($Perm.isReadVar $k@1959 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1959 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1959 (+ (- (+ (- $k@1840 $k@1868) $k@1887) $k@1928) $k@1947)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@1960 $Perm)
(assert ($Perm.isValidVar $k@1960))
(assert ($Perm.isReadVar $k@1960 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@1960 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@1960 (+ (- (+ (- $k@1842 $k@1869) $k@1888) $k@1929) $k@1948)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@1941 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 330] $t@1941 != Null
(push) ; 9
; [else-branch 330] $t@1941 == Null
(declare-const $k@1961 $Perm)
(assert ($Perm.isValidVar $k@1961))
(assert ($Perm.isReadVar $k@1961 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1961 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930) $k@1956) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930) $k@1956) $Perm.No)))
(assert (< $k@1961 (+ (- (+ (- $k@1847 $k@1870) $k@1926) $k@1930) $k@1956)))
(declare-const $k@1962 $Perm)
(assert ($Perm.isValidVar $k@1962))
(assert ($Perm.isReadVar $k@1962 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@1962 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931) $k@1957) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931) $k@1957) $Perm.No)))
(assert (< $k@1962 (+ (- (+ (- $k@1849 $k@1871) $k@1927) $k@1931) $k@1957)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 321] $t@1845 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 319] $t@1845 == Null
(assert (= $t@1845 $Ref.null))
(declare-const $k@1963 $Perm)
(assert ($Perm.isValidVar $k@1963))
(assert ($Perm.isReadVar $k@1963 $Perm.Write))
(declare-const $t@1964 $Ref)
(declare-const $k@1965 $Perm)
(assert ($Perm.isValidVar $k@1965))
(assert ($Perm.isReadVar $k@1965 $Perm.Write))
(declare-const $t@1966 $Ref)
(push) ; 4
(declare-const $k@1967 $Perm)
(assert ($Perm.isValidVar $k@1967))
(assert ($Perm.isReadVar $k@1967 $Perm.Write))
(declare-const $t@1968 $Ref)
(push) ; 5
(assert (not (not (= $k@1967 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1967 $Perm.No)))
(assert (not (= $t@1968 $Ref.null)))
(declare-const $k@1969 $Perm)
(assert ($Perm.isValidVar $k@1969))
(assert ($Perm.isReadVar $k@1969 $Perm.Write))
(declare-const $t@1970 Int)
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@1969 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1969 $Perm.No)))
(assert (> $t@1970 0))
(declare-const $k@1971 $Perm)
(assert ($Perm.isValidVar $k@1971))
(assert ($Perm.isReadVar $k@1971 $Perm.Write))
(declare-const $t@1972 $Ref)
(push) ; 5
(assert (not (not (= $k@1971 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@1971 $Perm.No)))
(assert (not (= $t@1972 $Ref.null)))
(declare-const $t@1973 Int)
(declare-const $t@1974 $Ref)
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@1974 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@1974 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 331] $t@1974 != Null
(assert (not (= $t@1974 $Ref.null)))
(declare-const $t@1975 $Snap)
(declare-const $k@1976 $Perm)
(assert ($Perm.isValidVar $k@1976))
(assert ($Perm.isReadVar $k@1976 $Perm.Write))
(declare-const $t@1977 $Ref)
(declare-const $k@1978 $Perm)
(assert ($Perm.isValidVar $k@1978))
(assert ($Perm.isReadVar $k@1978 $Perm.Write))
(declare-const $t@1979 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 331] $t@1974 == Null
(assert (= $t@1974 $Ref.null))
(declare-const $k@1980 $Perm)
(assert ($Perm.isValidVar $k@1980))
(assert ($Perm.isReadVar $k@1980 $Perm.Write))
(declare-const $t@1981 $Ref)
(declare-const $k@1982 $Perm)
(assert ($Perm.isValidVar $k@1982))
(assert ($Perm.isReadVar $k@1982 $Perm.Write))
(declare-const $t@1983 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_61 := BlockingQueue__offer(diz.LBQThread1b__queue, 2)
; [eval] diz != null
(declare-const $k@1984 $Perm)
(assert ($Perm.isValidVar $k@1984))
(assert ($Perm.isReadVar $k@1984 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1984 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1984 $k@1840))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@1985 $Perm)
(assert ($Perm.isValidVar $k@1985))
(assert ($Perm.isReadVar $k@1985 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@1985 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@1985 $k@1842))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@1845 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 332] $t@1845 != Null
(push) ; 5
; [else-branch 332] $t@1845 == Null
(declare-const $k@1986 $Perm)
(assert ($Perm.isValidVar $k@1986))
(assert ($Perm.isReadVar $k@1986 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1986 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1963 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1963 $Perm.No)))
(assert (< $k@1986 $k@1963))
(declare-const $k@1987 $Perm)
(assert ($Perm.isValidVar $k@1987))
(assert ($Perm.isReadVar $k@1987 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@1987 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@1965 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@1965 $Perm.No)))
(assert (< $k@1987 $k@1965))
(declare-const sys__result@1988 Bool)
(declare-const $t@1989 $Snap)
(declare-const $t@1990 $Snap)
(declare-const $t@1991 $Ref)
(assert (= $t@1989 ($Snap.combine $t@1990 ($SortWrappers.$RefTo$Snap $t@1991))))
(declare-const $t@1992 $Snap)
(declare-const $t@1993 $Ref)
(assert (= $t@1990 ($Snap.combine $t@1992 ($SortWrappers.$RefTo$Snap $t@1993))))
(declare-const $t@1994 $Snap)
(declare-const $t@1995 $Snap)
(assert (= $t@1992 ($Snap.combine $t@1994 $t@1995)))
(declare-const $t@1996 $Snap)
(declare-const $t@1997 $Ref)
(assert (= $t@1994 ($Snap.combine $t@1996 ($SortWrappers.$RefTo$Snap $t@1997))))
(declare-const $t@1998 $Snap)
(declare-const $t@1999 Int)
(assert (= $t@1996 ($Snap.combine $t@1998 ($SortWrappers.IntTo$Snap $t@1999))))
(declare-const $t@2000 Int)
(declare-const $t@2001 $Ref)
(assert (=
  $t@1998
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2000)
    ($SortWrappers.$RefTo$Snap $t@2001))))
(declare-const $t@2002 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2000)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2002) $Snap.unit)))
(declare-const $k@2003 $Perm)
(assert ($Perm.isValidVar $k@2003))
(assert ($Perm.isReadVar $k@2003 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1840 $k@1984)) (= $t@2002 $t@1841)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@1840 $k@1984) $k@2003) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1840 $k@1984) $k@2003) $Perm.No)))
(assert (> $t@2002 0))
(declare-const $k@2004 $Perm)
(assert ($Perm.isValidVar $k@2004))
(assert ($Perm.isReadVar $k@2004 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1842 $k@1985)) (= $t@2001 $t@1843)))
(push) ; 6
(assert (not (not (= (+ (- $k@1842 $k@1985) $k@2004) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@1842 $k@1985) $k@2004) $Perm.No)))
(assert (not (= $t@2001 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@1997 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@1997 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 333] $t@1997 != Null
(assert (not (= $t@1997 $Ref.null)))
(declare-const $k@2005 $Perm)
(assert ($Perm.isValidVar $k@2005))
(assert ($Perm.isReadVar $k@2005 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1963 $k@1986)) (= $t@1993 $t@1964)))
(declare-const $k@2006 $Perm)
(assert ($Perm.isValidVar $k@2006))
(assert ($Perm.isReadVar $k@2006 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1965 $k@1987)) (= $t@1991 $t@1966)))
; [exec]
; b := __flatten_61
; [exec]
; __flatten_62 := BlockingQueue__peek(diz.LBQThread1b__queue)
; [eval] diz != null
(declare-const $k@2007 $Perm)
(assert ($Perm.isValidVar $k@2007))
(assert ($Perm.isReadVar $k@2007 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2007 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2007 (+ (- $k@1840 $k@1984) $k@2003)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2008 $Perm)
(assert ($Perm.isValidVar $k@2008))
(assert ($Perm.isReadVar $k@2008 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2008 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2008 (+ (- $k@1842 $k@1985) $k@2004)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@1997 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 334] $t@1997 != Null
(declare-const $k@2009 $Perm)
(assert ($Perm.isValidVar $k@2009))
(assert ($Perm.isReadVar $k@2009 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2009 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1963 $k@1986) $k@2005) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1963 $k@1986) $k@2005) $Perm.No)))
(assert (< $k@2009 (+ (- $k@1963 $k@1986) $k@2005)))
(declare-const $k@2010 $Perm)
(assert ($Perm.isValidVar $k@2010))
(assert ($Perm.isReadVar $k@2010 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2010 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1965 $k@1987) $k@2006) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1965 $k@1987) $k@2006) $Perm.No)))
(assert (< $k@2010 (+ (- $k@1965 $k@1987) $k@2006)))
(declare-const sys__result@2011 $Ref)
(declare-const $t@2012 $Snap)
(declare-const $t@2013 $Snap)
(declare-const $t@2014 $Ref)
(assert (= $t@2012 ($Snap.combine $t@2013 ($SortWrappers.$RefTo$Snap $t@2014))))
(declare-const $t@2015 $Snap)
(declare-const $t@2016 $Ref)
(assert (= $t@2013 ($Snap.combine $t@2015 ($SortWrappers.$RefTo$Snap $t@2016))))
(declare-const $t@2017 $Snap)
(declare-const $t@2018 $Snap)
(assert (= $t@2015 ($Snap.combine $t@2017 $t@2018)))
(declare-const $t@2019 $Snap)
(declare-const $t@2020 $Ref)
(assert (= $t@2017 ($Snap.combine $t@2019 ($SortWrappers.$RefTo$Snap $t@2020))))
(declare-const $t@2021 $Snap)
(declare-const $t@2022 Int)
(assert (= $t@2019 ($Snap.combine $t@2021 ($SortWrappers.IntTo$Snap $t@2022))))
(declare-const $t@2023 Int)
(declare-const $t@2024 $Ref)
(assert (=
  $t@2021
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2023)
    ($SortWrappers.$RefTo$Snap $t@2024))))
(declare-const $t@2025 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2023)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2025) $Snap.unit)))
(declare-const $k@2026 $Perm)
(assert ($Perm.isValidVar $k@2026))
(assert ($Perm.isReadVar $k@2026 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1840 $k@1984) $k@2003) $k@2007))
  (= $t@2025 $t@2002)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2007) $k@2026) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2007) $k@2026) $Perm.No)))
(assert (> $t@2025 0))
(declare-const $k@2027 $Perm)
(assert ($Perm.isValidVar $k@2027))
(assert ($Perm.isReadVar $k@2027 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1842 $k@1985) $k@2004) $k@2008))
  (= $t@2024 $t@2001)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2008) $k@2027) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2008) $k@2027) $Perm.No)))
(assert (not (= $t@2024 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@2020 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@2020 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 335] $t@2020 != Null
(assert (not (= $t@2020 $Ref.null)))
(declare-const $k@2028 $Perm)
(assert ($Perm.isValidVar $k@2028))
(assert ($Perm.isReadVar $k@2028 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009))
  (= $t@2016 $t@1993)))
(declare-const $k@2029 $Perm)
(assert ($Perm.isValidVar $k@2029))
(assert ($Perm.isReadVar $k@2029 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010))
  (= $t@2014 $t@1991)))
; [exec]
; i := __flatten_62
(declare-const $k@2030 $Perm)
(assert ($Perm.isValidVar $k@2030))
(assert ($Perm.isReadVar $k@2030 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2030 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2030 $k@1838))
(declare-const $k@2031 $Perm)
(assert ($Perm.isValidVar $k@2031))
(assert ($Perm.isReadVar $k@2031 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2031 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2031 (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2007) $k@2026)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@2032 $Perm)
(assert ($Perm.isValidVar $k@2032))
(assert ($Perm.isReadVar $k@2032 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2032 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2032 (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2008) $k@2027)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@2020 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 336] $t@2020 != Null
(declare-const $k@2033 $Perm)
(assert ($Perm.isValidVar $k@2033))
(assert ($Perm.isReadVar $k@2033 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2033 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009) $k@2028) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009) $k@2028) $Perm.No)))
(assert (< $k@2033 (+ (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009) $k@2028)))
(declare-const $k@2034 $Perm)
(assert ($Perm.isValidVar $k@2034))
(assert ($Perm.isReadVar $k@2034 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2034 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010) $k@2029) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010) $k@2029) $Perm.No)))
(assert (< $k@2034 (+ (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010) $k@2029)))
(pop) ; 9
; [dead else-branch 336] $t@2020 == Null
(pop) ; 8
(push) ; 8
; [else-branch 335] $t@2020 == Null
(assert (= $t@2020 $Ref.null))
(declare-const $k@2035 $Perm)
(assert ($Perm.isValidVar $k@2035))
(assert ($Perm.isReadVar $k@2035 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009))
  (= $t@2016 $t@1993)))
(declare-const $k@2036 $Perm)
(assert ($Perm.isValidVar $k@2036))
(assert ($Perm.isReadVar $k@2036 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010))
  (= $t@2014 $t@1991)))
; [exec]
; i := __flatten_62
(declare-const $k@2037 $Perm)
(assert ($Perm.isValidVar $k@2037))
(assert ($Perm.isReadVar $k@2037 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2037 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2037 $k@1838))
(declare-const $k@2038 $Perm)
(assert ($Perm.isValidVar $k@2038))
(assert ($Perm.isReadVar $k@2038 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2038 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2038 (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2007) $k@2026)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@2039 $Perm)
(assert ($Perm.isValidVar $k@2039))
(assert ($Perm.isReadVar $k@2039 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2039 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2039 (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2008) $k@2027)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@2020 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 337] $t@2020 != Null
(push) ; 9
; [else-branch 337] $t@2020 == Null
(declare-const $k@2040 $Perm)
(assert ($Perm.isValidVar $k@2040))
(assert ($Perm.isReadVar $k@2040 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2040 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009) $k@2035) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009) $k@2035) $Perm.No)))
(assert (< $k@2040 (+ (- (+ (- $k@1963 $k@1986) $k@2005) $k@2009) $k@2035)))
(declare-const $k@2041 $Perm)
(assert ($Perm.isValidVar $k@2041))
(assert ($Perm.isReadVar $k@2041 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2041 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010) $k@2036) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010) $k@2036) $Perm.No)))
(assert (< $k@2041 (+ (- (+ (- $k@1965 $k@1987) $k@2006) $k@2010) $k@2036)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 334] $t@1997 == Null
(pop) ; 6
(push) ; 6
; [else-branch 333] $t@1997 == Null
(assert (= $t@1997 $Ref.null))
(declare-const $k@2042 $Perm)
(assert ($Perm.isValidVar $k@2042))
(assert ($Perm.isReadVar $k@2042 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1963 $k@1986)) (= $t@1993 $t@1964)))
(declare-const $k@2043 $Perm)
(assert ($Perm.isValidVar $k@2043))
(assert ($Perm.isReadVar $k@2043 $Perm.Write))
(assert (implies (< $Perm.No (- $k@1965 $k@1987)) (= $t@1991 $t@1966)))
; [exec]
; b := __flatten_61
; [exec]
; __flatten_62 := BlockingQueue__peek(diz.LBQThread1b__queue)
; [eval] diz != null
(declare-const $k@2044 $Perm)
(assert ($Perm.isValidVar $k@2044))
(assert ($Perm.isReadVar $k@2044 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2044 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2044 (+ (- $k@1840 $k@1984) $k@2003)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2045 $Perm)
(assert ($Perm.isValidVar $k@2045))
(assert ($Perm.isReadVar $k@2045 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2045 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2045 (+ (- $k@1842 $k@1985) $k@2004)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@1997 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 338] $t@1997 != Null
(push) ; 7
; [else-branch 338] $t@1997 == Null
(declare-const $k@2046 $Perm)
(assert ($Perm.isValidVar $k@2046))
(assert ($Perm.isReadVar $k@2046 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2046 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1963 $k@1986) $k@2042) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1963 $k@1986) $k@2042) $Perm.No)))
(assert (< $k@2046 (+ (- $k@1963 $k@1986) $k@2042)))
(declare-const $k@2047 $Perm)
(assert ($Perm.isValidVar $k@2047))
(assert ($Perm.isReadVar $k@2047 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2047 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@1965 $k@1987) $k@2043) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@1965 $k@1987) $k@2043) $Perm.No)))
(assert (< $k@2047 (+ (- $k@1965 $k@1987) $k@2043)))
(declare-const sys__result@2048 $Ref)
(declare-const $t@2049 $Snap)
(declare-const $t@2050 $Snap)
(declare-const $t@2051 $Ref)
(assert (= $t@2049 ($Snap.combine $t@2050 ($SortWrappers.$RefTo$Snap $t@2051))))
(declare-const $t@2052 $Snap)
(declare-const $t@2053 $Ref)
(assert (= $t@2050 ($Snap.combine $t@2052 ($SortWrappers.$RefTo$Snap $t@2053))))
(declare-const $t@2054 $Snap)
(declare-const $t@2055 $Snap)
(assert (= $t@2052 ($Snap.combine $t@2054 $t@2055)))
(declare-const $t@2056 $Snap)
(declare-const $t@2057 $Ref)
(assert (= $t@2054 ($Snap.combine $t@2056 ($SortWrappers.$RefTo$Snap $t@2057))))
(declare-const $t@2058 $Snap)
(declare-const $t@2059 Int)
(assert (= $t@2056 ($Snap.combine $t@2058 ($SortWrappers.IntTo$Snap $t@2059))))
(declare-const $t@2060 Int)
(declare-const $t@2061 $Ref)
(assert (=
  $t@2058
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2060)
    ($SortWrappers.$RefTo$Snap $t@2061))))
(declare-const $t@2062 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2060)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2062) $Snap.unit)))
(declare-const $k@2063 $Perm)
(assert ($Perm.isValidVar $k@2063))
(assert ($Perm.isReadVar $k@2063 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1840 $k@1984) $k@2003) $k@2044))
  (= $t@2062 $t@2002)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2044) $k@2063) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2044) $k@2063) $Perm.No)))
(assert (> $t@2062 0))
(declare-const $k@2064 $Perm)
(assert ($Perm.isValidVar $k@2064))
(assert ($Perm.isReadVar $k@2064 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1842 $k@1985) $k@2004) $k@2045))
  (= $t@2061 $t@2001)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2045) $k@2064) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2045) $k@2064) $Perm.No)))
(assert (not (= $t@2061 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@2057 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@2057 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 339] $t@2057 != Null
(assert (not (= $t@2057 $Ref.null)))
(declare-const $k@2065 $Perm)
(assert ($Perm.isValidVar $k@2065))
(assert ($Perm.isReadVar $k@2065 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046))
  (= $t@2053 $t@1993)))
(declare-const $k@2066 $Perm)
(assert ($Perm.isValidVar $k@2066))
(assert ($Perm.isReadVar $k@2066 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047))
  (= $t@2051 $t@1991)))
; [exec]
; i := __flatten_62
(declare-const $k@2067 $Perm)
(assert ($Perm.isValidVar $k@2067))
(assert ($Perm.isReadVar $k@2067 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2067 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2067 $k@1838))
(declare-const $k@2068 $Perm)
(assert ($Perm.isValidVar $k@2068))
(assert ($Perm.isReadVar $k@2068 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2068 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2068 (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2044) $k@2063)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@2069 $Perm)
(assert ($Perm.isValidVar $k@2069))
(assert ($Perm.isReadVar $k@2069 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2069 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2069 (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2045) $k@2064)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@2057 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 340] $t@2057 != Null
(declare-const $k@2070 $Perm)
(assert ($Perm.isValidVar $k@2070))
(assert ($Perm.isReadVar $k@2070 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2070 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046) $k@2065) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046) $k@2065) $Perm.No)))
(assert (< $k@2070 (+ (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046) $k@2065)))
(declare-const $k@2071 $Perm)
(assert ($Perm.isValidVar $k@2071))
(assert ($Perm.isReadVar $k@2071 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2071 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047) $k@2066) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047) $k@2066) $Perm.No)))
(assert (< $k@2071 (+ (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047) $k@2066)))
(pop) ; 9
; [dead else-branch 340] $t@2057 == Null
(pop) ; 8
(push) ; 8
; [else-branch 339] $t@2057 == Null
(assert (= $t@2057 $Ref.null))
(declare-const $k@2072 $Perm)
(assert ($Perm.isValidVar $k@2072))
(assert ($Perm.isReadVar $k@2072 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046))
  (= $t@2053 $t@1993)))
(declare-const $k@2073 $Perm)
(assert ($Perm.isValidVar $k@2073))
(assert ($Perm.isReadVar $k@2073 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047))
  (= $t@2051 $t@1991)))
; [exec]
; i := __flatten_62
(declare-const $k@2074 $Perm)
(assert ($Perm.isValidVar $k@2074))
(assert ($Perm.isReadVar $k@2074 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2074 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2074 $k@1838))
(declare-const $k@2075 $Perm)
(assert ($Perm.isValidVar $k@2075))
(assert ($Perm.isReadVar $k@2075 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2075 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2075 (+ (- (+ (- $k@1840 $k@1984) $k@2003) $k@2044) $k@2063)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__capacity > 0
(declare-const $k@2076 $Perm)
(assert ($Perm.isValidVar $k@2076))
(assert ($Perm.isReadVar $k@2076 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2076 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2076 (+ (- (+ (- $k@1842 $k@1985) $k@2004) $k@2045) $k@2064)))
; [eval] diz.LBQThread1b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@2057 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 341] $t@2057 != Null
(push) ; 9
; [else-branch 341] $t@2057 == Null
(declare-const $k@2077 $Perm)
(assert ($Perm.isValidVar $k@2077))
(assert ($Perm.isReadVar $k@2077 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2077 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046) $k@2072) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046) $k@2072) $Perm.No)))
(assert (< $k@2077 (+ (- (+ (- $k@1963 $k@1986) $k@2042) $k@2046) $k@2072)))
(declare-const $k@2078 $Perm)
(assert ($Perm.isValidVar $k@2078))
(assert ($Perm.isReadVar $k@2078 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2078 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047) $k@2073) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047) $k@2073) $Perm.No)))
(assert (< $k@2078 (+ (- (+ (- $k@1965 $k@1987) $k@2043) $k@2047) $k@2073)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2a__LBQThread1a ----------
(declare-const queue@2079 $Ref)
(declare-const sys__result@2080 $Ref)
(declare-const diz@2081 $Ref)
(declare-const __flatten_63@2082 $Ref)
(declare-const __flatten_123@2083 $Ref)
(push) ; 2
(assert (not (= queue@2079 $Ref.null)))
(declare-const $k@2084 $Perm)
(assert ($Perm.isValidVar $k@2084))
(assert ($Perm.isReadVar $k@2084 $Perm.Write))
(declare-const $t@2085 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2084 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2084 $Perm.No)))
(assert (> $t@2085 0))
(declare-const $k@2086 $Perm)
(assert ($Perm.isValidVar $k@2086))
(assert ($Perm.isReadVar $k@2086 $Perm.Write))
(declare-const $t@2087 $Ref)
(push) ; 3
(assert (not (not (= $k@2086 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2086 $Perm.No)))
(assert (not (= $t@2087 $Ref.null)))
(declare-const $t@2088 Int)
(declare-const $t@2089 $Ref)
; [eval] queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2089 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2089 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 342] $t@2089 != Null
(assert (not (= $t@2089 $Ref.null)))
(declare-const $t@2090 $Snap)
(declare-const $k@2091 $Perm)
(assert ($Perm.isValidVar $k@2091))
(assert ($Perm.isReadVar $k@2091 $Perm.Write))
(declare-const $t@2092 $Ref)
(declare-const $k@2093 $Perm)
(assert ($Perm.isValidVar $k@2093))
(assert ($Perm.isReadVar $k@2093 $Perm.Write))
(declare-const $t@2094 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2080 $Ref.null)))
(declare-const $k@2095 $Perm)
(assert ($Perm.isValidVar $k@2095))
(assert ($Perm.isReadVar $k@2095 $Perm.Write))
(declare-const $t@2096 $Ref)
(push) ; 5
(assert (not (not (= $k@2095 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2095 $Perm.No)))
(assert (not (= $t@2096 $Ref.null)))
(declare-const $k@2097 $Perm)
(assert ($Perm.isValidVar $k@2097))
(assert ($Perm.isReadVar $k@2097 $Perm.Write))
(declare-const $t@2098 Int)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2097 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2097 $Perm.No)))
(assert (> $t@2098 0))
(declare-const $k@2099 $Perm)
(assert ($Perm.isValidVar $k@2099))
(assert ($Perm.isReadVar $k@2099 $Perm.Write))
(declare-const $t@2100 $Ref)
(push) ; 5
(assert (not (not (= $k@2099 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2099 $Perm.No)))
(assert (not (= $t@2100 $Ref.null)))
(declare-const $t@2101 Int)
(declare-const $t@2102 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2102 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2102 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 343] $t@2102 != Null
(assert (not (= $t@2102 $Ref.null)))
(declare-const $t@2103 $Snap)
(declare-const $k@2104 $Perm)
(assert ($Perm.isValidVar $k@2104))
(assert ($Perm.isReadVar $k@2104 $Perm.Write))
(declare-const $t@2105 $Ref)
(declare-const $k@2106 $Perm)
(assert ($Perm.isValidVar $k@2106))
(assert ($Perm.isReadVar $k@2106 $Perm.Write))
(declare-const $t@2107 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 343] $t@2102 == Null
(assert (= $t@2102 $Ref.null))
(declare-const $k@2108 $Perm)
(assert ($Perm.isValidVar $k@2108))
(assert ($Perm.isReadVar $k@2108 $Perm.Write))
(declare-const $t@2109 $Ref)
(declare-const $k@2110 $Perm)
(assert ($Perm.isValidVar $k@2110))
(assert ($Perm.isReadVar $k@2110 $Perm.Write))
(declare-const $t@2111 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread2a__queue)
(declare-const diz@2112 $Ref)
(assert (not (= diz@2112 $Ref.null)))
(declare-const LBQThread2a__queue@2113 $Ref)
(assert (and
  (not (= queue@2079 diz@2112))
  (not (= sys__result@2080 diz@2112))
  (not (= __flatten_63@2082 diz@2112))
  (not (= __flatten_123@2083 diz@2112))
  (not (= $t@2087 diz@2112))
  (not (= $t@2089 diz@2112))
  (not (= LBQThread2a__queue@2113 diz@2112))
  (not (= $t@2092 diz@2112))
  (not (= $t@2094 diz@2112))))
; [exec]
; __flatten_63 := queue
; [exec]
; __flatten_123 := __flatten_63
; [exec]
; diz.LBQThread2a__queue := __flatten_123
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread2a__queue, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread2a__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread2a__queue.BlockingQueue__first, write) && ((sys__result.LBQThread2a__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread2a__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread2a__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2114 $Perm)
(assert ($Perm.isValidVar $k@2114))
(assert ($Perm.isReadVar $k@2114 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2114 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2114 $Perm.Write))
(declare-const $k@2115 $Perm)
(assert ($Perm.isValidVar $k@2115))
(assert ($Perm.isReadVar $k@2115 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2115 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2115 $k@2084))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@2116 $Perm)
(assert ($Perm.isValidVar $k@2116))
(assert ($Perm.isReadVar $k@2116 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2116 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2116 $k@2086))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2089 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 344] $t@2089 != Null
(declare-const $k@2117 $Perm)
(assert ($Perm.isValidVar $k@2117))
(assert ($Perm.isReadVar $k@2117 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2117 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2091 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2091 $Perm.No)))
(assert (< $k@2117 $k@2091))
(declare-const $k@2118 $Perm)
(assert ($Perm.isValidVar $k@2118))
(assert ($Perm.isReadVar $k@2118 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2118 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2093 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2093 $Perm.No)))
(assert (< $k@2118 $k@2093))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 344] $t@2089 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 342] $t@2089 == Null
(assert (= $t@2089 $Ref.null))
(declare-const $k@2119 $Perm)
(assert ($Perm.isValidVar $k@2119))
(assert ($Perm.isReadVar $k@2119 $Perm.Write))
(declare-const $t@2120 $Ref)
(declare-const $k@2121 $Perm)
(assert ($Perm.isValidVar $k@2121))
(assert ($Perm.isReadVar $k@2121 $Perm.Write))
(declare-const $t@2122 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2080 $Ref.null)))
(declare-const $k@2123 $Perm)
(assert ($Perm.isValidVar $k@2123))
(assert ($Perm.isReadVar $k@2123 $Perm.Write))
(declare-const $t@2124 $Ref)
(push) ; 5
(assert (not (not (= $k@2123 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2123 $Perm.No)))
(assert (not (= $t@2124 $Ref.null)))
(declare-const $k@2125 $Perm)
(assert ($Perm.isValidVar $k@2125))
(assert ($Perm.isReadVar $k@2125 $Perm.Write))
(declare-const $t@2126 Int)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2125 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2125 $Perm.No)))
(assert (> $t@2126 0))
(declare-const $k@2127 $Perm)
(assert ($Perm.isValidVar $k@2127))
(assert ($Perm.isReadVar $k@2127 $Perm.Write))
(declare-const $t@2128 $Ref)
(push) ; 5
(assert (not (not (= $k@2127 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2127 $Perm.No)))
(assert (not (= $t@2128 $Ref.null)))
(declare-const $t@2129 Int)
(declare-const $t@2130 $Ref)
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2130 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2130 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 345] $t@2130 != Null
(assert (not (= $t@2130 $Ref.null)))
(declare-const $t@2131 $Snap)
(declare-const $k@2132 $Perm)
(assert ($Perm.isValidVar $k@2132))
(assert ($Perm.isReadVar $k@2132 $Perm.Write))
(declare-const $t@2133 $Ref)
(declare-const $k@2134 $Perm)
(assert ($Perm.isValidVar $k@2134))
(assert ($Perm.isReadVar $k@2134 $Perm.Write))
(declare-const $t@2135 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 345] $t@2130 == Null
(assert (= $t@2130 $Ref.null))
(declare-const $k@2136 $Perm)
(assert ($Perm.isValidVar $k@2136))
(assert ($Perm.isReadVar $k@2136 $Perm.Write))
(declare-const $t@2137 $Ref)
(declare-const $k@2138 $Perm)
(assert ($Perm.isValidVar $k@2138))
(assert ($Perm.isReadVar $k@2138 $Perm.Write))
(declare-const $t@2139 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread2a__queue)
(declare-const diz@2140 $Ref)
(assert (not (= diz@2140 $Ref.null)))
(declare-const LBQThread2a__queue@2141 $Ref)
(assert (and
  (not (= queue@2079 diz@2140))
  (not (= sys__result@2080 diz@2140))
  (not (= __flatten_63@2082 diz@2140))
  (not (= __flatten_123@2083 diz@2140))
  (not (= $t@2087 diz@2140))
  (not (= LBQThread2a__queue@2141 diz@2140))
  (not (= $t@2089 diz@2140))
  (not (= $t@2120 diz@2140))
  (not (= $t@2122 diz@2140))))
; [exec]
; __flatten_63 := queue
; [exec]
; __flatten_123 := __flatten_63
; [exec]
; diz.LBQThread2a__queue := __flatten_123
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread2a__queue, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread2a__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread2a__queue.BlockingQueue__first, write) && ((sys__result.LBQThread2a__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread2a__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread2a__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread2a__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2142 $Perm)
(assert ($Perm.isValidVar $k@2142))
(assert ($Perm.isReadVar $k@2142 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2142 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2142 $Perm.Write))
(declare-const $k@2143 $Perm)
(assert ($Perm.isValidVar $k@2143))
(assert ($Perm.isReadVar $k@2143 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2143 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2143 $k@2084))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@2144 $Perm)
(assert ($Perm.isValidVar $k@2144))
(assert ($Perm.isReadVar $k@2144 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2144 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2144 $k@2086))
; [eval] sys__result.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2089 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 346] $t@2089 != Null
(push) ; 5
; [else-branch 346] $t@2089 == Null
(declare-const $k@2145 $Perm)
(assert ($Perm.isValidVar $k@2145))
(assert ($Perm.isReadVar $k@2145 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2145 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2119 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2119 $Perm.No)))
(assert (< $k@2145 $k@2119))
(declare-const $k@2146 $Perm)
(assert ($Perm.isValidVar $k@2146))
(assert ($Perm.isReadVar $k@2146 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2146 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2121 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2121 $Perm.No)))
(assert (< $k@2146 $k@2121))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2a__run ----------
(declare-const diz@2147 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2147 $Ref.null)))
(declare-const $k@2148 $Perm)
(assert ($Perm.isValidVar $k@2148))
(assert ($Perm.isReadVar $k@2148 $Perm.Write))
(declare-const $t@2149 $Ref)
(push) ; 3
(assert (not (not (= $k@2148 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2148 $Perm.No)))
(assert (not (= $t@2149 $Ref.null)))
(declare-const $k@2150 $Perm)
(assert ($Perm.isValidVar $k@2150))
(assert ($Perm.isReadVar $k@2150 $Perm.Write))
(declare-const $t@2151 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2150 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2150 $Perm.No)))
(assert (> $t@2151 0))
(declare-const $k@2152 $Perm)
(assert ($Perm.isValidVar $k@2152))
(assert ($Perm.isReadVar $k@2152 $Perm.Write))
(declare-const $t@2153 $Ref)
(push) ; 3
(assert (not (not (= $k@2152 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2152 $Perm.No)))
(assert (not (= $t@2153 $Ref.null)))
(declare-const $t@2154 Int)
(declare-const $t@2155 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2155 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2155 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 347] $t@2155 != Null
(assert (not (= $t@2155 $Ref.null)))
(declare-const $t@2156 $Snap)
(declare-const $k@2157 $Perm)
(assert ($Perm.isValidVar $k@2157))
(assert ($Perm.isReadVar $k@2157 $Perm.Write))
(declare-const $t@2158 $Ref)
(declare-const $k@2159 $Perm)
(assert ($Perm.isValidVar $k@2159))
(assert ($Perm.isReadVar $k@2159 $Perm.Write))
(declare-const $t@2160 $Ref)
(push) ; 4
(declare-const $k@2161 $Perm)
(assert ($Perm.isValidVar $k@2161))
(assert ($Perm.isReadVar $k@2161 $Perm.Write))
(declare-const $t@2162 $Ref)
(push) ; 5
(assert (not (not (= $k@2161 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2161 $Perm.No)))
(assert (not (= $t@2162 $Ref.null)))
(declare-const $k@2163 $Perm)
(assert ($Perm.isValidVar $k@2163))
(assert ($Perm.isReadVar $k@2163 $Perm.Write))
(declare-const $t@2164 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2163 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2163 $Perm.No)))
(assert (> $t@2164 0))
(declare-const $k@2165 $Perm)
(assert ($Perm.isValidVar $k@2165))
(assert ($Perm.isReadVar $k@2165 $Perm.Write))
(declare-const $t@2166 $Ref)
(push) ; 5
(assert (not (not (= $k@2165 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2165 $Perm.No)))
(assert (not (= $t@2166 $Ref.null)))
(declare-const $t@2167 Int)
(declare-const $t@2168 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2168 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2168 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 348] $t@2168 != Null
(assert (not (= $t@2168 $Ref.null)))
(declare-const $t@2169 $Snap)
(declare-const $k@2170 $Perm)
(assert ($Perm.isValidVar $k@2170))
(assert ($Perm.isReadVar $k@2170 $Perm.Write))
(declare-const $t@2171 $Ref)
(declare-const $k@2172 $Perm)
(assert ($Perm.isValidVar $k@2172))
(assert ($Perm.isReadVar $k@2172 $Perm.Write))
(declare-const $t@2173 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 348] $t@2168 == Null
(assert (= $t@2168 $Ref.null))
(declare-const $k@2174 $Perm)
(assert ($Perm.isValidVar $k@2174))
(assert ($Perm.isReadVar $k@2174 $Perm.Write))
(declare-const $t@2175 $Ref)
(declare-const $k@2176 $Perm)
(assert ($Perm.isValidVar $k@2176))
(assert ($Perm.isReadVar $k@2176 $Perm.Write))
(declare-const $t@2177 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; BlockingQueue__put(diz.LBQThread2a__queue, 1)
; [eval] diz != null
(declare-const $k@2178 $Perm)
(assert ($Perm.isValidVar $k@2178))
(assert ($Perm.isReadVar $k@2178 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2178 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2178 $k@2150))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2179 $Perm)
(assert ($Perm.isValidVar $k@2179))
(assert ($Perm.isReadVar $k@2179 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2179 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2179 $k@2152))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2155 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 349] $t@2155 != Null
(declare-const $k@2180 $Perm)
(assert ($Perm.isValidVar $k@2180))
(assert ($Perm.isReadVar $k@2180 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2180 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2157 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2157 $Perm.No)))
(assert (< $k@2180 $k@2157))
(declare-const $k@2181 $Perm)
(assert ($Perm.isValidVar $k@2181))
(assert ($Perm.isReadVar $k@2181 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2181 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2159 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2159 $Perm.No)))
(assert (< $k@2181 $k@2159))
(declare-const $t@2182 $Snap)
(declare-const $t@2183 $Snap)
(declare-const $t@2184 $Ref)
(assert (= $t@2182 ($Snap.combine $t@2183 ($SortWrappers.$RefTo$Snap $t@2184))))
(declare-const $t@2185 $Snap)
(declare-const $t@2186 $Ref)
(assert (= $t@2183 ($Snap.combine $t@2185 ($SortWrappers.$RefTo$Snap $t@2186))))
(declare-const $t@2187 $Snap)
(declare-const $t@2188 $Snap)
(assert (= $t@2185 ($Snap.combine $t@2187 $t@2188)))
(declare-const $t@2189 $Snap)
(declare-const $t@2190 $Ref)
(assert (= $t@2187 ($Snap.combine $t@2189 ($SortWrappers.$RefTo$Snap $t@2190))))
(declare-const $t@2191 $Snap)
(declare-const $t@2192 Int)
(assert (= $t@2189 ($Snap.combine $t@2191 ($SortWrappers.IntTo$Snap $t@2192))))
(declare-const $t@2193 Int)
(declare-const $t@2194 $Ref)
(assert (=
  $t@2191
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2193)
    ($SortWrappers.$RefTo$Snap $t@2194))))
(declare-const $t@2195 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2193)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2195) $Snap.unit)))
(declare-const $k@2196 $Perm)
(assert ($Perm.isValidVar $k@2196))
(assert ($Perm.isReadVar $k@2196 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2150 $k@2178)) (= $t@2195 $t@2151)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2150 $k@2178) $k@2196) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2150 $k@2178) $k@2196) $Perm.No)))
(assert (> $t@2195 0))
(declare-const $k@2197 $Perm)
(assert ($Perm.isValidVar $k@2197))
(assert ($Perm.isReadVar $k@2197 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2152 $k@2179)) (= $t@2194 $t@2153)))
(push) ; 6
(assert (not (not (= (+ (- $k@2152 $k@2179) $k@2197) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2152 $k@2179) $k@2197) $Perm.No)))
(assert (not (= $t@2194 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2190 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2190 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 350] $t@2190 != Null
(assert (not (= $t@2190 $Ref.null)))
(declare-const $k@2198 $Perm)
(assert ($Perm.isValidVar $k@2198))
(assert ($Perm.isReadVar $k@2198 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2157 $k@2180)) (= $t@2186 $t@2158)))
(declare-const $k@2199 $Perm)
(assert ($Perm.isValidVar $k@2199))
(assert ($Perm.isReadVar $k@2199 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2159 $k@2181)) (= $t@2184 $t@2160)))
(declare-const $k@2200 $Perm)
(assert ($Perm.isValidVar $k@2200))
(assert ($Perm.isReadVar $k@2200 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2200 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2200 $k@2148))
(declare-const $k@2201 $Perm)
(assert ($Perm.isValidVar $k@2201))
(assert ($Perm.isReadVar $k@2201 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2201 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2201 (+ (- $k@2150 $k@2178) $k@2196)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@2202 $Perm)
(assert ($Perm.isValidVar $k@2202))
(assert ($Perm.isReadVar $k@2202 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2202 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2202 (+ (- $k@2152 $k@2179) $k@2197)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2190 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 351] $t@2190 != Null
(declare-const $k@2203 $Perm)
(assert ($Perm.isValidVar $k@2203))
(assert ($Perm.isReadVar $k@2203 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2203 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2157 $k@2180) $k@2198) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2157 $k@2180) $k@2198) $Perm.No)))
(assert (< $k@2203 (+ (- $k@2157 $k@2180) $k@2198)))
(declare-const $k@2204 $Perm)
(assert ($Perm.isValidVar $k@2204))
(assert ($Perm.isReadVar $k@2204 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2204 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2159 $k@2181) $k@2199) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2159 $k@2181) $k@2199) $Perm.No)))
(assert (< $k@2204 (+ (- $k@2159 $k@2181) $k@2199)))
(pop) ; 7
; [dead else-branch 351] $t@2190 == Null
(pop) ; 6
(push) ; 6
; [else-branch 350] $t@2190 == Null
(assert (= $t@2190 $Ref.null))
(declare-const $k@2205 $Perm)
(assert ($Perm.isValidVar $k@2205))
(assert ($Perm.isReadVar $k@2205 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2157 $k@2180)) (= $t@2186 $t@2158)))
(declare-const $k@2206 $Perm)
(assert ($Perm.isValidVar $k@2206))
(assert ($Perm.isReadVar $k@2206 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2159 $k@2181)) (= $t@2184 $t@2160)))
(declare-const $k@2207 $Perm)
(assert ($Perm.isValidVar $k@2207))
(assert ($Perm.isReadVar $k@2207 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2207 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2207 $k@2148))
(declare-const $k@2208 $Perm)
(assert ($Perm.isValidVar $k@2208))
(assert ($Perm.isReadVar $k@2208 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2208 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2208 (+ (- $k@2150 $k@2178) $k@2196)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@2209 $Perm)
(assert ($Perm.isValidVar $k@2209))
(assert ($Perm.isReadVar $k@2209 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2209 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2209 (+ (- $k@2152 $k@2179) $k@2197)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2190 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 352] $t@2190 != Null
(push) ; 7
; [else-branch 352] $t@2190 == Null
(declare-const $k@2210 $Perm)
(assert ($Perm.isValidVar $k@2210))
(assert ($Perm.isReadVar $k@2210 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2210 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2157 $k@2180) $k@2205) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2157 $k@2180) $k@2205) $Perm.No)))
(assert (< $k@2210 (+ (- $k@2157 $k@2180) $k@2205)))
(declare-const $k@2211 $Perm)
(assert ($Perm.isValidVar $k@2211))
(assert ($Perm.isReadVar $k@2211 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2211 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2159 $k@2181) $k@2206) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2159 $k@2181) $k@2206) $Perm.No)))
(assert (< $k@2211 (+ (- $k@2159 $k@2181) $k@2206)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 349] $t@2155 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 347] $t@2155 == Null
(assert (= $t@2155 $Ref.null))
(declare-const $k@2212 $Perm)
(assert ($Perm.isValidVar $k@2212))
(assert ($Perm.isReadVar $k@2212 $Perm.Write))
(declare-const $t@2213 $Ref)
(declare-const $k@2214 $Perm)
(assert ($Perm.isValidVar $k@2214))
(assert ($Perm.isReadVar $k@2214 $Perm.Write))
(declare-const $t@2215 $Ref)
(push) ; 4
(declare-const $k@2216 $Perm)
(assert ($Perm.isValidVar $k@2216))
(assert ($Perm.isReadVar $k@2216 $Perm.Write))
(declare-const $t@2217 $Ref)
(push) ; 5
(assert (not (not (= $k@2216 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2216 $Perm.No)))
(assert (not (= $t@2217 $Ref.null)))
(declare-const $k@2218 $Perm)
(assert ($Perm.isValidVar $k@2218))
(assert ($Perm.isReadVar $k@2218 $Perm.Write))
(declare-const $t@2219 Int)
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2218 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2218 $Perm.No)))
(assert (> $t@2219 0))
(declare-const $k@2220 $Perm)
(assert ($Perm.isValidVar $k@2220))
(assert ($Perm.isReadVar $k@2220 $Perm.Write))
(declare-const $t@2221 $Ref)
(push) ; 5
(assert (not (not (= $k@2220 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2220 $Perm.No)))
(assert (not (= $t@2221 $Ref.null)))
(declare-const $t@2222 Int)
(declare-const $t@2223 $Ref)
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2223 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2223 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 353] $t@2223 != Null
(assert (not (= $t@2223 $Ref.null)))
(declare-const $t@2224 $Snap)
(declare-const $k@2225 $Perm)
(assert ($Perm.isValidVar $k@2225))
(assert ($Perm.isReadVar $k@2225 $Perm.Write))
(declare-const $t@2226 $Ref)
(declare-const $k@2227 $Perm)
(assert ($Perm.isValidVar $k@2227))
(assert ($Perm.isReadVar $k@2227 $Perm.Write))
(declare-const $t@2228 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 353] $t@2223 == Null
(assert (= $t@2223 $Ref.null))
(declare-const $k@2229 $Perm)
(assert ($Perm.isValidVar $k@2229))
(assert ($Perm.isReadVar $k@2229 $Perm.Write))
(declare-const $t@2230 $Ref)
(declare-const $k@2231 $Perm)
(assert ($Perm.isValidVar $k@2231))
(assert ($Perm.isReadVar $k@2231 $Perm.Write))
(declare-const $t@2232 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; BlockingQueue__put(diz.LBQThread2a__queue, 1)
; [eval] diz != null
(declare-const $k@2233 $Perm)
(assert ($Perm.isValidVar $k@2233))
(assert ($Perm.isReadVar $k@2233 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2233 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2233 $k@2150))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2234 $Perm)
(assert ($Perm.isValidVar $k@2234))
(assert ($Perm.isReadVar $k@2234 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2234 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2234 $k@2152))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2155 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 354] $t@2155 != Null
(push) ; 5
; [else-branch 354] $t@2155 == Null
(declare-const $k@2235 $Perm)
(assert ($Perm.isValidVar $k@2235))
(assert ($Perm.isReadVar $k@2235 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2235 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2212 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2212 $Perm.No)))
(assert (< $k@2235 $k@2212))
(declare-const $k@2236 $Perm)
(assert ($Perm.isValidVar $k@2236))
(assert ($Perm.isReadVar $k@2236 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2236 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2214 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2214 $Perm.No)))
(assert (< $k@2236 $k@2214))
(declare-const $t@2237 $Snap)
(declare-const $t@2238 $Snap)
(declare-const $t@2239 $Ref)
(assert (= $t@2237 ($Snap.combine $t@2238 ($SortWrappers.$RefTo$Snap $t@2239))))
(declare-const $t@2240 $Snap)
(declare-const $t@2241 $Ref)
(assert (= $t@2238 ($Snap.combine $t@2240 ($SortWrappers.$RefTo$Snap $t@2241))))
(declare-const $t@2242 $Snap)
(declare-const $t@2243 $Snap)
(assert (= $t@2240 ($Snap.combine $t@2242 $t@2243)))
(declare-const $t@2244 $Snap)
(declare-const $t@2245 $Ref)
(assert (= $t@2242 ($Snap.combine $t@2244 ($SortWrappers.$RefTo$Snap $t@2245))))
(declare-const $t@2246 $Snap)
(declare-const $t@2247 Int)
(assert (= $t@2244 ($Snap.combine $t@2246 ($SortWrappers.IntTo$Snap $t@2247))))
(declare-const $t@2248 Int)
(declare-const $t@2249 $Ref)
(assert (=
  $t@2246
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2248)
    ($SortWrappers.$RefTo$Snap $t@2249))))
(declare-const $t@2250 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2248)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2250) $Snap.unit)))
(declare-const $k@2251 $Perm)
(assert ($Perm.isValidVar $k@2251))
(assert ($Perm.isReadVar $k@2251 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2150 $k@2233)) (= $t@2250 $t@2151)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2150 $k@2233) $k@2251) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2150 $k@2233) $k@2251) $Perm.No)))
(assert (> $t@2250 0))
(declare-const $k@2252 $Perm)
(assert ($Perm.isValidVar $k@2252))
(assert ($Perm.isReadVar $k@2252 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2152 $k@2234)) (= $t@2249 $t@2153)))
(push) ; 6
(assert (not (not (= (+ (- $k@2152 $k@2234) $k@2252) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2152 $k@2234) $k@2252) $Perm.No)))
(assert (not (= $t@2249 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2245 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2245 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 355] $t@2245 != Null
(assert (not (= $t@2245 $Ref.null)))
(declare-const $k@2253 $Perm)
(assert ($Perm.isValidVar $k@2253))
(assert ($Perm.isReadVar $k@2253 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2212 $k@2235)) (= $t@2241 $t@2213)))
(declare-const $k@2254 $Perm)
(assert ($Perm.isValidVar $k@2254))
(assert ($Perm.isReadVar $k@2254 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2214 $k@2236)) (= $t@2239 $t@2215)))
(declare-const $k@2255 $Perm)
(assert ($Perm.isValidVar $k@2255))
(assert ($Perm.isReadVar $k@2255 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2255 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2255 $k@2148))
(declare-const $k@2256 $Perm)
(assert ($Perm.isValidVar $k@2256))
(assert ($Perm.isReadVar $k@2256 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2256 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2256 (+ (- $k@2150 $k@2233) $k@2251)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@2257 $Perm)
(assert ($Perm.isValidVar $k@2257))
(assert ($Perm.isReadVar $k@2257 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2257 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2257 (+ (- $k@2152 $k@2234) $k@2252)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2245 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 356] $t@2245 != Null
(declare-const $k@2258 $Perm)
(assert ($Perm.isValidVar $k@2258))
(assert ($Perm.isReadVar $k@2258 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2258 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2212 $k@2235) $k@2253) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2212 $k@2235) $k@2253) $Perm.No)))
(assert (< $k@2258 (+ (- $k@2212 $k@2235) $k@2253)))
(declare-const $k@2259 $Perm)
(assert ($Perm.isValidVar $k@2259))
(assert ($Perm.isReadVar $k@2259 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2259 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2214 $k@2236) $k@2254) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2214 $k@2236) $k@2254) $Perm.No)))
(assert (< $k@2259 (+ (- $k@2214 $k@2236) $k@2254)))
(pop) ; 7
; [dead else-branch 356] $t@2245 == Null
(pop) ; 6
(push) ; 6
; [else-branch 355] $t@2245 == Null
(assert (= $t@2245 $Ref.null))
(declare-const $k@2260 $Perm)
(assert ($Perm.isValidVar $k@2260))
(assert ($Perm.isReadVar $k@2260 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2212 $k@2235)) (= $t@2241 $t@2213)))
(declare-const $k@2261 $Perm)
(assert ($Perm.isValidVar $k@2261))
(assert ($Perm.isReadVar $k@2261 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2214 $k@2236)) (= $t@2239 $t@2215)))
(declare-const $k@2262 $Perm)
(assert ($Perm.isValidVar $k@2262))
(assert ($Perm.isReadVar $k@2262 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2262 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2262 $k@2148))
(declare-const $k@2263 $Perm)
(assert ($Perm.isValidVar $k@2263))
(assert ($Perm.isReadVar $k@2263 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2263 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2263 (+ (- $k@2150 $k@2233) $k@2251)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__capacity > 0
(declare-const $k@2264 $Perm)
(assert ($Perm.isValidVar $k@2264))
(assert ($Perm.isReadVar $k@2264 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2264 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2264 (+ (- $k@2152 $k@2234) $k@2252)))
; [eval] diz.LBQThread2a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2245 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 357] $t@2245 != Null
(push) ; 7
; [else-branch 357] $t@2245 == Null
(declare-const $k@2265 $Perm)
(assert ($Perm.isValidVar $k@2265))
(assert ($Perm.isReadVar $k@2265 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2265 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2212 $k@2235) $k@2260) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2212 $k@2235) $k@2260) $Perm.No)))
(assert (< $k@2265 (+ (- $k@2212 $k@2235) $k@2260)))
(declare-const $k@2266 $Perm)
(assert ($Perm.isValidVar $k@2266))
(assert ($Perm.isReadVar $k@2266 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2266 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2214 $k@2236) $k@2261) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2214 $k@2236) $k@2261) $Perm.No)))
(assert (< $k@2266 (+ (- $k@2214 $k@2236) $k@2261)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2b__LBQThread1a ----------
(declare-const queue@2267 $Ref)
(declare-const sys__result@2268 $Ref)
(declare-const diz@2269 $Ref)
(declare-const __flatten_65@2270 $Ref)
(declare-const __flatten_125@2271 $Ref)
(push) ; 2
(assert (not (= queue@2267 $Ref.null)))
(declare-const $k@2272 $Perm)
(assert ($Perm.isValidVar $k@2272))
(assert ($Perm.isReadVar $k@2272 $Perm.Write))
(declare-const $t@2273 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2272 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2272 $Perm.No)))
(assert (> $t@2273 0))
(declare-const $k@2274 $Perm)
(assert ($Perm.isValidVar $k@2274))
(assert ($Perm.isReadVar $k@2274 $Perm.Write))
(declare-const $t@2275 $Ref)
(push) ; 3
(assert (not (not (= $k@2274 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2274 $Perm.No)))
(assert (not (= $t@2275 $Ref.null)))
(declare-const $t@2276 Int)
(declare-const $t@2277 $Ref)
; [eval] queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2277 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2277 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 358] $t@2277 != Null
(assert (not (= $t@2277 $Ref.null)))
(declare-const $t@2278 $Snap)
(declare-const $k@2279 $Perm)
(assert ($Perm.isValidVar $k@2279))
(assert ($Perm.isReadVar $k@2279 $Perm.Write))
(declare-const $t@2280 $Ref)
(declare-const $k@2281 $Perm)
(assert ($Perm.isValidVar $k@2281))
(assert ($Perm.isReadVar $k@2281 $Perm.Write))
(declare-const $t@2282 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2268 $Ref.null)))
(declare-const $k@2283 $Perm)
(assert ($Perm.isValidVar $k@2283))
(assert ($Perm.isReadVar $k@2283 $Perm.Write))
(declare-const $t@2284 $Ref)
(push) ; 5
(assert (not (not (= $k@2283 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2283 $Perm.No)))
(assert (not (= $t@2284 $Ref.null)))
(declare-const $k@2285 $Perm)
(assert ($Perm.isValidVar $k@2285))
(assert ($Perm.isReadVar $k@2285 $Perm.Write))
(declare-const $t@2286 Int)
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2285 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2285 $Perm.No)))
(assert (> $t@2286 0))
(declare-const $k@2287 $Perm)
(assert ($Perm.isValidVar $k@2287))
(assert ($Perm.isReadVar $k@2287 $Perm.Write))
(declare-const $t@2288 $Ref)
(push) ; 5
(assert (not (not (= $k@2287 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2287 $Perm.No)))
(assert (not (= $t@2288 $Ref.null)))
(declare-const $t@2289 Int)
(declare-const $t@2290 $Ref)
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2290 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2290 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 359] $t@2290 != Null
(assert (not (= $t@2290 $Ref.null)))
(declare-const $t@2291 $Snap)
(declare-const $k@2292 $Perm)
(assert ($Perm.isValidVar $k@2292))
(assert ($Perm.isReadVar $k@2292 $Perm.Write))
(declare-const $t@2293 $Ref)
(declare-const $k@2294 $Perm)
(assert ($Perm.isValidVar $k@2294))
(assert ($Perm.isReadVar $k@2294 $Perm.Write))
(declare-const $t@2295 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 359] $t@2290 == Null
(assert (= $t@2290 $Ref.null))
(declare-const $k@2296 $Perm)
(assert ($Perm.isValidVar $k@2296))
(assert ($Perm.isReadVar $k@2296 $Perm.Write))
(declare-const $t@2297 $Ref)
(declare-const $k@2298 $Perm)
(assert ($Perm.isValidVar $k@2298))
(assert ($Perm.isReadVar $k@2298 $Perm.Write))
(declare-const $t@2299 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread2b__queue)
(declare-const diz@2300 $Ref)
(assert (not (= diz@2300 $Ref.null)))
(declare-const LBQThread2b__queue@2301 $Ref)
(assert (and
  (not (= queue@2267 diz@2300))
  (not (= sys__result@2268 diz@2300))
  (not (= __flatten_65@2270 diz@2300))
  (not (= __flatten_125@2271 diz@2300))
  (not (= $t@2275 diz@2300))
  (not (= $t@2277 diz@2300))
  (not (= LBQThread2b__queue@2301 diz@2300))
  (not (= $t@2280 diz@2300))
  (not (= $t@2282 diz@2300))))
; [exec]
; __flatten_65 := queue
; [exec]
; __flatten_125 := __flatten_65
; [exec]
; diz.LBQThread2b__queue := __flatten_125
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread2b__queue, wildcard) && acc(sys__result.LBQThread2b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread2b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread2b__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread2b__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread2b__queue.BlockingQueue__first, write) && ((sys__result.LBQThread2b__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread2b__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread2b__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread2b__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2302 $Perm)
(assert ($Perm.isValidVar $k@2302))
(assert ($Perm.isReadVar $k@2302 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2302 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2302 $Perm.Write))
(declare-const $k@2303 $Perm)
(assert ($Perm.isValidVar $k@2303))
(assert ($Perm.isReadVar $k@2303 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2303 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2303 $k@2272))
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2304 $Perm)
(assert ($Perm.isValidVar $k@2304))
(assert ($Perm.isReadVar $k@2304 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2304 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2304 $k@2274))
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2277 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 360] $t@2277 != Null
(declare-const $k@2305 $Perm)
(assert ($Perm.isValidVar $k@2305))
(assert ($Perm.isReadVar $k@2305 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2305 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2279 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2279 $Perm.No)))
(assert (< $k@2305 $k@2279))
(declare-const $k@2306 $Perm)
(assert ($Perm.isValidVar $k@2306))
(assert ($Perm.isReadVar $k@2306 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2306 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2281 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2281 $Perm.No)))
(assert (< $k@2306 $k@2281))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 360] $t@2277 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 358] $t@2277 == Null
(assert (= $t@2277 $Ref.null))
(declare-const $k@2307 $Perm)
(assert ($Perm.isValidVar $k@2307))
(assert ($Perm.isReadVar $k@2307 $Perm.Write))
(declare-const $t@2308 $Ref)
(declare-const $k@2309 $Perm)
(assert ($Perm.isValidVar $k@2309))
(assert ($Perm.isReadVar $k@2309 $Perm.Write))
(declare-const $t@2310 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2268 $Ref.null)))
(declare-const $k@2311 $Perm)
(assert ($Perm.isValidVar $k@2311))
(assert ($Perm.isReadVar $k@2311 $Perm.Write))
(declare-const $t@2312 $Ref)
(push) ; 5
(assert (not (not (= $k@2311 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2311 $Perm.No)))
(assert (not (= $t@2312 $Ref.null)))
(declare-const $k@2313 $Perm)
(assert ($Perm.isValidVar $k@2313))
(assert ($Perm.isReadVar $k@2313 $Perm.Write))
(declare-const $t@2314 Int)
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2313 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2313 $Perm.No)))
(assert (> $t@2314 0))
(declare-const $k@2315 $Perm)
(assert ($Perm.isValidVar $k@2315))
(assert ($Perm.isReadVar $k@2315 $Perm.Write))
(declare-const $t@2316 $Ref)
(push) ; 5
(assert (not (not (= $k@2315 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2315 $Perm.No)))
(assert (not (= $t@2316 $Ref.null)))
(declare-const $t@2317 Int)
(declare-const $t@2318 $Ref)
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2318 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2318 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 361] $t@2318 != Null
(assert (not (= $t@2318 $Ref.null)))
(declare-const $t@2319 $Snap)
(declare-const $k@2320 $Perm)
(assert ($Perm.isValidVar $k@2320))
(assert ($Perm.isReadVar $k@2320 $Perm.Write))
(declare-const $t@2321 $Ref)
(declare-const $k@2322 $Perm)
(assert ($Perm.isValidVar $k@2322))
(assert ($Perm.isReadVar $k@2322 $Perm.Write))
(declare-const $t@2323 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 361] $t@2318 == Null
(assert (= $t@2318 $Ref.null))
(declare-const $k@2324 $Perm)
(assert ($Perm.isValidVar $k@2324))
(assert ($Perm.isReadVar $k@2324 $Perm.Write))
(declare-const $t@2325 $Ref)
(declare-const $k@2326 $Perm)
(assert ($Perm.isValidVar $k@2326))
(assert ($Perm.isReadVar $k@2326 $Perm.Write))
(declare-const $t@2327 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread2b__queue)
(declare-const diz@2328 $Ref)
(assert (not (= diz@2328 $Ref.null)))
(declare-const LBQThread2b__queue@2329 $Ref)
(assert (and
  (not (= queue@2267 diz@2328))
  (not (= sys__result@2268 diz@2328))
  (not (= __flatten_65@2270 diz@2328))
  (not (= __flatten_125@2271 diz@2328))
  (not (= $t@2275 diz@2328))
  (not (= LBQThread2b__queue@2329 diz@2328))
  (not (= $t@2277 diz@2328))
  (not (= $t@2308 diz@2328))
  (not (= $t@2310 diz@2328))))
; [exec]
; __flatten_65 := queue
; [exec]
; __flatten_125 := __flatten_65
; [exec]
; diz.LBQThread2b__queue := __flatten_125
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread2b__queue, wildcard) && acc(sys__result.LBQThread2b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread2b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread2b__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread2b__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread2b__queue.BlockingQueue__first, write) && ((sys__result.LBQThread2b__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread2b__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread2b__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread2b__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2330 $Perm)
(assert ($Perm.isValidVar $k@2330))
(assert ($Perm.isReadVar $k@2330 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2330 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2330 $Perm.Write))
(declare-const $k@2331 $Perm)
(assert ($Perm.isValidVar $k@2331))
(assert ($Perm.isReadVar $k@2331 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2331 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2331 $k@2272))
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2332 $Perm)
(assert ($Perm.isValidVar $k@2332))
(assert ($Perm.isReadVar $k@2332 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2332 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2332 $k@2274))
; [eval] sys__result.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2277 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 362] $t@2277 != Null
(push) ; 5
; [else-branch 362] $t@2277 == Null
(declare-const $k@2333 $Perm)
(assert ($Perm.isValidVar $k@2333))
(assert ($Perm.isReadVar $k@2333 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2333 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2307 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2307 $Perm.No)))
(assert (< $k@2333 $k@2307))
(declare-const $k@2334 $Perm)
(assert ($Perm.isValidVar $k@2334))
(assert ($Perm.isReadVar $k@2334 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2334 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2309 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2309 $Perm.No)))
(assert (< $k@2334 $k@2309))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread2b__run ----------
(declare-const diz@2335 $Ref)
(declare-const i@2336 $Ref)
(declare-const __flatten_67@2337 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2335 $Ref.null)))
(declare-const $k@2338 $Perm)
(assert ($Perm.isValidVar $k@2338))
(assert ($Perm.isReadVar $k@2338 $Perm.Write))
(declare-const $t@2339 $Ref)
(push) ; 3
(assert (not (not (= $k@2338 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2338 $Perm.No)))
(assert (not (= $t@2339 $Ref.null)))
(declare-const $k@2340 $Perm)
(assert ($Perm.isValidVar $k@2340))
(assert ($Perm.isReadVar $k@2340 $Perm.Write))
(declare-const $t@2341 Int)
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2340 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2340 $Perm.No)))
(assert (> $t@2341 0))
(declare-const $k@2342 $Perm)
(assert ($Perm.isValidVar $k@2342))
(assert ($Perm.isReadVar $k@2342 $Perm.Write))
(declare-const $t@2343 $Ref)
(push) ; 3
(assert (not (not (= $k@2342 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2342 $Perm.No)))
(assert (not (= $t@2343 $Ref.null)))
(declare-const $t@2344 Int)
(declare-const $t@2345 $Ref)
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2345 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2345 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 363] $t@2345 != Null
(assert (not (= $t@2345 $Ref.null)))
(declare-const $t@2346 $Snap)
(declare-const $k@2347 $Perm)
(assert ($Perm.isValidVar $k@2347))
(assert ($Perm.isReadVar $k@2347 $Perm.Write))
(declare-const $t@2348 $Ref)
(declare-const $k@2349 $Perm)
(assert ($Perm.isValidVar $k@2349))
(assert ($Perm.isReadVar $k@2349 $Perm.Write))
(declare-const $t@2350 $Ref)
(push) ; 4
(declare-const $k@2351 $Perm)
(assert ($Perm.isValidVar $k@2351))
(assert ($Perm.isReadVar $k@2351 $Perm.Write))
(declare-const $t@2352 $Ref)
(push) ; 5
(assert (not (not (= $k@2351 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2351 $Perm.No)))
(assert (not (= $t@2352 $Ref.null)))
(declare-const $k@2353 $Perm)
(assert ($Perm.isValidVar $k@2353))
(assert ($Perm.isReadVar $k@2353 $Perm.Write))
(declare-const $t@2354 Int)
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2353 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2353 $Perm.No)))
(assert (> $t@2354 0))
(declare-const $k@2355 $Perm)
(assert ($Perm.isValidVar $k@2355))
(assert ($Perm.isReadVar $k@2355 $Perm.Write))
(declare-const $t@2356 $Ref)
(push) ; 5
(assert (not (not (= $k@2355 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2355 $Perm.No)))
(assert (not (= $t@2356 $Ref.null)))
(declare-const $t@2357 Int)
(declare-const $t@2358 $Ref)
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2358 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2358 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 364] $t@2358 != Null
(assert (not (= $t@2358 $Ref.null)))
(declare-const $t@2359 $Snap)
(declare-const $k@2360 $Perm)
(assert ($Perm.isValidVar $k@2360))
(assert ($Perm.isReadVar $k@2360 $Perm.Write))
(declare-const $t@2361 $Ref)
(declare-const $k@2362 $Perm)
(assert ($Perm.isValidVar $k@2362))
(assert ($Perm.isReadVar $k@2362 $Perm.Write))
(declare-const $t@2363 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 364] $t@2358 == Null
(assert (= $t@2358 $Ref.null))
(declare-const $k@2364 $Perm)
(assert ($Perm.isValidVar $k@2364))
(assert ($Perm.isReadVar $k@2364 $Perm.Write))
(declare-const $t@2365 $Ref)
(declare-const $k@2366 $Perm)
(assert ($Perm.isValidVar $k@2366))
(assert ($Perm.isReadVar $k@2366 $Perm.Write))
(declare-const $t@2367 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; BlockingQueue__put(diz.LBQThread2b__queue, 2)
; [eval] diz != null
(declare-const $k@2368 $Perm)
(assert ($Perm.isValidVar $k@2368))
(assert ($Perm.isReadVar $k@2368 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2368 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2368 $k@2340))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2369 $Perm)
(assert ($Perm.isValidVar $k@2369))
(assert ($Perm.isReadVar $k@2369 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2369 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2369 $k@2342))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2345 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 365] $t@2345 != Null
(declare-const $k@2370 $Perm)
(assert ($Perm.isValidVar $k@2370))
(assert ($Perm.isReadVar $k@2370 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2370 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2347 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2347 $Perm.No)))
(assert (< $k@2370 $k@2347))
(declare-const $k@2371 $Perm)
(assert ($Perm.isValidVar $k@2371))
(assert ($Perm.isReadVar $k@2371 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2371 $Perm.No) true)))
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
(assert (< $k@2371 $k@2349))
(declare-const $t@2372 $Snap)
(declare-const $t@2373 $Snap)
(declare-const $t@2374 $Ref)
(assert (= $t@2372 ($Snap.combine $t@2373 ($SortWrappers.$RefTo$Snap $t@2374))))
(declare-const $t@2375 $Snap)
(declare-const $t@2376 $Ref)
(assert (= $t@2373 ($Snap.combine $t@2375 ($SortWrappers.$RefTo$Snap $t@2376))))
(declare-const $t@2377 $Snap)
(declare-const $t@2378 $Snap)
(assert (= $t@2375 ($Snap.combine $t@2377 $t@2378)))
(declare-const $t@2379 $Snap)
(declare-const $t@2380 $Ref)
(assert (= $t@2377 ($Snap.combine $t@2379 ($SortWrappers.$RefTo$Snap $t@2380))))
(declare-const $t@2381 $Snap)
(declare-const $t@2382 Int)
(assert (= $t@2379 ($Snap.combine $t@2381 ($SortWrappers.IntTo$Snap $t@2382))))
(declare-const $t@2383 Int)
(declare-const $t@2384 $Ref)
(assert (=
  $t@2381
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2383)
    ($SortWrappers.$RefTo$Snap $t@2384))))
(declare-const $t@2385 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2383)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2385) $Snap.unit)))
(declare-const $k@2386 $Perm)
(assert ($Perm.isValidVar $k@2386))
(assert ($Perm.isReadVar $k@2386 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2340 $k@2368)) (= $t@2385 $t@2341)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2340 $k@2368) $k@2386) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2340 $k@2368) $k@2386) $Perm.No)))
(assert (> $t@2385 0))
(declare-const $k@2387 $Perm)
(assert ($Perm.isValidVar $k@2387))
(assert ($Perm.isReadVar $k@2387 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2342 $k@2369)) (= $t@2384 $t@2343)))
(push) ; 6
(assert (not (not (= (+ (- $k@2342 $k@2369) $k@2387) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2342 $k@2369) $k@2387) $Perm.No)))
(assert (not (= $t@2384 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2380 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2380 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 366] $t@2380 != Null
(assert (not (= $t@2380 $Ref.null)))
(declare-const $k@2388 $Perm)
(assert ($Perm.isValidVar $k@2388))
(assert ($Perm.isReadVar $k@2388 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2347 $k@2370)) (= $t@2376 $t@2348)))
(declare-const $k@2389 $Perm)
(assert ($Perm.isValidVar $k@2389))
(assert ($Perm.isReadVar $k@2389 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2349 $k@2371)) (= $t@2374 $t@2350)))
; [exec]
; __flatten_67 := BlockingQueue__poll(diz.LBQThread2b__queue)
; [eval] diz != null
(declare-const $k@2390 $Perm)
(assert ($Perm.isValidVar $k@2390))
(assert ($Perm.isReadVar $k@2390 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2390 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2390 (+ (- $k@2340 $k@2368) $k@2386)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2391 $Perm)
(assert ($Perm.isValidVar $k@2391))
(assert ($Perm.isReadVar $k@2391 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2391 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2391 (+ (- $k@2342 $k@2369) $k@2387)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2380 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 367] $t@2380 != Null
(declare-const $k@2392 $Perm)
(assert ($Perm.isValidVar $k@2392))
(assert ($Perm.isReadVar $k@2392 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2392 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2347 $k@2370) $k@2388) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2347 $k@2370) $k@2388) $Perm.No)))
(assert (< $k@2392 (+ (- $k@2347 $k@2370) $k@2388)))
(declare-const $k@2393 $Perm)
(assert ($Perm.isValidVar $k@2393))
(assert ($Perm.isReadVar $k@2393 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2393 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2349 $k@2371) $k@2389) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2349 $k@2371) $k@2389) $Perm.No)))
(assert (< $k@2393 (+ (- $k@2349 $k@2371) $k@2389)))
(declare-const sys__result@2394 $Ref)
(declare-const $t@2395 $Snap)
(declare-const $t@2396 $Snap)
(declare-const $t@2397 $Ref)
(assert (= $t@2395 ($Snap.combine $t@2396 ($SortWrappers.$RefTo$Snap $t@2397))))
(declare-const $t@2398 $Snap)
(declare-const $t@2399 $Ref)
(assert (= $t@2396 ($Snap.combine $t@2398 ($SortWrappers.$RefTo$Snap $t@2399))))
(declare-const $t@2400 $Snap)
(declare-const $t@2401 $Snap)
(assert (= $t@2398 ($Snap.combine $t@2400 $t@2401)))
(declare-const $t@2402 $Snap)
(declare-const $t@2403 $Ref)
(assert (= $t@2400 ($Snap.combine $t@2402 ($SortWrappers.$RefTo$Snap $t@2403))))
(declare-const $t@2404 $Snap)
(declare-const $t@2405 Int)
(assert (= $t@2402 ($Snap.combine $t@2404 ($SortWrappers.IntTo$Snap $t@2405))))
(declare-const $t@2406 Int)
(declare-const $t@2407 $Ref)
(assert (=
  $t@2404
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2406)
    ($SortWrappers.$RefTo$Snap $t@2407))))
(declare-const $t@2408 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2406)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2408) $Snap.unit)))
(declare-const $k@2409 $Perm)
(assert ($Perm.isValidVar $k@2409))
(assert ($Perm.isReadVar $k@2409 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2340 $k@2368) $k@2386) $k@2390))
  (= $t@2408 $t@2385)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2390) $k@2409) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2390) $k@2409) $Perm.No)))
(assert (> $t@2408 0))
(declare-const $k@2410 $Perm)
(assert ($Perm.isValidVar $k@2410))
(assert ($Perm.isReadVar $k@2410 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2342 $k@2369) $k@2387) $k@2391))
  (= $t@2407 $t@2384)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2391) $k@2410) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2391) $k@2410) $Perm.No)))
(assert (not (= $t@2407 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@2403 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@2403 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 368] $t@2403 != Null
(assert (not (= $t@2403 $Ref.null)))
(declare-const $k@2411 $Perm)
(assert ($Perm.isValidVar $k@2411))
(assert ($Perm.isReadVar $k@2411 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392))
  (= $t@2399 $t@2376)))
(declare-const $k@2412 $Perm)
(assert ($Perm.isValidVar $k@2412))
(assert ($Perm.isReadVar $k@2412 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393))
  (= $t@2397 $t@2374)))
; [exec]
; i := __flatten_67
(declare-const $k@2413 $Perm)
(assert ($Perm.isValidVar $k@2413))
(assert ($Perm.isReadVar $k@2413 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2413 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2413 $k@2338))
(declare-const $k@2414 $Perm)
(assert ($Perm.isValidVar $k@2414))
(assert ($Perm.isReadVar $k@2414 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2414 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2414 (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2390) $k@2409)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2415 $Perm)
(assert ($Perm.isValidVar $k@2415))
(assert ($Perm.isReadVar $k@2415 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2415 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2415 (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2391) $k@2410)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@2403 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 369] $t@2403 != Null
(declare-const $k@2416 $Perm)
(assert ($Perm.isValidVar $k@2416))
(assert ($Perm.isReadVar $k@2416 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2416 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392) $k@2411) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392) $k@2411) $Perm.No)))
(assert (< $k@2416 (+ (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392) $k@2411)))
(declare-const $k@2417 $Perm)
(assert ($Perm.isValidVar $k@2417))
(assert ($Perm.isReadVar $k@2417 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2417 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393) $k@2412) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393) $k@2412) $Perm.No)))
(assert (< $k@2417 (+ (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393) $k@2412)))
(pop) ; 9
; [dead else-branch 369] $t@2403 == Null
(pop) ; 8
(push) ; 8
; [else-branch 368] $t@2403 == Null
(assert (= $t@2403 $Ref.null))
(declare-const $k@2418 $Perm)
(assert ($Perm.isValidVar $k@2418))
(assert ($Perm.isReadVar $k@2418 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392))
  (= $t@2399 $t@2376)))
(declare-const $k@2419 $Perm)
(assert ($Perm.isValidVar $k@2419))
(assert ($Perm.isReadVar $k@2419 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393))
  (= $t@2397 $t@2374)))
; [exec]
; i := __flatten_67
(declare-const $k@2420 $Perm)
(assert ($Perm.isValidVar $k@2420))
(assert ($Perm.isReadVar $k@2420 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2420 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2420 $k@2338))
(declare-const $k@2421 $Perm)
(assert ($Perm.isValidVar $k@2421))
(assert ($Perm.isReadVar $k@2421 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2421 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2421 (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2390) $k@2409)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2422 $Perm)
(assert ($Perm.isValidVar $k@2422))
(assert ($Perm.isReadVar $k@2422 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2422 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2422 (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2391) $k@2410)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@2403 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 370] $t@2403 != Null
(push) ; 9
; [else-branch 370] $t@2403 == Null
(declare-const $k@2423 $Perm)
(assert ($Perm.isValidVar $k@2423))
(assert ($Perm.isReadVar $k@2423 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2423 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392) $k@2418) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392) $k@2418) $Perm.No)))
(assert (< $k@2423 (+ (- (+ (- $k@2347 $k@2370) $k@2388) $k@2392) $k@2418)))
(declare-const $k@2424 $Perm)
(assert ($Perm.isValidVar $k@2424))
(assert ($Perm.isReadVar $k@2424 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2424 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393) $k@2419) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393) $k@2419) $Perm.No)))
(assert (< $k@2424 (+ (- (+ (- $k@2349 $k@2371) $k@2389) $k@2393) $k@2419)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 367] $t@2380 == Null
(pop) ; 6
(push) ; 6
; [else-branch 366] $t@2380 == Null
(assert (= $t@2380 $Ref.null))
(declare-const $k@2425 $Perm)
(assert ($Perm.isValidVar $k@2425))
(assert ($Perm.isReadVar $k@2425 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2347 $k@2370)) (= $t@2376 $t@2348)))
(declare-const $k@2426 $Perm)
(assert ($Perm.isValidVar $k@2426))
(assert ($Perm.isReadVar $k@2426 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2349 $k@2371)) (= $t@2374 $t@2350)))
; [exec]
; __flatten_67 := BlockingQueue__poll(diz.LBQThread2b__queue)
; [eval] diz != null
(declare-const $k@2427 $Perm)
(assert ($Perm.isValidVar $k@2427))
(assert ($Perm.isReadVar $k@2427 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2427 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2427 (+ (- $k@2340 $k@2368) $k@2386)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2428 $Perm)
(assert ($Perm.isValidVar $k@2428))
(assert ($Perm.isReadVar $k@2428 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2428 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2428 (+ (- $k@2342 $k@2369) $k@2387)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2380 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 371] $t@2380 != Null
(push) ; 7
; [else-branch 371] $t@2380 == Null
(declare-const $k@2429 $Perm)
(assert ($Perm.isValidVar $k@2429))
(assert ($Perm.isReadVar $k@2429 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2429 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2347 $k@2370) $k@2425) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2347 $k@2370) $k@2425) $Perm.No)))
(assert (< $k@2429 (+ (- $k@2347 $k@2370) $k@2425)))
(declare-const $k@2430 $Perm)
(assert ($Perm.isValidVar $k@2430))
(assert ($Perm.isReadVar $k@2430 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2430 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2349 $k@2371) $k@2426) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2349 $k@2371) $k@2426) $Perm.No)))
(assert (< $k@2430 (+ (- $k@2349 $k@2371) $k@2426)))
(declare-const sys__result@2431 $Ref)
(declare-const $t@2432 $Snap)
(declare-const $t@2433 $Snap)
(declare-const $t@2434 $Ref)
(assert (= $t@2432 ($Snap.combine $t@2433 ($SortWrappers.$RefTo$Snap $t@2434))))
(declare-const $t@2435 $Snap)
(declare-const $t@2436 $Ref)
(assert (= $t@2433 ($Snap.combine $t@2435 ($SortWrappers.$RefTo$Snap $t@2436))))
(declare-const $t@2437 $Snap)
(declare-const $t@2438 $Snap)
(assert (= $t@2435 ($Snap.combine $t@2437 $t@2438)))
(declare-const $t@2439 $Snap)
(declare-const $t@2440 $Ref)
(assert (= $t@2437 ($Snap.combine $t@2439 ($SortWrappers.$RefTo$Snap $t@2440))))
(declare-const $t@2441 $Snap)
(declare-const $t@2442 Int)
(assert (= $t@2439 ($Snap.combine $t@2441 ($SortWrappers.IntTo$Snap $t@2442))))
(declare-const $t@2443 Int)
(declare-const $t@2444 $Ref)
(assert (=
  $t@2441
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2443)
    ($SortWrappers.$RefTo$Snap $t@2444))))
(declare-const $t@2445 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2443)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2445) $Snap.unit)))
(declare-const $k@2446 $Perm)
(assert ($Perm.isValidVar $k@2446))
(assert ($Perm.isReadVar $k@2446 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2340 $k@2368) $k@2386) $k@2427))
  (= $t@2445 $t@2385)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2427) $k@2446) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2427) $k@2446) $Perm.No)))
(assert (> $t@2445 0))
(declare-const $k@2447 $Perm)
(assert ($Perm.isValidVar $k@2447))
(assert ($Perm.isReadVar $k@2447 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2342 $k@2369) $k@2387) $k@2428))
  (= $t@2444 $t@2384)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2428) $k@2447) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2428) $k@2447) $Perm.No)))
(assert (not (= $t@2444 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@2440 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@2440 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 372] $t@2440 != Null
(assert (not (= $t@2440 $Ref.null)))
(declare-const $k@2448 $Perm)
(assert ($Perm.isValidVar $k@2448))
(assert ($Perm.isReadVar $k@2448 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429))
  (= $t@2436 $t@2376)))
(declare-const $k@2449 $Perm)
(assert ($Perm.isValidVar $k@2449))
(assert ($Perm.isReadVar $k@2449 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430))
  (= $t@2434 $t@2374)))
; [exec]
; i := __flatten_67
(declare-const $k@2450 $Perm)
(assert ($Perm.isValidVar $k@2450))
(assert ($Perm.isReadVar $k@2450 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2450 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2450 $k@2338))
(declare-const $k@2451 $Perm)
(assert ($Perm.isValidVar $k@2451))
(assert ($Perm.isReadVar $k@2451 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2451 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2451 (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2427) $k@2446)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2452 $Perm)
(assert ($Perm.isValidVar $k@2452))
(assert ($Perm.isReadVar $k@2452 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2452 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2452 (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2428) $k@2447)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@2440 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 373] $t@2440 != Null
(declare-const $k@2453 $Perm)
(assert ($Perm.isValidVar $k@2453))
(assert ($Perm.isReadVar $k@2453 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2453 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429) $k@2448) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429) $k@2448) $Perm.No)))
(assert (< $k@2453 (+ (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429) $k@2448)))
(declare-const $k@2454 $Perm)
(assert ($Perm.isValidVar $k@2454))
(assert ($Perm.isReadVar $k@2454 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2454 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430) $k@2449) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430) $k@2449) $Perm.No)))
(assert (< $k@2454 (+ (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430) $k@2449)))
(pop) ; 9
; [dead else-branch 373] $t@2440 == Null
(pop) ; 8
(push) ; 8
; [else-branch 372] $t@2440 == Null
(assert (= $t@2440 $Ref.null))
(declare-const $k@2455 $Perm)
(assert ($Perm.isValidVar $k@2455))
(assert ($Perm.isReadVar $k@2455 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429))
  (= $t@2436 $t@2376)))
(declare-const $k@2456 $Perm)
(assert ($Perm.isValidVar $k@2456))
(assert ($Perm.isReadVar $k@2456 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430))
  (= $t@2434 $t@2374)))
; [exec]
; i := __flatten_67
(declare-const $k@2457 $Perm)
(assert ($Perm.isValidVar $k@2457))
(assert ($Perm.isReadVar $k@2457 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2457 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2457 $k@2338))
(declare-const $k@2458 $Perm)
(assert ($Perm.isValidVar $k@2458))
(assert ($Perm.isReadVar $k@2458 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2458 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2458 (+ (- (+ (- $k@2340 $k@2368) $k@2386) $k@2427) $k@2446)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2459 $Perm)
(assert ($Perm.isValidVar $k@2459))
(assert ($Perm.isReadVar $k@2459 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2459 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2459 (+ (- (+ (- $k@2342 $k@2369) $k@2387) $k@2428) $k@2447)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@2440 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 374] $t@2440 != Null
(push) ; 9
; [else-branch 374] $t@2440 == Null
(declare-const $k@2460 $Perm)
(assert ($Perm.isValidVar $k@2460))
(assert ($Perm.isReadVar $k@2460 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2460 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429) $k@2455) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429) $k@2455) $Perm.No)))
(assert (< $k@2460 (+ (- (+ (- $k@2347 $k@2370) $k@2425) $k@2429) $k@2455)))
(declare-const $k@2461 $Perm)
(assert ($Perm.isValidVar $k@2461))
(assert ($Perm.isReadVar $k@2461 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2461 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430) $k@2456) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430) $k@2456) $Perm.No)))
(assert (< $k@2461 (+ (- (+ (- $k@2349 $k@2371) $k@2426) $k@2430) $k@2456)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 365] $t@2345 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 363] $t@2345 == Null
(assert (= $t@2345 $Ref.null))
(declare-const $k@2462 $Perm)
(assert ($Perm.isValidVar $k@2462))
(assert ($Perm.isReadVar $k@2462 $Perm.Write))
(declare-const $t@2463 $Ref)
(declare-const $k@2464 $Perm)
(assert ($Perm.isValidVar $k@2464))
(assert ($Perm.isReadVar $k@2464 $Perm.Write))
(declare-const $t@2465 $Ref)
(push) ; 4
(declare-const $k@2466 $Perm)
(assert ($Perm.isValidVar $k@2466))
(assert ($Perm.isReadVar $k@2466 $Perm.Write))
(declare-const $t@2467 $Ref)
(push) ; 5
(assert (not (not (= $k@2466 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2466 $Perm.No)))
(assert (not (= $t@2467 $Ref.null)))
(declare-const $k@2468 $Perm)
(assert ($Perm.isValidVar $k@2468))
(assert ($Perm.isReadVar $k@2468 $Perm.Write))
(declare-const $t@2469 Int)
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2468 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2468 $Perm.No)))
(assert (> $t@2469 0))
(declare-const $k@2470 $Perm)
(assert ($Perm.isValidVar $k@2470))
(assert ($Perm.isReadVar $k@2470 $Perm.Write))
(declare-const $t@2471 $Ref)
(push) ; 5
(assert (not (not (= $k@2470 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2470 $Perm.No)))
(assert (not (= $t@2471 $Ref.null)))
(declare-const $t@2472 Int)
(declare-const $t@2473 $Ref)
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2473 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2473 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 375] $t@2473 != Null
(assert (not (= $t@2473 $Ref.null)))
(declare-const $t@2474 $Snap)
(declare-const $k@2475 $Perm)
(assert ($Perm.isValidVar $k@2475))
(assert ($Perm.isReadVar $k@2475 $Perm.Write))
(declare-const $t@2476 $Ref)
(declare-const $k@2477 $Perm)
(assert ($Perm.isValidVar $k@2477))
(assert ($Perm.isReadVar $k@2477 $Perm.Write))
(declare-const $t@2478 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 375] $t@2473 == Null
(assert (= $t@2473 $Ref.null))
(declare-const $k@2479 $Perm)
(assert ($Perm.isValidVar $k@2479))
(assert ($Perm.isReadVar $k@2479 $Perm.Write))
(declare-const $t@2480 $Ref)
(declare-const $k@2481 $Perm)
(assert ($Perm.isValidVar $k@2481))
(assert ($Perm.isReadVar $k@2481 $Perm.Write))
(declare-const $t@2482 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; BlockingQueue__put(diz.LBQThread2b__queue, 2)
; [eval] diz != null
(declare-const $k@2483 $Perm)
(assert ($Perm.isValidVar $k@2483))
(assert ($Perm.isReadVar $k@2483 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2483 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2483 $k@2340))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2484 $Perm)
(assert ($Perm.isValidVar $k@2484))
(assert ($Perm.isReadVar $k@2484 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2484 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2484 $k@2342))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2345 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 376] $t@2345 != Null
(push) ; 5
; [else-branch 376] $t@2345 == Null
(declare-const $k@2485 $Perm)
(assert ($Perm.isValidVar $k@2485))
(assert ($Perm.isReadVar $k@2485 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2485 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2462 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2462 $Perm.No)))
(assert (< $k@2485 $k@2462))
(declare-const $k@2486 $Perm)
(assert ($Perm.isValidVar $k@2486))
(assert ($Perm.isReadVar $k@2486 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2486 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2464 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2464 $Perm.No)))
(assert (< $k@2486 $k@2464))
(declare-const $t@2487 $Snap)
(declare-const $t@2488 $Snap)
(declare-const $t@2489 $Ref)
(assert (= $t@2487 ($Snap.combine $t@2488 ($SortWrappers.$RefTo$Snap $t@2489))))
(declare-const $t@2490 $Snap)
(declare-const $t@2491 $Ref)
(assert (= $t@2488 ($Snap.combine $t@2490 ($SortWrappers.$RefTo$Snap $t@2491))))
(declare-const $t@2492 $Snap)
(declare-const $t@2493 $Snap)
(assert (= $t@2490 ($Snap.combine $t@2492 $t@2493)))
(declare-const $t@2494 $Snap)
(declare-const $t@2495 $Ref)
(assert (= $t@2492 ($Snap.combine $t@2494 ($SortWrappers.$RefTo$Snap $t@2495))))
(declare-const $t@2496 $Snap)
(declare-const $t@2497 Int)
(assert (= $t@2494 ($Snap.combine $t@2496 ($SortWrappers.IntTo$Snap $t@2497))))
(declare-const $t@2498 Int)
(declare-const $t@2499 $Ref)
(assert (=
  $t@2496
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2498)
    ($SortWrappers.$RefTo$Snap $t@2499))))
(declare-const $t@2500 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2498)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2500) $Snap.unit)))
(declare-const $k@2501 $Perm)
(assert ($Perm.isValidVar $k@2501))
(assert ($Perm.isReadVar $k@2501 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2340 $k@2483)) (= $t@2500 $t@2341)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2340 $k@2483) $k@2501) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2340 $k@2483) $k@2501) $Perm.No)))
(assert (> $t@2500 0))
(declare-const $k@2502 $Perm)
(assert ($Perm.isValidVar $k@2502))
(assert ($Perm.isReadVar $k@2502 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2342 $k@2484)) (= $t@2499 $t@2343)))
(push) ; 6
(assert (not (not (= (+ (- $k@2342 $k@2484) $k@2502) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2342 $k@2484) $k@2502) $Perm.No)))
(assert (not (= $t@2499 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2495 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2495 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 377] $t@2495 != Null
(assert (not (= $t@2495 $Ref.null)))
(declare-const $k@2503 $Perm)
(assert ($Perm.isValidVar $k@2503))
(assert ($Perm.isReadVar $k@2503 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2462 $k@2485)) (= $t@2491 $t@2463)))
(declare-const $k@2504 $Perm)
(assert ($Perm.isValidVar $k@2504))
(assert ($Perm.isReadVar $k@2504 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2464 $k@2486)) (= $t@2489 $t@2465)))
; [exec]
; __flatten_67 := BlockingQueue__poll(diz.LBQThread2b__queue)
; [eval] diz != null
(declare-const $k@2505 $Perm)
(assert ($Perm.isValidVar $k@2505))
(assert ($Perm.isReadVar $k@2505 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2505 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2505 (+ (- $k@2340 $k@2483) $k@2501)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2506 $Perm)
(assert ($Perm.isValidVar $k@2506))
(assert ($Perm.isReadVar $k@2506 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2506 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2506 (+ (- $k@2342 $k@2484) $k@2502)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2495 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 378] $t@2495 != Null
(declare-const $k@2507 $Perm)
(assert ($Perm.isValidVar $k@2507))
(assert ($Perm.isReadVar $k@2507 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2507 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2462 $k@2485) $k@2503) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2462 $k@2485) $k@2503) $Perm.No)))
(assert (< $k@2507 (+ (- $k@2462 $k@2485) $k@2503)))
(declare-const $k@2508 $Perm)
(assert ($Perm.isValidVar $k@2508))
(assert ($Perm.isReadVar $k@2508 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2508 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2464 $k@2486) $k@2504) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2464 $k@2486) $k@2504) $Perm.No)))
(assert (< $k@2508 (+ (- $k@2464 $k@2486) $k@2504)))
(declare-const sys__result@2509 $Ref)
(declare-const $t@2510 $Snap)
(declare-const $t@2511 $Snap)
(declare-const $t@2512 $Ref)
(assert (= $t@2510 ($Snap.combine $t@2511 ($SortWrappers.$RefTo$Snap $t@2512))))
(declare-const $t@2513 $Snap)
(declare-const $t@2514 $Ref)
(assert (= $t@2511 ($Snap.combine $t@2513 ($SortWrappers.$RefTo$Snap $t@2514))))
(declare-const $t@2515 $Snap)
(declare-const $t@2516 $Snap)
(assert (= $t@2513 ($Snap.combine $t@2515 $t@2516)))
(declare-const $t@2517 $Snap)
(declare-const $t@2518 $Ref)
(assert (= $t@2515 ($Snap.combine $t@2517 ($SortWrappers.$RefTo$Snap $t@2518))))
(declare-const $t@2519 $Snap)
(declare-const $t@2520 Int)
(assert (= $t@2517 ($Snap.combine $t@2519 ($SortWrappers.IntTo$Snap $t@2520))))
(declare-const $t@2521 Int)
(declare-const $t@2522 $Ref)
(assert (=
  $t@2519
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2521)
    ($SortWrappers.$RefTo$Snap $t@2522))))
(declare-const $t@2523 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2521)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2523) $Snap.unit)))
(declare-const $k@2524 $Perm)
(assert ($Perm.isValidVar $k@2524))
(assert ($Perm.isReadVar $k@2524 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2340 $k@2483) $k@2501) $k@2505))
  (= $t@2523 $t@2500)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2505) $k@2524) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2505) $k@2524) $Perm.No)))
(assert (> $t@2523 0))
(declare-const $k@2525 $Perm)
(assert ($Perm.isValidVar $k@2525))
(assert ($Perm.isReadVar $k@2525 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2342 $k@2484) $k@2502) $k@2506))
  (= $t@2522 $t@2499)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2506) $k@2525) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2506) $k@2525) $Perm.No)))
(assert (not (= $t@2522 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@2518 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@2518 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 379] $t@2518 != Null
(assert (not (= $t@2518 $Ref.null)))
(declare-const $k@2526 $Perm)
(assert ($Perm.isValidVar $k@2526))
(assert ($Perm.isReadVar $k@2526 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507))
  (= $t@2514 $t@2491)))
(declare-const $k@2527 $Perm)
(assert ($Perm.isValidVar $k@2527))
(assert ($Perm.isReadVar $k@2527 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508))
  (= $t@2512 $t@2489)))
; [exec]
; i := __flatten_67
(declare-const $k@2528 $Perm)
(assert ($Perm.isValidVar $k@2528))
(assert ($Perm.isReadVar $k@2528 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2528 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2528 $k@2338))
(declare-const $k@2529 $Perm)
(assert ($Perm.isValidVar $k@2529))
(assert ($Perm.isReadVar $k@2529 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2529 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2529 (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2505) $k@2524)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2530 $Perm)
(assert ($Perm.isValidVar $k@2530))
(assert ($Perm.isReadVar $k@2530 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2530 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2530 (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2506) $k@2525)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@2518 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 380] $t@2518 != Null
(declare-const $k@2531 $Perm)
(assert ($Perm.isValidVar $k@2531))
(assert ($Perm.isReadVar $k@2531 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2531 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507) $k@2526) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507) $k@2526) $Perm.No)))
(assert (< $k@2531 (+ (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507) $k@2526)))
(declare-const $k@2532 $Perm)
(assert ($Perm.isValidVar $k@2532))
(assert ($Perm.isReadVar $k@2532 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2532 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508) $k@2527) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508) $k@2527) $Perm.No)))
(assert (< $k@2532 (+ (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508) $k@2527)))
(pop) ; 9
; [dead else-branch 380] $t@2518 == Null
(pop) ; 8
(push) ; 8
; [else-branch 379] $t@2518 == Null
(assert (= $t@2518 $Ref.null))
(declare-const $k@2533 $Perm)
(assert ($Perm.isValidVar $k@2533))
(assert ($Perm.isReadVar $k@2533 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507))
  (= $t@2514 $t@2491)))
(declare-const $k@2534 $Perm)
(assert ($Perm.isValidVar $k@2534))
(assert ($Perm.isReadVar $k@2534 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508))
  (= $t@2512 $t@2489)))
; [exec]
; i := __flatten_67
(declare-const $k@2535 $Perm)
(assert ($Perm.isValidVar $k@2535))
(assert ($Perm.isReadVar $k@2535 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2535 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2535 $k@2338))
(declare-const $k@2536 $Perm)
(assert ($Perm.isValidVar $k@2536))
(assert ($Perm.isReadVar $k@2536 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2536 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2536 (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2505) $k@2524)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2537 $Perm)
(assert ($Perm.isValidVar $k@2537))
(assert ($Perm.isReadVar $k@2537 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2537 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2537 (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2506) $k@2525)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@2518 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 381] $t@2518 != Null
(push) ; 9
; [else-branch 381] $t@2518 == Null
(declare-const $k@2538 $Perm)
(assert ($Perm.isValidVar $k@2538))
(assert ($Perm.isReadVar $k@2538 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2538 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507) $k@2533) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507) $k@2533) $Perm.No)))
(assert (< $k@2538 (+ (- (+ (- $k@2462 $k@2485) $k@2503) $k@2507) $k@2533)))
(declare-const $k@2539 $Perm)
(assert ($Perm.isValidVar $k@2539))
(assert ($Perm.isReadVar $k@2539 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2539 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508) $k@2534) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508) $k@2534) $Perm.No)))
(assert (< $k@2539 (+ (- (+ (- $k@2464 $k@2486) $k@2504) $k@2508) $k@2534)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 378] $t@2495 == Null
(pop) ; 6
(push) ; 6
; [else-branch 377] $t@2495 == Null
(assert (= $t@2495 $Ref.null))
(declare-const $k@2540 $Perm)
(assert ($Perm.isValidVar $k@2540))
(assert ($Perm.isReadVar $k@2540 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2462 $k@2485)) (= $t@2491 $t@2463)))
(declare-const $k@2541 $Perm)
(assert ($Perm.isValidVar $k@2541))
(assert ($Perm.isReadVar $k@2541 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2464 $k@2486)) (= $t@2489 $t@2465)))
; [exec]
; __flatten_67 := BlockingQueue__poll(diz.LBQThread2b__queue)
; [eval] diz != null
(declare-const $k@2542 $Perm)
(assert ($Perm.isValidVar $k@2542))
(assert ($Perm.isReadVar $k@2542 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2542 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2542 (+ (- $k@2340 $k@2483) $k@2501)))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2543 $Perm)
(assert ($Perm.isValidVar $k@2543))
(assert ($Perm.isReadVar $k@2543 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2543 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2543 (+ (- $k@2342 $k@2484) $k@2502)))
; [eval] diz.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2495 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 382] $t@2495 != Null
(push) ; 7
; [else-branch 382] $t@2495 == Null
(declare-const $k@2544 $Perm)
(assert ($Perm.isValidVar $k@2544))
(assert ($Perm.isReadVar $k@2544 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2544 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2462 $k@2485) $k@2540) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2462 $k@2485) $k@2540) $Perm.No)))
(assert (< $k@2544 (+ (- $k@2462 $k@2485) $k@2540)))
(declare-const $k@2545 $Perm)
(assert ($Perm.isValidVar $k@2545))
(assert ($Perm.isReadVar $k@2545 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2545 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2464 $k@2486) $k@2541) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2464 $k@2486) $k@2541) $Perm.No)))
(assert (< $k@2545 (+ (- $k@2464 $k@2486) $k@2541)))
(declare-const sys__result@2546 $Ref)
(declare-const $t@2547 $Snap)
(declare-const $t@2548 $Snap)
(declare-const $t@2549 $Ref)
(assert (= $t@2547 ($Snap.combine $t@2548 ($SortWrappers.$RefTo$Snap $t@2549))))
(declare-const $t@2550 $Snap)
(declare-const $t@2551 $Ref)
(assert (= $t@2548 ($Snap.combine $t@2550 ($SortWrappers.$RefTo$Snap $t@2551))))
(declare-const $t@2552 $Snap)
(declare-const $t@2553 $Snap)
(assert (= $t@2550 ($Snap.combine $t@2552 $t@2553)))
(declare-const $t@2554 $Snap)
(declare-const $t@2555 $Ref)
(assert (= $t@2552 ($Snap.combine $t@2554 ($SortWrappers.$RefTo$Snap $t@2555))))
(declare-const $t@2556 $Snap)
(declare-const $t@2557 Int)
(assert (= $t@2554 ($Snap.combine $t@2556 ($SortWrappers.IntTo$Snap $t@2557))))
(declare-const $t@2558 Int)
(declare-const $t@2559 $Ref)
(assert (=
  $t@2556
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2558)
    ($SortWrappers.$RefTo$Snap $t@2559))))
(declare-const $t@2560 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2558)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2560) $Snap.unit)))
(declare-const $k@2561 $Perm)
(assert ($Perm.isValidVar $k@2561))
(assert ($Perm.isReadVar $k@2561 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2340 $k@2483) $k@2501) $k@2542))
  (= $t@2560 $t@2500)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2542) $k@2561) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2542) $k@2561) $Perm.No)))
(assert (> $t@2560 0))
(declare-const $k@2562 $Perm)
(assert ($Perm.isValidVar $k@2562))
(assert ($Perm.isReadVar $k@2562 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2342 $k@2484) $k@2502) $k@2543))
  (= $t@2559 $t@2499)))
(push) ; 8
(assert (not (not (= (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2543) $k@2562) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2543) $k@2562) $Perm.No)))
(assert (not (= $t@2559 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 8
(assert (not (= $t@2555 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $t@2555 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 383] $t@2555 != Null
(assert (not (= $t@2555 $Ref.null)))
(declare-const $k@2563 $Perm)
(assert ($Perm.isValidVar $k@2563))
(assert ($Perm.isReadVar $k@2563 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544))
  (= $t@2551 $t@2491)))
(declare-const $k@2564 $Perm)
(assert ($Perm.isValidVar $k@2564))
(assert ($Perm.isReadVar $k@2564 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545))
  (= $t@2549 $t@2489)))
; [exec]
; i := __flatten_67
(declare-const $k@2565 $Perm)
(assert ($Perm.isValidVar $k@2565))
(assert ($Perm.isReadVar $k@2565 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2565 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2565 $k@2338))
(declare-const $k@2566 $Perm)
(assert ($Perm.isValidVar $k@2566))
(assert ($Perm.isReadVar $k@2566 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2566 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2566 (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2542) $k@2561)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2567 $Perm)
(assert ($Perm.isValidVar $k@2567))
(assert ($Perm.isReadVar $k@2567 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2567 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2567 (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2543) $k@2562)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (= $t@2555 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 384] $t@2555 != Null
(declare-const $k@2568 $Perm)
(assert ($Perm.isValidVar $k@2568))
(assert ($Perm.isReadVar $k@2568 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2568 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544) $k@2563) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544) $k@2563) $Perm.No)))
(assert (< $k@2568 (+ (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544) $k@2563)))
(declare-const $k@2569 $Perm)
(assert ($Perm.isValidVar $k@2569))
(assert ($Perm.isReadVar $k@2569 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2569 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545) $k@2564) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545) $k@2564) $Perm.No)))
(assert (< $k@2569 (+ (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545) $k@2564)))
(pop) ; 9
; [dead else-branch 384] $t@2555 == Null
(pop) ; 8
(push) ; 8
; [else-branch 383] $t@2555 == Null
(assert (= $t@2555 $Ref.null))
(declare-const $k@2570 $Perm)
(assert ($Perm.isValidVar $k@2570))
(assert ($Perm.isReadVar $k@2570 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544))
  (= $t@2551 $t@2491)))
(declare-const $k@2571 $Perm)
(assert ($Perm.isValidVar $k@2571))
(assert ($Perm.isReadVar $k@2571 $Perm.Write))
(assert (implies
  (< $Perm.No (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545))
  (= $t@2549 $t@2489)))
; [exec]
; i := __flatten_67
(declare-const $k@2572 $Perm)
(assert ($Perm.isValidVar $k@2572))
(assert ($Perm.isReadVar $k@2572 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2572 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2572 $k@2338))
(declare-const $k@2573 $Perm)
(assert ($Perm.isValidVar $k@2573))
(assert ($Perm.isReadVar $k@2573 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2573 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2573 (+ (- (+ (- $k@2340 $k@2483) $k@2501) $k@2542) $k@2561)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__capacity > 0
(declare-const $k@2574 $Perm)
(assert ($Perm.isValidVar $k@2574))
(assert ($Perm.isReadVar $k@2574 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@2574 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@2574 (+ (- (+ (- $k@2342 $k@2484) $k@2502) $k@2543) $k@2562)))
; [eval] diz.LBQThread2b__queue.BlockingQueue__first != null
(push) ; 9
(assert (not (not (= $t@2555 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 385] $t@2555 != Null
(push) ; 9
; [else-branch 385] $t@2555 == Null
(declare-const $k@2575 $Perm)
(assert ($Perm.isValidVar $k@2575))
(assert ($Perm.isReadVar $k@2575 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2575 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544) $k@2570) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544) $k@2570) $Perm.No)))
(assert (< $k@2575 (+ (- (+ (- $k@2462 $k@2485) $k@2540) $k@2544) $k@2570)))
(declare-const $k@2576 $Perm)
(assert ($Perm.isValidVar $k@2576))
(assert ($Perm.isReadVar $k@2576 $Perm.Write))
(push) ; 10
(assert (not (or (= $k@2576 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(push) ; 10
(assert (not (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545) $k@2571) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 10
(assert (not (= (+ (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545) $k@2571) $Perm.No)))
(assert (< $k@2576 (+ (- (+ (- $k@2464 $k@2486) $k@2541) $k@2545) $k@2571)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3a__LBQThread1a ----------
(declare-const queue@2577 $Ref)
(declare-const sys__result@2578 $Ref)
(declare-const diz@2579 $Ref)
(declare-const __flatten_68@2580 $Ref)
(declare-const __flatten_128@2581 $Ref)
(push) ; 2
(assert (not (= queue@2577 $Ref.null)))
(declare-const $k@2582 $Perm)
(assert ($Perm.isValidVar $k@2582))
(assert ($Perm.isReadVar $k@2582 $Perm.Write))
(declare-const $t@2583 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2582 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2582 $Perm.No)))
(assert (> $t@2583 0))
(declare-const $k@2584 $Perm)
(assert ($Perm.isValidVar $k@2584))
(assert ($Perm.isReadVar $k@2584 $Perm.Write))
(declare-const $t@2585 $Ref)
(push) ; 3
(assert (not (not (= $k@2584 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2584 $Perm.No)))
(assert (not (= $t@2585 $Ref.null)))
(declare-const $t@2586 Int)
(declare-const $t@2587 $Ref)
; [eval] queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2587 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2587 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 386] $t@2587 != Null
(assert (not (= $t@2587 $Ref.null)))
(declare-const $t@2588 $Snap)
(declare-const $k@2589 $Perm)
(assert ($Perm.isValidVar $k@2589))
(assert ($Perm.isReadVar $k@2589 $Perm.Write))
(declare-const $t@2590 $Ref)
(declare-const $k@2591 $Perm)
(assert ($Perm.isValidVar $k@2591))
(assert ($Perm.isReadVar $k@2591 $Perm.Write))
(declare-const $t@2592 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2578 $Ref.null)))
(declare-const $k@2593 $Perm)
(assert ($Perm.isValidVar $k@2593))
(assert ($Perm.isReadVar $k@2593 $Perm.Write))
(declare-const $t@2594 $Ref)
(push) ; 5
(assert (not (not (= $k@2593 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2593 $Perm.No)))
(assert (not (= $t@2594 $Ref.null)))
(declare-const $k@2595 $Perm)
(assert ($Perm.isValidVar $k@2595))
(assert ($Perm.isReadVar $k@2595 $Perm.Write))
(declare-const $t@2596 Int)
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2595 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2595 $Perm.No)))
(assert (> $t@2596 0))
(declare-const $k@2597 $Perm)
(assert ($Perm.isValidVar $k@2597))
(assert ($Perm.isReadVar $k@2597 $Perm.Write))
(declare-const $t@2598 $Ref)
(push) ; 5
(assert (not (not (= $k@2597 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2597 $Perm.No)))
(assert (not (= $t@2598 $Ref.null)))
(declare-const $t@2599 Int)
(declare-const $t@2600 $Ref)
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2600 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2600 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 387] $t@2600 != Null
(assert (not (= $t@2600 $Ref.null)))
(declare-const $t@2601 $Snap)
(declare-const $k@2602 $Perm)
(assert ($Perm.isValidVar $k@2602))
(assert ($Perm.isReadVar $k@2602 $Perm.Write))
(declare-const $t@2603 $Ref)
(declare-const $k@2604 $Perm)
(assert ($Perm.isValidVar $k@2604))
(assert ($Perm.isReadVar $k@2604 $Perm.Write))
(declare-const $t@2605 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 387] $t@2600 == Null
(assert (= $t@2600 $Ref.null))
(declare-const $k@2606 $Perm)
(assert ($Perm.isValidVar $k@2606))
(assert ($Perm.isReadVar $k@2606 $Perm.Write))
(declare-const $t@2607 $Ref)
(declare-const $k@2608 $Perm)
(assert ($Perm.isValidVar $k@2608))
(assert ($Perm.isReadVar $k@2608 $Perm.Write))
(declare-const $t@2609 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread3a__queue)
(declare-const diz@2610 $Ref)
(assert (not (= diz@2610 $Ref.null)))
(declare-const LBQThread3a__queue@2611 $Ref)
(assert (and
  (not (= queue@2577 diz@2610))
  (not (= sys__result@2578 diz@2610))
  (not (= __flatten_68@2580 diz@2610))
  (not (= __flatten_128@2581 diz@2610))
  (not (= $t@2585 diz@2610))
  (not (= $t@2587 diz@2610))
  (not (= LBQThread3a__queue@2611 diz@2610))
  (not (= $t@2590 diz@2610))
  (not (= $t@2592 diz@2610))))
; [exec]
; __flatten_68 := queue
; [exec]
; __flatten_128 := __flatten_68
; [exec]
; diz.LBQThread3a__queue := __flatten_128
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread3a__queue, wildcard) && acc(sys__result.LBQThread3a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread3a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread3a__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread3a__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread3a__queue.BlockingQueue__first, write) && ((sys__result.LBQThread3a__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread3a__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread3a__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread3a__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2612 $Perm)
(assert ($Perm.isValidVar $k@2612))
(assert ($Perm.isReadVar $k@2612 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2612 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2612 $Perm.Write))
(declare-const $k@2613 $Perm)
(assert ($Perm.isValidVar $k@2613))
(assert ($Perm.isReadVar $k@2613 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2613 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2613 $k@2582))
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__capacity > 0
(declare-const $k@2614 $Perm)
(assert ($Perm.isValidVar $k@2614))
(assert ($Perm.isReadVar $k@2614 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2614 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2614 $k@2584))
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2587 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 388] $t@2587 != Null
(declare-const $k@2615 $Perm)
(assert ($Perm.isValidVar $k@2615))
(assert ($Perm.isReadVar $k@2615 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2615 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2589 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2589 $Perm.No)))
(assert (< $k@2615 $k@2589))
(declare-const $k@2616 $Perm)
(assert ($Perm.isValidVar $k@2616))
(assert ($Perm.isReadVar $k@2616 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2616 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2591 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2591 $Perm.No)))
(assert (< $k@2616 $k@2591))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 388] $t@2587 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 386] $t@2587 == Null
(assert (= $t@2587 $Ref.null))
(declare-const $k@2617 $Perm)
(assert ($Perm.isValidVar $k@2617))
(assert ($Perm.isReadVar $k@2617 $Perm.Write))
(declare-const $t@2618 $Ref)
(declare-const $k@2619 $Perm)
(assert ($Perm.isValidVar $k@2619))
(assert ($Perm.isReadVar $k@2619 $Perm.Write))
(declare-const $t@2620 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2578 $Ref.null)))
(declare-const $k@2621 $Perm)
(assert ($Perm.isValidVar $k@2621))
(assert ($Perm.isReadVar $k@2621 $Perm.Write))
(declare-const $t@2622 $Ref)
(push) ; 5
(assert (not (not (= $k@2621 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2621 $Perm.No)))
(assert (not (= $t@2622 $Ref.null)))
(declare-const $k@2623 $Perm)
(assert ($Perm.isValidVar $k@2623))
(assert ($Perm.isReadVar $k@2623 $Perm.Write))
(declare-const $t@2624 Int)
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2623 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2623 $Perm.No)))
(assert (> $t@2624 0))
(declare-const $k@2625 $Perm)
(assert ($Perm.isValidVar $k@2625))
(assert ($Perm.isReadVar $k@2625 $Perm.Write))
(declare-const $t@2626 $Ref)
(push) ; 5
(assert (not (not (= $k@2625 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2625 $Perm.No)))
(assert (not (= $t@2626 $Ref.null)))
(declare-const $t@2627 Int)
(declare-const $t@2628 $Ref)
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2628 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2628 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 389] $t@2628 != Null
(assert (not (= $t@2628 $Ref.null)))
(declare-const $t@2629 $Snap)
(declare-const $k@2630 $Perm)
(assert ($Perm.isValidVar $k@2630))
(assert ($Perm.isReadVar $k@2630 $Perm.Write))
(declare-const $t@2631 $Ref)
(declare-const $k@2632 $Perm)
(assert ($Perm.isValidVar $k@2632))
(assert ($Perm.isReadVar $k@2632 $Perm.Write))
(declare-const $t@2633 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 389] $t@2628 == Null
(assert (= $t@2628 $Ref.null))
(declare-const $k@2634 $Perm)
(assert ($Perm.isValidVar $k@2634))
(assert ($Perm.isReadVar $k@2634 $Perm.Write))
(declare-const $t@2635 $Ref)
(declare-const $k@2636 $Perm)
(assert ($Perm.isValidVar $k@2636))
(assert ($Perm.isReadVar $k@2636 $Perm.Write))
(declare-const $t@2637 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread3a__queue)
(declare-const diz@2638 $Ref)
(assert (not (= diz@2638 $Ref.null)))
(declare-const LBQThread3a__queue@2639 $Ref)
(assert (and
  (not (= queue@2577 diz@2638))
  (not (= sys__result@2578 diz@2638))
  (not (= __flatten_68@2580 diz@2638))
  (not (= __flatten_128@2581 diz@2638))
  (not (= $t@2585 diz@2638))
  (not (= LBQThread3a__queue@2639 diz@2638))
  (not (= $t@2587 diz@2638))
  (not (= $t@2618 diz@2638))
  (not (= $t@2620 diz@2638))))
; [exec]
; __flatten_68 := queue
; [exec]
; __flatten_128 := __flatten_68
; [exec]
; diz.LBQThread3a__queue := __flatten_128
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread3a__queue, wildcard) && acc(sys__result.LBQThread3a__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread3a__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread3a__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread3a__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread3a__queue.BlockingQueue__first, write) && ((sys__result.LBQThread3a__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread3a__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread3a__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread3a__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2640 $Perm)
(assert ($Perm.isValidVar $k@2640))
(assert ($Perm.isReadVar $k@2640 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2640 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2640 $Perm.Write))
(declare-const $k@2641 $Perm)
(assert ($Perm.isValidVar $k@2641))
(assert ($Perm.isReadVar $k@2641 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2641 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2641 $k@2582))
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__capacity > 0
(declare-const $k@2642 $Perm)
(assert ($Perm.isValidVar $k@2642))
(assert ($Perm.isReadVar $k@2642 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2642 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2642 $k@2584))
; [eval] sys__result.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2587 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 390] $t@2587 != Null
(push) ; 5
; [else-branch 390] $t@2587 == Null
(declare-const $k@2643 $Perm)
(assert ($Perm.isValidVar $k@2643))
(assert ($Perm.isReadVar $k@2643 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2643 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2617 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2617 $Perm.No)))
(assert (< $k@2643 $k@2617))
(declare-const $k@2644 $Perm)
(assert ($Perm.isValidVar $k@2644))
(assert ($Perm.isReadVar $k@2644 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2644 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2619 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2619 $Perm.No)))
(assert (< $k@2644 $k@2619))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3a__run ----------
(declare-const diz@2645 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2645 $Ref.null)))
(declare-const $k@2646 $Perm)
(assert ($Perm.isValidVar $k@2646))
(assert ($Perm.isReadVar $k@2646 $Perm.Write))
(declare-const $t@2647 $Ref)
(push) ; 3
(assert (not (not (= $k@2646 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2646 $Perm.No)))
(assert (not (= $t@2647 $Ref.null)))
(declare-const $k@2648 $Perm)
(assert ($Perm.isValidVar $k@2648))
(assert ($Perm.isReadVar $k@2648 $Perm.Write))
(declare-const $t@2649 Int)
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2648 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2648 $Perm.No)))
(assert (> $t@2649 0))
(declare-const $k@2650 $Perm)
(assert ($Perm.isValidVar $k@2650))
(assert ($Perm.isReadVar $k@2650 $Perm.Write))
(declare-const $t@2651 $Ref)
(push) ; 3
(assert (not (not (= $k@2650 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2650 $Perm.No)))
(assert (not (= $t@2651 $Ref.null)))
(declare-const $t@2652 Int)
(declare-const $t@2653 $Ref)
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2653 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2653 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 391] $t@2653 != Null
(assert (not (= $t@2653 $Ref.null)))
(declare-const $t@2654 $Snap)
(declare-const $k@2655 $Perm)
(assert ($Perm.isValidVar $k@2655))
(assert ($Perm.isReadVar $k@2655 $Perm.Write))
(declare-const $t@2656 $Ref)
(declare-const $k@2657 $Perm)
(assert ($Perm.isValidVar $k@2657))
(assert ($Perm.isReadVar $k@2657 $Perm.Write))
(declare-const $t@2658 $Ref)
(push) ; 4
(declare-const $k@2659 $Perm)
(assert ($Perm.isValidVar $k@2659))
(assert ($Perm.isReadVar $k@2659 $Perm.Write))
(declare-const $t@2660 $Ref)
(push) ; 5
(assert (not (not (= $k@2659 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2659 $Perm.No)))
(assert (not (= $t@2660 $Ref.null)))
(declare-const $k@2661 $Perm)
(assert ($Perm.isValidVar $k@2661))
(assert ($Perm.isReadVar $k@2661 $Perm.Write))
(declare-const $t@2662 Int)
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2661 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2661 $Perm.No)))
(assert (> $t@2662 0))
(declare-const $k@2663 $Perm)
(assert ($Perm.isValidVar $k@2663))
(assert ($Perm.isReadVar $k@2663 $Perm.Write))
(declare-const $t@2664 $Ref)
(push) ; 5
(assert (not (not (= $k@2663 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2663 $Perm.No)))
(assert (not (= $t@2664 $Ref.null)))
(declare-const $t@2665 Int)
(declare-const $t@2666 $Ref)
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2666 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2666 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 392] $t@2666 != Null
(assert (not (= $t@2666 $Ref.null)))
(declare-const $t@2667 $Snap)
(declare-const $k@2668 $Perm)
(assert ($Perm.isValidVar $k@2668))
(assert ($Perm.isReadVar $k@2668 $Perm.Write))
(declare-const $t@2669 $Ref)
(declare-const $k@2670 $Perm)
(assert ($Perm.isValidVar $k@2670))
(assert ($Perm.isReadVar $k@2670 $Perm.Write))
(declare-const $t@2671 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 392] $t@2666 == Null
(assert (= $t@2666 $Ref.null))
(declare-const $k@2672 $Perm)
(assert ($Perm.isValidVar $k@2672))
(assert ($Perm.isReadVar $k@2672 $Perm.Write))
(declare-const $t@2673 $Ref)
(declare-const $k@2674 $Perm)
(assert ($Perm.isValidVar $k@2674))
(assert ($Perm.isReadVar $k@2674 $Perm.Write))
(declare-const $t@2675 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; BlockingQueue__put(diz.LBQThread3a__queue, 1)
; [eval] diz != null
(declare-const $k@2676 $Perm)
(assert ($Perm.isValidVar $k@2676))
(assert ($Perm.isReadVar $k@2676 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2676 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2676 $k@2648))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2677 $Perm)
(assert ($Perm.isValidVar $k@2677))
(assert ($Perm.isReadVar $k@2677 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2677 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2677 $k@2650))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2653 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 393] $t@2653 != Null
(declare-const $k@2678 $Perm)
(assert ($Perm.isValidVar $k@2678))
(assert ($Perm.isReadVar $k@2678 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2678 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2655 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2655 $Perm.No)))
(assert (< $k@2678 $k@2655))
(declare-const $k@2679 $Perm)
(assert ($Perm.isValidVar $k@2679))
(assert ($Perm.isReadVar $k@2679 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2679 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2657 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2657 $Perm.No)))
(assert (< $k@2679 $k@2657))
(declare-const $t@2680 $Snap)
(declare-const $t@2681 $Snap)
(declare-const $t@2682 $Ref)
(assert (= $t@2680 ($Snap.combine $t@2681 ($SortWrappers.$RefTo$Snap $t@2682))))
(declare-const $t@2683 $Snap)
(declare-const $t@2684 $Ref)
(assert (= $t@2681 ($Snap.combine $t@2683 ($SortWrappers.$RefTo$Snap $t@2684))))
(declare-const $t@2685 $Snap)
(declare-const $t@2686 $Snap)
(assert (= $t@2683 ($Snap.combine $t@2685 $t@2686)))
(declare-const $t@2687 $Snap)
(declare-const $t@2688 $Ref)
(assert (= $t@2685 ($Snap.combine $t@2687 ($SortWrappers.$RefTo$Snap $t@2688))))
(declare-const $t@2689 $Snap)
(declare-const $t@2690 Int)
(assert (= $t@2687 ($Snap.combine $t@2689 ($SortWrappers.IntTo$Snap $t@2690))))
(declare-const $t@2691 Int)
(declare-const $t@2692 $Ref)
(assert (=
  $t@2689
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2691)
    ($SortWrappers.$RefTo$Snap $t@2692))))
(declare-const $t@2693 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2691)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2693) $Snap.unit)))
(declare-const $k@2694 $Perm)
(assert ($Perm.isValidVar $k@2694))
(assert ($Perm.isReadVar $k@2694 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2648 $k@2676)) (= $t@2693 $t@2649)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2648 $k@2676) $k@2694) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2648 $k@2676) $k@2694) $Perm.No)))
(assert (> $t@2693 0))
(declare-const $k@2695 $Perm)
(assert ($Perm.isValidVar $k@2695))
(assert ($Perm.isReadVar $k@2695 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2650 $k@2677)) (= $t@2692 $t@2651)))
(push) ; 6
(assert (not (not (= (+ (- $k@2650 $k@2677) $k@2695) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2650 $k@2677) $k@2695) $Perm.No)))
(assert (not (= $t@2692 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2688 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2688 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 394] $t@2688 != Null
(assert (not (= $t@2688 $Ref.null)))
(declare-const $k@2696 $Perm)
(assert ($Perm.isValidVar $k@2696))
(assert ($Perm.isReadVar $k@2696 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2655 $k@2678)) (= $t@2684 $t@2656)))
(declare-const $k@2697 $Perm)
(assert ($Perm.isValidVar $k@2697))
(assert ($Perm.isReadVar $k@2697 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2657 $k@2679)) (= $t@2682 $t@2658)))
(declare-const $k@2698 $Perm)
(assert ($Perm.isValidVar $k@2698))
(assert ($Perm.isReadVar $k@2698 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2698 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2698 $k@2646))
(declare-const $k@2699 $Perm)
(assert ($Perm.isValidVar $k@2699))
(assert ($Perm.isReadVar $k@2699 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2699 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2699 (+ (- $k@2648 $k@2676) $k@2694)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(declare-const $k@2700 $Perm)
(assert ($Perm.isValidVar $k@2700))
(assert ($Perm.isReadVar $k@2700 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2700 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2700 (+ (- $k@2650 $k@2677) $k@2695)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2688 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 395] $t@2688 != Null
(declare-const $k@2701 $Perm)
(assert ($Perm.isValidVar $k@2701))
(assert ($Perm.isReadVar $k@2701 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2701 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2655 $k@2678) $k@2696) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2655 $k@2678) $k@2696) $Perm.No)))
(assert (< $k@2701 (+ (- $k@2655 $k@2678) $k@2696)))
(declare-const $k@2702 $Perm)
(assert ($Perm.isValidVar $k@2702))
(assert ($Perm.isReadVar $k@2702 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2702 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2657 $k@2679) $k@2697) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2657 $k@2679) $k@2697) $Perm.No)))
(assert (< $k@2702 (+ (- $k@2657 $k@2679) $k@2697)))
(pop) ; 7
; [dead else-branch 395] $t@2688 == Null
(pop) ; 6
(push) ; 6
; [else-branch 394] $t@2688 == Null
(assert (= $t@2688 $Ref.null))
(declare-const $k@2703 $Perm)
(assert ($Perm.isValidVar $k@2703))
(assert ($Perm.isReadVar $k@2703 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2655 $k@2678)) (= $t@2684 $t@2656)))
(declare-const $k@2704 $Perm)
(assert ($Perm.isValidVar $k@2704))
(assert ($Perm.isReadVar $k@2704 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2657 $k@2679)) (= $t@2682 $t@2658)))
(declare-const $k@2705 $Perm)
(assert ($Perm.isValidVar $k@2705))
(assert ($Perm.isReadVar $k@2705 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2705 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2705 $k@2646))
(declare-const $k@2706 $Perm)
(assert ($Perm.isValidVar $k@2706))
(assert ($Perm.isReadVar $k@2706 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2706 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2706 (+ (- $k@2648 $k@2676) $k@2694)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(declare-const $k@2707 $Perm)
(assert ($Perm.isValidVar $k@2707))
(assert ($Perm.isReadVar $k@2707 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2707 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2707 (+ (- $k@2650 $k@2677) $k@2695)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2688 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 396] $t@2688 != Null
(push) ; 7
; [else-branch 396] $t@2688 == Null
(declare-const $k@2708 $Perm)
(assert ($Perm.isValidVar $k@2708))
(assert ($Perm.isReadVar $k@2708 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2708 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2655 $k@2678) $k@2703) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2655 $k@2678) $k@2703) $Perm.No)))
(assert (< $k@2708 (+ (- $k@2655 $k@2678) $k@2703)))
(declare-const $k@2709 $Perm)
(assert ($Perm.isValidVar $k@2709))
(assert ($Perm.isReadVar $k@2709 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2709 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2657 $k@2679) $k@2704) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2657 $k@2679) $k@2704) $Perm.No)))
(assert (< $k@2709 (+ (- $k@2657 $k@2679) $k@2704)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 393] $t@2653 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 391] $t@2653 == Null
(assert (= $t@2653 $Ref.null))
(declare-const $k@2710 $Perm)
(assert ($Perm.isValidVar $k@2710))
(assert ($Perm.isReadVar $k@2710 $Perm.Write))
(declare-const $t@2711 $Ref)
(declare-const $k@2712 $Perm)
(assert ($Perm.isValidVar $k@2712))
(assert ($Perm.isReadVar $k@2712 $Perm.Write))
(declare-const $t@2713 $Ref)
(push) ; 4
(declare-const $k@2714 $Perm)
(assert ($Perm.isValidVar $k@2714))
(assert ($Perm.isReadVar $k@2714 $Perm.Write))
(declare-const $t@2715 $Ref)
(push) ; 5
(assert (not (not (= $k@2714 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2714 $Perm.No)))
(assert (not (= $t@2715 $Ref.null)))
(declare-const $k@2716 $Perm)
(assert ($Perm.isValidVar $k@2716))
(assert ($Perm.isReadVar $k@2716 $Perm.Write))
(declare-const $t@2717 Int)
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2716 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2716 $Perm.No)))
(assert (> $t@2717 0))
(declare-const $k@2718 $Perm)
(assert ($Perm.isValidVar $k@2718))
(assert ($Perm.isReadVar $k@2718 $Perm.Write))
(declare-const $t@2719 $Ref)
(push) ; 5
(assert (not (not (= $k@2718 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2718 $Perm.No)))
(assert (not (= $t@2719 $Ref.null)))
(declare-const $t@2720 Int)
(declare-const $t@2721 $Ref)
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2721 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2721 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 397] $t@2721 != Null
(assert (not (= $t@2721 $Ref.null)))
(declare-const $t@2722 $Snap)
(declare-const $k@2723 $Perm)
(assert ($Perm.isValidVar $k@2723))
(assert ($Perm.isReadVar $k@2723 $Perm.Write))
(declare-const $t@2724 $Ref)
(declare-const $k@2725 $Perm)
(assert ($Perm.isValidVar $k@2725))
(assert ($Perm.isReadVar $k@2725 $Perm.Write))
(declare-const $t@2726 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 397] $t@2721 == Null
(assert (= $t@2721 $Ref.null))
(declare-const $k@2727 $Perm)
(assert ($Perm.isValidVar $k@2727))
(assert ($Perm.isReadVar $k@2727 $Perm.Write))
(declare-const $t@2728 $Ref)
(declare-const $k@2729 $Perm)
(assert ($Perm.isValidVar $k@2729))
(assert ($Perm.isReadVar $k@2729 $Perm.Write))
(declare-const $t@2730 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; BlockingQueue__put(diz.LBQThread3a__queue, 1)
; [eval] diz != null
(declare-const $k@2731 $Perm)
(assert ($Perm.isValidVar $k@2731))
(assert ($Perm.isReadVar $k@2731 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2731 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2731 $k@2648))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2732 $Perm)
(assert ($Perm.isValidVar $k@2732))
(assert ($Perm.isReadVar $k@2732 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2732 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2732 $k@2650))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2653 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 398] $t@2653 != Null
(push) ; 5
; [else-branch 398] $t@2653 == Null
(declare-const $k@2733 $Perm)
(assert ($Perm.isValidVar $k@2733))
(assert ($Perm.isReadVar $k@2733 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2733 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2710 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2710 $Perm.No)))
(assert (< $k@2733 $k@2710))
(declare-const $k@2734 $Perm)
(assert ($Perm.isValidVar $k@2734))
(assert ($Perm.isReadVar $k@2734 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2734 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2712 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2712 $Perm.No)))
(assert (< $k@2734 $k@2712))
(declare-const $t@2735 $Snap)
(declare-const $t@2736 $Snap)
(declare-const $t@2737 $Ref)
(assert (= $t@2735 ($Snap.combine $t@2736 ($SortWrappers.$RefTo$Snap $t@2737))))
(declare-const $t@2738 $Snap)
(declare-const $t@2739 $Ref)
(assert (= $t@2736 ($Snap.combine $t@2738 ($SortWrappers.$RefTo$Snap $t@2739))))
(declare-const $t@2740 $Snap)
(declare-const $t@2741 $Snap)
(assert (= $t@2738 ($Snap.combine $t@2740 $t@2741)))
(declare-const $t@2742 $Snap)
(declare-const $t@2743 $Ref)
(assert (= $t@2740 ($Snap.combine $t@2742 ($SortWrappers.$RefTo$Snap $t@2743))))
(declare-const $t@2744 $Snap)
(declare-const $t@2745 Int)
(assert (= $t@2742 ($Snap.combine $t@2744 ($SortWrappers.IntTo$Snap $t@2745))))
(declare-const $t@2746 Int)
(declare-const $t@2747 $Ref)
(assert (=
  $t@2744
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2746)
    ($SortWrappers.$RefTo$Snap $t@2747))))
(declare-const $t@2748 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2746)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2748) $Snap.unit)))
(declare-const $k@2749 $Perm)
(assert ($Perm.isValidVar $k@2749))
(assert ($Perm.isReadVar $k@2749 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2648 $k@2731)) (= $t@2748 $t@2649)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2648 $k@2731) $k@2749) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2648 $k@2731) $k@2749) $Perm.No)))
(assert (> $t@2748 0))
(declare-const $k@2750 $Perm)
(assert ($Perm.isValidVar $k@2750))
(assert ($Perm.isReadVar $k@2750 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2650 $k@2732)) (= $t@2747 $t@2651)))
(push) ; 6
(assert (not (not (= (+ (- $k@2650 $k@2732) $k@2750) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2650 $k@2732) $k@2750) $Perm.No)))
(assert (not (= $t@2747 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2743 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2743 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 399] $t@2743 != Null
(assert (not (= $t@2743 $Ref.null)))
(declare-const $k@2751 $Perm)
(assert ($Perm.isValidVar $k@2751))
(assert ($Perm.isReadVar $k@2751 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2710 $k@2733)) (= $t@2739 $t@2711)))
(declare-const $k@2752 $Perm)
(assert ($Perm.isValidVar $k@2752))
(assert ($Perm.isReadVar $k@2752 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2712 $k@2734)) (= $t@2737 $t@2713)))
(declare-const $k@2753 $Perm)
(assert ($Perm.isValidVar $k@2753))
(assert ($Perm.isReadVar $k@2753 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2753 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2753 $k@2646))
(declare-const $k@2754 $Perm)
(assert ($Perm.isValidVar $k@2754))
(assert ($Perm.isReadVar $k@2754 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2754 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2754 (+ (- $k@2648 $k@2731) $k@2749)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(declare-const $k@2755 $Perm)
(assert ($Perm.isValidVar $k@2755))
(assert ($Perm.isReadVar $k@2755 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2755 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2755 (+ (- $k@2650 $k@2732) $k@2750)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2743 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 400] $t@2743 != Null
(declare-const $k@2756 $Perm)
(assert ($Perm.isValidVar $k@2756))
(assert ($Perm.isReadVar $k@2756 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2756 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2710 $k@2733) $k@2751) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2710 $k@2733) $k@2751) $Perm.No)))
(assert (< $k@2756 (+ (- $k@2710 $k@2733) $k@2751)))
(declare-const $k@2757 $Perm)
(assert ($Perm.isValidVar $k@2757))
(assert ($Perm.isReadVar $k@2757 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2757 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2712 $k@2734) $k@2752) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2712 $k@2734) $k@2752) $Perm.No)))
(assert (< $k@2757 (+ (- $k@2712 $k@2734) $k@2752)))
(pop) ; 7
; [dead else-branch 400] $t@2743 == Null
(pop) ; 6
(push) ; 6
; [else-branch 399] $t@2743 == Null
(assert (= $t@2743 $Ref.null))
(declare-const $k@2758 $Perm)
(assert ($Perm.isValidVar $k@2758))
(assert ($Perm.isReadVar $k@2758 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2710 $k@2733)) (= $t@2739 $t@2711)))
(declare-const $k@2759 $Perm)
(assert ($Perm.isValidVar $k@2759))
(assert ($Perm.isReadVar $k@2759 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2712 $k@2734)) (= $t@2737 $t@2713)))
(declare-const $k@2760 $Perm)
(assert ($Perm.isValidVar $k@2760))
(assert ($Perm.isReadVar $k@2760 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2760 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2760 $k@2646))
(declare-const $k@2761 $Perm)
(assert ($Perm.isValidVar $k@2761))
(assert ($Perm.isReadVar $k@2761 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2761 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2761 (+ (- $k@2648 $k@2731) $k@2749)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__capacity > 0
(declare-const $k@2762 $Perm)
(assert ($Perm.isValidVar $k@2762))
(assert ($Perm.isReadVar $k@2762 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2762 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2762 (+ (- $k@2650 $k@2732) $k@2750)))
; [eval] diz.LBQThread3a__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2743 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 401] $t@2743 != Null
(push) ; 7
; [else-branch 401] $t@2743 == Null
(declare-const $k@2763 $Perm)
(assert ($Perm.isValidVar $k@2763))
(assert ($Perm.isReadVar $k@2763 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2763 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2710 $k@2733) $k@2758) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2710 $k@2733) $k@2758) $Perm.No)))
(assert (< $k@2763 (+ (- $k@2710 $k@2733) $k@2758)))
(declare-const $k@2764 $Perm)
(assert ($Perm.isValidVar $k@2764))
(assert ($Perm.isReadVar $k@2764 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2764 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2712 $k@2734) $k@2759) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2712 $k@2734) $k@2759) $Perm.No)))
(assert (< $k@2764 (+ (- $k@2712 $k@2734) $k@2759)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3b__LBQThread1a ----------
(declare-const queue@2765 $Ref)
(declare-const sys__result@2766 $Ref)
(declare-const diz@2767 $Ref)
(declare-const __flatten_70@2768 $Ref)
(declare-const __flatten_130@2769 $Ref)
(push) ; 2
(assert (not (= queue@2765 $Ref.null)))
(declare-const $k@2770 $Perm)
(assert ($Perm.isValidVar $k@2770))
(assert ($Perm.isReadVar $k@2770 $Perm.Write))
(declare-const $t@2771 Int)
; [eval] queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2770 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2770 $Perm.No)))
(assert (> $t@2771 0))
(declare-const $k@2772 $Perm)
(assert ($Perm.isValidVar $k@2772))
(assert ($Perm.isReadVar $k@2772 $Perm.Write))
(declare-const $t@2773 $Ref)
(push) ; 3
(assert (not (not (= $k@2772 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2772 $Perm.No)))
(assert (not (= $t@2773 $Ref.null)))
(declare-const $t@2774 Int)
(declare-const $t@2775 $Ref)
; [eval] queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2775 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2775 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 402] $t@2775 != Null
(assert (not (= $t@2775 $Ref.null)))
(declare-const $t@2776 $Snap)
(declare-const $k@2777 $Perm)
(assert ($Perm.isValidVar $k@2777))
(assert ($Perm.isReadVar $k@2777 $Perm.Write))
(declare-const $t@2778 $Ref)
(declare-const $k@2779 $Perm)
(assert ($Perm.isValidVar $k@2779))
(assert ($Perm.isReadVar $k@2779 $Perm.Write))
(declare-const $t@2780 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2766 $Ref.null)))
(declare-const $k@2781 $Perm)
(assert ($Perm.isValidVar $k@2781))
(assert ($Perm.isReadVar $k@2781 $Perm.Write))
(declare-const $t@2782 $Ref)
(push) ; 5
(assert (not (not (= $k@2781 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2781 $Perm.No)))
(assert (not (= $t@2782 $Ref.null)))
(declare-const $k@2783 $Perm)
(assert ($Perm.isValidVar $k@2783))
(assert ($Perm.isReadVar $k@2783 $Perm.Write))
(declare-const $t@2784 Int)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2783 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2783 $Perm.No)))
(assert (> $t@2784 0))
(declare-const $k@2785 $Perm)
(assert ($Perm.isValidVar $k@2785))
(assert ($Perm.isReadVar $k@2785 $Perm.Write))
(declare-const $t@2786 $Ref)
(push) ; 5
(assert (not (not (= $k@2785 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2785 $Perm.No)))
(assert (not (= $t@2786 $Ref.null)))
(declare-const $t@2787 Int)
(declare-const $t@2788 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2788 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2788 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 403] $t@2788 != Null
(assert (not (= $t@2788 $Ref.null)))
(declare-const $t@2789 $Snap)
(declare-const $k@2790 $Perm)
(assert ($Perm.isValidVar $k@2790))
(assert ($Perm.isReadVar $k@2790 $Perm.Write))
(declare-const $t@2791 $Ref)
(declare-const $k@2792 $Perm)
(assert ($Perm.isValidVar $k@2792))
(assert ($Perm.isReadVar $k@2792 $Perm.Write))
(declare-const $t@2793 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 403] $t@2788 == Null
(assert (= $t@2788 $Ref.null))
(declare-const $k@2794 $Perm)
(assert ($Perm.isValidVar $k@2794))
(assert ($Perm.isReadVar $k@2794 $Perm.Write))
(declare-const $t@2795 $Ref)
(declare-const $k@2796 $Perm)
(assert ($Perm.isValidVar $k@2796))
(assert ($Perm.isReadVar $k@2796 $Perm.Write))
(declare-const $t@2797 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread3b__queue)
(declare-const diz@2798 $Ref)
(assert (not (= diz@2798 $Ref.null)))
(declare-const LBQThread3b__queue@2799 $Ref)
(assert (and
  (not (= queue@2765 diz@2798))
  (not (= sys__result@2766 diz@2798))
  (not (= __flatten_70@2768 diz@2798))
  (not (= __flatten_130@2769 diz@2798))
  (not (= $t@2773 diz@2798))
  (not (= $t@2775 diz@2798))
  (not (= LBQThread3b__queue@2799 diz@2798))
  (not (= $t@2778 diz@2798))
  (not (= $t@2780 diz@2798))))
; [exec]
; __flatten_70 := queue
; [exec]
; __flatten_130 := __flatten_70
; [exec]
; diz.LBQThread3b__queue := __flatten_130
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread3b__queue, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread3b__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread3b__queue.BlockingQueue__first, write) && ((sys__result.LBQThread3b__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread3b__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread3b__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2800 $Perm)
(assert ($Perm.isValidVar $k@2800))
(assert ($Perm.isReadVar $k@2800 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2800 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2800 $Perm.Write))
(declare-const $k@2801 $Perm)
(assert ($Perm.isValidVar $k@2801))
(assert ($Perm.isReadVar $k@2801 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2801 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2801 $k@2770))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@2802 $Perm)
(assert ($Perm.isValidVar $k@2802))
(assert ($Perm.isReadVar $k@2802 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2802 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2802 $k@2772))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2775 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 404] $t@2775 != Null
(declare-const $k@2803 $Perm)
(assert ($Perm.isValidVar $k@2803))
(assert ($Perm.isReadVar $k@2803 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2803 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2777 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2777 $Perm.No)))
(assert (< $k@2803 $k@2777))
(declare-const $k@2804 $Perm)
(assert ($Perm.isValidVar $k@2804))
(assert ($Perm.isReadVar $k@2804 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2804 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2779 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2779 $Perm.No)))
(assert (< $k@2804 $k@2779))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 404] $t@2775 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 402] $t@2775 == Null
(assert (= $t@2775 $Ref.null))
(declare-const $k@2805 $Perm)
(assert ($Perm.isValidVar $k@2805))
(assert ($Perm.isReadVar $k@2805 $Perm.Write))
(declare-const $t@2806 $Ref)
(declare-const $k@2807 $Perm)
(assert ($Perm.isValidVar $k@2807))
(assert ($Perm.isReadVar $k@2807 $Perm.Write))
(declare-const $t@2808 $Ref)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@2766 $Ref.null)))
(declare-const $k@2809 $Perm)
(assert ($Perm.isValidVar $k@2809))
(assert ($Perm.isReadVar $k@2809 $Perm.Write))
(declare-const $t@2810 $Ref)
(push) ; 5
(assert (not (not (= $k@2809 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2809 $Perm.No)))
(assert (not (= $t@2810 $Ref.null)))
(declare-const $k@2811 $Perm)
(assert ($Perm.isValidVar $k@2811))
(assert ($Perm.isReadVar $k@2811 $Perm.Write))
(declare-const $t@2812 Int)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2811 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2811 $Perm.No)))
(assert (> $t@2812 0))
(declare-const $k@2813 $Perm)
(assert ($Perm.isValidVar $k@2813))
(assert ($Perm.isReadVar $k@2813 $Perm.Write))
(declare-const $t@2814 $Ref)
(push) ; 5
(assert (not (not (= $k@2813 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2813 $Perm.No)))
(assert (not (= $t@2814 $Ref.null)))
(declare-const $t@2815 Int)
(declare-const $t@2816 $Ref)
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2816 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2816 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 405] $t@2816 != Null
(assert (not (= $t@2816 $Ref.null)))
(declare-const $t@2817 $Snap)
(declare-const $k@2818 $Perm)
(assert ($Perm.isValidVar $k@2818))
(assert ($Perm.isReadVar $k@2818 $Perm.Write))
(declare-const $t@2819 $Ref)
(declare-const $k@2820 $Perm)
(assert ($Perm.isValidVar $k@2820))
(assert ($Perm.isReadVar $k@2820 $Perm.Write))
(declare-const $t@2821 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 405] $t@2816 == Null
(assert (= $t@2816 $Ref.null))
(declare-const $k@2822 $Perm)
(assert ($Perm.isValidVar $k@2822))
(assert ($Perm.isReadVar $k@2822 $Perm.Write))
(declare-const $t@2823 $Ref)
(declare-const $k@2824 $Perm)
(assert ($Perm.isValidVar $k@2824))
(assert ($Perm.isReadVar $k@2824 $Perm.Write))
(declare-const $t@2825 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(LBQThread3b__queue)
(declare-const diz@2826 $Ref)
(assert (not (= diz@2826 $Ref.null)))
(declare-const LBQThread3b__queue@2827 $Ref)
(assert (and
  (not (= queue@2765 diz@2826))
  (not (= sys__result@2766 diz@2826))
  (not (= __flatten_70@2768 diz@2826))
  (not (= __flatten_130@2769 diz@2826))
  (not (= $t@2773 diz@2826))
  (not (= LBQThread3b__queue@2827 diz@2826))
  (not (= $t@2775 diz@2826))
  (not (= $t@2806 diz@2826))
  (not (= $t@2808 diz@2826))))
; [exec]
; __flatten_70 := queue
; [exec]
; __flatten_130 := __flatten_70
; [exec]
; diz.LBQThread3b__queue := __flatten_130
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LBQThread3b__queue, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__capacity, wildcard) && (sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0) && acc(sys__result.LBQThread3b__queue.BlockingQueue__count, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__count.AtomicInteger__ghostVal, write) && acc(sys__result.LBQThread3b__queue.BlockingQueue__first, write) && ((sys__result.LBQThread3b__queue.BlockingQueue__first != null) ==> acc(Node__state(sys__result.LBQThread3b__queue.BlockingQueue__first), write)) && acc(sys__result.LBQThread3b__queue.BlockingQueue__putLock, wildcard) && acc(sys__result.LBQThread3b__queue.BlockingQueue__takeLock, wildcard)
; [eval] sys__result != null
(declare-const $k@2828 $Perm)
(assert ($Perm.isValidVar $k@2828))
(assert ($Perm.isReadVar $k@2828 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2828 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2828 $Perm.Write))
(declare-const $k@2829 $Perm)
(assert ($Perm.isValidVar $k@2829))
(assert ($Perm.isReadVar $k@2829 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2829 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2829 $k@2770))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@2830 $Perm)
(assert ($Perm.isValidVar $k@2830))
(assert ($Perm.isReadVar $k@2830 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2830 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2830 $k@2772))
; [eval] sys__result.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2775 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 406] $t@2775 != Null
(push) ; 5
; [else-branch 406] $t@2775 == Null
(declare-const $k@2831 $Perm)
(assert ($Perm.isValidVar $k@2831))
(assert ($Perm.isReadVar $k@2831 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2831 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2805 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2805 $Perm.No)))
(assert (< $k@2831 $k@2805))
(declare-const $k@2832 $Perm)
(assert ($Perm.isValidVar $k@2832))
(assert ($Perm.isReadVar $k@2832 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2832 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2807 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2807 $Perm.No)))
(assert (< $k@2832 $k@2807))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LBQThread3b__run ----------
(declare-const diz@2833 $Ref)
(declare-const i@2834 Int)
(declare-const __flatten_71@2835 Int)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2833 $Ref.null)))
(declare-const $k@2836 $Perm)
(assert ($Perm.isValidVar $k@2836))
(assert ($Perm.isReadVar $k@2836 $Perm.Write))
(declare-const $t@2837 $Ref)
(push) ; 3
(assert (not (not (= $k@2836 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2836 $Perm.No)))
(assert (not (= $t@2837 $Ref.null)))
(declare-const $k@2838 $Perm)
(assert ($Perm.isValidVar $k@2838))
(assert ($Perm.isReadVar $k@2838 $Perm.Write))
(declare-const $t@2839 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 3
(assert (not (not (= $k@2838 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2838 $Perm.No)))
(assert (> $t@2839 0))
(declare-const $k@2840 $Perm)
(assert ($Perm.isValidVar $k@2840))
(assert ($Perm.isReadVar $k@2840 $Perm.Write))
(declare-const $t@2841 $Ref)
(push) ; 3
(assert (not (not (= $k@2840 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 3
(assert (not (= $k@2840 $Perm.No)))
(assert (not (= $t@2841 $Ref.null)))
(declare-const $t@2842 Int)
(declare-const $t@2843 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 3
(assert (not (= $t@2843 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@2843 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 407] $t@2843 != Null
(assert (not (= $t@2843 $Ref.null)))
(declare-const $t@2844 $Snap)
(declare-const $k@2845 $Perm)
(assert ($Perm.isValidVar $k@2845))
(assert ($Perm.isReadVar $k@2845 $Perm.Write))
(declare-const $t@2846 $Ref)
(declare-const $k@2847 $Perm)
(assert ($Perm.isValidVar $k@2847))
(assert ($Perm.isReadVar $k@2847 $Perm.Write))
(declare-const $t@2848 $Ref)
(push) ; 4
(declare-const $k@2849 $Perm)
(assert ($Perm.isValidVar $k@2849))
(assert ($Perm.isReadVar $k@2849 $Perm.Write))
(declare-const $t@2850 $Ref)
(push) ; 5
(assert (not (not (= $k@2849 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2849 $Perm.No)))
(assert (not (= $t@2850 $Ref.null)))
(declare-const $k@2851 $Perm)
(assert ($Perm.isValidVar $k@2851))
(assert ($Perm.isReadVar $k@2851 $Perm.Write))
(declare-const $t@2852 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2851 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2851 $Perm.No)))
(assert (> $t@2852 0))
(declare-const $k@2853 $Perm)
(assert ($Perm.isValidVar $k@2853))
(assert ($Perm.isReadVar $k@2853 $Perm.Write))
(declare-const $t@2854 $Ref)
(push) ; 5
(assert (not (not (= $k@2853 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2853 $Perm.No)))
(assert (not (= $t@2854 $Ref.null)))
(declare-const $t@2855 Int)
(declare-const $t@2856 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2856 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2856 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 408] $t@2856 != Null
(assert (not (= $t@2856 $Ref.null)))
(declare-const $t@2857 $Snap)
(declare-const $k@2858 $Perm)
(assert ($Perm.isValidVar $k@2858))
(assert ($Perm.isReadVar $k@2858 $Perm.Write))
(declare-const $t@2859 $Ref)
(declare-const $k@2860 $Perm)
(assert ($Perm.isValidVar $k@2860))
(assert ($Perm.isReadVar $k@2860 $Perm.Write))
(declare-const $t@2861 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 408] $t@2856 == Null
(assert (= $t@2856 $Ref.null))
(declare-const $k@2862 $Perm)
(assert ($Perm.isValidVar $k@2862))
(assert ($Perm.isReadVar $k@2862 $Perm.Write))
(declare-const $t@2863 $Ref)
(declare-const $k@2864 $Perm)
(assert ($Perm.isValidVar $k@2864))
(assert ($Perm.isReadVar $k@2864 $Perm.Write))
(declare-const $t@2865 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_71 := BlockingQueue__take(diz.LBQThread3b__queue)
; [eval] diz != null
(declare-const $k@2866 $Perm)
(assert ($Perm.isValidVar $k@2866))
(assert ($Perm.isReadVar $k@2866 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2866 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2866 $k@2838))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2867 $Perm)
(assert ($Perm.isValidVar $k@2867))
(assert ($Perm.isReadVar $k@2867 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2867 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2867 $k@2840))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2843 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 409] $t@2843 != Null
(declare-const $k@2868 $Perm)
(assert ($Perm.isValidVar $k@2868))
(assert ($Perm.isReadVar $k@2868 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2868 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2845 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2845 $Perm.No)))
(assert (< $k@2868 $k@2845))
(declare-const $k@2869 $Perm)
(assert ($Perm.isValidVar $k@2869))
(assert ($Perm.isReadVar $k@2869 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2869 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2847 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2847 $Perm.No)))
(assert (< $k@2869 $k@2847))
(declare-const sys__result@2870 Int)
(declare-const $t@2871 $Snap)
(declare-const $t@2872 $Snap)
(declare-const $t@2873 $Ref)
(assert (= $t@2871 ($Snap.combine $t@2872 ($SortWrappers.$RefTo$Snap $t@2873))))
(declare-const $t@2874 $Snap)
(declare-const $t@2875 $Ref)
(assert (= $t@2872 ($Snap.combine $t@2874 ($SortWrappers.$RefTo$Snap $t@2875))))
(declare-const $t@2876 $Snap)
(declare-const $t@2877 $Snap)
(assert (= $t@2874 ($Snap.combine $t@2876 $t@2877)))
(declare-const $t@2878 $Snap)
(declare-const $t@2879 $Ref)
(assert (= $t@2876 ($Snap.combine $t@2878 ($SortWrappers.$RefTo$Snap $t@2879))))
(declare-const $t@2880 $Snap)
(declare-const $t@2881 Int)
(assert (= $t@2878 ($Snap.combine $t@2880 ($SortWrappers.IntTo$Snap $t@2881))))
(declare-const $t@2882 Int)
(declare-const $t@2883 $Ref)
(assert (=
  $t@2880
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2882)
    ($SortWrappers.$RefTo$Snap $t@2883))))
(declare-const $t@2884 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2882)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2884) $Snap.unit)))
(declare-const $k@2885 $Perm)
(assert ($Perm.isValidVar $k@2885))
(assert ($Perm.isReadVar $k@2885 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2838 $k@2866)) (= $t@2884 $t@2839)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2838 $k@2866) $k@2885) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2838 $k@2866) $k@2885) $Perm.No)))
(assert (> $t@2884 0))
(declare-const $k@2886 $Perm)
(assert ($Perm.isValidVar $k@2886))
(assert ($Perm.isReadVar $k@2886 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2840 $k@2867)) (= $t@2883 $t@2841)))
(push) ; 6
(assert (not (not (= (+ (- $k@2840 $k@2867) $k@2886) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2840 $k@2867) $k@2886) $Perm.No)))
(assert (not (= $t@2883 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2879 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2879 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 410] $t@2879 != Null
(assert (not (= $t@2879 $Ref.null)))
(declare-const $k@2887 $Perm)
(assert ($Perm.isValidVar $k@2887))
(assert ($Perm.isReadVar $k@2887 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2845 $k@2868)) (= $t@2875 $t@2846)))
(declare-const $k@2888 $Perm)
(assert ($Perm.isValidVar $k@2888))
(assert ($Perm.isReadVar $k@2888 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2847 $k@2869)) (= $t@2873 $t@2848)))
; [exec]
; i := __flatten_71
(declare-const $k@2889 $Perm)
(assert ($Perm.isValidVar $k@2889))
(assert ($Perm.isReadVar $k@2889 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2889 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2889 $k@2836))
(declare-const $k@2890 $Perm)
(assert ($Perm.isValidVar $k@2890))
(assert ($Perm.isReadVar $k@2890 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2890 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2890 (+ (- $k@2838 $k@2866) $k@2885)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@2891 $Perm)
(assert ($Perm.isValidVar $k@2891))
(assert ($Perm.isReadVar $k@2891 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2891 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2891 (+ (- $k@2840 $k@2867) $k@2886)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2879 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 411] $t@2879 != Null
(declare-const $k@2892 $Perm)
(assert ($Perm.isValidVar $k@2892))
(assert ($Perm.isReadVar $k@2892 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2892 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2845 $k@2868) $k@2887) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2845 $k@2868) $k@2887) $Perm.No)))
(assert (< $k@2892 (+ (- $k@2845 $k@2868) $k@2887)))
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
(assert (not (not (= (+ (- $k@2847 $k@2869) $k@2888) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2847 $k@2869) $k@2888) $Perm.No)))
(assert (< $k@2893 (+ (- $k@2847 $k@2869) $k@2888)))
(pop) ; 7
; [dead else-branch 411] $t@2879 == Null
(pop) ; 6
(push) ; 6
; [else-branch 410] $t@2879 == Null
(assert (= $t@2879 $Ref.null))
(declare-const $k@2894 $Perm)
(assert ($Perm.isValidVar $k@2894))
(assert ($Perm.isReadVar $k@2894 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2845 $k@2868)) (= $t@2875 $t@2846)))
(declare-const $k@2895 $Perm)
(assert ($Perm.isValidVar $k@2895))
(assert ($Perm.isReadVar $k@2895 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2847 $k@2869)) (= $t@2873 $t@2848)))
; [exec]
; i := __flatten_71
(declare-const $k@2896 $Perm)
(assert ($Perm.isValidVar $k@2896))
(assert ($Perm.isReadVar $k@2896 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2896 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2896 $k@2836))
(declare-const $k@2897 $Perm)
(assert ($Perm.isValidVar $k@2897))
(assert ($Perm.isReadVar $k@2897 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2897 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2897 (+ (- $k@2838 $k@2866) $k@2885)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@2898 $Perm)
(assert ($Perm.isValidVar $k@2898))
(assert ($Perm.isReadVar $k@2898 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2898 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2898 (+ (- $k@2840 $k@2867) $k@2886)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2879 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 412] $t@2879 != Null
(push) ; 7
; [else-branch 412] $t@2879 == Null
(declare-const $k@2899 $Perm)
(assert ($Perm.isValidVar $k@2899))
(assert ($Perm.isReadVar $k@2899 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2899 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2845 $k@2868) $k@2894) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2845 $k@2868) $k@2894) $Perm.No)))
(assert (< $k@2899 (+ (- $k@2845 $k@2868) $k@2894)))
(declare-const $k@2900 $Perm)
(assert ($Perm.isValidVar $k@2900))
(assert ($Perm.isReadVar $k@2900 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2900 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2847 $k@2869) $k@2895) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2847 $k@2869) $k@2895) $Perm.No)))
(assert (< $k@2900 (+ (- $k@2847 $k@2869) $k@2895)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
; [dead else-branch 409] $t@2843 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 407] $t@2843 == Null
(assert (= $t@2843 $Ref.null))
(declare-const $k@2901 $Perm)
(assert ($Perm.isValidVar $k@2901))
(assert ($Perm.isReadVar $k@2901 $Perm.Write))
(declare-const $t@2902 $Ref)
(declare-const $k@2903 $Perm)
(assert ($Perm.isValidVar $k@2903))
(assert ($Perm.isReadVar $k@2903 $Perm.Write))
(declare-const $t@2904 $Ref)
(push) ; 4
(declare-const $k@2905 $Perm)
(assert ($Perm.isValidVar $k@2905))
(assert ($Perm.isReadVar $k@2905 $Perm.Write))
(declare-const $t@2906 $Ref)
(push) ; 5
(assert (not (not (= $k@2905 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2905 $Perm.No)))
(assert (not (= $t@2906 $Ref.null)))
(declare-const $k@2907 $Perm)
(assert ($Perm.isValidVar $k@2907))
(assert ($Perm.isReadVar $k@2907 $Perm.Write))
(declare-const $t@2908 Int)
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(push) ; 5
(assert (not (not (= $k@2907 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2907 $Perm.No)))
(assert (> $t@2908 0))
(declare-const $k@2909 $Perm)
(assert ($Perm.isValidVar $k@2909))
(assert ($Perm.isReadVar $k@2909 $Perm.Write))
(declare-const $t@2910 $Ref)
(push) ; 5
(assert (not (not (= $k@2909 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@2909 $Perm.No)))
(assert (not (= $t@2910 $Ref.null)))
(declare-const $t@2911 Int)
(declare-const $t@2912 $Ref)
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 5
(assert (not (= $t@2912 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@2912 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 413] $t@2912 != Null
(assert (not (= $t@2912 $Ref.null)))
(declare-const $t@2913 $Snap)
(declare-const $k@2914 $Perm)
(assert ($Perm.isValidVar $k@2914))
(assert ($Perm.isReadVar $k@2914 $Perm.Write))
(declare-const $t@2915 $Ref)
(declare-const $k@2916 $Perm)
(assert ($Perm.isValidVar $k@2916))
(assert ($Perm.isReadVar $k@2916 $Perm.Write))
(declare-const $t@2917 $Ref)
(pop) ; 5
(push) ; 5
; [else-branch 413] $t@2912 == Null
(assert (= $t@2912 $Ref.null))
(declare-const $k@2918 $Perm)
(assert ($Perm.isValidVar $k@2918))
(assert ($Perm.isReadVar $k@2918 $Perm.Write))
(declare-const $t@2919 $Ref)
(declare-const $k@2920 $Perm)
(assert ($Perm.isValidVar $k@2920))
(assert ($Perm.isReadVar $k@2920 $Perm.Write))
(declare-const $t@2921 $Ref)
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; __flatten_71 := BlockingQueue__take(diz.LBQThread3b__queue)
; [eval] diz != null
(declare-const $k@2922 $Perm)
(assert ($Perm.isValidVar $k@2922))
(assert ($Perm.isReadVar $k@2922 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2922 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2922 $k@2838))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2923 $Perm)
(assert ($Perm.isValidVar $k@2923))
(assert ($Perm.isReadVar $k@2923 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2923 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2923 $k@2840))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2843 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 414] $t@2843 != Null
(push) ; 5
; [else-branch 414] $t@2843 == Null
(declare-const $k@2924 $Perm)
(assert ($Perm.isValidVar $k@2924))
(assert ($Perm.isReadVar $k@2924 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2924 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2901 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2901 $Perm.No)))
(assert (< $k@2924 $k@2901))
(declare-const $k@2925 $Perm)
(assert ($Perm.isValidVar $k@2925))
(assert ($Perm.isReadVar $k@2925 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2925 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2903 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2903 $Perm.No)))
(assert (< $k@2925 $k@2903))
(declare-const sys__result@2926 Int)
(declare-const $t@2927 $Snap)
(declare-const $t@2928 $Snap)
(declare-const $t@2929 $Ref)
(assert (= $t@2927 ($Snap.combine $t@2928 ($SortWrappers.$RefTo$Snap $t@2929))))
(declare-const $t@2930 $Snap)
(declare-const $t@2931 $Ref)
(assert (= $t@2928 ($Snap.combine $t@2930 ($SortWrappers.$RefTo$Snap $t@2931))))
(declare-const $t@2932 $Snap)
(declare-const $t@2933 $Snap)
(assert (= $t@2930 ($Snap.combine $t@2932 $t@2933)))
(declare-const $t@2934 $Snap)
(declare-const $t@2935 $Ref)
(assert (= $t@2932 ($Snap.combine $t@2934 ($SortWrappers.$RefTo$Snap $t@2935))))
(declare-const $t@2936 $Snap)
(declare-const $t@2937 Int)
(assert (= $t@2934 ($Snap.combine $t@2936 ($SortWrappers.IntTo$Snap $t@2937))))
(declare-const $t@2938 Int)
(declare-const $t@2939 $Ref)
(assert (=
  $t@2936
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2938)
    ($SortWrappers.$RefTo$Snap $t@2939))))
(declare-const $t@2940 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2938)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2940) $Snap.unit)))
(declare-const $k@2941 $Perm)
(assert ($Perm.isValidVar $k@2941))
(assert ($Perm.isReadVar $k@2941 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2838 $k@2922)) (= $t@2940 $t@2839)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2838 $k@2922) $k@2941) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2838 $k@2922) $k@2941) $Perm.No)))
(assert (> $t@2940 0))
(declare-const $k@2942 $Perm)
(assert ($Perm.isValidVar $k@2942))
(assert ($Perm.isReadVar $k@2942 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2840 $k@2923)) (= $t@2939 $t@2841)))
(push) ; 6
(assert (not (not (= (+ (- $k@2840 $k@2923) $k@2942) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2840 $k@2923) $k@2942) $Perm.No)))
(assert (not (= $t@2939 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@2935 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@2935 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 415] $t@2935 != Null
(assert (not (= $t@2935 $Ref.null)))
(declare-const $k@2943 $Perm)
(assert ($Perm.isValidVar $k@2943))
(assert ($Perm.isReadVar $k@2943 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2901 $k@2924)) (= $t@2931 $t@2902)))
(declare-const $k@2944 $Perm)
(assert ($Perm.isValidVar $k@2944))
(assert ($Perm.isReadVar $k@2944 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2903 $k@2925)) (= $t@2929 $t@2904)))
; [exec]
; i := __flatten_71
(declare-const $k@2945 $Perm)
(assert ($Perm.isValidVar $k@2945))
(assert ($Perm.isReadVar $k@2945 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2945 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2945 $k@2836))
(declare-const $k@2946 $Perm)
(assert ($Perm.isValidVar $k@2946))
(assert ($Perm.isReadVar $k@2946 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2946 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2946 (+ (- $k@2838 $k@2922) $k@2941)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@2947 $Perm)
(assert ($Perm.isValidVar $k@2947))
(assert ($Perm.isReadVar $k@2947 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2947 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2947 (+ (- $k@2840 $k@2923) $k@2942)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (= $t@2935 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 416] $t@2935 != Null
(declare-const $k@2948 $Perm)
(assert ($Perm.isValidVar $k@2948))
(assert ($Perm.isReadVar $k@2948 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2948 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2901 $k@2924) $k@2943) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2901 $k@2924) $k@2943) $Perm.No)))
(assert (< $k@2948 (+ (- $k@2901 $k@2924) $k@2943)))
(declare-const $k@2949 $Perm)
(assert ($Perm.isValidVar $k@2949))
(assert ($Perm.isReadVar $k@2949 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2949 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2903 $k@2925) $k@2944) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2903 $k@2925) $k@2944) $Perm.No)))
(assert (< $k@2949 (+ (- $k@2903 $k@2925) $k@2944)))
(pop) ; 7
; [dead else-branch 416] $t@2935 == Null
(pop) ; 6
(push) ; 6
; [else-branch 415] $t@2935 == Null
(assert (= $t@2935 $Ref.null))
(declare-const $k@2950 $Perm)
(assert ($Perm.isValidVar $k@2950))
(assert ($Perm.isReadVar $k@2950 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2901 $k@2924)) (= $t@2931 $t@2902)))
(declare-const $k@2951 $Perm)
(assert ($Perm.isValidVar $k@2951))
(assert ($Perm.isReadVar $k@2951 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2903 $k@2925)) (= $t@2929 $t@2904)))
; [exec]
; i := __flatten_71
(declare-const $k@2952 $Perm)
(assert ($Perm.isValidVar $k@2952))
(assert ($Perm.isReadVar $k@2952 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2952 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2952 $k@2836))
(declare-const $k@2953 $Perm)
(assert ($Perm.isValidVar $k@2953))
(assert ($Perm.isReadVar $k@2953 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2953 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2953 (+ (- $k@2838 $k@2922) $k@2941)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__capacity > 0
(declare-const $k@2954 $Perm)
(assert ($Perm.isValidVar $k@2954))
(assert ($Perm.isReadVar $k@2954 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@2954 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@2954 (+ (- $k@2840 $k@2923) $k@2942)))
; [eval] diz.LBQThread3b__queue.BlockingQueue__first != null
(push) ; 7
(assert (not (not (= $t@2935 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 417] $t@2935 != Null
(push) ; 7
; [else-branch 417] $t@2935 == Null
(declare-const $k@2955 $Perm)
(assert ($Perm.isValidVar $k@2955))
(assert ($Perm.isReadVar $k@2955 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2955 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2901 $k@2924) $k@2950) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2901 $k@2924) $k@2950) $Perm.No)))
(assert (< $k@2955 (+ (- $k@2901 $k@2924) $k@2950)))
(declare-const $k@2956 $Perm)
(assert ($Perm.isValidVar $k@2956))
(assert ($Perm.isReadVar $k@2956 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@2956 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= (+ (- $k@2903 $k@2925) $k@2951) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= (+ (- $k@2903 $k@2925) $k@2951) $Perm.No)))
(assert (< $k@2956 (+ (- $k@2903 $k@2925) $k@2951)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Test__testEmpty ----------
(declare-const diz@2957 $Ref)
(declare-const queue@2958 $Ref)
(declare-const __flatten_72@2959 $Ref)
(declare-const i@2960 $Ref)
(declare-const __flatten_73@2961 $Ref)
(declare-const j@2962 $Ref)
(declare-const __flatten_74@2963 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2957 $Ref.null)))
(push) ; 3
(pop) ; 3
(push) ; 3
; [exec]
; __flatten_72 := BlockingQueue__BlockingQueue(10)
; [eval] capacity > 0
(declare-const sys__result@2964 $Ref)
(declare-const $t@2965 $Snap)
(declare-const $t@2966 $Snap)
(assert (= $t@2965 ($Snap.combine $t@2966 $Snap.unit)))
(declare-const $t@2967 $Snap)
(assert (= $t@2966 ($Snap.combine $t@2967 $Snap.unit)))
(declare-const $t@2968 $Snap)
(assert (= $t@2967 ($Snap.combine $t@2968 $Snap.unit)))
(declare-const $t@2969 $Snap)
(declare-const $t@2970 $Ref)
(assert (= $t@2968 ($Snap.combine $t@2969 ($SortWrappers.$RefTo$Snap $t@2970))))
(declare-const $t@2971 $Snap)
(declare-const $t@2972 $Ref)
(assert (= $t@2969 ($Snap.combine $t@2971 ($SortWrappers.$RefTo$Snap $t@2972))))
(declare-const $t@2973 $Snap)
(declare-const $t@2974 $Snap)
(assert (= $t@2971 ($Snap.combine $t@2973 $t@2974)))
(declare-const $t@2975 $Snap)
(declare-const $t@2976 $Ref)
(assert (= $t@2973 ($Snap.combine $t@2975 ($SortWrappers.$RefTo$Snap $t@2976))))
(declare-const $t@2977 $Snap)
(declare-const $t@2978 Int)
(assert (= $t@2975 ($Snap.combine $t@2977 ($SortWrappers.IntTo$Snap $t@2978))))
(declare-const $t@2979 Int)
(declare-const $t@2980 $Ref)
(assert (=
  $t@2977
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@2979)
    ($SortWrappers.$RefTo$Snap $t@2980))))
(declare-const $t@2981 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2979)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@2981) $Snap.unit)))
(declare-const $t@2982 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@2981)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@2982))))
; [eval] sys__result != null
(assert (not (= sys__result@2964 $Ref.null)))
(declare-const $k@2983 $Perm)
(assert ($Perm.isValidVar $k@2983))
(assert ($Perm.isReadVar $k@2983 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity > 0
(push) ; 4
(assert (not (not (= $k@2983 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2983 $Perm.No)))
(assert (> $t@2982 0))
(declare-const $k@2984 $Perm)
(assert ($Perm.isValidVar $k@2984))
(assert ($Perm.isReadVar $k@2984 $Perm.Write))
(push) ; 4
(assert (not (not (= $k@2984 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 4
(assert (not (= $k@2984 $Perm.No)))
(assert (not (= $t@2980 $Ref.null)))
; [eval] sys__result.BlockingQueue__first != null
(push) ; 4
(assert (not (= $t@2976 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@2976 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 418] $t@2976 != Null
(assert (not (= $t@2976 $Ref.null)))
(declare-const $k@2985 $Perm)
(assert ($Perm.isValidVar $k@2985))
(assert ($Perm.isReadVar $k@2985 $Perm.Write))
(declare-const $k@2986 $Perm)
(assert ($Perm.isValidVar $k@2986))
(assert ($Perm.isReadVar $k@2986 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@2982 10))
; [eval] sys__result.BlockingQueue__first == null
(assert (= $t@2976 $Ref.null))
; [eval] sys__result.BlockingQueue__count.AtomicInteger__ghostVal == 0
(assert (= $t@2978 0))
; [exec]
; queue := __flatten_72
; [exec]
; __flatten_73 := BlockingQueue__peek(queue)
; [eval] diz != null
(declare-const $k@2987 $Perm)
(assert ($Perm.isValidVar $k@2987))
(assert ($Perm.isReadVar $k@2987 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2987 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2987 $k@2983))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2988 $Perm)
(assert ($Perm.isValidVar $k@2988))
(assert ($Perm.isReadVar $k@2988 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2988 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2988 $k@2984))
; [eval] diz.BlockingQueue__first != null
; [dead then-branch 419] $t@2976 != Null
; [dead else-branch 419] $t@2976 == Null
(pop) ; 4
(push) ; 4
; [else-branch 418] $t@2976 == Null
(assert (= $t@2976 $Ref.null))
(declare-const $k@2989 $Perm)
(assert ($Perm.isValidVar $k@2989))
(assert ($Perm.isReadVar $k@2989 $Perm.Write))
(declare-const $k@2990 $Perm)
(assert ($Perm.isValidVar $k@2990))
(assert ($Perm.isReadVar $k@2990 $Perm.Write))
; [eval] sys__result.BlockingQueue__capacity == capacity
(assert (= $t@2982 10))
; [eval] sys__result.BlockingQueue__first == null
; [eval] sys__result.BlockingQueue__count.AtomicInteger__ghostVal == 0
(assert (= $t@2978 0))
; [exec]
; queue := __flatten_72
; [exec]
; __flatten_73 := BlockingQueue__peek(queue)
; [eval] diz != null
(declare-const $k@2991 $Perm)
(assert ($Perm.isValidVar $k@2991))
(assert ($Perm.isReadVar $k@2991 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2991 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2991 $k@2983))
; [eval] diz.BlockingQueue__capacity > 0
(declare-const $k@2992 $Perm)
(assert ($Perm.isValidVar $k@2992))
(assert ($Perm.isReadVar $k@2992 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@2992 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@2992 $k@2984))
; [eval] diz.BlockingQueue__first != null
(push) ; 5
(assert (not (not (= $t@2976 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 420] $t@2976 != Null
(push) ; 5
; [else-branch 420] $t@2976 == Null
(declare-const $k@2993 $Perm)
(assert ($Perm.isValidVar $k@2993))
(assert ($Perm.isReadVar $k@2993 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2993 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2989 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2989 $Perm.No)))
(assert (< $k@2993 $k@2989))
(declare-const $k@2994 $Perm)
(assert ($Perm.isValidVar $k@2994))
(assert ($Perm.isReadVar $k@2994 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@2994 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@2990 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@2990 $Perm.No)))
(assert (< $k@2994 $k@2990))
(declare-const sys__result@2995 $Ref)
(declare-const $t@2996 $Snap)
(declare-const $t@2997 $Snap)
(declare-const $t@2998 $Ref)
(assert (= $t@2996 ($Snap.combine $t@2997 ($SortWrappers.$RefTo$Snap $t@2998))))
(declare-const $t@2999 $Snap)
(declare-const $t@3000 $Ref)
(assert (= $t@2997 ($Snap.combine $t@2999 ($SortWrappers.$RefTo$Snap $t@3000))))
(declare-const $t@3001 $Snap)
(declare-const $t@3002 $Snap)
(assert (= $t@2999 ($Snap.combine $t@3001 $t@3002)))
(declare-const $t@3003 $Snap)
(declare-const $t@3004 $Ref)
(assert (= $t@3001 ($Snap.combine $t@3003 ($SortWrappers.$RefTo$Snap $t@3004))))
(declare-const $t@3005 $Snap)
(declare-const $t@3006 Int)
(assert (= $t@3003 ($Snap.combine $t@3005 ($SortWrappers.IntTo$Snap $t@3006))))
(declare-const $t@3007 Int)
(declare-const $t@3008 $Ref)
(assert (=
  $t@3005
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@3007)
    ($SortWrappers.$RefTo$Snap $t@3008))))
(declare-const $t@3009 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@3007)
  ($Snap.combine ($SortWrappers.IntTo$Snap $t@3009) $Snap.unit)))
(declare-const $k@3010 $Perm)
(assert ($Perm.isValidVar $k@3010))
(assert ($Perm.isReadVar $k@3010 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2983 $k@2991)) (= $t@3009 $t@2982)))
; [eval] diz.BlockingQueue__capacity > 0
(push) ; 6
(assert (not (not (= (+ (- $k@2983 $k@2991) $k@3010) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2983 $k@2991) $k@3010) $Perm.No)))
(assert (> $t@3009 0))
(declare-const $k@3011 $Perm)
(assert ($Perm.isValidVar $k@3011))
(assert ($Perm.isReadVar $k@3011 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2984 $k@2992)) (= $t@3008 $t@2980)))
(push) ; 6
(assert (not (not (= (+ (- $k@2984 $k@2992) $k@3011) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= (+ (- $k@2984 $k@2992) $k@3011) $Perm.No)))
(assert (not (= $t@3008 $Ref.null)))
; [eval] diz.BlockingQueue__first != null
(push) ; 6
(assert (not (= $t@3004 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@3004 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 421] $t@3004 != Null
(assert (not (= $t@3004 $Ref.null)))
(declare-const $k@3012 $Perm)
(assert ($Perm.isValidVar $k@3012))
(assert ($Perm.isReadVar $k@3012 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2989 $k@2993)) (= $t@3000 $t@2972)))
(declare-const $k@3013 $Perm)
(assert ($Perm.isValidVar $k@3013))
(assert ($Perm.isReadVar $k@3013 $Perm.Write))
(assert (implies (< $Perm.No (- $k@2990 $k@2994)) (= $t@2998 $t@2970)))
; [exec]
; i := __flatten_73
; [exec]
; assert i == null
; [eval] i == null
(push) ; 7
(assert (not (= sys__result@2995 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(pop) ; 7
(assert (or
  (= $Perm.Write (+ (- $k@2983 $k@2991) $k@3010))
  (< (+ (- $k@2983 $k@2991) $k@3010) $Perm.Write)))
(assert (or
  (= $Perm.Write (+ (- $k@2984 $k@2992) $k@3011))
  (< (+ (- $k@2984 $k@2992) $k@3011) $Perm.Write)))
(assert (or
  (= $Perm.Write (+ (- $k@2989 $k@2993) $k@3012))
  (< (+ (- $k@2989 $k@2993) $k@3012) $Perm.Write)))
(assert (or
  (= $Perm.Write (+ (- $k@2990 $k@2994) $k@3013))
  (< (+ (- $k@2990 $k@2994) $k@3013) $Perm.Write)))
; [eval] i == null
(push) ; 7
(assert (not (= sys__result@2995 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(pop) ; 6
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Test__Test ----------
(declare-const sys__result@3014 $Ref)
(declare-const diz@3015 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@3014 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new()
(declare-const diz@3016 $Ref)
(assert (not (= diz@3016 $Ref.null)))
(assert (not (= sys__result@3014 diz@3016)))
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
