(get-info :version)
; (:version "4.3.2")
; Input file is <unknown>
; Started: 2015-06-30 16:02:21
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
(declare-fun $Queue__contents ($Snap $Ref) $Seq<Int>)
(declare-fun $Queue__contents$ ($Snap $Ref) $Seq<Int>)
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
; ---------- FUNCTION Queue__contents (specs well-defined) ----------
(declare-const result@9 $Seq<Int>)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2 $Ref.null)))
; [eval] diz.Queue__first != null
(push) ; 3
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 4] Second(First(First(First(First(First(First(s@$))))))) != Null
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
    $Ref.null)))
(declare-const $k@10 $Perm)
(assert ($Perm.isValidVar $k@10))
(assert ($Perm.isReadVar $k@10 $Perm.Write))
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null)))
(pop) ; 3
(push) ; 3
; [else-branch 4] Second(First(First(First(First(First(First(s@$))))))) == Null
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
  $Ref.null))
(declare-const $k@11 $Perm)
(assert ($Perm.isValidVar $k@11))
(assert ($Perm.isReadVar $k@11 $Perm.Write))
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null)))
(pop) ; 3
(pop) ; 2
(assert (forall ((s@$ $Snap) (diz@2 $Ref)) (!
  ($Seq.equal ($Queue__contents$ s@$ diz@2) ($Queue__contents s@$ diz@2))
  :pattern (($Queue__contents s@$ diz@2)))))
(assert true)
; ---------- FUNCTION Queue__contents----------
(declare-const result@12 $Seq<Int>)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@2 $Ref.null)))
; [eval] diz.Queue__first != null
(push) ; 3
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 5] Second(First(First(First(First(First(First(s@$))))))) != Null
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
    $Ref.null)))
(declare-const $k@13 $Perm)
(assert ($Perm.isValidVar $k@13))
(assert ($Perm.isReadVar $k@13 $Perm.Write))
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null)))
; [eval] (diz.Queue__first == null ? Seq[Int]() : Node__contents(diz.Queue__first))
; [eval] diz.Queue__first == null
(push) ; 4
(assert (not (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
  $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 6] Second(First(First(First(First(First(First(s@$))))))) == Null
(push) ; 4
; [else-branch 6] Second(First(First(First(First(First(First(s@$))))))) != Null
; [eval] Node__contents(diz.Queue__first)
; [eval] diz.Queue__first != null
(pop) ; 4
(declare-const $deadThen@14 $Seq<Int>)
(pop) ; 3
(push) ; 3
; [else-branch 5] Second(First(First(First(First(First(First(s@$))))))) == Null
(assert (=
  ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
  $Ref.null))
(declare-const $k@15 $Perm)
(assert ($Perm.isValidVar $k@15))
(assert ($Perm.isReadVar $k@15 $Perm.Write))
(assert (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first s@$)))))
    $Ref.null)))
; [eval] (diz.Queue__first == null ? Seq[Int]() : Node__contents(diz.Queue__first))
; [eval] diz.Queue__first == null
(push) ; 4
(assert (not (not
  (=
    ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
    $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 7] Second(First(First(First(First(First(First(s@$))))))) == Null
; [eval] Seq[Int]()
(pop) ; 4
; [dead else-branch 7] Second(First(First(First(First(First(First(s@$))))))) != Null
(declare-const $deadElse@16 $Seq<Int>)
(pop) ; 3
(pop) ; 2
(assert (forall ((s@$ $Snap) (diz@2 $Ref)) (!
  (implies
    (not (= diz@2 $Ref.null))
    ($Seq.equal
      ($Queue__contents s@$ diz@2)
      (ite
        (=
          ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))
          $Ref.null)
        $Seq.empty<Int>
        ($Node__contents ($Snap.combine
          $Snap.unit
          ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))) ($SortWrappers.$SnapTo$Ref ($Snap.second ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first ($Snap.first s@$))))))))))))
  :pattern (($Queue__contents s@$ diz@2)))))
; ---------- LockableInteger__lock_held ----------
(declare-const diz@17 $Ref)
; ---------- Node__state ----------
(declare-const diz@18 $Ref)
(push) ; 2
(declare-const $t@19 $Snap)
(declare-const $t@20 $Snap)
(declare-const $t@21 $Snap)
(assert (= $t@19 ($Snap.combine $t@20 $t@21)))
(declare-const $t@22 Int)
(declare-const $t@23 $Ref)
(assert (=
  $t@20
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@22)
    ($SortWrappers.$RefTo$Snap $t@23))))
(assert (not (= diz@18 $Ref.null)))
(declare-const $k@24 $Perm)
(assert ($Perm.isValidVar $k@24))
(assert ($Perm.isReadVar $k@24 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 3
(assert (not (= $t@23 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@23 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 8] $t@23 != Null
(assert (not (= $t@23 $Ref.null)))
(pop) ; 3
(push) ; 3
; [else-branch 8] $t@23 == Null
(assert (= $t@23 $Ref.null))
(pop) ; 3
(pop) ; 2
; ---------- Queue__lock_held ----------
(declare-const diz@25 $Ref)
; ---------- LockSymbol__lock_held ----------
(declare-const diz@26 $Ref)
; ---------- LockableInteger__LockableInteger ----------
(declare-const val@27 Int)
(declare-const sys__result@28 $Ref)
(declare-const diz@29 $Ref)
(declare-const __flatten_1@30 Int)
(declare-const __flatten_22@31 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@28 $Ref.null)))
(declare-const $t@32 Int)
; [eval] sys__result.LockableInteger__val == val
(assert (= $t@32 val@27))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LockableInteger__val)
(declare-const diz@33 $Ref)
(assert (not (= diz@33 $Ref.null)))
(declare-const LockableInteger__val@34 Int)
(assert (not (= sys__result@28 diz@33)))
; [exec]
; __flatten_1 := val
; [exec]
; __flatten_22 := __flatten_1
; [exec]
; diz.LockableInteger__val := __flatten_22
; [exec]
; exhale acc(diz.LockableInteger__val, write)
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.LockableInteger__val, write) && (sys__result.LockableInteger__val == val)
; [eval] sys__result != null
(check-sat)
; unknown
(push) ; 4
(pop) ; 4
(check-sat)
; unknown
(pop) ; 3
(pop) ; 2
; ---------- Node__Node ----------
(declare-const val@35 Int)
(declare-const next@36 $Ref)
(declare-const sys__result@37 $Ref)
(declare-const diz@38 $Ref)
(declare-const __flatten_2@39 Int)
(declare-const __flatten_3@40 $Ref)
(declare-const __flatten_23@41 Int)
(declare-const __flatten_24@42 $Ref)
(push) ; 2
; [eval] next != null
(push) ; 3
(assert (not (= next@36 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= next@36 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 9] next@36 != Null
(assert (not (= next@36 $Ref.null)))
(declare-const $t@43 $Snap)
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@37 $Ref.null)))
(declare-const $t@44 $Snap)
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@45 $Snap)
(declare-const $t@46 $Snap)
(assert (= $t@44 ($Snap.combine $t@45 $t@46)))
(declare-const $t@47 Int)
(declare-const $t@48 $Ref)
(assert (=
  $t@45
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@47)
    ($SortWrappers.$RefTo$Snap $t@48))))
(declare-const $k@49 $Perm)
(assert ($Perm.isValidVar $k@49))
(assert ($Perm.isReadVar $k@49 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 5
(assert (not (= $t@48 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@48 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 10] $t@48 != Null
(assert (not (= $t@48 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@49 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@49 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@47 val@35))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@47 val@35)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 11] $t@47 == val@35
(assert (= $t@47 val@35))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 11] $t@47 != val@35
(assert (not (= $t@47 val@35)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 10] $t@48 == Null
(assert (= $t@48 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@49 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@49 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@47 val@35))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@47 val@35)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 12] $t@47 == val@35
(assert (= $t@47 val@35))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 12] $t@47 != val@35
(assert (not (= $t@47 val@35)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(declare-fun joinedIn@50 () Bool)
(assert (implies
  (= $t@48 $Ref.null)
  (and
    (not (= $k@49 $Perm.No))
    (= $t@48 $Ref.null)
    ($Perm.isReadVar $k@49 $Perm.Write)
    ($Perm.isValidVar $k@49)
    (=
      $t@45
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@47)
        ($SortWrappers.$RefTo$Snap $t@48)))
    (= $t@44 ($Snap.combine $t@45 $t@46)))))
(assert (implies
  (not (= $t@48 $Ref.null))
  (and
    (not (= $k@49 $Perm.No))
    (not (= $t@48 $Ref.null))
    ($Perm.isReadVar $k@49 $Perm.Write)
    ($Perm.isValidVar $k@49)
    (=
      $t@45
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@47)
        ($SortWrappers.$RefTo$Snap $t@48)))
    (= $t@44 ($Snap.combine $t@45 $t@46)))))
(assert (and
  (implies
    (= $t@48 $Ref.null)
    (= joinedIn@50 (and (= $t@47 val@35) (= $t@48 next@36))))
  (implies
    (not (= $t@48 $Ref.null))
    (= joinedIn@50 (and (= $t@47 val@35) (= $t@48 next@36))))))
(assert joinedIn@50)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@35)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 5
(assert (not (= next@36 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 13] next@36 == Null
(push) ; 5
; [else-branch 13] next@36 != Null
; [eval] old(Node__contents(next))
; [eval] Node__contents(next)
; [eval] next != null
(pop) ; 5
(declare-const $deadThen@51 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@44) sys__result@37)
  ($Seq.append
    ($Seq.singleton val@35)
    (ite
      (= next@36 $Ref.null)
      $deadThen@51
      ($Node__contents ($Snap.combine $Snap.unit $t@43) next@36)))))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@52 $Ref)
(assert (not (= diz@52 $Ref.null)))
(declare-const Node__next@53 $Ref)
(declare-const Node__val@54 Int)
(assert (and
  (not (= next@36 diz@52))
  (not (= sys__result@37 diz@52))
  (not (= __flatten_3@40 diz@52))
  (not (= __flatten_24@42 diz@52))
  (not (= Node__next@53 diz@52))))
; [exec]
; __flatten_2 := val
; [exec]
; __flatten_23 := __flatten_2
; [exec]
; diz.Node__val := __flatten_23
; [exec]
; __flatten_3 := next
; [exec]
; __flatten_24 := __flatten_3
; [exec]
; diz.Node__next := __flatten_24
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@55 $Perm)
(assert ($Perm.isValidVar $k@55))
(assert ($Perm.isReadVar $k@55 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@55 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@55 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 5
(assert (not (= next@36 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 14] next@36 != Null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(Node__state(sys__result), write) && (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next)) && (Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next))))
; [eval] sys__result != null
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@56 $Snap)
(declare-const $t@57 $Snap)
(assert (=
  ($Snap.combine
    ($Snap.combine
      ($SortWrappers.IntTo$Snap val@35)
      ($SortWrappers.$RefTo$Snap next@36))
    $t@43)
  ($Snap.combine $t@56 $t@57)))
(declare-const $t@58 Int)
(declare-const $t@59 $Ref)
(assert (=
  $t@56
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@58)
    ($SortWrappers.$RefTo$Snap $t@59))))
(declare-const $k@60 $Perm)
(assert ($Perm.isValidVar $k@60))
(assert ($Perm.isReadVar $k@60 $Perm.Write))
(assert (implies (< $Perm.No (- $Perm.Write $k@55)) (= $t@58 val@35)))
; [eval] sys__result.Node__next != null
(push) ; 6
(assert (not (= $t@59 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@59 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 15] $t@59 != Null
(assert (not (= $t@59 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 7
(assert (not (not (= (+ (- $Perm.Write $k@55) $k@60) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- $Perm.Write $k@55) $k@60) $Perm.No)))
(push) ; 7
(push) ; 8
(assert (not (not (= $t@58 val@35))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@58 val@35)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 16] $t@58 == val@35
(assert (= $t@58 val@35))
; [eval] sys__result.Node__next == next
(pop) ; 8
; [dead else-branch 16] $t@58 != val@35
(pop) ; 7
(pop) ; 6
; [dead else-branch 15] $t@59 == Null
(assert (not (= $t@59 $Ref.null)))
(assert (not (= (+ (- $Perm.Write $k@55) $k@60) $Perm.No)))
(push) ; 6
(assert (not (and (= $t@58 val@35) (= $t@59 next@36))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (and (= $t@58 val@35) (= $t@59 next@36)))
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@35)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 6
(assert (not (= next@36 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 17] next@36 == Null
(push) ; 6
; [else-branch 17] next@36 != Null
; [eval] old(Node__contents(next))
; [eval] Node__contents(next)
; [eval] next != null
(pop) ; 6
(declare-const $deadThen@61 $Seq<Int>)
(push) ; 6
(assert (not ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@35)
        ($SortWrappers.$RefTo$Snap next@36))
      $t@43)) diz@52)
  ($Seq.append
    ($Seq.singleton val@35)
    (ite
      (= next@36 $Ref.null)
      $deadThen@61
      ($Node__contents ($Snap.combine $Snap.unit $t@43) next@36))))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@35)
        ($SortWrappers.$RefTo$Snap next@36))
      $t@43)) diz@52)
  ($Seq.append
    ($Seq.singleton val@35)
    (ite
      (= next@36 $Ref.null)
      $deadThen@61
      ($Node__contents ($Snap.combine $Snap.unit $t@43) next@36)))))
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 14] next@36 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 9] next@36 == Null
(assert (= next@36 $Ref.null))
(push) ; 4
; [eval] sys__result != null
(assert (not (= sys__result@37 $Ref.null)))
(declare-const $t@62 $Snap)
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@63 $Snap)
(declare-const $t@64 $Snap)
(assert (= $t@62 ($Snap.combine $t@63 $t@64)))
(declare-const $t@65 Int)
(declare-const $t@66 $Ref)
(assert (=
  $t@63
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@65)
    ($SortWrappers.$RefTo$Snap $t@66))))
(declare-const $k@67 $Perm)
(assert ($Perm.isValidVar $k@67))
(assert ($Perm.isReadVar $k@67 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 5
(assert (not (= $t@66 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@66 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 18] $t@66 != Null
(assert (not (= $t@66 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@67 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@67 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@65 val@35))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@65 val@35)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 19] $t@65 == val@35
(assert (= $t@65 val@35))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 19] $t@65 != val@35
(assert (not (= $t@65 val@35)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 18] $t@66 == Null
(assert (= $t@66 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 6
(assert (not (not (= $k@67 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@67 $Perm.No)))
(push) ; 6
(push) ; 7
(assert (not (not (= $t@65 val@35))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (= $t@65 val@35)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 20] $t@65 == val@35
(assert (= $t@65 val@35))
; [eval] sys__result.Node__next == next
(pop) ; 7
(push) ; 7
; [else-branch 20] $t@65 != val@35
(assert (not (= $t@65 val@35)))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(declare-fun joinedIn@68 () Bool)
(assert (implies
  (= $t@66 $Ref.null)
  (and
    (not (= $k@67 $Perm.No))
    (= $t@66 $Ref.null)
    ($Perm.isReadVar $k@67 $Perm.Write)
    ($Perm.isValidVar $k@67)
    (=
      $t@63
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@65)
        ($SortWrappers.$RefTo$Snap $t@66)))
    (= $t@62 ($Snap.combine $t@63 $t@64)))))
(assert (implies
  (not (= $t@66 $Ref.null))
  (and
    (not (= $k@67 $Perm.No))
    (not (= $t@66 $Ref.null))
    ($Perm.isReadVar $k@67 $Perm.Write)
    ($Perm.isValidVar $k@67)
    (=
      $t@63
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@65)
        ($SortWrappers.$RefTo$Snap $t@66)))
    (= $t@62 ($Snap.combine $t@63 $t@64)))))
(assert (and
  (implies
    (= $t@66 $Ref.null)
    (= joinedIn@68 (and (= $t@65 val@35) (= $t@66 next@36))))
  (implies
    (not (= $t@66 $Ref.null))
    (= joinedIn@68 (and (= $t@65 val@35) (= $t@66 next@36))))))
(assert joinedIn@68)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@35)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 5
(assert (not (not (= next@36 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 21] next@36 == Null
; [eval] Seq[Int]()
(pop) ; 5
; [dead else-branch 21] next@36 != Null
(declare-const $deadElse@69 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@62) sys__result@37)
  ($Seq.append
    ($Seq.singleton val@35)
    (ite (= next@36 $Ref.null) $Seq.empty<Int> $deadElse@69))))
(pop) ; 4
(push) ; 4
; [exec]
; diz := new(Node__next, Node__val)
(declare-const diz@70 $Ref)
(assert (not (= diz@70 $Ref.null)))
(declare-const Node__next@71 $Ref)
(declare-const Node__val@72 Int)
(assert (and
  (not (= next@36 diz@70))
  (not (= sys__result@37 diz@70))
  (not (= __flatten_3@40 diz@70))
  (not (= __flatten_24@42 diz@70))
  (not (= Node__next@71 diz@70))))
; [exec]
; __flatten_2 := val
; [exec]
; __flatten_23 := __flatten_2
; [exec]
; diz.Node__val := __flatten_23
; [exec]
; __flatten_3 := next
; [exec]
; __flatten_24 := __flatten_3
; [exec]
; diz.Node__next := __flatten_24
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@73 $Perm)
(assert ($Perm.isValidVar $k@73))
(assert ($Perm.isReadVar $k@73 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@73 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@73 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 5
(assert (not (not (= next@36 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 22] next@36 != Null
(push) ; 5
; [else-branch 22] next@36 == Null
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(Node__state(sys__result), write) && (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next)) && (Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next))))
; [eval] sys__result != null
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@74 $Snap)
(declare-const $t@75 $Snap)
(assert (=
  ($Snap.combine
    ($Snap.combine
      ($SortWrappers.IntTo$Snap val@35)
      ($SortWrappers.$RefTo$Snap next@36))
    $Snap.unit)
  ($Snap.combine $t@74 $t@75)))
(declare-const $t@76 Int)
(declare-const $t@77 $Ref)
(assert (=
  $t@74
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@76)
    ($SortWrappers.$RefTo$Snap $t@77))))
(declare-const $k@78 $Perm)
(assert ($Perm.isValidVar $k@78))
(assert ($Perm.isReadVar $k@78 $Perm.Write))
(assert (implies (< $Perm.No (- $Perm.Write $k@73)) (= $t@76 val@35)))
; [eval] sys__result.Node__next != null
(push) ; 6
(assert (not (= $t@77 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $t@77 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 23] $t@77 != Null
(push) ; 6
; [else-branch 23] $t@77 == Null
(assert (= $t@77 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 7
(assert (not (not (= (+ (- $Perm.Write $k@73) $k@78) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= (+ (- $Perm.Write $k@73) $k@78) $Perm.No)))
(push) ; 7
(push) ; 8
(assert (not (not (= $t@76 val@35))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (= $t@76 val@35)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 24] $t@76 == val@35
(assert (= $t@76 val@35))
; [eval] sys__result.Node__next == next
(pop) ; 8
; [dead else-branch 24] $t@76 != val@35
(pop) ; 7
(pop) ; 6
(assert (= $t@77 $Ref.null))
(assert (not (= (+ (- $Perm.Write $k@73) $k@78) $Perm.No)))
(push) ; 6
(assert (not (and (= $t@76 val@35) (= $t@77 next@36))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (and (= $t@76 val@35) (= $t@77 next@36)))
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@35)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 6
(assert (not (not (= next@36 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 25] next@36 == Null
; [eval] Seq[Int]()
(pop) ; 6
; [dead else-branch 25] next@36 != Null
(declare-const $deadElse@79 $Seq<Int>)
(push) ; 6
(assert (not ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@35)
        ($SortWrappers.$RefTo$Snap next@36))
      $Snap.unit)) diz@70)
  ($Seq.append
    ($Seq.singleton val@35)
    (ite (= next@36 $Ref.null) $Seq.empty<Int> $deadElse@79)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap val@35)
        ($SortWrappers.$RefTo$Snap next@36))
      $Snap.unit)) diz@70)
  ($Seq.append
    ($Seq.singleton val@35)
    (ite (= next@36 $Ref.null) $Seq.empty<Int> $deadElse@79))))
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Node__append ----------
(declare-const diz@80 $Ref)
(declare-const n@81 $Ref)
(declare-const __flatten_4@82 $Ref)
(declare-const __flatten_25@83 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@80 $Ref.null)))
(declare-const $t@84 $Snap)
; [eval] n != null
(assert (not (= n@81 $Ref.null)))
(declare-const $t@85 $Snap)
(push) ; 3
(assert (not (= diz@80 n@81)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(declare-const $t@86 $Snap)
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
  ($Node__contents ($Snap.combine $Snap.unit $t@86) diz@80)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@84) diz@80)
    ($Node__contents ($Snap.combine $Snap.unit $t@85) n@81))))
(pop) ; 3
(push) ; 3
; [exec]
; unfold acc(Node__state(diz), write)
(declare-const $t@87 $Snap)
(declare-const $t@88 $Snap)
(assert (= $t@84 ($Snap.combine $t@87 $t@88)))
(declare-const $t@89 Int)
(declare-const $t@90 $Ref)
(assert (=
  $t@87
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@89)
    ($SortWrappers.$RefTo$Snap $t@90))))
(declare-const $k@91 $Perm)
(assert ($Perm.isValidVar $k@91))
(assert ($Perm.isReadVar $k@91 $Perm.Write))
; [eval] diz.Node__next != null
(push) ; 4
(assert (not (= $t@90 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@90 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 26] $t@90 != Null
(assert (not (= $t@90 $Ref.null)))
(push) ; 5
(assert (not (= n@81 $t@90)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (= $t@90 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 27] $t@90 == Null
(push) ; 5
; [else-branch 27] $t@90 != Null
(pop) ; 5
; [eval] !(diz.Node__next == null)
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (= $t@90 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 28] $t@90 != Null
; [exec]
; Node__append(diz.Node__next, n)
; [eval] diz != null
; [eval] n != null
(declare-const $t@92 $Snap)
(declare-const $t@93 $Snap)
(assert (= $t@92 ($Snap.combine $t@93 $Snap.unit)))
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
  ($Node__contents ($Snap.combine $Snap.unit $t@93) $t@90)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@88) $t@90)
    ($Node__contents ($Snap.combine $Snap.unit $t@85) n@81))))
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@94 $Perm)
(assert ($Perm.isValidVar $k@94))
(assert ($Perm.isReadVar $k@94 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@94 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@91 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@91 $Perm.No)))
(assert (< $k@94 $k@91))
; [eval] diz.Node__next != null
(push) ; 6
(assert (not (= $t@90 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 29] $t@90 != Null
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
        ($SortWrappers.IntTo$Snap $t@89)
        ($SortWrappers.$RefTo$Snap $t@90))
      $t@93)) diz@80)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@84) diz@80)
    ($Node__contents ($Snap.combine $Snap.unit $t@85) n@81)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@89)
        ($SortWrappers.$RefTo$Snap $t@90))
      $t@93)) diz@80)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@84) diz@80)
    ($Node__contents ($Snap.combine $Snap.unit $t@85) n@81))))
(pop) ; 6
; [dead else-branch 29] $t@90 == Null
(pop) ; 5
; [dead else-branch 28] $t@90 == Null
(pop) ; 4
(push) ; 4
; [else-branch 26] $t@90 == Null
(assert (= $t@90 $Ref.null))
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (not (= $t@90 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 30] $t@90 == Null
; [exec]
; __flatten_4 := n
; [exec]
; __flatten_25 := __flatten_4
; [exec]
; diz.Node__next := __flatten_25
; [exec]
; fold acc(Node__state(diz), write)
(declare-const $k@95 $Perm)
(assert ($Perm.isValidVar $k@95))
(assert ($Perm.isReadVar $k@95 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@95 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(push) ; 6
(assert (not (not (= $k@91 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@91 $Perm.No)))
(assert (< $k@95 $k@91))
; [eval] diz.Node__next != null
(push) ; 6
(assert (not (= n@81 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 31] n@81 != Null
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
        ($SortWrappers.IntTo$Snap $t@89)
        ($SortWrappers.$RefTo$Snap n@81))
      $t@85)) diz@80)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@84) diz@80)
    ($Node__contents ($Snap.combine $Snap.unit $t@85) n@81)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert ($Seq.equal
  ($Node__contents ($Snap.combine
    $Snap.unit
    ($Snap.combine
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@89)
        ($SortWrappers.$RefTo$Snap n@81))
      $t@85)) diz@80)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@84) diz@80)
    ($Node__contents ($Snap.combine $Snap.unit $t@85) n@81))))
(pop) ; 6
; [dead else-branch 31] n@81 == Null
(pop) ; 5
; [dead else-branch 30] $t@90 != Null
; [eval] !(diz.Node__next == null)
; [eval] diz.Node__next == null
(push) ; 5
(assert (not (not (= $t@90 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 32] $t@90 != Null
(push) ; 5
; [else-branch 32] $t@90 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Queue__Queue ----------
(declare-const capacity@96 Int)
(declare-const sys__result@97 $Ref)
(declare-const diz@98 $Ref)
(declare-const __flatten_6@99 Int)
(declare-const __flatten_7@100 $Ref)
(declare-const __flatten_8@101 $Ref)
(declare-const __flatten_9@102 $Ref)
(declare-const __flatten_10@103 $Ref)
(declare-const __flatten_11@104 $Ref)
(declare-const __flatten_12@105 $Ref)
(declare-const __flatten_13@106 $Ref)
(declare-const __flatten_14@107 $Ref)
(declare-const __flatten_27@108 Int)
(declare-const __flatten_29@109 $Ref)
(declare-const __flatten_31@110 $Ref)
(declare-const __flatten_33@111 $Ref)
(declare-const __flatten_35@112 $Ref)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@97 $Ref.null)))
(declare-const $t@113 $Ref)
; [eval] sys__result.Queue__first != null
(push) ; 4
(assert (not (= $t@113 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
(assert (not (not (= $t@113 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
(push) ; 4
; [then-branch 33] $t@113 != Null
(assert (not (= $t@113 $Ref.null)))
(declare-const $t@114 $Snap)
(declare-const $k@115 $Perm)
(assert ($Perm.isValidVar $k@115))
(assert ($Perm.isReadVar $k@115 $Perm.Write))
(declare-const $t@116 Int)
(declare-const $t@117 $Ref)
(assert (not (= $t@117 $Ref.null)))
(declare-const $t@118 Int)
(declare-const $t@119 $Ref)
(declare-const $t@120 $Ref)
; [eval] sys__result.Queue__first == null
(assert (= $t@113 $Ref.null))
; [eval] sys__result.Queue__capacity == capacity
(push) ; 5
(assert (not (not (= $k@115 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@115 $Perm.No)))
(assert (= $t@116 capacity@96))
; [eval] sys__result.Queue__count != null
(declare-const $t@121 Int)
(assert (= $t@118 $t@121))
; [eval] sys__result.Queue__count.LockableInteger__val == 0
(push) ; 5
(assert (not (not (= (+ $Perm.Write $Perm.Write) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $Perm.Write $Perm.Write) $Perm.No)))
(assert (= $t@118 0))
(pop) ; 4
(push) ; 4
; [else-branch 33] $t@113 == Null
(assert (= $t@113 $Ref.null))
(declare-const $k@122 $Perm)
(assert ($Perm.isValidVar $k@122))
(assert ($Perm.isReadVar $k@122 $Perm.Write))
(declare-const $t@123 Int)
(declare-const $t@124 $Ref)
(assert (not (= $t@124 $Ref.null)))
(declare-const $t@125 Int)
(declare-const $t@126 $Ref)
(declare-const $t@127 $Ref)
; [eval] sys__result.Queue__first == null
; [eval] sys__result.Queue__capacity == capacity
(push) ; 5
(assert (not (not (= $k@122 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@122 $Perm.No)))
(assert (= $t@123 capacity@96))
; [eval] sys__result.Queue__count != null
(declare-const $t@128 Int)
(assert (= $t@125 $t@128))
; [eval] sys__result.Queue__count.LockableInteger__val == 0
(push) ; 5
(assert (not (not (= (+ $Perm.Write $Perm.Write) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $Perm.Write $Perm.Write) $Perm.No)))
(assert (= $t@125 0))
(pop) ; 4
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(Queue__capacity, Queue__first, Queue__count, Queue__putLock, Queue__takeLock, Queue__notFull)
(declare-const diz@129 $Ref)
(assert (not (= diz@129 $Ref.null)))
(declare-const Queue__capacity@130 Int)
(declare-const Queue__first@131 $Ref)
(declare-const Queue__count@132 $Ref)
(declare-const Queue__putLock@133 $Ref)
(declare-const Queue__takeLock@134 $Ref)
(declare-const Queue__notFull@135 $Ref)
(assert (and
  (not (= sys__result@97 diz@129))
  (not (= __flatten_7@100 diz@129))
  (not (= __flatten_8@101 diz@129))
  (not (= __flatten_9@102 diz@129))
  (not (= __flatten_10@103 diz@129))
  (not (= __flatten_11@104 diz@129))
  (not (= __flatten_12@105 diz@129))
  (not (= __flatten_13@106 diz@129))
  (not (= __flatten_14@107 diz@129))
  (not (= __flatten_29@109 diz@129))
  (not (= __flatten_31@110 diz@129))
  (not (= __flatten_33@111 diz@129))
  (not (= __flatten_35@112 diz@129))
  (not (= Queue__first@131 diz@129))
  (not (= Queue__count@132 diz@129))
  (not (= Queue__putLock@133 diz@129))
  (not (= Queue__takeLock@134 diz@129))
  (not (= Queue__notFull@135 diz@129))))
; [exec]
; diz.Queue__first := null
; [exec]
; __flatten_6 := capacity
; [exec]
; __flatten_27 := __flatten_6
; [exec]
; diz.Queue__capacity := __flatten_27
; [exec]
; __flatten_8 := LockableInteger__LockableInteger(0)
(declare-const sys__result@136 $Ref)
(declare-const $t@137 $Snap)
(declare-const $t@138 Int)
(assert (= $t@137 ($Snap.combine ($SortWrappers.IntTo$Snap $t@138) $Snap.unit)))
(declare-const $t@139 Int)
(assert (=
  ($SortWrappers.IntTo$Snap $t@138)
  ($Snap.combine $Snap.unit ($SortWrappers.IntTo$Snap $t@139))))
; [eval] sys__result != null
(assert (not (= sys__result@136 $Ref.null)))
; [eval] sys__result.LockableInteger__val == val
(assert (= $t@139 0))
; [exec]
; __flatten_7 := __flatten_8
; [exec]
; __flatten_29 := __flatten_7
; [exec]
; diz.Queue__count := __flatten_29
; [exec]
; __flatten_10 := LockSymbol__LockSymbol()
(declare-const sys__result@140 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@140 $Ref.null)))
; [exec]
; __flatten_9 := __flatten_10
; [exec]
; __flatten_31 := __flatten_9
; [exec]
; diz.Queue__putLock := __flatten_31
; [exec]
; __flatten_12 := LockSymbol__LockSymbol()
(declare-const sys__result@141 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@141 $Ref.null)))
; [exec]
; __flatten_11 := __flatten_12
; [exec]
; __flatten_33 := __flatten_11
; [exec]
; diz.Queue__takeLock := __flatten_33
; [exec]
; __flatten_14 := LockSymbol__LockSymbol()
(declare-const sys__result@142 $Ref)
; [eval] sys__result != null
(assert (not (= sys__result@142 $Ref.null)))
; [exec]
; __flatten_13 := __flatten_14
; [exec]
; __flatten_35 := __flatten_13
; [exec]
; diz.Queue__notFull := __flatten_35
; [exec]
; exhale true
; [exec]
; sys__result := diz
; [exec]
; assert (sys__result != null) && acc(sys__result.Queue__first, write) && ((sys__result.Queue__first != null) ==> acc(Node__state(sys__result.Queue__first), write)) && acc(sys__result.Queue__capacity, wildcard) && acc(sys__result.Queue__count, write) && acc(sys__result.Queue__count.LockableInteger__val, write) && acc(sys__result.Queue__putLock, write) && acc(sys__result.Queue__takeLock, write) && (sys__result.Queue__first == null) && (sys__result.Queue__capacity == capacity) && (sys__result.Queue__count != null) && acc(sys__result.Queue__count.LockableInteger__val, write) && (sys__result.Queue__count.LockableInteger__val == 0)
; [eval] sys__result != null
; [eval] sys__result.Queue__first != null
(push) ; 4
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 4
; [dead then-branch 34] False
(push) ; 4
; [else-branch 34] True
(declare-const $k@143 $Perm)
(assert ($Perm.isValidVar $k@143))
(assert ($Perm.isReadVar $k@143 $Perm.Write))
(push) ; 5
(assert (not (or (= $k@143 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (< $k@143 $Perm.Write))
; [eval] sys__result.Queue__first == null
; [eval] sys__result.Queue__capacity == capacity
; [eval] sys__result.Queue__count != null
(check-sat)
; unknown
(push) ; 5
(pop) ; 5
(assert (or
  (= $Perm.Write (- $Perm.Write $k@143))
  (< (- $Perm.Write $k@143) $Perm.Write)))
(check-sat)
; unknown
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Queue__linkLast ----------
(declare-const diz@144 $Ref)
(declare-const val@145 Int)
(declare-const __flatten_15@146 $Ref)
(declare-const __flatten_16@147 $Ref)
(declare-const __flatten_17@148 $Ref)
(declare-const __flatten_37@149 $Ref)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@144 $Ref.null)))
(declare-const $t@150 $Ref)
; [eval] diz.Queue__first != null
(push) ; 3
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 35] $t@150 != Null
(assert (not (= $t@150 $Ref.null)))
(declare-const $t@151 $Snap)
(declare-const $k@152 $Perm)
(assert ($Perm.isValidVar $k@152))
(assert ($Perm.isReadVar $k@152 $Perm.Write))
(declare-const $t@153 Int)
(declare-const $t@154 $Ref)
(assert (not (= $t@154 $Ref.null)))
(declare-const $t@155 Int)
(declare-const $t@156 $Ref)
(declare-const $t@157 $Ref)
(push) ; 4
(declare-const $t@158 $Ref)
; [eval] diz.Queue__first != null
(push) ; 5
(assert (not (= $t@158 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@158 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 36] $t@158 != Null
(assert (not (= $t@158 $Ref.null)))
(declare-const $t@159 $Snap)
(declare-const $k@160 $Perm)
(assert ($Perm.isValidVar $k@160))
(assert ($Perm.isReadVar $k@160 $Perm.Write))
(declare-const $t@161 Int)
(declare-const $t@162 $Ref)
(assert (not (= $t@162 $Ref.null)))
(declare-const $t@163 Int)
(declare-const $t@164 $Ref)
(declare-const $t@165 $Ref)
; [eval] diz.Queue__first != null
; [eval] (old(|Queue__contents(diz)|) == 0) ==> (Queue__contents(diz) == Seq(val))
; [eval] old(|Queue__contents(diz)|) == 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 6
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 37] $t@150 != Null
(declare-const $k@166 $Perm)
(assert ($Perm.isValidVar $k@166))
(assert ($Perm.isReadVar $k@166 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@166 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@152 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@152 $Perm.No)))
(assert (< $k@166 $k@152))
(pop) ; 6
; [dead else-branch 37] $t@150 == Null
(assert ($Perm.isValidVar $k@166))
(assert ($Perm.isReadVar $k@166 $Perm.Write))
(assert (not (= $k@152 $Perm.No)))
(assert (< $k@166 $k@152))
(push) ; 6
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $t@151)
              ($SortWrappers.IntTo$Snap $t@153))
            ($SortWrappers.$RefTo$Snap $t@154))
          ($SortWrappers.IntTo$Snap $t@155))
        ($SortWrappers.$RefTo$Snap $t@156))
      ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 38] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| == 0
(push) ; 7
; [else-branch 38] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| != 0
(assert (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0)))
(pop) ; 7
(pop) ; 6
; [eval] (old(|Queue__contents(diz)|) != 0) ==> (Queue__contents(diz) == old(Queue__contents(diz)) ++ Seq(val))
; [eval] old(|Queue__contents(diz)|) != 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 6
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
(push) ; 6
; [then-branch 39] $t@150 != Null
(declare-const $k@167 $Perm)
(assert ($Perm.isValidVar $k@167))
(assert ($Perm.isReadVar $k@167 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@167 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@167 $k@152))
(pop) ; 6
; [dead else-branch 39] $t@150 == Null
(assert ($Perm.isValidVar $k@167))
(assert ($Perm.isReadVar $k@167 $Perm.Write))
(assert (< $k@167 $k@152))
(push) ; 6
(push) ; 7
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $t@151)
              ($SortWrappers.IntTo$Snap $t@153))
            ($SortWrappers.$RefTo$Snap $t@154))
          ($SortWrappers.IntTo$Snap $t@155))
        ($SortWrappers.$RefTo$Snap $t@156))
      ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 40] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| != 0
(assert (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0)))
; [eval] Queue__contents(diz) == old(Queue__contents(diz)) ++ Seq(val)
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (= $t@158 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 41] $t@158 != Null
(declare-const $k@168 $Perm)
(assert ($Perm.isValidVar $k@168))
(assert ($Perm.isReadVar $k@168 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@168 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@160 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@160 $Perm.No)))
(assert (< $k@168 $k@160))
(pop) ; 8
; [dead else-branch 41] $t@158 == Null
(assert ($Perm.isValidVar $k@168))
(assert ($Perm.isReadVar $k@168 $Perm.Write))
(assert (not (= $k@160 $Perm.No)))
(assert (< $k@168 $k@160))
; [eval] old(Queue__contents(diz)) ++ Seq(val)
; [eval] old(Queue__contents(diz))
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 42] $t@150 != Null
(declare-const $k@169 $Perm)
(assert ($Perm.isValidVar $k@169))
(assert ($Perm.isReadVar $k@169 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@169 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@169 $k@152))
(pop) ; 8
; [dead else-branch 42] $t@150 == Null
(assert ($Perm.isValidVar $k@169))
(assert ($Perm.isReadVar $k@169 $Perm.Write))
(assert (< $k@169 $k@152))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@145)) 1))
(pop) ; 7
; [dead else-branch 40] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| == 0
(pop) ; 6
(assert ($Perm.isValidVar $k@168))
(assert ($Perm.isReadVar $k@168 $Perm.Write))
(assert (not (= $k@160 $Perm.No)))
(assert (< $k@168 $k@160))
(assert ($Perm.isValidVar $k@169))
(assert ($Perm.isReadVar $k@169 $Perm.Write))
(assert (< $k@169 $k@152))
(assert (= ($Seq.length ($Seq.singleton val@145)) 1))
(assert (implies
  (not
    (=
      ($Seq.length
        ($Queue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                    $t@151)
                  ($SortWrappers.IntTo$Snap $t@153))
                ($SortWrappers.$RefTo$Snap $t@154))
              ($SortWrappers.IntTo$Snap $t@155))
            ($SortWrappers.$RefTo$Snap $t@156))
          ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
      0))
  ($Seq.equal
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@158))
                $t@159)
              ($SortWrappers.IntTo$Snap $t@161))
            ($SortWrappers.$RefTo$Snap $t@162))
          ($SortWrappers.IntTo$Snap $t@163))
        ($SortWrappers.$RefTo$Snap $t@164))
      ($SortWrappers.$RefTo$Snap $t@165)) diz@144)
    ($Seq.append
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144)
      ($Seq.singleton val@145)))))
(pop) ; 5
(push) ; 5
; [else-branch 36] $t@158 == Null
(assert (= $t@158 $Ref.null))
(declare-const $k@170 $Perm)
(assert ($Perm.isValidVar $k@170))
(assert ($Perm.isReadVar $k@170 $Perm.Write))
(declare-const $t@171 Int)
(declare-const $t@172 $Ref)
(assert (not (= $t@172 $Ref.null)))
(declare-const $t@173 Int)
(declare-const $t@174 $Ref)
(declare-const $t@175 $Ref)
; [eval] diz.Queue__first != null
(assert (not (= $t@158 $Ref.null)))
; [eval] (old(|Queue__contents(diz)|) == 0) ==> (Queue__contents(diz) == Seq(val))
; [eval] old(|Queue__contents(diz)|) == 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 6
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [dead then-branch 43] $t@150 != Null
; [dead else-branch 43] $t@150 == Null
(pop) ; 5
(pop) ; 4
(push) ; 4
; [eval] diz.Queue__first == null
(push) ; 5
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 44] $t@150 == Null
(push) ; 5
; [else-branch 44] $t@150 != Null
(pop) ; 5
; [eval] !(diz.Queue__first == null)
; [eval] diz.Queue__first == null
(push) ; 5
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 45] $t@150 != Null
; [exec]
; __flatten_17 := Node__Node(val, null)
; [eval] next != null
(push) ; 6
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 46] False
(push) ; 6
; [else-branch 46] True
(declare-const sys__result@176 $Ref)
(declare-const $t@177 $Snap)
(declare-const $t@178 $Snap)
(assert (= $t@177 ($Snap.combine $t@178 $Snap.unit)))
(declare-const $t@179 $Snap)
(assert (= $t@178 ($Snap.combine $t@179 $Snap.unit)))
(declare-const $t@180 $Snap)
(assert (= $t@179 ($Snap.combine $Snap.unit $t@180)))
; [eval] sys__result != null
(assert (not (= sys__result@176 $Ref.null)))
(push) ; 7
(assert (not (= $t@150 sys__result@176)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@181 $Snap)
(declare-const $t@182 $Snap)
(assert (= $t@180 ($Snap.combine $t@181 $t@182)))
(declare-const $t@183 Int)
(declare-const $t@184 $Ref)
(assert (=
  $t@181
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@183)
    ($SortWrappers.$RefTo$Snap $t@184))))
(declare-const $k@185 $Perm)
(assert ($Perm.isValidVar $k@185))
(assert ($Perm.isReadVar $k@185 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 7
(assert (not (= $t@184 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@184 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 47] $t@184 != Null
(assert (not (= $t@184 $Ref.null)))
(push) ; 8
(assert (not (= $t@150 $t@184)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@185 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@185 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@183 val@145))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@183 val@145)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 48] $t@183 == val@145
(assert (= $t@183 val@145))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 48] $t@183 != val@145
(assert (not (= $t@183 val@145)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 47] $t@184 == Null
(assert (= $t@184 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@185 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@185 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@183 val@145))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@183 val@145)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 49] $t@183 == val@145
(assert (= $t@183 val@145))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 49] $t@183 != val@145
(assert (not (= $t@183 val@145)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(declare-fun joinedIn@186 () Bool)
(assert (implies
  (= $t@184 $Ref.null)
  (and
    (not (= $k@185 $Perm.No))
    (= $t@184 $Ref.null)
    ($Perm.isReadVar $k@185 $Perm.Write)
    ($Perm.isValidVar $k@185)
    (=
      $t@181
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@183)
        ($SortWrappers.$RefTo$Snap $t@184)))
    (= $t@180 ($Snap.combine $t@181 $t@182)))))
(assert (implies
  (not (= $t@184 $Ref.null))
  (and
    (not (= $k@185 $Perm.No))
    (not (= $t@184 $Ref.null))
    ($Perm.isReadVar $k@185 $Perm.Write)
    ($Perm.isValidVar $k@185)
    (=
      $t@181
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@183)
        ($SortWrappers.$RefTo$Snap $t@184)))
    (= $t@180 ($Snap.combine $t@181 $t@182)))))
(assert (and
  (implies
    (= $t@184 $Ref.null)
    (= joinedIn@186 (and (= $t@183 val@145) (= $t@184 $Ref.null))))
  (implies
    (not (= $t@184 $Ref.null))
    (= joinedIn@186 (and (= $t@183 val@145) (= $t@184 $Ref.null))))))
(assert joinedIn@186)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@145)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 7
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 50] True
; [eval] Seq[Int]()
(pop) ; 7
; [dead else-branch 50] False
(declare-const $deadElse@187 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@180) sys__result@176)
  ($Seq.append ($Seq.singleton val@145) $Seq.empty<Int>)))
; [exec]
; Node__append(diz.Queue__first, __flatten_17)
; [eval] diz != null
; [eval] n != null
(declare-const $t@188 $Snap)
(declare-const $t@189 $Snap)
(assert (= $t@188 ($Snap.combine $t@189 $Snap.unit)))
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
  ($Node__contents ($Snap.combine $Snap.unit $t@189) $t@150)
  ($Seq.append
    ($Node__contents ($Snap.combine $Snap.unit $t@151) $t@150)
    ($Node__contents ($Snap.combine $Snap.unit $t@180) sys__result@176))))
; [eval] diz.Queue__first != null
(push) ; 7
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 51] $t@150 != Null
(declare-const $k@190 $Perm)
(assert ($Perm.isValidVar $k@190))
(assert ($Perm.isReadVar $k@190 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@190 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@152 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@152 $Perm.No)))
(assert (< $k@190 $k@152))
; [eval] diz.Queue__first != null
; [eval] (old(|Queue__contents(diz)|) == 0) ==> (Queue__contents(diz) == Seq(val))
; [eval] old(|Queue__contents(diz)|) == 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 52] $t@150 != Null
(declare-const $k@191 $Perm)
(assert ($Perm.isValidVar $k@191))
(assert ($Perm.isReadVar $k@191 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@191 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@191 $k@152))
(pop) ; 8
; [dead else-branch 52] $t@150 == Null
(assert ($Perm.isValidVar $k@191))
(assert ($Perm.isReadVar $k@191 $Perm.Write))
(assert (< $k@191 $k@152))
(push) ; 8
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $t@151)
              ($SortWrappers.IntTo$Snap $t@153))
            ($SortWrappers.$RefTo$Snap $t@154))
          ($SortWrappers.IntTo$Snap $t@155))
        ($SortWrappers.$RefTo$Snap $t@156))
      ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 53] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| == 0
(push) ; 9
; [else-branch 53] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| != 0
(assert (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0)))
(pop) ; 9
(pop) ; 8
; [eval] (old(|Queue__contents(diz)|) != 0) ==> (Queue__contents(diz) == old(Queue__contents(diz)) ++ Seq(val))
; [eval] old(|Queue__contents(diz)|) != 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 54] $t@150 != Null
(declare-const $k@192 $Perm)
(assert ($Perm.isValidVar $k@192))
(assert ($Perm.isReadVar $k@192 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@192 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@192 $k@152))
(pop) ; 8
; [dead else-branch 54] $t@150 == Null
(assert ($Perm.isValidVar $k@192))
(assert ($Perm.isReadVar $k@192 $Perm.Write))
(assert (< $k@192 $k@152))
(push) ; 8
(push) ; 9
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $t@151)
              ($SortWrappers.IntTo$Snap $t@153))
            ($SortWrappers.$RefTo$Snap $t@154))
          ($SortWrappers.IntTo$Snap $t@155))
        ($SortWrappers.$RefTo$Snap $t@156))
      ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
  0)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 55] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| != 0
(assert (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
    0)))
; [eval] Queue__contents(diz) == old(Queue__contents(diz)) ++ Seq(val)
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 10
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 56] $t@150 != Null
(declare-const $k@193 $Perm)
(assert ($Perm.isValidVar $k@193))
(assert ($Perm.isReadVar $k@193 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@193 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@193 $k@152))
(pop) ; 10
; [dead else-branch 56] $t@150 == Null
(assert ($Perm.isValidVar $k@193))
(assert ($Perm.isReadVar $k@193 $Perm.Write))
(assert (< $k@193 $k@152))
; [eval] old(Queue__contents(diz)) ++ Seq(val)
; [eval] old(Queue__contents(diz))
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 10
(assert (not (= $t@150 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 57] $t@150 != Null
(declare-const $k@194 $Perm)
(assert ($Perm.isValidVar $k@194))
(assert ($Perm.isReadVar $k@194 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@194 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@194 $k@152))
(pop) ; 10
; [dead else-branch 57] $t@150 == Null
(assert ($Perm.isValidVar $k@194))
(assert ($Perm.isReadVar $k@194 $Perm.Write))
(assert (< $k@194 $k@152))
; [eval] Seq(val)
(pop) ; 9
; [dead else-branch 55] |Queue__contents(diz@144;(((((((_, $t@150), $t@151), $t@153), $t@154), $t@155), $t@156), $t@157))| == 0
(pop) ; 8
(assert ($Perm.isValidVar $k@193))
(assert ($Perm.isReadVar $k@193 $Perm.Write))
(assert (< $k@193 $k@152))
(assert ($Perm.isValidVar $k@194))
(assert ($Perm.isReadVar $k@194 $Perm.Write))
(assert (< $k@194 $k@152))
(push) ; 8
(assert (not (implies
  (not
    (=
      ($Seq.length
        ($Queue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                    $t@151)
                  ($SortWrappers.IntTo$Snap $t@153))
                ($SortWrappers.$RefTo$Snap $t@154))
              ($SortWrappers.IntTo$Snap $t@155))
            ($SortWrappers.$RefTo$Snap $t@156))
          ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
      0))
  ($Seq.equal
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $t@189)
              ($SortWrappers.IntTo$Snap $t@153))
            ($SortWrappers.$RefTo$Snap $t@154))
          ($SortWrappers.IntTo$Snap $t@155))
        ($SortWrappers.$RefTo$Snap $t@156))
      ($SortWrappers.$RefTo$Snap $t@157)) diz@144)
    ($Seq.append
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144)
      ($Seq.singleton val@145))))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies
  (not
    (=
      ($Seq.length
        ($Queue__contents ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine
                    ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                    $t@151)
                  ($SortWrappers.IntTo$Snap $t@153))
                ($SortWrappers.$RefTo$Snap $t@154))
              ($SortWrappers.IntTo$Snap $t@155))
            ($SortWrappers.$RefTo$Snap $t@156))
          ($SortWrappers.$RefTo$Snap $t@157)) diz@144))
      0))
  ($Seq.equal
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $t@189)
              ($SortWrappers.IntTo$Snap $t@153))
            ($SortWrappers.$RefTo$Snap $t@154))
          ($SortWrappers.IntTo$Snap $t@155))
        ($SortWrappers.$RefTo$Snap $t@156))
      ($SortWrappers.$RefTo$Snap $t@157)) diz@144)
    ($Seq.append
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $t@151)
                ($SortWrappers.IntTo$Snap $t@153))
              ($SortWrappers.$RefTo$Snap $t@154))
            ($SortWrappers.IntTo$Snap $t@155))
          ($SortWrappers.$RefTo$Snap $t@156))
        ($SortWrappers.$RefTo$Snap $t@157)) diz@144)
      ($Seq.singleton val@145)))))
(pop) ; 7
; [dead else-branch 51] $t@150 == Null
(pop) ; 6
(pop) ; 5
; [dead else-branch 45] $t@150 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 35] $t@150 == Null
(assert (= $t@150 $Ref.null))
(declare-const $k@195 $Perm)
(assert ($Perm.isValidVar $k@195))
(assert ($Perm.isReadVar $k@195 $Perm.Write))
(declare-const $t@196 Int)
(declare-const $t@197 $Ref)
(assert (not (= $t@197 $Ref.null)))
(declare-const $t@198 Int)
(declare-const $t@199 $Ref)
(declare-const $t@200 $Ref)
(push) ; 4
(declare-const $t@201 $Ref)
; [eval] diz.Queue__first != null
(push) ; 5
(assert (not (= $t@201 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@201 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 58] $t@201 != Null
(assert (not (= $t@201 $Ref.null)))
(declare-const $t@202 $Snap)
(declare-const $k@203 $Perm)
(assert ($Perm.isValidVar $k@203))
(assert ($Perm.isReadVar $k@203 $Perm.Write))
(declare-const $t@204 Int)
(declare-const $t@205 $Ref)
(assert (not (= $t@205 $Ref.null)))
(declare-const $t@206 Int)
(declare-const $t@207 $Ref)
(declare-const $t@208 $Ref)
; [eval] diz.Queue__first != null
; [eval] (old(|Queue__contents(diz)|) == 0) ==> (Queue__contents(diz) == Seq(val))
; [eval] old(|Queue__contents(diz)|) == 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 6
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 59] $t@150 != Null
(push) ; 6
; [else-branch 59] $t@150 == Null
(declare-const $k@209 $Perm)
(assert ($Perm.isValidVar $k@209))
(assert ($Perm.isReadVar $k@209 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@209 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $k@195 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (not (= $k@195 $Perm.No)))
(assert (< $k@209 $k@195))
(pop) ; 6
(assert ($Perm.isValidVar $k@209))
(assert ($Perm.isReadVar $k@209 $Perm.Write))
(assert (not (= $k@195 $Perm.No)))
(assert (< $k@209 $k@195))
(push) ; 6
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 60] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| == 0
(assert (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0))
; [eval] Queue__contents(diz) == Seq(val)
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (= $t@201 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
(push) ; 8
; [then-branch 61] $t@201 != Null
(declare-const $k@210 $Perm)
(assert ($Perm.isValidVar $k@210))
(assert ($Perm.isReadVar $k@210 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@210 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not (= $k@203 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (not (= $k@203 $Perm.No)))
(assert (< $k@210 $k@203))
(pop) ; 8
; [dead else-branch 61] $t@201 == Null
(assert ($Perm.isValidVar $k@210))
(assert ($Perm.isReadVar $k@210 $Perm.Write))
(assert (not (= $k@203 $Perm.No)))
(assert (< $k@210 $k@203))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@145)) 1))
(pop) ; 7
; [dead else-branch 60] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| != 0
(pop) ; 6
(assert ($Perm.isValidVar $k@210))
(assert ($Perm.isReadVar $k@210 $Perm.Write))
(assert (not (= $k@203 $Perm.No)))
(assert (< $k@210 $k@203))
(assert (= ($Seq.length ($Seq.singleton val@145)) 1))
(assert (implies
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0)
  ($Seq.equal
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@201))
                $t@202)
              ($SortWrappers.IntTo$Snap $t@204))
            ($SortWrappers.$RefTo$Snap $t@205))
          ($SortWrappers.IntTo$Snap $t@206))
        ($SortWrappers.$RefTo$Snap $t@207))
      ($SortWrappers.$RefTo$Snap $t@208)) diz@144)
    ($Seq.singleton val@145))))
; [eval] (old(|Queue__contents(diz)|) != 0) ==> (Queue__contents(diz) == old(Queue__contents(diz)) ++ Seq(val))
; [eval] old(|Queue__contents(diz)|) != 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 6
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 62] $t@150 != Null
(push) ; 6
; [else-branch 62] $t@150 == Null
(declare-const $k@211 $Perm)
(assert ($Perm.isValidVar $k@211))
(assert ($Perm.isReadVar $k@211 $Perm.Write))
(push) ; 7
(assert (not (or (= $k@211 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(assert (< $k@211 $k@195))
(pop) ; 6
(assert ($Perm.isValidVar $k@211))
(assert ($Perm.isReadVar $k@211 $Perm.Write))
(assert (< $k@211 $k@195))
(push) ; 6
(push) ; 7
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
; [dead then-branch 63] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| != 0
(push) ; 7
; [else-branch 63] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| == 0
(assert (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0))
(pop) ; 7
(pop) ; 6
(pop) ; 5
(push) ; 5
; [else-branch 58] $t@201 == Null
(assert (= $t@201 $Ref.null))
(declare-const $k@212 $Perm)
(assert ($Perm.isValidVar $k@212))
(assert ($Perm.isReadVar $k@212 $Perm.Write))
(declare-const $t@213 Int)
(declare-const $t@214 $Ref)
(assert (not (= $t@214 $Ref.null)))
(declare-const $t@215 Int)
(declare-const $t@216 $Ref)
(declare-const $t@217 $Ref)
; [eval] diz.Queue__first != null
(assert (not (= $t@201 $Ref.null)))
; [eval] (old(|Queue__contents(diz)|) == 0) ==> (Queue__contents(diz) == Seq(val))
; [eval] old(|Queue__contents(diz)|) == 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 6
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
; [dead then-branch 64] $t@150 != Null
; [dead else-branch 64] $t@150 == Null
(pop) ; 5
(pop) ; 4
(push) ; 4
; [eval] diz.Queue__first == null
(push) ; 5
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 65] $t@150 == Null
; [exec]
; __flatten_16 := Node__Node(val, null)
; [eval] next != null
(push) ; 6
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 6
; [dead then-branch 66] False
(push) ; 6
; [else-branch 66] True
(declare-const sys__result@218 $Ref)
(declare-const $t@219 $Snap)
(declare-const $t@220 $Snap)
(assert (= $t@219 ($Snap.combine $t@220 $Snap.unit)))
(declare-const $t@221 $Snap)
(assert (= $t@220 ($Snap.combine $t@221 $Snap.unit)))
(declare-const $t@222 $Snap)
(assert (= $t@221 ($Snap.combine $Snap.unit $t@222)))
; [eval] sys__result != null
(assert (not (= sys__result@218 $Ref.null)))
; [eval] (unfolding acc(Node__state(sys__result), write) in (sys__result.Node__val == val) && (sys__result.Node__next == next))
(declare-const $t@223 $Snap)
(declare-const $t@224 $Snap)
(assert (= $t@222 ($Snap.combine $t@223 $t@224)))
(declare-const $t@225 Int)
(declare-const $t@226 $Ref)
(assert (=
  $t@223
  ($Snap.combine
    ($SortWrappers.IntTo$Snap $t@225)
    ($SortWrappers.$RefTo$Snap $t@226))))
(declare-const $k@227 $Perm)
(assert ($Perm.isValidVar $k@227))
(assert ($Perm.isReadVar $k@227 $Perm.Write))
; [eval] sys__result.Node__next != null
(push) ; 7
(assert (not (= $t@226 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
(assert (not (not (= $t@226 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 67] $t@226 != Null
(assert (not (= $t@226 $Ref.null)))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@227 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@227 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@225 val@145))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@225 val@145)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 68] $t@225 == val@145
(assert (= $t@225 val@145))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 68] $t@225 != val@145
(assert (not (= $t@225 val@145)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(push) ; 7
; [else-branch 67] $t@226 == Null
(assert (= $t@226 $Ref.null))
; [eval] (sys__result.Node__val == val) && (sys__result.Node__next == next)
; [eval] sys__result.Node__val == val
(push) ; 8
(assert (not (not (= $k@227 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@227 $Perm.No)))
(push) ; 8
(push) ; 9
(assert (not (not (= $t@225 val@145))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (= $t@225 val@145)))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 69] $t@225 == val@145
(assert (= $t@225 val@145))
; [eval] sys__result.Node__next == next
(pop) ; 9
(push) ; 9
; [else-branch 69] $t@225 != val@145
(assert (not (= $t@225 val@145)))
(pop) ; 9
(pop) ; 8
(pop) ; 7
(declare-fun joinedIn@228 () Bool)
(assert (implies
  (= $t@226 $Ref.null)
  (and
    (not (= $k@227 $Perm.No))
    (= $t@226 $Ref.null)
    ($Perm.isReadVar $k@227 $Perm.Write)
    ($Perm.isValidVar $k@227)
    (=
      $t@223
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@225)
        ($SortWrappers.$RefTo$Snap $t@226)))
    (= $t@222 ($Snap.combine $t@223 $t@224)))))
(assert (implies
  (not (= $t@226 $Ref.null))
  (and
    (not (= $k@227 $Perm.No))
    (not (= $t@226 $Ref.null))
    ($Perm.isReadVar $k@227 $Perm.Write)
    ($Perm.isValidVar $k@227)
    (=
      $t@223
      ($Snap.combine
        ($SortWrappers.IntTo$Snap $t@225)
        ($SortWrappers.$RefTo$Snap $t@226)))
    (= $t@222 ($Snap.combine $t@223 $t@224)))))
(assert (and
  (implies
    (= $t@226 $Ref.null)
    (= joinedIn@228 (and (= $t@225 val@145) (= $t@226 $Ref.null))))
  (implies
    (not (= $t@226 $Ref.null))
    (= joinedIn@228 (and (= $t@225 val@145) (= $t@226 $Ref.null))))))
(assert joinedIn@228)
; [eval] Node__contents(sys__result) == Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Node__contents(sys__result)
; [eval] sys__result != null
; [eval] Seq(val) ++ (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] Seq(val)
(assert (= ($Seq.length ($Seq.singleton val@145)) 1))
; [eval] (next == null ? Seq[Int]() : old(Node__contents(next)))
; [eval] next == null
(push) ; 7
(assert (not false))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 70] True
; [eval] Seq[Int]()
(pop) ; 7
; [dead else-branch 70] False
(declare-const $deadElse@229 $Seq<Int>)
(assert ($Seq.equal
  ($Node__contents ($Snap.combine $Snap.unit $t@222) sys__result@218)
  ($Seq.append ($Seq.singleton val@145) $Seq.empty<Int>)))
; [exec]
; __flatten_15 := __flatten_16
; [exec]
; __flatten_37 := __flatten_15
; [exec]
; diz.Queue__first := __flatten_37
; [eval] diz.Queue__first != null
(push) ; 7
(assert (not (= sys__result@218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 7
(push) ; 7
; [then-branch 71] sys__result@218 != Null
(declare-const $k@230 $Perm)
(assert ($Perm.isValidVar $k@230))
(assert ($Perm.isReadVar $k@230 $Perm.Write))
(push) ; 8
(assert (not (or (= $k@230 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(push) ; 8
(assert (not (not (= $k@195 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (not (= $k@195 $Perm.No)))
(assert (< $k@230 $k@195))
; [eval] diz.Queue__first != null
; [eval] (old(|Queue__contents(diz)|) == 0) ==> (Queue__contents(diz) == Seq(val))
; [eval] old(|Queue__contents(diz)|) == 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 72] $t@150 != Null
(push) ; 8
; [else-branch 72] $t@150 == Null
(declare-const $k@231 $Perm)
(assert ($Perm.isValidVar $k@231))
(assert ($Perm.isReadVar $k@231 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@231 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@231 $k@195))
(pop) ; 8
(assert ($Perm.isValidVar $k@231))
(assert ($Perm.isReadVar $k@231 $Perm.Write))
(assert (< $k@231 $k@195))
(push) ; 8
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
; [then-branch 73] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| == 0
(assert (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0))
; [eval] Queue__contents(diz) == Seq(val)
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 10
(assert (not (= sys__result@218 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 10
(push) ; 10
; [then-branch 74] sys__result@218 != Null
(declare-const $k@232 $Perm)
(assert ($Perm.isValidVar $k@232))
(assert ($Perm.isReadVar $k@232 $Perm.Write))
(push) ; 11
(assert (not (or (= $k@232 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 11
(assert (< $k@232 $k@195))
(pop) ; 10
; [dead else-branch 74] sys__result@218 == Null
(assert ($Perm.isValidVar $k@232))
(assert ($Perm.isReadVar $k@232 $Perm.Write))
(assert (< $k@232 $k@195))
; [eval] Seq(val)
(pop) ; 9
; [dead else-branch 73] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| != 0
(pop) ; 8
(assert ($Perm.isValidVar $k@232))
(assert ($Perm.isReadVar $k@232 $Perm.Write))
(assert (< $k@232 $k@195))
(push) ; 8
(assert (not (implies
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0)
  ($Seq.equal
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  $Snap.unit
                  ($SortWrappers.$RefTo$Snap sys__result@218))
                $t@222)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144)
    ($Seq.singleton val@145)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 8
(assert (implies
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0)
  ($Seq.equal
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  $Snap.unit
                  ($SortWrappers.$RefTo$Snap sys__result@218))
                $t@222)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144)
    ($Seq.singleton val@145))))
; [eval] (old(|Queue__contents(diz)|) != 0) ==> (Queue__contents(diz) == old(Queue__contents(diz)) ++ Seq(val))
; [eval] old(|Queue__contents(diz)|) != 0
; [eval] old(|Queue__contents(diz)|)
; [eval] |Queue__contents(diz)|
; [eval] Queue__contents(diz)
; [eval] diz != null
; [eval] diz.Queue__first != null
(push) ; 8
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 8
; [dead then-branch 75] $t@150 != Null
(push) ; 8
; [else-branch 75] $t@150 == Null
(declare-const $k@233 $Perm)
(assert ($Perm.isValidVar $k@233))
(assert ($Perm.isReadVar $k@233 $Perm.Write))
(push) ; 9
(assert (not (or (= $k@233 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(assert (< $k@233 $k@195))
(pop) ; 8
(assert ($Perm.isValidVar $k@233))
(assert ($Perm.isReadVar $k@233 $Perm.Write))
(assert (< $k@233 $k@195))
(push) ; 8
(push) ; 9
(assert (not (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0)))
(check-sat)
; unsat
; 0.00s
(pop) ; 9
(push) ; 9
(assert (not (not
  (=
    ($Seq.length
      ($Queue__contents ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine
                  ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                  $Snap.unit)
                ($SortWrappers.IntTo$Snap $t@196))
              ($SortWrappers.$RefTo$Snap $t@197))
            ($SortWrappers.IntTo$Snap $t@198))
          ($SortWrappers.$RefTo$Snap $t@199))
        ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
    0))))
(check-sat)
; unknown
; 0.00s
(pop) ; 9
; [dead then-branch 76] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| != 0
(push) ; 9
; [else-branch 76] |Queue__contents(diz@144;(((((((_, $t@150), _), $t@196), $t@197), $t@198), $t@199), $t@200))| == 0
(assert (=
  ($Seq.length
    ($Queue__contents ($Snap.combine
      ($Snap.combine
        ($Snap.combine
          ($Snap.combine
            ($Snap.combine
              ($Snap.combine
                ($Snap.combine $Snap.unit ($SortWrappers.$RefTo$Snap $t@150))
                $Snap.unit)
              ($SortWrappers.IntTo$Snap $t@196))
            ($SortWrappers.$RefTo$Snap $t@197))
          ($SortWrappers.IntTo$Snap $t@198))
        ($SortWrappers.$RefTo$Snap $t@199))
      ($SortWrappers.$RefTo$Snap $t@200)) diz@144))
  0))
(pop) ; 9
(pop) ; 8
(pop) ; 7
; [dead else-branch 71] sys__result@218 == Null
(pop) ; 6
(pop) ; 5
; [dead else-branch 65] $t@150 != Null
; [eval] !(diz.Queue__first == null)
; [eval] diz.Queue__first == null
(push) ; 5
(assert (not (not (= $t@150 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 77] $t@150 != Null
(push) ; 5
; [else-branch 77] $t@150 == Null
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- Queue__isFull ----------
(declare-const diz@234 $Ref)
(declare-const sys__result@235 Bool)
(declare-const ret@236 Bool)
(declare-const __flatten_19@237 $Ref)
(declare-const __flatten_20@238 Bool)
(push) ; 2
; [eval] diz != null
(assert (not (= diz@234 $Ref.null)))
(declare-const $t@239 $Ref)
; [eval] diz.Queue__first != null
(push) ; 3
(assert (not (= $t@239 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
(assert (not (not (= $t@239 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 3
(push) ; 3
; [then-branch 78] $t@239 != Null
(assert (not (= $t@239 $Ref.null)))
(declare-const $t@240 $Snap)
(declare-const $k@241 $Perm)
(assert ($Perm.isValidVar $k@241))
(assert ($Perm.isReadVar $k@241 $Perm.Write))
(declare-const $t@242 Int)
(declare-const $t@243 $Ref)
(assert (not (= $t@243 $Ref.null)))
(declare-const $t@244 Int)
(declare-const $t@245 $Ref)
(declare-const $t@246 $Ref)
(push) ; 4
(declare-const $t@247 $Ref)
; [eval] diz.Queue__first != null
(push) ; 5
(assert (not (= $t@247 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@247 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 79] $t@247 != Null
(assert (not (= $t@247 $Ref.null)))
(declare-const $t@248 $Snap)
(declare-const $k@249 $Perm)
(assert ($Perm.isValidVar $k@249))
(assert ($Perm.isReadVar $k@249 $Perm.Write))
(declare-const $t@250 Int)
(declare-const $t@251 $Ref)
(assert (not (= $t@251 $Ref.null)))
(declare-const $t@252 Int)
(declare-const $t@253 $Ref)
(declare-const $t@254 $Ref)
; [eval] sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity)
; [eval] diz.Queue__count.LockableInteger__val == diz.Queue__capacity
(push) ; 6
(assert (not (not (= $k@249 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@249 $Perm.No)))
(assert (= sys__result@235 (= $t@252 $t@250)))
(pop) ; 5
(push) ; 5
; [else-branch 79] $t@247 == Null
(assert (= $t@247 $Ref.null))
(declare-const $k@255 $Perm)
(assert ($Perm.isValidVar $k@255))
(assert ($Perm.isReadVar $k@255 $Perm.Write))
(declare-const $t@256 Int)
(declare-const $t@257 $Ref)
(assert (not (= $t@257 $Ref.null)))
(declare-const $t@258 Int)
(declare-const $t@259 $Ref)
(declare-const $t@260 $Ref)
; [eval] sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity)
; [eval] diz.Queue__count.LockableInteger__val == diz.Queue__capacity
(push) ; 6
(assert (not (not (= $k@255 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@255 $Perm.No)))
(assert (= sys__result@235 (= $t@258 $t@256)))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; inhale acc(diz.Queue__count.LockableInteger__val, write)
(declare-const $t@261 Int)
(assert (= $t@244 $t@261))
; [exec]
; inhale acc(LockableInteger__lock_held(diz.Queue__count), write)
(declare-const $t@262 $Snap)
; [exec]
; __flatten_19 := diz.Queue__count
; [exec]
; ret := __flatten_19.LockableInteger__val == diz.Queue__capacity
; [eval] __flatten_19.LockableInteger__val == diz.Queue__capacity
(push) ; 5
(assert (not (not (= (+ $Perm.Write $Perm.Write) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $Perm.Write $Perm.Write) $Perm.No)))
(push) ; 5
(assert (not (not (= $k@241 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@241 $Perm.No)))
; [exec]
; exhale acc(LockableInteger__lock_held(diz.Queue__count), write)
; [exec]
; exhale acc(diz.Queue__count.LockableInteger__val, write)
(push) ; 5
(assert (not (or
  (= (+ $Perm.Write $Perm.Write) $Perm.Write)
  (< $Perm.Write (+ $Perm.Write $Perm.Write)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (or
  (= (+ $Perm.Write $Perm.Write) $Perm.Write)
  (< $Perm.Write (+ $Perm.Write $Perm.Write))))
(push) ; 5
(assert (not (< $Perm.Write $Perm.No)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [exec]
; __flatten_20 := ret
; [exec]
; sys__result := __flatten_20
; [exec]
; assert acc(diz.Queue__first, write) && ((diz.Queue__first != null) ==> acc(Node__state(diz.Queue__first), write)) && acc(diz.Queue__capacity, wildcard) && acc(diz.Queue__count, write) && acc(diz.Queue__count.LockableInteger__val, write) && acc(diz.Queue__putLock, write) && acc(diz.Queue__takeLock, write) && (sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity))
; [eval] diz.Queue__first != null
(push) ; 5
(assert (not (= $t@239 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 80] $t@239 != Null
(declare-const $k@263 $Perm)
(assert ($Perm.isValidVar $k@263))
(assert ($Perm.isReadVar $k@263 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@263 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@263 $k@241))
; [eval] sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity)
; [eval] diz.Queue__count.LockableInteger__val == diz.Queue__capacity
; [exec]
; inhale false
(pop) ; 5
; [dead else-branch 80] $t@239 == Null
(pop) ; 4
(pop) ; 3
(push) ; 3
; [else-branch 78] $t@239 == Null
(assert (= $t@239 $Ref.null))
(declare-const $k@264 $Perm)
(assert ($Perm.isValidVar $k@264))
(assert ($Perm.isReadVar $k@264 $Perm.Write))
(declare-const $t@265 Int)
(declare-const $t@266 $Ref)
(assert (not (= $t@266 $Ref.null)))
(declare-const $t@267 Int)
(declare-const $t@268 $Ref)
(declare-const $t@269 $Ref)
(push) ; 4
(declare-const $t@270 $Ref)
; [eval] diz.Queue__first != null
(push) ; 5
(assert (not (= $t@270 $Ref.null)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
(assert (not (not (= $t@270 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
(push) ; 5
; [then-branch 81] $t@270 != Null
(assert (not (= $t@270 $Ref.null)))
(declare-const $t@271 $Snap)
(declare-const $k@272 $Perm)
(assert ($Perm.isValidVar $k@272))
(assert ($Perm.isReadVar $k@272 $Perm.Write))
(declare-const $t@273 Int)
(declare-const $t@274 $Ref)
(assert (not (= $t@274 $Ref.null)))
(declare-const $t@275 Int)
(declare-const $t@276 $Ref)
(declare-const $t@277 $Ref)
; [eval] sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity)
; [eval] diz.Queue__count.LockableInteger__val == diz.Queue__capacity
(push) ; 6
(assert (not (not (= $k@272 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@272 $Perm.No)))
(assert (= sys__result@235 (= $t@275 $t@273)))
(pop) ; 5
(push) ; 5
; [else-branch 81] $t@270 == Null
(assert (= $t@270 $Ref.null))
(declare-const $k@278 $Perm)
(assert ($Perm.isValidVar $k@278))
(assert ($Perm.isReadVar $k@278 $Perm.Write))
(declare-const $t@279 Int)
(declare-const $t@280 $Ref)
(assert (not (= $t@280 $Ref.null)))
(declare-const $t@281 Int)
(declare-const $t@282 $Ref)
(declare-const $t@283 $Ref)
; [eval] sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity)
; [eval] diz.Queue__count.LockableInteger__val == diz.Queue__capacity
(push) ; 6
(assert (not (not (= $k@278 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (not (= $k@278 $Perm.No)))
(assert (= sys__result@235 (= $t@281 $t@279)))
(pop) ; 5
(pop) ; 4
(push) ; 4
; [exec]
; inhale acc(diz.Queue__count.LockableInteger__val, write)
(declare-const $t@284 Int)
(assert (= $t@267 $t@284))
; [exec]
; inhale acc(LockableInteger__lock_held(diz.Queue__count), write)
(declare-const $t@285 $Snap)
; [exec]
; __flatten_19 := diz.Queue__count
; [exec]
; ret := __flatten_19.LockableInteger__val == diz.Queue__capacity
; [eval] __flatten_19.LockableInteger__val == diz.Queue__capacity
(push) ; 5
(assert (not (not (= (+ $Perm.Write $Perm.Write) $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= (+ $Perm.Write $Perm.Write) $Perm.No)))
(push) ; 5
(assert (not (not (= $k@264 $Perm.No))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (not (= $k@264 $Perm.No)))
; [exec]
; exhale acc(LockableInteger__lock_held(diz.Queue__count), write)
; [exec]
; exhale acc(diz.Queue__count.LockableInteger__val, write)
(push) ; 5
(assert (not (or
  (= (+ $Perm.Write $Perm.Write) $Perm.Write)
  (< $Perm.Write (+ $Perm.Write $Perm.Write)))))
(check-sat)
; unsat
; 0.00s
(pop) ; 5
(assert (or
  (= (+ $Perm.Write $Perm.Write) $Perm.Write)
  (< $Perm.Write (+ $Perm.Write $Perm.Write))))
(push) ; 5
(assert (not (< $Perm.Write $Perm.No)))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [exec]
; __flatten_20 := ret
; [exec]
; sys__result := __flatten_20
; [exec]
; assert acc(diz.Queue__first, write) && ((diz.Queue__first != null) ==> acc(Node__state(diz.Queue__first), write)) && acc(diz.Queue__capacity, wildcard) && acc(diz.Queue__count, write) && acc(diz.Queue__count.LockableInteger__val, write) && acc(diz.Queue__putLock, write) && acc(diz.Queue__takeLock, write) && (sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity))
; [eval] diz.Queue__first != null
(push) ; 5
(assert (not (not (= $t@239 $Ref.null))))
(check-sat)
; unknown
; 0.00s
(pop) ; 5
; [dead then-branch 82] $t@239 != Null
(push) ; 5
; [else-branch 82] $t@239 == Null
(declare-const $k@286 $Perm)
(assert ($Perm.isValidVar $k@286))
(assert ($Perm.isReadVar $k@286 $Perm.Write))
(push) ; 6
(assert (not (or (= $k@286 $Perm.No) true)))
(check-sat)
; unsat
; 0.00s
(pop) ; 6
(assert (< $k@286 $k@264))
; [eval] sys__result == (diz.Queue__count.LockableInteger__val == diz.Queue__capacity)
; [eval] diz.Queue__count.LockableInteger__val == diz.Queue__capacity
; [exec]
; inhale false
(pop) ; 5
(pop) ; 4
(pop) ; 3
(pop) ; 2
; ---------- LockSymbol__LockSymbol ----------
(declare-const sys__result@287 $Ref)
(declare-const diz@288 $Ref)
(declare-const __flatten_21@289 Int)
(declare-const __flatten_40@290 Int)
(push) ; 2
(push) ; 3
; [eval] sys__result != null
(assert (not (= sys__result@287 $Ref.null)))
(pop) ; 3
(push) ; 3
; [exec]
; diz := new(LockSymbol__x)
(declare-const diz@291 $Ref)
(assert (not (= diz@291 $Ref.null)))
(declare-const LockSymbol__x@292 Int)
(assert (not (= sys__result@287 diz@291)))
; [exec]
; __flatten_21 := 0
; [exec]
; __flatten_40 := __flatten_21
; [exec]
; diz.LockSymbol__x := __flatten_40
; [exec]
; exhale acc(diz.LockSymbol__x, write)
; [exec]
; sys__result := diz
; [exec]
; assert sys__result != null
; [eval] sys__result != null
; [exec]
; inhale false
(pop) ; 3
(pop) ; 2
